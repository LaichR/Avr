/*
 * Vlc.c
 *
 * Created: 12.03.2021 16:15:00
 * Author : rolfL
 */ 

#include "atmega328p.h"
#include "AvrLib.h"
#include "RegisterAccess.h"


Bool HandleMessageFromPc(const AvrMessage* msg);


int main(void)
{
	
    Usart_Init(250000);
	
	TRACE("Hello World");

	RegisterAvrMessageHandler(HandleMessageFromPc);

	InitializeStateEventFramework();
	
	return 0;
}

Bool HandleMessageFromPc(const AvrMessage* msg )
{
	return True;
}

