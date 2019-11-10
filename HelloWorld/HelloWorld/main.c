/*
 * HelloWorld.c
 *
 * Created: 05.11.2019 07:42:24
 * Author : Rolf Laich
 */ 

#include <avr/io.h>

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
	
}

/*************************************************************
	private implementations: do not consider
**************************************************************/

void Usart_Init(void)
{
	
	UBRRH = 0;
	//UBRRL = 12;							// initialize baud rate = 38400 at 8MHZ
	UBRRL = 5;								// initialize baud rate 34800 at 3.68MHz
	UCSRC = 0x86;							// 8 data bits, 1 stop bit, not parity; docu page 162
	UCSRB = (1<<TXEN);						// enabe tx, 

}


void Usart_PutChar( char ch)
{
	UDR = ch;
	while ( !( UCSRA & (1<<UDRE)) );
}

