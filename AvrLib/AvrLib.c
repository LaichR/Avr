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


//static uint8_t _enterAtomicNesting = 0;



#define USART_RX_BUFFER_SIZE 32
#define USART_TX_BUFFER_SIZE 64

static uint8_t USART_rxBuffer[USART_RX_BUFFER_SIZE];
static uint8_t USART_txBuffer[USART_TX_BUFFER_SIZE];

#define FilledTxEntries() (((USART_txBufferIn + USART_TX_BUFFER_SIZE) - USART_txBufferOut)%USART_TX_BUFFER_SIZE)

static volatile uint8_t USART_rxBufferIn = 0;
static volatile uint8_t USART_rxBufferOut = 0;

static volatile uint8_t USART_txBufferIn = 0;
static volatile uint8_t USART_txBufferOut = 0;

static AvrMessage _avrMessagePool[4];
static uint8_t    _avrMsgIndex[4] = { 0, 1, 2, 3};
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
void ProcessMessage(uint8_t msgType, const uint8_t* msg, uint8_t msgLen);
void Usart_PutShort(uint16_t value);
void Usart_TriggerTx(void);
uint8_t Usart_AvailableTxBuffer(void);
uint8_t Usart_UnsafeEnqueueByte(uint8_t index, uint8_t b);
uint8_t Usart_AwaitAwailableSpaceAndLockBuffer(uint8_t needed);


/**************************************************************************/
/*                function implementations                                */
/**************************************************************************/


void Usart_AckBytes(uint8_t nrOfBytes, AvrPacketType packetType)
{
	// this allows the flow control with the PC!
	uint8_t index = Usart_AwaitAwailableSpaceAndLockBuffer(3);
	index = Usart_UnsafeEnqueueByte(index, PacketType_AnyDataAck);
	index = Usart_UnsafeEnqueueByte(index, nrOfBytes);
	index = Usart_UnsafeEnqueueByte(index, packetType);
	USART_txBufferIn = index;
	Usart_TriggerTx();
	LeaveAtomic();
}

void Usart_SendAnyData(const uint8_t *bytes, uint8_t count)
{
	uint8_t index = Usart_AwaitAwailableSpaceAndLockBuffer(count + 2);
	uint8_t i = 0;
	index = Usart_UnsafeEnqueueByte(index, PacketType_AnyData);
	index = Usart_UnsafeEnqueueByte(index, count);
	while( i < count) // we may send messages of length 0
	{
		index = Usart_UnsafeEnqueueByte(index, bytes[i++]);
	}
	USART_txBufferIn = index;
	Usart_TriggerTx();
	LeaveAtomic();
}

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

uint8_t Usart_AwaitAwailableSpaceAndLockBuffer(uint8_t needed)
{
	EnterAtomic();
	uint8_t index = USART_txBufferIn;
	while( needed > Usart_AvailableTxBuffer())
	{
		LeaveAtomic();
		_delay_ms(5);
		EnterAtomic();
		index = USART_txBufferIn;
	}
	return index;
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
	EnterAtomic();
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
	timer->TCNT = 0;
	SetRegister(timer->TCCRA, (TCCRA_WGM, ClrTmrOnCmpMatch));
	SetRegister(timer->TCCRB, (TCCRB_CS, pDiv[frequency]));
	volatile uint8_t* pmatch = &timer->OCRA;
	pmatch[isrMask] = match;
	_compareMatchHandler[source] = handler;
	*msk |= 1 << ((isrMask) + 1);
	LeaveAtomic();
}

