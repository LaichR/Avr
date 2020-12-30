# Lift Door

In this class project we control a simple model of a lift door. Part of this model is a DC motor and the motor driver, two light switches and the connected PC. The model is controlled through the metro board. It receives the user input from the PC (open door/close door) and controls the motor driver using the PWM generator. The light switche signals indicate when the motor has to stop again.<br>
With a block diagram the system may be represented as follows <img src="https://user-images.githubusercontent.com/46196385/103366688-90011400-4ac3-11eb-8e9e-65c0397db300.png" />
The descriptions on the connections between the different blocks indicate the used IO Ports of the microcontroller. Thus we have to deal with the following connections:
- **Microcontroller <-> PC**: The data is exchanged using serial data transmission. The PC sends the commands *Open Door* and *Close Door"*. The microcontroller may send trace information for debugging.
- **Microcontroller <-> Light switches**: The light switches are connected to PortD 2 and PortD 3. When a switch closes (e.g. the door reaches its final position) the respective pin gets the value 1. As soon the switch opens again, the value of the respective pin gets 0.
- **Microcontroller <-> Motordriver**: We connect the motor driver on PortD 5 and PortD 6. This means, we use TimerCounter 0 (Tcnt0) for the PWM generation. We need to use two signal lines to control the direction of the motor. Only on Signal will be active at the time and the signal that is not used has to be set to 0. We can achive this be just setting the dutycycle of the PWM to 0.

