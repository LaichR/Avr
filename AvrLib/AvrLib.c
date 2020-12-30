/**
 * UartHandler.c
 *
 * Created: 12.11.2019 09:12:23
 *  Author: rolfl
*/

#ifndef __AVR_ATmega328P__
#define __AVR_ATmega328P__
#endif // !1



#include <string.h>
#include <inttypes.h>

#include <avr/io.h>
#include <Atmega328P.h>
#include <avr/interrupt.h>
#include "AvrLib.h"
#include <RegisterAccess.h>

#define F_CPU 16000000
#include <util/delay.h>



/**************************************************************************/
/*                global variables                                        */
/**************************************************************************/


static IsrHandler _extIntHandler[2] = { 0,0 };
static IsrHandler _compareMatchHandler[4] = { 0,0,0,0 };

Fsm TestHandler = { .Next = 0, .RxMask = 1, .CurrentState = 0 };


static uint8_t _enterAtomicNesting = 0;
static Bool _withinIsr = False;

#define USART_RX_BUFFER_SIZE 32
#define USART_TX_BUFFER_SIZE 32

static uint8_t USART_rxBuffer[USART_RX_BUFFER_SIZE];
static uint8_t USART_txBuffer[USART_TX_BUFFER_SIZE];

#define FilledTxEntries() (((USART_txBufferIn + USART_TX_BUFFER_SIZE) - USART_txBufferOut)%USART_TX_BUFFER_SIZE)

static volatile uint8_t USART_rxBufferIn = 0;
static volatile uint8_t USART_rxBufferOut = 0;

static volatile uint8_t USART_txBufferIn = 0;
static volatile uint8_t USART_txBufferOut = 0;

static AvrMessage _avrMessagePool[8];
static uint8_t    _avrMsgIndex[8] = { 0, 1, 2, 3, 4, 5, 6, 7};
static uint8_t    _avrPoolIn = countof(_avrMessagePool) - 1;
static uint8_t    _avrPoolOut = 0;

typedef struct
{
	uint16_t adress;
	uint8_t len;
	union
	{
		uint8_t byte;
		uint16_t word;
	}data;
}CmdWriteReg;

typedef struct
{
	uint16_t adress;
	uint8_t len;
}CmdReadReg;

static uint32_t _timerUs;

static Fsm _anchor = { .CurrentState = 0, .Next = &_anchor , .RxMask = 0 };

static Message _messagePool[32];


static Message _root = { .Priority = 16, .__next = &_root };

static uint8_t _messagePoolIndex[countof(_messagePool)] =
{
	0,1,2,3,4,5,6,7,
	8,9,10,11,12,13,14,15,
	16,17,18,19,20,21,22,23,
	24, 25, 26, 27, 28,29,30,31
};

static uint8_t _qIn = 0;
static uint8_t _qOut = 0;





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


uint16_t MeasureOnce(AnalogChannelSelection channel, ReferenceSelection Vref, AdcPrescaler prescaler)
{
	
	Adc.Adcsrb = 0;
	if (channel < 6)
	{
		Adc.Didr0 = 1 << channel;
	}
	SetRegister( Adc.Admux, (ADMUX_MUX, channel), (ADMUX_REFS,Vref));
	SetRegister(Adc.Adcsra, (ADCSRA_ADEN, 1), (ADCSRA_ADSC, 1), (ADCSRA_ADPS, prescaler));
	while (Adc.Adcsra & ADCSRA_ADSC_mask);
	Adc.Didr0 = 0;
	return Adc.Data;
}

/**
 * @brief Setup exernal Interrupt source
 *
 */
void RegisterExternalInteruptHandler(ExtInteruptSource source,
	ExtIntTrigger trigger, IsrHandler handler)
{
	EnterAtomic();
	Eicra |= ((trigger&0xF) << source);
	_extIntHandler[source] = handler;
	Eimsk |= (1 << source);
	LeaveAtomic();
}

/**
* Disable intterupts and unregister a previously registered handler
*/
void UnregisterExternalInterruptHandler(ExtInteruptSource source)
{
	EnterAtomic();
	Eimsk &= ~(1 << source);
	_extIntHandler[source] = 0;
	LeaveAtomic();
}

/**
* Change the behavior of an initially configured external interrupt
*
*/
void SetExtInterruptEnable(ExtInteruptSource source, Bool enable)
{
	EnterAtomic();
	if (_extIntHandler != 0)
	{
		uint8_t mask = (1 << source);
		uint8_t val = Eimsk|mask;
		if (!enable)
		{
			mask = ~mask;
			val &= mask;
		}
		Eimsk = val;
	}
	LeaveAtomic();
}


