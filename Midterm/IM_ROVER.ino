//the right motor will be controlled by the motor A pins on the motor driver
const int AIN1 = 13;           //control pin 1 on the motor driver for the right motor
const int AIN2 = 12;            //control pin 2 on the motor driver for the right motor
const int PWMA = 11;            //speed control pin on the motor driver for the right motor

//the left motor will be controlled by the motor B pins on the motor driver
const int PWMB = 10;           //speed control pin on the motor driver for the left motor
const int BIN2 = 9;           //control pin 2 on the motor driver for the left motor
const int BIN1 = 8;           //control pin 1 on the motor driver for the left motor

const int speed = 255;      //motor speed
//distance variables
const int trigPin = 6;
const int echoPin = 5;

const int switchPin = 7;             //switch to turn the robot on and off

//lights variables
const int headLightsPin = 3;
const int leftIndicatorPin = 4;
const int rightIndicatorPin = 2;

//lights digital variables
bool leftIndicator = LOW;
bool rightIndicator = LOW;

float distance = 0;            //variable to store the distance measured by the distance sensor


/********************************************************************************/
void setup()
{
  pinMode(trigPin, OUTPUT);       //this pin will send ultrasonic pulses out from the distance sensor
  pinMode(echoPin, INPUT);        //this pin will sense when the pulses reflect back to the distance sensor

  pinMode(switchPin, INPUT_PULLUP);   //set this as a pullup to sense whether the switch is flipped


  //set the motor control pins as outputs
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);
  pinMode(PWMA, OUTPUT);

  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);
  pinMode(PWMB, OUTPUT);

  pinMode(headLightsPin, OUTPUT);
  pinMode(rightIndicatorPin, OUTPUT);
  pinMode(leftIndicatorPin, OUTPUT);

  Serial.begin(9600);                       //begin serial communication with the computer
  Serial.print("To infinity and beyond!");  //test the serial connection
}

/********************************************************************************/
void loop()
{
  //DETECT THE DISTANCE READ BY THE DISTANCE SENSOR
  distance = getDistance();
  delay(300); // fixed distance reading error for an unkown reason
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" in");              // print the units

  if (digitalRead(switchPin) == LOW) { //if the on switch is flipped

    digitalWrite(headLightsPin, HIGH);

    if (distance < 20) {              //if an object is detected
      //back up and turn
      Serial.print(" ");
      Serial.print("BACK!");

      //stop for a moment
      rightMotor(0);
      leftMotor(0);
      flash(leftIndicatorPin, rightIndicatorPin); //blinking indicators

      //back up
      rightMotor(-speed);
      leftMotor(-speed);
      flash(leftIndicatorPin, rightIndicatorPin); //blinking indicators

      //turn away from obstacle
      rightMotor(speed);
      leftMotor(-speed);
      flash(rightIndicatorPin, rightIndicatorPin); //will only blink right indicator

    } else {                        //if no obstacle is detected drive forward
      Serial.print(" ");
      Serial.print("Moving...");
      rightMotor(speed);
      leftMotor(speed);
    }
  } else {                        //if the switch is off then stop

    //stop the motors
    rightMotor(0);
    leftMotor(0);
    digitalWrite(headLightsPin, LOW);
  }

  delay(50);                      //wait 50 milliseconds between readings
}

/********************************************************************************/
void flash(int indicator1, int indicator2)
{
  // this causes a 200ms delay which is the amount of time that the robot will stop/back up/turn when it senses an object
      digitalWrite(indicator1, HIGH);
      digitalWrite(indicator2, HIGH);
      delay(50);
      digitalWrite(indicator1, LOW);
      digitalWrite(indicator2, LOW);
      delay(50);
      digitalWrite(indicator1, HIGH);
      digitalWrite(indicator2, HIGH);
      delay(50);
      digitalWrite(indicator1, LOW);
      digitalWrite(indicator2, LOW);
      delay(50); 
}
/********************************************************************************/
void rightMotor(int motorSpeed)                       //function for driving the right motor
{
  if (motorSpeed < 0)                                 //if the motor should drive forward (positive speed)
  {
    digitalWrite(AIN1, HIGH);                         //set pin 1 to high
    digitalWrite(AIN2, LOW);                          //set pin 2 to low
  }
  else if (motorSpeed > 0)                            //if the motor should drive backward (negative speed)
  {
    digitalWrite(AIN1, LOW);                          //set pin 1 to low
    digitalWrite(AIN2, HIGH);                         //set pin 2 to high
  }
  else                                                //if the motor should stop
  {
    digitalWrite(AIN1, LOW);                          //set pin 1 to low
    digitalWrite(AIN2, LOW);                          //set pin 2 to low
  }
  analogWrite(PWMA, abs(motorSpeed));                 //now that the motor direction is set, drive it at the entered speed
}

/********************************************************************************/
void leftMotor(int motorSpeed)                        //function for driving the left motor
{
  if (motorSpeed < 0)                                 //if the motor should drive forward (positive speed)
  {
    digitalWrite(BIN1, HIGH);                         //set pin 1 to high
    digitalWrite(BIN2, LOW);                          //set pin 2 to low
  }
  else if (motorSpeed > 0)                            //if the motor should drive backward (negative speed)
  {
    digitalWrite(BIN1, LOW);                          //set pin 1 to low
    digitalWrite(BIN2, HIGH);                         //set pin 2 to high
  }
  else                                                //if the motor should stop
  {
    digitalWrite(BIN1, LOW);                          //set pin 1 to low
    digitalWrite(BIN2, LOW);                          //set pin 2 to low
  }
  analogWrite(PWMB, abs(motorSpeed));                 //now that the motor direction is set, drive it at the entered speed
}

/********************************************************************************/
//RETURNS THE DISTANCE MEASURED BY THE HC-SR04 DISTANCE SENSOR
float getDistance()
{
  float echoTime;                   //variable to store the time it takes for a ping to bounce off an object
  float calculatedDistance;         //variable to store the distance calculated from the echo time

  //send out an ultrasonic pulse that's 10ms long
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  echoTime = pulseIn(echoPin, HIGH);      //use the pulsein command to see how long it takes for the
  //pulse to bounce back to the sensor

  calculatedDistance = echoTime / 148.0;  //calculate the distance of the object that reflected the pulse (half the bounce time multiplied by the speed of sound)

  return calculatedDistance;              //send back the distance that was calculated
}
