hack_dx6i
=========

Automatic Timer Start / Stop for Spektrum Dx6i Transmitter

          +-------+
+       NC | 1   8 | VCC (Check that never be higher than 5.5V)
+ Throttle | 2   7 | NC
+     Gear | 3   6 | NC
+      GND | 4   5 | Trainer Switch
+          +-------+
+           Attiny85

Connect this on the Dx6i spektrum. Two working mode set on power up:
 1- If the Throttle stick is at bottom, the timer is enabled by moving the stick and pause when stick return to bottom.
 2- If the Throttle stick is at middle, the timer is enabled/paused by the gear switch changes
 
 In all case, Trainer switch can bypass the automatic timer start.
