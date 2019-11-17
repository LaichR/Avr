/*
 * HelloWorldTypes.h
 *
 * Created: 12.11.2019 09:29:58
 *  Author: rolfl
 */ 


#ifndef HELLOWORLDTYPES_H_
#define HELLOWORLDTYPES_H_

#define MAX_MESSAGE_SIZE 16

typedef enum
{
	False = 0,
	True = 1
} Bool;

 typedef enum
 {
	 PacketType_Undefined = 0,
	 PacketType_TraceMessage = 1,
	 PacketType_LiftSimulatorButton = 2,
	 PacketType_TestCommand = 3
 }AvrPacketType;
 
 typedef enum
 {
	 CmdIdServoPos = 1,
 } TestCommandId;
 
 typedef struct AvrMessage_tag
 {
	 AvrPacketType MsgType;
	 uint8_t Length;
	 uint8_t Payload[8];
 }AvrMessage;

typedef struct ServoControlMsg_tag
{
	uint8_t cmd;
	uint8_t position; // this is expected to be a value between 0 and 16;
}ServoControlMsg;


Bool Usart_GetMessage( AvrMessage* msg);
void Usart_PutChar(char ch);

void EnterAtomic(void);
void LeaveAtomic(void);

void SetPosition(uint8_t pos);

void InitializeServoCtrl(void);

#endif /* HELLOWORLDTYPES_H_ */