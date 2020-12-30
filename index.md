# Welcome to AVR

The Avr project contains resources for class projects related to the courses held at GIBZ in 2020/21.

## The metro board <img src="https://user-images.githubusercontent.com/46196385/99855226-9d52e680-2b86-11eb-9b21-aa7be37c54b5.jpg" width="100" height="100"/>
In the courses we use the [Adafruit metro board](https://www.adafruit.com/product/2488?gclid=EAIaIQobChMI383B5Yr27QIVEgOLCh1_Vw1FEAAYAiAAEgJi-PD_BwE). 
The metro board is compatible with the arduino toolchain. Since we are working exclusively with C we use not the arduino toolchain but a custom one. The used toolchain is based on the gcc avr toolchain. <br>
In [this link](https://cdn-shop.adafruit.com/product-files/2488/Adafruit+Metrol_v2_0.pdf) you can find a simple overview of the metro board board. The diagram shows the exposed pins and their functions.
The metro board is equiped with a atmega328p microcontroller. The datasheet of this microcontroller you can find [here](http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf)

##  AvrLib and its headers

The library AvrLib provides the basic functionalities for the class projects. This includes:
- The typdefs for the relevant (used) HW-blocks
- Some macros to easily set bitfields within registers
- A tracing framework to support little overhead tracing
- A simple state event framework

The librar is documented using Doxygen. The current html version is available [here](docs/html_docs/html/index.html)

## Class Projects

- [Lift-Door](docs/ProjDoor)