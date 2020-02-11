
int pushButton = 9; 


void setup() {
  pinMode(pushButton, INPUT);
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(8, OUTPUT);
}

void loop() {
  int buttonState = digitalRead(pushButton);
  if (buttonState) { 
    delay(1500);
    digitalWrite(13, HIGH); 
    digitalWrite(12, LOW);
    delay(5000);
    digitalWrite(13, LOW);
    digitalWrite(8, HIGH);
    delay(7000);
  } else { 
    digitalWrite(12, HIGH);
    digitalWrite(13, LOW);
    digitalWrite(8, LOW);
    delay(1500);
  }
}
