/*
 * UartHandler.c
 *
 * Created: 12.11.2019 09:12:23
 *  Author: rolfl
*/
#include <inttypes.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include "HelloWorldTypes.h"


#define USART_RX_BUFFER_SIZE 32
static uint8_t USART_rxBufferIn = 0;
static uint8_t USART_rxBufferOut = 0;
static char USART_rxBuffer[USART_RX_BUFFER_SIZE];

void Usart_Init(void)
{
	
	UBRRH = 0;
	//UBRRL = 12;							// initialize baud rate = 38400 at 8MHZ
	UBRRL = 5;								// initialize baud rate 34800 at 3.68MHz
	UCSRC = 0x86;							// 8 data bits, 1 stop bit, not parity; docu page 162
	UCSRB = (1<<TXEN)|(1<<RXEN)|(1<<RXCIE);	// enabe tx, rx and rx interrupts
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



void Usart_PutChar( char ch)
{
	UDR = ch;
	while ( !( UCSRA & (1<<UDRE)) );
}

Bool Usart_GetMessage( AvrMessage* msg)
{

	static AvrPacketType packetType = PacketType_Undefined;
	static uint8_t msgLen = 0;
	static uint8_t nrOfConsumedBytes = 0;
	while( USART_rxBufferOut!=USART_rxBufferIn)
	{
		uint8_t nextOutput = (USART_rxBufferOut+1) % USART_RX_BUFFER_SIZE;
		if( packetType == PacketType_Undefined)
		{
			packetType = USART_rxBuffer[USART_rxBufferOut];
			USART_rxBufferOut = nextOutput;
			msgLen =0;
		}
		else if( msgLen == 0)
		{
			msgLen =  USART_rxBuffer[USART_rxBufferOut];
			msgLen -=2;
			USART_rxBufferOut = nextOutput;
			nrOfConsumedBytes = 0;
		}
		else if( nrOfConsumedBytes < msgLen )
		{
			msg->Payload[nrOfConsumedBytes++] =  USART_rxBuffer[USART_rxBufferOut];
			USART_rxBufferOut = nextOutput;
			if( nrOfConsumedBytes == msgLen)
			{
				msg->MsgType = packetType;
				msg->Length = msgLen;
				packetType = PacketType_Undefined;
				return True;
			}
		}
	}
	return False;
}

ISR(USART_RXC_vect)
{

	while(UCSRA&(1<<RXC))
	{
		char receivedChar = UDR;
		uint8_t nextInput = (USART_rxBufferIn + 1)%USART_RX_BUFFER_SIZE;
		if( (nextInput) != USART_rxBufferOut )
		{	
			USART_rxBuffer[USART_rxBufferIn] = receivedChar;
			USART_rxBufferIn = nextInput;
		}
	}
	
}

