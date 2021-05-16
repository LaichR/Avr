/***
 * @file: AvrLib.h
 * 
 * AvrLib privides the definitions to use the AvrLib Library. The AvrLib provides upporting functions for the course ICT M121 and M242 
 * 
 * @Author: Rolf Laich
 * 
 */



#ifndef AVRLIB_H_
#define AVRLIB_H_

 /**************************************************************************************/
 /*                   type definitions                                                 */
 /**************************************************************************************/

#define TRACE(traceStr,...)
#define countof(array)      (sizeof(array)/sizeof(array[0]))

//#define DEBUG_PORT B
#ifdef DEBUG_PORT
#define cat(x,y)    x ## y
#define xcat( x, y) cat(x,y)
#define SET_DBG_PIN(x) xcat(Port,DEBUG_PORT).PORT |= (1<<x)
#define CLR_DBG_PIN(x) xcat(Port,DEBUG_PORT).PORT &= ~(1<<x)
#else
#define SET_DBG_PIN(x) 
#define CLR_DBG_PIN(x)
#endif

#define _withinIsr *((volatile uint8_t*)0x3e)

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
    ExtInterruptSource0, ///< Int0
    ExtInterruptSource1  ///< Int1
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
    CompareMatchSource1=0, ///< Tcnt0 OCRA
    CompareMatchSource2=1, ///< Tcnt0 OCRB
    CompareMatchSource3=2, ///< Tcnt2 ORCA
    CompareMatchSource4=3, ///< Tcnt2 ORCB
}CompareMatchSource;


/**
* @brief enum describing the timer divisions supported by the function *RegisterCompareMatchInterrupt()*
* 
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

/**
* This enumerate defines the defined messages that are exchanged between PC and board
*/
typedef enum
{
	 PacketType_Undefined = 0,                  ///< spare
	 PacketType_LiftSimulatorButton = 0xA2,     ///< a button on the AVR terminal application was pressed. The data is in the payload[0] byte
	 PacketType_TestCommand = 0xA3,             ///< a test command was sent from the AVR terminal application
     PacketType_RawData = 0xA4,                 ///< raw date is transmitted from any UART channel
     PacketType_ReadRegister = 0xA6,            ///< read register command
     PacketType_WriteRegister = 0xA8,           ///< write register command
     PacketType_TraceMassagePadLen = 0xA8,      ///< The unused of this value hold the length of a trace message
	 PacketType_TraceMessage = 0xA5,            ///< a trace message is sent from the board to the PC
} AvrPacketType;

/**
* Genreic structure of a data packate that is used to exchange data between PC and Board
* 
* The length of the packet is restricted to 14 bytes. The available memory space is quite little!
*/
 typedef struct AvrMessage_tag
 {
	 AvrPacketType MsgType; ///< Type of the packet
	 uint8_t Length;        ///< Length of the payload
	 uint8_t Payload[14];   ///< data of the packet // the used length may be smaller
 }AvrMessage;


/**
* @brief Der Typ Message modlliert ein asynchrones Ereignis. Einem solchen Ereignis können Daten mitgegeben werden. 
*
* Im StateEvent-Frameword der AvrLib werden Messages verwendet, um Ereinisse zu signalisiern und Informationen zwischen Zustandsmaschinen auszutauschen. 
* Mit der Funktion \ref SendMessage werden Meldungen erzeugt und verschickt. Ereignisse werden in einer Queue zwischengespeichert, bevor sie beim Empfänger bearbeitet werden.
* Meldungen mit grosser Priorität werden vor Meldungen mit kleiner Priorität bearbeit. Innerhalb derselben Priorität gilt FIFO Ordnung.
* 
*/
 typedef struct Message_tag
 {
     uint8_t Priority;				///< Definiert die Priorität; je kleiner die Zahl, desto grösser die Priorität;
                                    ///  Es sind 8 Prioritäten defniert.
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
 typedef Bool (*AvrMessageHandler)(const AvrMessage* msg);


 /**
* @brief Repräsentiert eine Zustandsmaschine
*
* Die Zustandsmaschinen werden verwendet, um die verschiedenen Zustände eines bestimmten Objektes zu implementieren.
* Dabei ist jeder Zustand eine Funktion vom Typ \ref StateHandler. Eine Funktion implementiert also einen Zustand der Maschine. 
* Bei einem Zustandsübergang wird dem Feld CurrentState eine andere Zustandsfunktion zugewiesen.
* Eine oder mehrere Zustandsmaschinen können im Framework registriert werden. Beim Auftreten einer \ref Message, werden alle registrierten Zustandsmaschinen benachrichtigt. 
* Falls das Feld RxMask die Priorität der Meldung enthält,
* wird die \ref Message an die entsprechende Zustandsmaschine weitergeleitet.
* 
* 
*/
 typedef struct Fsm_tag
 {
     struct Fsm_tag* Next;			///< nächste registrierte Zustandsmaschine; dieses Feld wird vom Framework verwendet!
     uint8_t RxMask;			    ///< Maske, welche angibt, welche *Prioritäyten* bearbeitet werden sollen
     StateHandler CurrentState;		///< Funktion, welche den aktuellen Zustand representiert
 }Fsm;




/**************************************************************************************/
/*                   Function Prototypes                                              */
/**************************************************************************************/

/** \defgroup Functions Available Function Prototypes
* @{
*/



 /**
 * @brief Initialize Framework
 *
 * The framework starts the dispatch loop and allows to receive messages
 * from the PC
 * The PB5 is set as output in order to allow LED indications. The call to \ref InitializeStateEventFramework will never return. Hence all code that follows is not reachable!
 */
 void InitializeStateEventFramework(void);

/**
* @brief Register a test handler
* 
* @param handler function
* 
* The handler can react on uart messages sent from the PC. Note: a default handler is already installed
* In case a custom handler is registered, the default handler should be called as fallback handler. 
* Otherwise reading and writing registers will not work anymore.
*/

 AvrMessageHandler RegisterAvrMessageHandler(AvrMessageHandler handler);

 /**
 * @brief This is the default message handler which is set during initialisation of global variables.
 * 
 * The default message handler handles all read and write regiseter requests from the PC.
 * Custom implementations can call this DefaultHandler. In case the return value is False, the Default handler did not do anything and it is appropriate to
 * do something with the message.
 * 
 * @param msg this is the received message
 * @return indicates if the message was handled by the implementation. 
 */
 Bool DefaultMessageHandler(const AvrMessage* msg);

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
 * @brief Switch on/off the intterrupt of a specified external interrupt source without chaning its configuration
 * 
 */
 void SetExtInterruptEnable(ExtInteruptSource source, Bool enable);

 /**
 * @brief Execute a single measurement on the ADC. 
 * 
 * A single measurement is started. The caller is blocked until the measurement completes.
 * 
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
 * The timer variable will hence overflow every 2^23 us = 8 388 608us  > 8s
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
* @brief guarantee exclusive access!
*/
void EnterAtomic(void);

void LeaveAtomic(void);

/**
* @brief mark beginning of ISR
*/
void IsrEnter(void);

/**
* @brief mark end of ISR
*/
void IsrLeave(void);

/** @} */

#endif /* AVRLIB_H_ */
