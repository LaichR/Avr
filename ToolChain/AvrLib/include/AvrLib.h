/***
 * AvrLib.h
 *
 * Supporting functions for the course ICT M121 and M242
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


/**
* @brief enum describing the usable interrupt sources
* 
*/

typedef enum
{
    ExtInterruptSource0,
    ExtInterruptSource1
}ExtInteruptSource;

/**
* @brief enum describing the trigger events on the interrupt sources. The enum names should be self-expanatory
* 
*/
typedef enum
{
    ExtIntTrigger_OnLow = 0,
    ExtIntTrigger_OnChange = 1,
    ExtIntTrigger_OnFallingEdge = 2,
    ExtIntTrigger_OnRaisingEdge = 3,
}ExtIntTrigger;


/**
* @brief Enum identifying the supported compare match trigger sources
* 
* 
*/
typedef enum
{
    CompareMatchSource1=0,
    CompareMatchSource2=1,
    CompareMatchSource3=2,
    CompareMatchSource4=3,
}CompareMatchSource;


/**
* @brief enum describing the timer devisions supported by teh function: RegisterCompareMatch
*/
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
/*                   Function Prototypes                                              */
/**************************************************************************************/


 /**
 * @brief Initialize Framework
 *
 * The framework starts the dispatch loop and allows to receive messages
 * from the PC
 */
 void InitializeStateEventFramework(void);

/**
* @brief Register a test handler
* 
* @param handler funktion
* 
* The handler can react on uart message sent from the PC. Note: a default handler is already installed
* in case a custom handler is register, the default handler should be called as fallback handler. 
* Otherwise reading and writing registers will not work anymore.
*/

 void RegisterAvrMessageHander(AvrMessageHandler handler);

 /**
 * @brief Setup exernal Interrupt source
 * 
 * @param source indicates the interrupt source, on Atmega328 this might be Int0 or Int1
 * @param trigger specifies, what change triggers the interrupt (raising, falling, any, low)
 * @param handler this is the function that handles the event
 * 
 * Setup external interrupt source. This includes the configuration of the HW and the
 * enabling of the interrupts;
 */
 void RegisterExternalInteruptHandler(ExtInteruptSource source,
     ExtIntTrigger trigger, IsrHandler handler);


 /**
 * @brief Execute a single measurement on the ADC. 
 * 
 * A single measurement is exeucted. The caller is blocked until the measurement completes
 * @param channel is the analog channel that is used in the measurement
 * @param Vref is the reference voltage to be used 
 * @param prescaler is the ADC prescaler. The higher the value the more time is used for the measurement and the more accurate the measurement will be.
 * @return measured value from ADC
 */
 uint16_t MeasureOnce(AnalogChannelSelection channel, ReferenceSelection Vref, AdcPrescaler prescaler);
 


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
 * Apparently CompareMatch1 only is operational if CompareMatch0 is running and CompareMatch3 is only operational if Comparematch2 is running.
 * This seems to be a HW constraint.
 * 
 * @param source source of comparematch interrupt
 * @param frequency division factor for timer. The base frequency is 16Mhz
 * @param handler the function that does the work
 */
 void RegisterCompareMatchInterrupt(CompareMatchSource source,
     TimerFrequency frequency, uint8_t match, IsrHandler handler);

 void UnregisterCompareMatchInterrupt(CompareMatchSource source);


 /**
 * @brief Start the Timer on Tcnt1 and reset internal counters
 * 
 * Tcnt1 holds a 16bit counter. In case the counter overflows, a int32 counter variable is incremented.
 * The counter variable is supposed to refelct the us since the last start of the counter!
 * (Timer-Frequency is set to 2Mhz)
 * The timer variable will hence overflow every 2^32 us 4295s  > 1h
 */
 void StartTimer(void);

 /**
 * Get the elapsed time since the last call to StartTimer
 * @return time in us
 */
 uint32_t GetElapsedTime(void);

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
