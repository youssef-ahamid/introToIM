# IM Rover
The IM (Self-Driven) Rover is comprised of chassis, two motorized wheels, one 360° (swivel) wheel (non-motorized) a few sensors, LED’s, a cardboard box and plastic piece. It is powered by 4 AA batteries using an Arduino Nano connected to two mini breadboards to control the motors and sensors. When it is turned on, it starts driving straight forward and the headlights get turned on. When it finds an obstacle ahead, the indicators start blinking, drives backwards, and then starts turning right, with the right indicator blinking to indicate a right turn, and will repeat the process until the ultrasonic sensors “see” free space. 

## Pictures of electronics and wiring

[<img align="center" src="https://github.com/youssef-ahamid/introToIM/blob/master/Midterm/bottom.jpg" alt="bottom" width="400">](#)
[<img align="right" src="https://github.com/youssef-ahamid/introToIM/blob/master/Midterm/front.JPG" alt="front" width="400">](#)

[<img align="center" src="https://github.com/youssef-ahamid/introToIM/blob/master/Midterm/top.JPG" alt="top" width="400">](#)
[<img align="right" src="https://github.com/youssef-ahamid/introToIM/blob/master/Midterm/side.jpg" alt="side" width="400">](#)

## Components:
1.	2x Gear Motors
2.	2x Car Tires
3.	1x 360° Wheel
4.	1x Arduino Board 
5.	2x Mini Breadboards
6.	1x Motor Driver 
7.	1x Ultrasonic Sensor HC SR04 
8.	4x AA Batteries 
9.	1x Battery Holder
10.	1x On-off switch
11.	2x White LED’s
12.	2x Yellow LED’s
13.	4x 330 Ohm Resistors


## A schematic diagram of the circuit is shown below

## Project Description

The car drives straight ahead whenever the switch is turned on, and will keep going forward until an object is detected with the ultrasonic sensor. In my code, I calculate the distance between the ultrasonic sensor (the front of the car) and the nearest object to it using the function getDistance(). If this distance is less than 20 inches, the car will stop, back up, and turn right. This is accomplished by manipulating the gear motors using the motor driver. The motor driver takes input from the Arduino board at pins A1, A2 and B1, B2 to drive both motors using pins A11, A12 and B11, B12 respectively (output). Setting either one of the motor driver’s input pins as HIGH and the other as LOW will cause the motor driver to drive in a particular direction. Alternating their digital values will cause current in the gear motors to flow in the opposite direction thus reversing their rotation. Initially, when the car is driving forward, both gear motors drive at the same speed of 255. Whenever an obstacle is detected, the digital values of the motor driver’s input pins (A1-A2, B1-B2) will be reversed, causing the car to drive backwards. After some delay, the left motor is set at a speed higher than the right one, causing the car to move to the right. The flashing yellow indicators blink whenever an obstacle is detected, and the right indicator will blink while maneuvering to the right.
The biggest problem I faced with this project is that one of the DC motors is always faster than the other, no matter how I manipulate the code. This causes the car to be in a constant turn instead of a forward movement. I have learnt that facing this problem is inevitable while dealing with DC motors. Also, the ultrasonic sensor will sometimes detect an object that is not there. I have minimized this using delays (worked for some unknown reason).

## Here are pictures of the final product!