void UnregisterCompareMatchInterrupt(CompareMatchSource source)
{
	EnterAtomic();
	volatile TCNT8_T *timer = &Tcnt0;
	volatile uint8_t* msk = &Timsk0;
	if (source > CompareMatchSource2)
	{
		timer = &Tcnt2;
		msk = &Timsk2;
	}
	SetRegister(timer->TCCRB, (TCCRB_CS, 0));
	*msk &= ~( 1 << ((source & 1) + 1));
	_compareMatchHandler[source] = 0;
	LeaveAtomic();
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

inline void IsrEnter()
{
	//asm( "sbi 0x1e, 7":);
	_withinIsr |= 0x80;
}

inline void IsrLeave()
{
	_withinIsr &= ~0x80;
	//asm("cbi 0x1e, 7":);
}

void EnterAtomic(void)
{
	// in case we are in interrupt context, we must never reenable interrupts
	
	if (_withinIsr&0x80) return;
	uint8_t withinIsr = _withinIsr;
	cli(); // this just forces the bit to be cleared; should be possible to call this many times without side effect
	withinIsr+=1;
	_withinIsr = withinIsr;
} 

void LeaveAtomic(void)
{
	if (_withinIsr&0x80) return;

	uint8_t within_isr = _withinIsr;
	//if (within_isr > 0)
	{
		within_isr--;
		_withinIsr = within_isr;
		if (within_isr == 0)
		{
			sei();
		}
	}
}

void HandleMessage(char receivedData)
{
	
	
	static uint8_t msgBuffer[16]; // longest
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
		if( msgLen == 0)
		{
			ProcessMessage(msgType, msgBuffer, msgLen);
			msgType = 0;
		}
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

void ProcessMessage(uint8_t msgType, const uint8_t* msg, uint8_t msgLen)
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
			if( HandleAvrMessage(avrMsg) )
			{
				Usart_AckBytes((avrMsg->Length + 2), avrMsg->MsgType);
			}
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
	return False;
}

/**
* @brief Put a message into the queue
* 
*/
void SendMessage(uint8_t prio, uint8_t id, uint8_t msgLow, uint8_t msgHigh)
{
	//uint8_t nextMessageIn = (_qIn + 1) % (countof(_prioQueue));
	SET_DBG_PIN(5);
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
			PortB.PORT ^= 0xFF;
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
	CLR_DBG_PIN(5);
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
	Usart.UDR = USART_txBuffer[USART_txBufferOut++];
	USART_txBufferOut %= countof(USART_txBuffer);

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



uint8_t Usart_AvailableTxBuffer(void)
{
	int8_t used = USART_txBufferIn - USART_txBufferOut;
	if( used < 0) used += countof(USART_txBuffer);
	return countof(USART_txBuffer) - used - 1;
}


uint8_t Usart_UnsafeEnqueueByte(uint8_t index, uint8_t b)
{
	USART_txBuffer[index++] = b;
	index = index % countof(USART_txBuffer); 
	return index;
}

inline void Usart_TriggerTx(void)
{
	Usart.UCSRB |= UCSRB_UDRIEN_mask;
}

uint8_t Usart_TraceHeader(uint8_t index, uint16_t id, uint8_t nrOfBytes)
{
	index = Usart_UnsafeEnqueueByte(index, PacketType_TraceMessage);
	index = Usart_UnsafeEnqueueByte(index, PacketType_TraceMassagePadLen | nrOfBytes);
	index = Usart_UnsafeEnqueueByte(index, id>>8);
	index = Usart_UnsafeEnqueueByte(index, id&0xFF);
	return index;
}

void Usart_Trace0(ZeroByteTrace_T t)
{
	EnterAtomic();
	if ( Usart_AvailableTxBuffer() >= 4)
	{
		uint8_t index = Usart_TraceHeader(USART_txBufferIn, t.id, 0);
		USART_txBufferIn = index;
		Usart_TriggerTx();
	}
	LeaveAtomic();
}

void Usart_Trace1(OneByteTrace_T t)
{
	EnterAtomic();
	if ( Usart_AvailableTxBuffer() >= 5)
	{
		uint8_t index = Usart_TraceHeader(USART_txBufferIn, t.id, 1);
		index = Usart_UnsafeEnqueueByte(index, t.b0);
		USART_txBufferIn = index;
		Usart_TriggerTx();
	}
	LeaveAtomic();
}

void Usart_Trace2(TwoByteTrace_T t)
{
	EnterAtomic();
	if ( Usart_AvailableTxBuffer() >= 6)
	{
		uint8_t index = Usart_TraceHeader(USART_txBufferIn, t.id, 2);
		index = Usart_UnsafeEnqueueByte(index, t.b0);
		index = Usart_UnsafeEnqueueByte(index, t.b1);
		USART_txBufferIn = index;
		Usart_TriggerTx();
	}
	LeaveAtomic();
}

void Usart_Trace3(ThreeByteTrace_T t)
{
	EnterAtomic();
	if ( Usart_AvailableTxBuffer() >= 7)
	{
		uint8_t index = Usart_TraceHeader(USART_txBufferIn, t.id, 3);
		index = Usart_UnsafeEnqueueByte(index, t.b0);
		index = Usart_UnsafeEnqueueByte(index, t.b1);
		index = Usart_UnsafeEnqueueByte(index, t.b2);
		USART_txBufferIn = index;
		Usart_TriggerTx();
	}
	LeaveAtomic();
}

void Usart_Trace4(FourByteTrace_T t)
{
	EnterAtomic();
	if ( Usart_AvailableTxBuffer() >= 8)
	{
		uint8_t index = Usart_TraceHeader(USART_txBufferIn, t.id, 3);
		index = Usart_UnsafeEnqueueByte(index, t.b0);
		index = Usart_UnsafeEnqueueByte(index, t.b1);
		index = Usart_UnsafeEnqueueByte(index, t.b2);
		index = Usart_UnsafeEnqueueByte(index, t.b3);
		USART_txBufferIn = index;
		Usart_TriggerTx();
	}
	LeaveAtomic();
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
		uint8_t index = Usart_AwaitAwailableSpaceAndLockBuffer(4);
		if (pReadReg->len == 1)
		{
			uint8_t* regAddr = (uint8_t*)pReadReg->adress;
			uint8_t byte = *regAddr;
			index = Usart_UnsafeEnqueueByte(index, header>> 8);
			index = Usart_UnsafeEnqueueByte(index, (uint8_t)header );
			index = Usart_UnsafeEnqueueByte(index, (uint8_t)byte );
		}
		else if (pReadReg->len == 2)
		{
			uint16_t* regAddr = (uint16_t*)pReadReg->adress;
			uint16_t word = *regAddr;
			index = Usart_UnsafeEnqueueByte(index, header>> 8);
			index = Usart_UnsafeEnqueueByte(index, (uint8_t)header );
			index = Usart_UnsafeEnqueueByte(index, word >> 8 );
			index = Usart_UnsafeEnqueueByte(index, (uint8_t)word );
		}
		else
		{
			header &= 0xFF;
			index = Usart_UnsafeEnqueueByte(index, header>> 8);
			index = Usart_UnsafeEnqueueByte(index, (uint8_t)header );
		}
		USART_txBufferIn = index;
		Usart_TriggerTx();
		LeaveAtomic();
		//PortB.PORT &= ~PIN_5_mask;
		return True;
	}
	if (msg->MsgType == PacketType_WriteRegister)
	{
		
		CmdWriteReg* pWriteReg = (CmdWriteReg* )msg->Payload;
		uint16_t header = (PacketType_WriteRegister<<8)|1;
		uint8_t index = Usart_AwaitAwailableSpaceAndLockBuffer(2);
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
			header &= 0xFF00;
		}	
		index = Usart_UnsafeEnqueueByte(index, header>> 8);
		index = Usart_UnsafeEnqueueByte(index, (uint8_t)header );
		USART_txBufferIn = index;
		Usart_TriggerTx();
		LeaveAtomic();
		return True;
	}
	return False;
}

