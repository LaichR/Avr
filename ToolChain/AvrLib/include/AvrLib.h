/***
 * AvrLib.h
 *
 * Supporting functions for the course ICT M242
 *
 */


#ifndef AVRLIB_H_
#define AVRLIB_H_

 /**************************************************************************************/
 /*                   type definitions                                                 */
 /**************************************************************************************/

#define TRACE(traceStr,...)
#define countof(array)      (sizeof(array)/sizeof(array[0]))


/**************************************************************************************/
/*                   type definitions                                                 */
/**************************************************************************************/


typedef enum
{
	False = 0,
	True = 1
} Bool;

typedef enum
{
    ExtInterruptSource0,
    ExtInterruptSource1
}ExtInteruptSource;

typedef enum
{
    ExtIntTrigger_OnLow = 0,
    ExtIntTrigger_OnChange = 1,
    ExtIntTrigger_OnFallingEdge = 2,
    ExtIntTrigger_OnRaisingEdge = 3,
}ExtIntTrigger;

typedef enum
{
    CompareMatchSource1,
    CompareMatchSource2,
    CompareMatchSource3,
    CompareMatchSource4,
}CompareMatchSource;

typedef enum
{
    TimerFrequency_Div1 = 0,
    TimerFrequency_Div8 = 1,
    TimerFrequency_Div64 = 2,
    TimerFrequency_Div256 = 3,
    TimerFrequency_Div1024 = 4,
}TimerFrequency;

typedef enum
{
    Priority_0, ///<small numbers have low priority
    Priority_1,
    Priority_2,
    Priority_3,
    Priority_4,
    Priority_5,    
    Priority_6,
    Priority_7,
} Priority_T;

typedef enum
{
    MessageId_Undefined = 0,
    MessageId_HwEvent = 1,
} MessageId;

typedef enum
{
	 PacketType_Undefined = 0,
	 PacketType_LiftSimulatorButton = 0xA2,
	 PacketType_TestCommand = 0xA3,
     PacketType_RawData = 0xA4,
     PacketType_ReadRegister = 0xA6,
     PacketType_WriteRegister = 0xA8,
     PacketType_TraceMassagePadLen = 0xA8,
	 PacketType_TraceMessage = 0xA5,     
} AvrPacketType;


 typedef struct AvrMessage_tag
 {
	 AvrPacketType MsgType;
	 uint8_t Length;
	 uint8_t Payload[12];
 }AvrMessage;


 /**
* @brief Item um Information zwischen verschiedenen Komponenten des Systems auszutauschen.
*
*
*/
 typedef struct Message_tag
 {
     uint8_t Priority;				///< Definiert die Priorität; je kleiner die Zahl, desto grösser die Priorität;
                                    ///  Es sind vier Prioritäten defniert
     uint8_t Id;					///< Id der Meldung
     union
     {
         struct
         {
             uint8_t MsgParamLow;			///< lower byte[0] des Meldungs-Parameters
             uint8_t MsgParamHigh;			///< upper byte[1] des Meldungs-Paramsters
         };
         void* Ptr;                         ///< man kann die Parameter auch als Pointer interpretieren
     };
     struct Message_tag* __next;                ///< element with next priority
 }Message;
 


 /**
 * @brief Prototyp einer InterruptServiceRoutine
 */

 typedef void (*IsrHandler)(void);

 /**
 * @brief Prototyp einer Zustandsfunktion
 */
 typedef void (*StateHandler)(const Message* msg);

 /**
 * @brief Prototyp eines AvrPacketHandlers
 */
 typedef void (*AvrMessageHandler)(const AvrMessage* msg);


 /**
* @brief Repräsentiert eine Zustandsmaschine
*
* Eine oder mehrere Zustandsmaschinen können im Framework registriert werden. Beim Auftreten einer Meldung werden alle
* Zustandsmaschinen, welche auf diese *EventSource* registriert sind, notifiziert
*/
 typedef struct Fsm_tag
 {
     struct Fsm_tag* Next;			///< nächste registrierte Zustanndsmaschine; internal use only!
     uint8_t RxMask;			    ///< Maske, welche angibt, welche *Prioritäyten* bearbeitet werden sollen
     StateHandler CurrentState;		///< Funktion, welche den aktuellen Zustand representiert
 }Fsm;




