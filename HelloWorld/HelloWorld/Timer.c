/*
 * Timer.c
 *
 * Created: 16.11.2019 17:50:48
 *  Author: rolfl
 */ 

#include <inttypes.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include "HelloWorldTypes.h"

#define INIT_LOW -22
#define LOW_LIMIT -8
#define HIGH_LIMIT 8

volatile uint16_t baseRateTimer;
static int8_t _servo1Pos = LOW_LIMIT;
static int8_t highPulsDuration = INIT_LOW;
static uint8_t enterAtomicNesting = 0;

void EnterAtomic(void)
{
	cli(); // this just forces the bit to be cleared; should be possible to call this many times without side effect
	enterAtomicNesting ++;
}

void LeaveAtomic(void)
{
	enterAtomicNesting--;
	if(enterAtomicNesting == 0)
	{
		sei();
	}
}


#define ServoPort PORTC
#define ServoPins PINC;
#define DDRServo DDRC


void TogglePortPin(uint8_t pin)
{
	uint8_t curValue = ServoPins;
	
	if( curValue&pin)
	{
		ServoPort &=~pin;
	}
	else
	{
		ServoPort |= pin;
	}
	
	
}

void SetPosition(uint8_t pos)
{
	int8_t relPos = pos - 8;
	if( relPos > HIGH_LIMIT)
	{
		relPos = HIGH_LIMIT;
	}
	else if( relPos < LOW_LIMIT )
	{
		relPos = LOW_LIMIT;
	}
	
	EnterAtomic();	
	_servo1Pos = relPos;
	LeaveAtomic();
	
}


void InitializeServoCtrl(void)
{

	
	ServoPort &= ~0x01;	
	DDRServo = 0xFF;
	TCNT0 = 0;
	TCCR0 = 0x0D;	//prescaler = 5 (1024), wgm12=1 (0x8 =Clear timer on counter match)
	OCR0 = 40;
	TIMSK |=0x2;  // enable compare match irq
	
}

void StartControlPulse(void)
{
	highPulsDuration = INIT_LOW;
	TCCR2 = 0x01; // prescaler = 1 bei 3600000 Hz => 2.2us = 450 ticks für gesamtausschlag 
	TCNT2 = 0;
	OCR2 = 1;
	TIMSK |=0x80;  // enable compare match irq
	ServoPort |= 1;
	
};


ISR(TIMER0_COMP_vect)
{
	baseRateTimer = 0;
	StartControlPulse();
	TogglePortPin(2); 
}

ISR(TIMER2_COMP_vect)
{

	highPulsDuration++;
	if(highPulsDuration >= _servo1Pos)
	{
		TCCR2 = 0;
		TIMSK &= ~0x80;
		ServoPort &= ~1;		
	}	
}

