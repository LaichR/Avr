/**
 * UartHandler.c
 *
 * Created: 12.11.2019 09:12:23
 *  Author: rolfl
*/

//#define __AVR_ATmega328P__

#include <string.h>
#include <inttypes.h>

#include <avr/io.h>
#include <Atmega328P.h>
#include <avr/interrupt.h>
#include "AvrLib.h"
#include <RegisterAccess.h>

/**************************************************************************/
/*                global variables                                        */
/**************************************************************************/




Fsm TestHandler = { .Next = 0, .RxMask = 1, .CurrentState = 0 };

static uint8_t _enterAtomicNesting = 0;

#define USART_RX_BUFFER_SIZE 32
#define USART_TX_BUFFER_SIZE 32

static uint8_t USART_rxBuffer[USART_RX_BUFFER_SIZE];
static uint8_t USART_txBuffer[USART_TX_BUFFER_SIZE];

#define FilledTxEntries() (((USART_txBufferIn + USART_TX_BUFFER_SIZE) - USART_txBufferOut)%USART_TX_BUFFER_SIZE)

static volatile uint8_t USART_rxBufferIn = 0;
static volatile uint8_t USART_rxBufferOut = 0;

static volatile uint8_t USART_txBufferIn = 0;
static volatile uint8_t USART_txBufferOut = 0;

static AvrMessage _avrMessagePool[7];
static uint8_t    _avrMsgIndex[8] = { 0,1,2,3,4,5,6, 0};
static uint8_t    _avrPoolIn = countof(_avrMessagePool) - 1;
static uint8_t    _avrPoolOut = 0;



static Fsm _anchor = { .CurrentState = 0, .Next = &_anchor , .RxMask = 0 };

static Message _messagePool[32] =
{
	[31] = {.__next = 31, .Priority = 16 }
};

static Message* _root = &_messagePool[31];

static uint8_t _messagePoolIndex[countof(_messagePool)] =
{
	0,1,2,3,4,5,6,7,
	8,9,10,11,12,13,14,15,
	16,17,18,19,20,21,22,23,
	24, 25, 26, 26, 28,29,30
};

static uint8_t _qIn = countof(_messagePool)-1;
static uint8_t _qOut = 0;

void DefaultMessageHandler(const AvrMessage* msg);



void SendMessage(uint8_t prio, uint8_t id, uint8_t msgLow, uint8_t msgHigh);
Bool GetMessage(Message* msg);

static AvrMessageHandler HandleAvrMessage = DefaultMessageHandler;

/**************************************************************************/
/*                private functions                                       */
/**************************************************************************/

void HandleMessage(char receivedData);
void ProcessMessage(uint8_t msgType, uint8_t* msg, uint8_t msgLen);
void Usart_PutShort(uint16_t value);

/**************************************************************************/
/*                function implementations                                */
/**************************************************************************/


/**
* @brief Initialisierung des Anfangszustandes
*
* Die Funktion InitializeStart() started das Framework.
*/
void InitializeStateEventFramework(void) 
{

	Usart_PutChar(0xCA);
	Usart_PutChar(0xFE);	
	
	while (1)
	{
		DispatchEvent();
		// process messages received from the UART
		while (USART_rxBufferOut != USART_rxBufferIn)
		{
			EnterAtomic();
			char receivedData = USART_rxBuffer[USART_rxBufferOut++];
			USART_rxBufferOut %= countof(USART_rxBuffer);
			LeaveAtomic();
			HandleMessage(receivedData);
		}
	}
}

void EnterAtomic(void)
{
	// in case we are in interrupt context, we must never reenable interrupts
	//if (((SREG & 0x80) == 0) && _enterAtomicNesting == 0) return;
	
	cli(); // this just forces the bit to be cleared; should be possible to call this many times without side effect
	_enterAtomicNesting++;
}

void LeaveAtomic(void)
{
	if (_enterAtomicNesting > 0)
	{
		_enterAtomicNesting--;
		if (_enterAtomicNesting == 0)
		{
			sei();
		}
	}
}

void HandleMessage(char receivedData)
{
	//Usart_PutChar(0xaa);
	//Usart_PutChar(receivedData);
	static uint8_t msgBuffer[14]; // longest
	static uint8_t bufferIndex = 0;
	static uint8_t msgType = 0;
	static uint8_t msgLen = 0;
	if (msgType == 0)
	{
		msgType = receivedData;
		msgLen = 0;
	}
	else if (msgLen == 0)
	{
		msgLen = receivedData - 2;

		bufferIndex = 0;
	}
	else if (bufferIndex < msgLen)
	{
		msgBuffer[bufferIndex++] = receivedData;
		if (bufferIndex == msgLen)
		{
			ProcessMessage(msgType, msgBuffer, msgLen);
			msgType = 0;
			bufferIndex = 0;
		}
	}
}

