# Freeze-Tag-in-Verilog
Freeze Tag game written in Verilog to be used with any FPGA

# Description:

The purpose of this project is to design a freeze tag game using the BASYS3 board, VGA monitor, and pure logic. The player controls a green 16 by 16 square using directional buttons, and is able to move anywhere in the active region, governed by 4 blue walls. If the square comes in contact with any of the walls, it will bounce off in the opposite direction, as long as the player does not ‘wallride’, by holding the corresponding directional button. The objective of the game is to tag all 8 randomly falling red rectangles within the set time. If the player wins, the borders will flash, indicating the player has won. If time runs out before the player tags all the rectangles, the game will automatically reset, and time won’t start to count down until the first rectangle has been tagged.

# Methods:

In the top module the following modules were implemented: count8, count4, edgeDetector, vgaControlMod, taggerMod, updownTagger, lfsr, count8D, redRectangle, count14D, ringCounter, selector, hex7seg.

count8 - an 8 bit counter used to generate a high signal after 4 seconds, (~255 frames). Used to time how long to flash the green square at the beginning of the game. 

count4 - an 4 bit counter used to generate a high signal every eighth of a second. (8 frames) Used as the flash rate of all flashing objects.

edgeDetector  - Used to edge detect btnC press, so that even when the button is held down, the game won’t constantly be resetting itself.

vgaControlMod - Using 2 ten-bit counters, one for horizontal and vertical sweep, this module keeps track of hOut, vOut, hSync, vSync, as well as defining wall boundaries.

taggerMod - Handles creation of the green tagger. This module also contains its own set of 2 ten-bit counters, one for horizontal and vertical motion. 

updownTagger - The State Machine for the tagger, this handles logic on how the ball should behave based on directional button presses, and wall collisions. This module is reused twice, once for vertical motion, and repeated again for horizontal motion.

lfsr - Linear Feedback shift register, used to generate a sudo-random number. The result of which is randomly fed into 8 different 8-bit busses, used to load 8 different count8D modules.

count8D - an 8 bit decrement counter, used to count down from a loaded value to 0 (TC). There are 8 different counters, one for each rectangle. Once TC is high, count8D sends a signal for the rectangle to begin dropping down.

redRectangle - Handles creation of red rectangle, and is responsible for movement. This module has a nested state machine: rectangleSM mod, which is responsible for that rectangle’s logic, movement, and flashing states.

count14D - Timer that the player can set, if the player tags all 8 rectangles before time runs out, the timer freezes. If the timer runs out before the player can tag all 8 rectangles, the timer will reset back to its initial value. The value of the timer can be set using switches[15:7].

ringCounter / selector / hex7seg - These modules are used to display output to hex 7 display
