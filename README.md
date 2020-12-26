# Contents 
<img src="https://user-images.githubusercontent.com/46196385/99855226-9d52e680-2b86-11eb-9b21-aa7be37c54b5.jpg" width="100" height="100"/>

- Toolchain to work with avr boards. This includes the gcc toolchain and avrdude. Prerequisites:
  - make utilitiy
  - Python 3.7.x, 
  - .Net
  - TODO: Simplify Setup
- AvrTerminal: GUI to interact with the board:
  - Display read and write registers of the board. The register description is provided by means of a xml file
  - Receive and display formatted trace from the baord
  - Write single byte commands to the board
- A library to support class projects. The library includes:
  - A specific header for hardware descriptions
  - A simple state event framework.

 