void ProcessMessage(uint8_t msgType, uint8_t* msg, uint8_t msgLen)
{
	if (_avrPoolOut != _avrPoolIn)
	{
		uint8_t msgIndex = _avrMsgIndex[_avrPoolOut++];
		_avrPoolOut %= countof(_avrMsgIndex);
		_avrMessagePool[msgIndex].MsgType = msgType;
		_avrMessagePool[msgIndex].Length = msgLen;
		memcpy(_avrMessagePool[msgIndex].Payload, msg, msgLen);
		SendMessage(Priority_0, msgType | 0x80, msgIndex, 0);
	}
}


void SetState(Fsm* fsm, StateHandler handler)
{
	EnterAtomic();
	fsm->CurrentState = handler; // we never do this in interrupt context!
	LeaveAtomic();
}

/**
* @brief register a new finite state machine;
*
* This function will never be called from ISR context; hence no need to protect
*/
void RegisterFsm(Fsm* fsm)
{
	
	Fsm* p = &_anchor;
	Fsm* q = p->Next;
	while (q != &_anchor)
	{
		p = q;
		q = q->Next;
	}
	p->Next = fsm;
	fsm->Next = q;
}

Bool DispatchEvent(void)
{
	Message msg;
	if (GetMessage(&msg))
	{
		
		if (msg.Id & 0x80) // this was a AVR message => pass it to the messageHandler
		{
			uint8_t msgIndex = msg.MsgParamLow;
			HandleAvrMessage(&_avrMessagePool[_avrMsgIndex[msgIndex]]);
			_avrMsgIndex[_avrPoolIn++] = msgIndex;
			_avrPoolIn %= countof(_avrMsgIndex);
		}
		else
		{
			Fsm* p = _anchor.Next;
			uint8_t prioFlag = 1 << msg.Priority;
			while (p != &_anchor)
			{
				if ((p->RxMask & prioFlag) != 0)
				{
					p->CurrentState(&msg);
				}
				p = p->Next;
			}
		}
		return True;
	}
	//Usart_PutChar(0xB2);
	return False;
}


void SendMessage(uint8_t prio, uint8_t id, uint8_t msgLow, uint8_t msgHigh)
{
	//uint8_t nextMessageIn = (_qIn + 1) % (countof(_prioQueue));
	if (_qIn == _qOut)
	{
		Usart_PutChar(0xDE);
		Usart_PutChar(0xAD);
		return; // todo: what shall be done in case a message is discarded?
	}
	
	Message* msg = &_messagePool[_messagePoolIndex[_qOut++]];
	_qOut %= countof(_messagePool);
	msg->Priority = prio;
	msg->Id = id;
	msg->MsgParamLow = msgLow;
	msg->MsgParamHigh = msgHigh;
	
	Message* p = _root;
	
	Message* q = p;
	while (msg->Priority <= p->Priority && p->__next != 31 )
	{
		q = p;
		p = &_messagePool[p->__next];
	}
	EnterAtomic();
	msg->__next = q->__next;
	q->__next = (msg - _messagePool);
	LeaveAtomic();
}


Bool GetMessage(Message* msg)
{
	Message* p = _root;
	Message* q = &_messagePool[p->__next];
	if (p != q)
	{
		*msg = *q;
		EnterAtomic();
		_messagePoolIndex[_qIn++] = p->__next;
		_qIn %= countof(_messagePoolIndex);
		p->__next = q->__next;		
		LeaveAtomic();
		return True;
	}
	//else if (_qIn + 1 != _qOut)
	//{
	//	EnterAtomic();
	//	//Usart_PutChar(0xF0); // the pool should be full; otherwise we have made a mistake!
	//	Usart_PutChar(p->__next);
	//	LeaveAtomic();

	//}
	return False;
}

#ifdef __AVR_ATmega328P__

#ifndef F_CPU
#define F_CPU 16000000
#endif

void Usart_Init(uint32_t baudrate)
{
	/*Set baud rate */
	Usart.UBBR = (uint16_t)(F_CPU/16/baudrate -1);

	/*Enable receiver and transmitter */
	SetRegister(Usart.UCSRB, (UCSRB_RXEN, 1),(UCSRB_RXCIEN, True), (UCSRB_TXEN, 1));

	/* Set frame format: 8data, 2stop bit; work in  */
	SetRegister(Usart.UCSRC, (UCSRC_USBS, 1), (UCSRC_UCSZ01, 3));
}