/**************************************************************************************/
/*                   Funktion Prototypes                                              */
/**************************************************************************************/


 /**
 * @brief Initialize Framework
 *
 * The framework starts the dispatch loop and allows to receive messages
 * from the PC
 */
 void InitializeStateEventFramework(void);

/**
* @brief Registriert einen Test handler für die Bearbeitung von Uart Inputs
* 
*/

 void RegisterAvrMessageHander(AvrMessageHandler handler);

 /**
 * @brief Setup exernal Interrupt source
 * 
 * Setup external interrupt source. This includes the configuration of the HW and the
 * enabling of the interrupts;
 */
 void RegisterExternalInteruptHandler(ExtInteruptSource source,
     ExtIntTrigger trigger, IsrHandler handler);

 /**
 * Disable intterupts and unregister a previously registered handler
 */
 void UnregisterExternalInterruptHandler(ExtInteruptSource source);

 /**
 * @brief Setup compare match interrupt on one of four available interrupt sources
 * 
 * This function sets up the timer block in order to generate compare match interrupts
 * Note: CompareMatchSource0 and CompareMatchSource1 refer to the HW Tcnt0
 * CompareMatchSource2 and CompareMatchSource3 refer to Tcnt1. Changing the frequency
 * changes the frequenty of both interrupt sources of the timer!
 */
 void RegisterCompareMatchInterrupt(CompareMatchSource source,
     TimerFrequency frequency, uint8_t match, IsrHandler handler);

 void UnregisterCompareMatchInterrupt(CompareMatchSource source);


/**
* @brief Registriert eine Zustandsmaschine im Framework
* @param fsm Zustandsmaschine, welche registriert werden soll
*/
void RegisterFsm(Fsm* fsm);

/**
* @brief Funktion für das Ausführen eine *Zustandübergangs*
*
* @param fsm Zuststandsmaschine, welche den Zustandsübergang ausführen soll
* @param state Funktion, welche den neuen Zustand implementiert
*/
void SetState(Fsm* fsm, StateHandler state);


/**
* @brief Funktion zum Senden einer Meldung
*
* @param prio Priorität, mit welcher die Meldung bearbeitet werden soll
* @param id Id der Meldung
* @param msgLow low byte des Meldungs-Parameters
* @param msgHigh upper byte des Meldungs-Parameters
*/
void SendMessage(uint8_t prio, uint8_t id, uint8_t msgLow, uint8_t msgHigh);

/**
* @brief Funktion um ein event an die registrierten Zustandsmaschinen zu verteilen
*
* @return Status welcher angibt, ob die Meldungsqueue leer war;
*  - False: es war keine Meldung in der Queue;
*  - True: eine Meldung wurde dispatched.
* Der return wert kann sinnvoll sein, um den Prozessor in den sleep mode zu stellen.
*/
Bool DispatchEvent(void);

/**
* @brief initialize port D to use the uart
*/
void Usart_Init(uint32_t baudrate);

/**
* Don't bother about these implementations; you should not use them directly;
* that's up to the build process!
*/
void Usart_Trace0(uint16_t id );
void Usart_Trace1(uint16_t id, uint8_t val);
void Usart_Trace2(uint16_t id, uint8_t val1, uint8_t val2);
void Usart_Trace3(uint16_t id, uint8_t val1, uint8_t val2, uint8_t val3);
void Usart_Trace4(uint16_t id, uint8_t val1, uint8_t val2, uint8_t val3, uint8_t val4);

/**
* @brief Put one charactor to the Uart
*
* This might be useful in case we are very time critical with tracing!
*/
void Usart_PutChar(char ch);

/**
* @brief Guarantee exclusive access!
*/
void EnterAtomic(void);

void LeaveAtomic(void);


#endif /* AVRLIB_H_ */
