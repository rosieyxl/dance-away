# ECE 241 Final Course Project
**Contributors:** Rosie Liu, Napat Kaewkamnerd, Eshaa Chenthuran

**Introduction**
Our final project for the Digital Logic course, ECE241, at the University of Toronto: an adaptation of the classic arcade game, Dance Dance Revolution.

**Internal Logic (Napat + Rosie)**
- Multiple FSMs & datapaths
- Game logic (in progress)

**Inputs (Eshaa)**
- PS2 Keyboard input to FPGA Board
- Analog vibration sensors (in progress)
- Many state FSM (to manage sensor states)
- FPGA switches & keys
  
**Audio Output (Napat)**
- Audio output from FPGA Board
  
**VGA Output (Rosie)**
- Static VGA display (using large on-chip memory)
- Moving VGA display with double buffering

**VGA Portion**
VGA output for this project consists of two components: static background displays, and the moving arrows descending the screen during gameplay.

The static background displays change according to input from the user, such as the selection of a difficulty level or a song. All the possible background images are converted into Memory Initialization Files (MIFs), and used to initialize a block of on-chip memory. The FSM controlling the static displays will switch to the respective state, and display the appropriate colour onto each pixel, using the respective MIF.

As for the moving display, each of the four arrows images was also converted into a MIF. Based on a randomly-generated number, one of the four is chosen at a time, and the arrow is very quickly drawn, erased, then drawn a little lower each time, giving it the impression of it moving down the screen. Additionally, to allow for smoother movement, the code for the VGA adapter (given by the University of Toronto) was altered to accommodate double buffering.

![VGA moving arrow display diagram](https://github.com/rosieyxl/dance-away/blob/main/images/image2.png)