void Usart_PutChar(char ch)
{
	EnterAtomic();
	uint8_t nextIn = 0;
	nextIn = (USART_txBufferIn + 1) % countof(USART_txBuffer);
	if (nextIn != USART_txBufferOut)
	{
		USART_txBuffer[USART_txBufferIn] = ch;
		USART_txBufferIn = nextIn;
		UpdateRegister(Usart.UCSRB, (UCSRB_UDRIEN, True));
	}
	LeaveAtomic();
}
 
ISR_UsartDataRegEmpty()
{
	if (USART_txBufferOut != USART_txBufferIn)
	{
		Usart.UDR = USART_txBuffer[USART_txBufferOut++];
		USART_txBufferOut %= countof(USART_txBuffer);
	}
	else
	{
		UpdateRegister(Usart.UCSRB, (UCSRB_UDRIEN, False));
	}
}

void AllowUartRx(void)
{
	Usart.UCSRB |= UCSRB_RXCIEN_mask;
}

void DisallowUartRx(void)
{
	Usart.UCSRB &= ~ UCSRB_RXCIEN_mask;
}


ISR(USART_RX_vect)
{
	while (Usart.UCSRA & UCSRA_RXC_mask)
	{
		char receivedChar = Usart.UDR;
		uint8_t nextInput = (USART_rxBufferIn + 1) % USART_RX_BUFFER_SIZE;
		if ((nextInput) != USART_rxBufferOut)
		{
			USART_rxBuffer[USART_rxBufferIn] = receivedChar;
			USART_rxBufferIn = nextInput;
		}
	}
}

#else

void Usart_Init(uint32_t baudrate) //tbd fix this for atmega32!
{

	UBRRH = 0;
	//UBRRL = 12;							// initialize baud rate = 38400 at 8MHZ
	UBRRL = 5;								// initialize baud rate 34800 at 3.68MHz
	UCSRC = 0x86;							// 8 data bits, 1 stop bit, not parity; docu page 162
	UCSRB = (1<<TXEN)|(1<<RXEN)|(1<<RXCIE)|(1<<TXCIE);	// enabe tx, rx and rx, tx interrupts
	sei();									// enable interrupts
}

void AllowUartRx(void)
{
	UCSRB |= (1<<RXCIE);
}

void DisallowUartRx(void)
{
	UCSRB &= ~(1<<RXCIE);
}


ISR(USART_RXC_vect)
{

	while (UCSRA & (1 << RXC))
	{
		char receivedChar = UDR;
		uint8_t nextInput = (USART_rxBufferIn + 1) % USART_RX_BUFFER_SIZE;
		if ((nextInput) != USART_rxBufferOut)
		{
			USART_rxBuffer[USART_rxBufferIn] = receivedChar;
			USART_rxBufferIn = nextInput;
		}
	}
}

void Usart_PutChar(char ch)
{
	UDR = ch;
	while (!(UCSRA & (1 << UDRE)));
}


#endif



void Usart_PutShort(uint16_t val)
{
	Usart_PutChar(val >> 8);
	Usart_PutChar(val & 0xFF);
}

void Usart_TraceN(uint16_t id, const uint8_t* pVal, int8_t len)
{
	EnterAtomic();
	// avoid partial messages!
	if ((USART_TX_BUFFER_SIZE - 1 - FilledTxEntries()) >= (len + 4))
	{
		Usart_PutChar(PacketType_TraceMessage);
			Usart_PutChar(PacketType_TraceMassagePadLen | len);
			Usart_PutShort(id);
			while (len-- > 0)
			{
				Usart_PutChar(*pVal++);
			}
	}
	LeaveAtomic();
}

void Usart_Trace0(uint16_t id)
{
	Usart_TraceN(id, 0, 0);

}

void Usart_Trace1(uint16_t id, uint8_t ch)
{
	Usart_TraceN(id, &ch, 1);
}

void Usart_Trace2(uint16_t id, uint8_t val1, uint8_t val2)
{
	uint8_t buffer[2] = {val1, val2};
	Usart_TraceN(id, buffer, 2);
}

void Usart_Trace3(uint16_t id, uint8_t val1, uint8_t val2, uint8_t val3)
{
	uint8_t buffer[3] = {val1, val2, val3};
	Usart_TraceN(id, buffer, 3);
}

void Usart_Trace4(uint16_t id, uint8_t val1, uint8_t val2, uint8_t val3, uint8_t val4)
{
	uint8_t buffer[4] = {val1, val2, val3, val4};
	Usart_TraceN(id, buffer, 4);
}

void RegisterAvrMessageHandler(AvrMessageHandler handler)
{
	HandleAvrMessage = handler;
}


void DefaultMessageHandler(const AvrMessage* msg)
{

}






