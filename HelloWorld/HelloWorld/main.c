/*
 * HelloWorld.c
 *
 * Created: 05.11.2019 07:42:24 
 * Author : Rolf Laich
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>
#include "HelloWorldTypes.h"

/**
* Initialisierung der seriellen Schnittstelle
*/
void Usart_Init(void);

/** 
* Schreiben eines einzelnen Zeichens auf die serielle Schnittstelle
*/
void Usart_PutChar( char ch);



char helloWorld[] = "hello world\n";

int main(void)
{
	InitializeServoCtrl();
	DDRB = 0xFF; // set port b as output!
	DDRA = 0;	 // set port a as input!
	
	volatile uint8_t portB = 0xFF;
	uint16_t i = 0;
	uint16_t j = 0;    
	Usart_Init();
	uint8_t userInput = 1;
	
	char *chPtr = helloWorld;
	while(*chPtr)
	{
		Usart_PutChar(*chPtr++);
	}
	
    while (userInput) 
    {	
		PORTB = portB;
		portB = ~portB;
		
		for( i = 0; i < 1000; i++)
		{
			for(j = 0; j < 200; j++);
		}
		
		
		userInput = PINA&1;
		//Usart_PutChar(userInput);
		static AvrMessage msg;
		
		if ( Usart_GetMessage(&msg) )
		{
			uint8_t i = 0;
			if( msg.MsgType == PacketType_TestCommand)
			{
				if( msg.Payload[0] == CmdIdServoPos )
				{
					Usart_PutChar(0xAA);
					SetPosition(msg.Payload[1]);
				}
			}
			while( i < msg.Length)
			{
				Usart_PutChar(msg.Payload[i++]);
			}	
		}
		
		
		
    }
}