/**
* @brief Setup compare match interrupt on one of four available interrupt sources
*
* This function sets up the timer block in order to generate compare match interrupts
* Note: CompareMatchSource0 and CompareMatchSource1 refer to the HW Tcnt0
* CompareMatchSource2 and CompareMatchSource3 refer to Tcnt1. Changing the frequency
* changes the frequenty of both interrupt sources of the timer!
*/

static const uint8_t source1Div[] = { 1,2,3,4,5 };
static const uint8_t source2Div[] = { 1,2,4,6,7 };

void RegisterCompareMatchInterrupt(CompareMatchSource source,
	TimerFrequency frequency, uint8_t match, IsrHandler handler)
{

	volatile TCNT8_T *timer = &Tcnt0;
	volatile uint8_t* msk = &Timsk0;
	const uint8_t* pDiv = source1Div;
	uint8_t  isrMask = source & 0x3;;
	if (source > CompareMatchSource2)
	{
		timer = &Tcnt2;
		pDiv = source2Div;
		msk = &Timsk2;
		isrMask = (source- CompareMatchSource3) & 3;
	}
	SetRegister(timer->TCCRA, (TCCRA_WGM, ClrTmrOnCmpMatch));
	SetRegister(timer->TCCRB, (TCCRB_CS, pDiv[frequency]));
	volatile uint8_t* pmatch = &timer->OCRA;
	pmatch[isrMask] = match;
	_compareMatchHandler[source] = handler;
	*msk |= 1 << ((isrMask) + 1);
}

void UnregisterCompareMatchInterrupt(CompareMatchSource source)
{
	volatile uint8_t* msk = &Timsk0;
	if (source > CompareMatchSource1)
	{
		msk = &Timsk2;
	}
	*msk &= ~( 1 << ((source & 1) + 1));
	_compareMatchHandler[source] = 0;
}

/**
* @brief Initialisierung des Anfangszustandes
*
* Die Funktion InitializeStart() started das Framework.
*/
void InitializeStateEventFramework(void) 
{

	Usart_PutChar(0xCA);
	Usart_PutChar(0xFE);	
	PortB.DDR |= PIN_5_mask; // set port b as outptut => this allows to toggle the led for debugging purpose!
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

void IsrEnter()
{
	_withinIsr = True;
}

void IsrLeave()
{
	_withinIsr = False;
}

void EnterAtomic(void)
{
	// in case we are in interrupt context, we must never reenable interrupts
	
	if (_withinIsr) return;
	
	cli(); // this just forces the bit to be cleared; should be possible to call this many times without side effect
	_enterAtomicNesting++;
}

void LeaveAtomic(void)
{
	if (_withinIsr) return;

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
	//Usart_PutChar(0xD1);
	if (_avrPoolOut != _avrPoolIn)
	{
		uint8_t msgIndex = _avrMsgIndex[_avrPoolOut++];
		_avrPoolOut %= countof(_avrMsgIndex);
		//Usart_PutChar(0xD5);
		//Usart_PutChar(msgIndex);
		//Usart_PutChar(msgType^0xFF);
		_avrMessagePool[msgIndex].MsgType = msgType;
		_avrMessagePool[msgIndex].Length = msgLen;
		memcpy(_avrMessagePool[msgIndex].Payload, msg, msgLen);
		SendMessage(Priority_0, msgType | 0x80, msgIndex, 0);
	}
}


void StartTimer(void)
{
	_timerUs = 0;
	Tcnt1.TCCRA = 0; // normal timer operation
	Tcnt1.TCCRB = 2; // clock divider = 8 => every tick is 0.5 us;
	TIMSK1 |= 1; // enable overflow interrupt
}	

uint32_t GetElapsedTime(void)
{
	//Tcnt1.OCRB &= ~0x7; // stop the timer by setting its divider to 0
	uint32_t us = (Tcnt1.TCNT >> 1) + _timerUs;
	Tcnt1.TCNT = 0;
	return us;
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
	Message msg = { .Id = 0, .__next = 0 };
	if (GetMessage(&msg))
	{
		if (msg.Id & 0x80) // this was a AVR message => pass it to the messageHandler
		{
			uint8_t msgIndex = msg.MsgParamLow;
			//Usart_PutChar(msgIndex);
			AvrMessage* avrMsg = &_avrMessagePool[msgIndex];
			//Usart_PutChar(avrMsg->MsgType ^ 0xFF);

			HandleAvrMessage(avrMsg);
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
					p->CurrentState( &msg );
				}
				p = p->Next;
			}
		}
		return True;
	}
	//Usart_PutChar(0xB2);
	return False;
}

