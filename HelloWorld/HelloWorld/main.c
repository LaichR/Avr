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
* @brief Initialisierung der seriellen Schnittstelle
*
*/
void Usart_Init(void);

/** 
* @brief Schreiben eines einzelnen Zeichens auf die serielle Schnittstelle
*/
void Usart_PutChar( char ch);

/** 
* @brief Funktion um eine RaceCondition sichtbar zu machen
*
*/
void CatchRace(void);

char helloWorld[] = "hello world\n";

int main(void)
{

}


void CatchRace(void)
{
	uint16_t oldTimer = baseRateTimer;
	baseRateTimer ++;
	uint16_t newTimer = baseRateTimer;
	if ( oldTimer+1 != newTimer )
	{
		
		Usart_PutChar(0xAA);
		Usart_PutChar(oldTimer&0xFF);
		Usart_PutChar(oldTimer>>8);
		Usart_PutChar(0xAA);
		Usart_PutChar(newTimer&0xFF);
		Usart_PutChar(newTimer>>8);
	}
}