const static uint8_t crc_table[256] =
	{	
		0, 141, 151, 26, 163, 46, 52, 185, 203, 70, 92, 209, 104, 229, 255, 114, 27, 150, 140, 
		1, 184, 53, 47, 162, 208, 93, 71, 202, 115, 254, 228, 105, 54, 187, 161, 44, 149, 24, 
		2, 143, 253, 112, 106, 231, 94, 211, 201, 68, 45, 160, 186, 55, 142, 3, 25, 148, 230, 
		107, 113, 252, 69, 200, 210, 95, 108, 225, 251, 118, 207, 66, 88, 213, 167, 42, 48, 189, 
		4, 137, 147, 30, 119, 250, 224, 109, 212, 89, 67, 206, 188, 49, 43, 166, 31, 146, 136, 5, 
		90, 215, 205, 64, 249, 116, 110, 227, 145, 28, 6, 139, 50, 191, 165, 40, 65, 204, 214, 91, 
		226, 111, 117, 248, 138, 7, 29, 144, 41, 164, 190, 51, 216, 85, 79, 194, 123, 246, 236, 
		97, 19, 158, 132, 9, 176, 61, 39, 170, 195, 78, 84, 217, 96, 237, 247, 122, 8, 133, 159, 
		18, 171, 38, 60, 177, 238, 99, 121, 244, 77, 192, 218, 87, 37, 168, 178, 63, 134, 11, 17, 
		156, 245, 120, 98, 239, 86, 219, 193, 76, 62, 179, 169, 36, 157, 16, 10, 135, 180, 57, 35, 
		174, 23, 154, 128, 13, 127, 242, 232, 101, 220, 81, 75, 198, 175, 34, 56, 181, 12, 129, 
		155, 22, 100, 233, 243, 126, 199, 74, 80, 221, 130, 15, 21, 152, 33, 172, 182, 59, 73, 
		196, 222, 83, 234, 103, 125, 240, 153, 20, 14, 131, 58, 183, 173, 32, 82, 223, 197, 72, 
		241, 124, 102, 235
	};

uint8_t ComputeCrc(const uint8_t* data, uint8_t len, uint8_t initialCrc)
{
	
	uint8_t crc = initialCrc;
	 
	for (; len > 0; data++, len--)
	{
		crc ^= *data;
		crc = crc_table[crc];
	}
	return crc;
}

uint8_t ComputeNextCrc(uint8_t data, uint8_t previous_crc)
{
	data =data^previous_crc;
	return crc_table[data];
}