/**
* @brief Put a message into the queue
* 
*/
void SendMessage(uint8_t prio, uint8_t id, uint8_t msgLow, uint8_t msgHigh)
{
	//uint8_t nextMessageIn = (_qIn + 1) % (countof(_prioQueue));
	PortB.PORT |= PIN_5_mask;
	EnterAtomic();
	uint8_t nextIn = (_qIn + 1) % countof(_messagePool);
	if (nextIn == _qOut)
	{
		Usart_PutChar(0xDE);
		Usart_PutChar(0xAD);
		LeaveAtomic();
		return; // todo: what shall be done in case a message is discarded?
	}

	// get a free slot
	Message* msg = &_messagePool[_messagePoolIndex[_qIn]];
	_qIn = nextIn;
	if (msg->__next != 0)
	{ 
		Usart_PutChar(0xDE);
		Usart_PutChar(0xAD);
		Usart_PutChar(0xBE);
		Usart_PutChar(0xAF);
		while (1)
		{
			PortB.PORT ^= PIN_5_mask;
			_delay_ms(1000);
		}
		LeaveAtomic();
	}
	msg->Priority = prio;
	msg->Id = id;
	msg->MsgParamLow = msgLow;
	msg->MsgParamHigh = msgHigh;

	Message* p = &_root;
	
	Message* q = p;
	// search place in the priority list to insert the message
	while (msg->Priority <= p->Priority && p->__next != &_root )
	{
		q = p;
		p = p->__next;
	}
	
	msg->__next = q->__next;
	q->__next = msg;
	LeaveAtomic();
	PortB.PORT ^= PIN_5_mask;
}


Bool GetMessage(Message* msg)
{
	EnterAtomic();
	Message* p = &_root;
	Message* q = _root.__next;
	Bool retValue = False;
	if (p != q) // there is an element in the queue
	{
		// get the first element in the queue
		*msg = *q;
		msg->__next = 0;

		// set pointer back to free list
		_messagePoolIndex[_qOut++] = q-_messagePool;
		_root.__next = q->__next;

		memset(q, 0, sizeof(Message));

		_qOut %= countof(_messagePoolIndex);

		retValue = True;
	}
	LeaveAtomic();
	return retValue;
}

#ifdef __AVR_ATmega328P__

#ifndef F_CPU
#define F_CPU 16000000
#endif

void Usart_Init(uint32_t baudrate)
{
	PortB.DDR |= (PIN_4_mask|PIN_5_mask);
	/*Set baud rate */
	Usart.UBBR = (uint16_t)(F_CPU/16/baudrate -1);

	/*Enable receiver and transmitter */
	SetRegister(Usart.UCSRB, (UCSRB_RXEN, 1),(UCSRB_RXCIEN, True),(UCSRB_TXEN, True));

	/* Set frame format: 8data, 2stop bit; work in  */
	SetRegister(Usart.UCSRC, (UCSRC_USBS, 1), (UCSRC_UCSZ01, 3));

	// enable interupts
	sei();
}

void Usart_PutChar(char ch)
{
	//PortB.PORT |= PIN_4_mask;
	EnterAtomic();
	uint8_t nextIn = 0;
	nextIn = (USART_txBufferIn + 1) % countof(USART_txBuffer);
	if (nextIn != USART_txBufferOut)
	{
		USART_txBuffer[USART_txBufferIn] = ch;
		USART_txBufferIn = nextIn;
		Usart.UCSRB |= UCSRB_UDRIEN_mask;
	}
	LeaveAtomic();
	//PortB.PORT &= ~PIN_4_mask;
}
 
ISR_UsartDataRegEmpty()
{	
	IsrEnter();
	if (USART_txBufferOut != USART_txBufferIn)
	{
		Usart.UDR = USART_txBuffer[USART_txBufferOut++];
		USART_txBufferOut %= countof(USART_txBuffer);
	}
	if (USART_txBufferOut == USART_txBufferIn)
	{
		UpdateRegister(Usart.UCSRB, (UCSRB_UDRIEN, False));
	}
	IsrLeave();
}

void AllowUartRx(void)
{
	Usart.UCSRB |= UCSRB_RXCIEN_mask;
}

