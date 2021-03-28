# Visual Light Communcation (VLC)
<p align="center"><img src="https://user-images.githubusercontent.com/46196385/112745591-e76f2d00-8fa9-11eb-95c1-da0239d32dd3.jpg" width= "350"/></p>

In this class project we transfer data from one metro board to the other. 
The communication will be done using two ordinary LEDS. 

In oder to achieve this goal we have to:
- **Transmit Data:** Transform the data into a blinking pattern of the LED.
- **Receive Data:** The energy of the blinking pattern has to be measured and transformed back to bytes.
- **Synchronization:** The above two processes (transmission/ receiption) have to be carried out in a well synchronized manner. 
  This has consequences on how to encode the data.
- **Protocol:** We may also think about error probabilities, recognition of errors and possible error handling. 
  As a consequence we will define a packet structure and a protocol.

The picuture below shows the recording of the reception of  a short byte sequence.

<p align="center"><img src="https://user-images.githubusercontent.com/46196385/112746285-1daeab80-8fae-11eb-9ceb-ac2f1db8243a.png" width= "350"/></p>
The red line shows the received signal. The blue line shows the bit sampling of the receiver. In one period of the blue signal, two bits are received.

All this will be done using the available RAM and Clock-Cycles of our microcontroller. 
While we are working on this project, we will 
repeatingly looking behind the scenes and try to understand:
- How our program starts?
- Where the variables are placed?
- What is an interrupt service handler and what happens, when the hardware raises an interrupt?
- What is a function call?


