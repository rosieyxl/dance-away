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

**Audio Portion**
Our project plays audio via hard coded sounds. This is done through passing a square wave, at specific frequencies which correspond to notes, into the audio output. The notes to be played are stored within an FMS, with one state holding either a note to be played or a rest. The Song FSM’s state is incremented every beat to play a song.

A rate divider is used on the 50MHz system clock to produce the correct beat for the song currently played. The pulse of the beat is determined through 2 different things:
The BPM of the song
The difficulty at which the game is being played at
Easy: x0.75 speed
Normal: x1 speed
Hard: x1.5 speed

The game ends when the song finishes playing, at which point a signal will be sent through the song_finisehd wire. The code for the Audio Controller is given by the University of Toronto.

![Audio output diagram](https://github.com/rosieyxl/dance-away/blob/main/images/image1.1.png)
 **Internal Logic**
 Main FSM States Portion

Our project has 4 main states:
- Main menu
    - Contains the title screen
    - Pressing any of the 4 inputs will move you to the next stage
- Song Selector
    - Selects 1 of 3 songs
- Difficulty Selector
    - Selects 1 of 3 difficulties
- Gameplay (detailed in the next portion)

![Main FSM state diagrams](https://github.com/rosieyxl/dance-away/blob/main/images/image1.2.png)

**Inputs Portion**
Our game relies on inputs from the user, which is currently implemented using the PS2 keyboard, which also serves as a selector/search tool to navigate the game. The inputs are retrieved using the four navigation keys: up (to select), down (to go back), left and right (to search). In order for our keyboard to fully function, we modified demo and controller files (provided by the University of Toronto).

A finite state machine is used to track the different states the keyboard goes into when a user selects a specific key. If for instance the user decides to press the select button multiple times or remains pressing on the key, then the program goes into a hold state in which that input is fed into data received.

![PS2 Keyboard diagram](https://github.com/rosieyxl/dance-away/blob/main/images/image4.png)

**VGA Portion**
VGA output for this project consists of two components: static background displays, and the moving arrows descending the screen during gameplay.

The static background displays change according to input from the user, such as the selection of a difficulty level or a song. All the possible background images are converted into Memory Initialization Files (MIFs), and used to initialize a block of on-chip memory. The FSM controlling the static displays will switch to the respective state, and display the appropriate colour onto each pixel, using the respective MIF.

As for the moving display, each of the four arrows images was also converted into a MIF. Based on a randomly-generated number, one of the four is chosen at a time, and the arrow is very quickly drawn, erased, then drawn a little lower each time, giving it the impression of it moving down the screen. Additionally, to allow for smoother movement, the code for the VGA adapter (given by the University of Toronto) was altered to accommodate double buffering.

![VGA moving arrow display diagram](https://github.com/rosieyxl/dance-away/blob/main/images/image2.png)