void DisallowUartRx(void)
{
	Usart.UCSRB &= ~ UCSRB_RXCIEN_mask;
}


ISR_UsartRxComplete()
{
	IsrEnter();
	while (Usart.UCSRA & UCSRA_RXC_mask)
	{
		char receivedChar = Usart.UDR;
		uint8_t nextInput = (USART_rxBufferIn + 1) % countof(USART_rxBuffer);
		if ((nextInput) != USART_rxBufferOut)
		{
			USART_rxBuffer[USART_rxBufferIn] = receivedChar;
			USART_rxBufferIn = nextInput;
		}
	}
	IsrLeave();
}


ISR_ExtInt0()
{
	IsrEnter();
	if (_extIntHandler[ExtInterruptSource0] != 0)
	{
		_extIntHandler[ExtInterruptSource0]();
	}
	IsrLeave();
}

ISR_ExtInt1()
{
	IsrEnter();
	if (_extIntHandler[ExtInterruptSource1] != 0)
	{
		_extIntHandler[ExtInterruptSource1]();
	}
	IsrLeave();
}


ISR_Tcnt0CompareMatchA()
{
	IsrEnter();
	if (_compareMatchHandler[CompareMatchSource1] != 0)
	{
		_compareMatchHandler[CompareMatchSource1]();
	}
	IsrLeave();
}

ISR_Tcnt0CompareMatchB()
{
	IsrEnter();
	if (_compareMatchHandler[CompareMatchSource2] != 0)
	{
		_compareMatchHandler[CompareMatchSource2]();
	}
	IsrLeave();
}

ISR_Tcnt2CompareMatchA()
{
	IsrEnter();
	if (_compareMatchHandler[CompareMatchSource3] != 0)
	{
		_compareMatchHandler[CompareMatchSource3]();
	}
	IsrLeave();
}

ISR_Tcnt2CompareMatchB()
{
	IsrEnter();
	if (_compareMatchHandler[CompareMatchSource4] != 0)
	{
		_compareMatchHandler[CompareMatchSource4]();
	}
	IsrLeave();
}

ISR_Tcnt1Overflow()
{

	_timerUs += 0x7FFF; // this is the amount of us that has elapsed
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
		uint8_t nextInput = (USART_rxBufferIn + 1) % countof(USART_rxBuffer);
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

AvrMessageHandler RegisterAvrMessageHandler(AvrMessageHandler handler)
{
	AvrMessageHandler oldHandler = HandleAvrMessage;
	if( handler != 0)
	{
		HandleAvrMessage = handler;
	}
	return oldHandler;
}


Bool DefaultMessageHandler(const AvrMessage* msg)
{
	//PortB.PORT |= PIN_5_mask;
	if (msg->MsgType == PacketType_ReadRegister)
	{
		
		CmdReadReg* pReadReg = (CmdReadReg*)msg->Payload;
		uint16_t header = (PacketType_ReadRegister<<8) | (pReadReg->len);
		EnterAtomic();
		if (pReadReg->len == 1)
		{
			uint8_t* regAddr = (uint8_t*)pReadReg->adress;
			uint8_t byte = *regAddr;
			Usart_PutShort(header);
			Usart_PutChar(byte);
		}
		else if (pReadReg->len == 2)
		{
			uint16_t* regAddr = (uint16_t*)pReadReg->adress;
			uint16_t word = *regAddr;
			Usart_PutShort(header);
			Usart_PutShort(word);
		}
		else
		{
			header &= 0xFF;
			Usart_PutShort(header);
		}
		LeaveAtomic();
		//PortB.PORT &= ~PIN_5_mask;
		return True;
	}
	if (msg->MsgType == PacketType_WriteRegister)
	{
		CmdWriteReg* pWriteReg = (CmdWriteReg* )msg->Payload;
		uint16_t status = (PacketType_WriteRegister<<8)|1;
		EnterAtomic();
		if (pWriteReg->len == 1)
		{
			uint8_t* regAddr = (uint8_t*)pWriteReg->adress;
			*regAddr = pWriteReg->data.byte;
		}
		else if (pWriteReg->len == 2)
		{
			uint16_t* regAddr = (uint16_t*)pWriteReg->adress;
			*regAddr = pWriteReg->data.word;
		}
		else
		{
			status &= 0xFF00;
		}
		
		Usart_PutShort(status);
		LeaveAtomic();
	
		return True;
	}
	return False;
}






