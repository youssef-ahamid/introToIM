#include "pitches.h"

int recordSwitch = 11;
int n = 0; // n is a counter that holds the index of the current note in the melody array

class Key {
  public:
    int noteNumber;
    unsigned long duration;
    unsigned long startMillis;
    bool on; // shows whether or not this is a pause
    bool filler; // if this is on, then it is an empty note; fixed error with creating the array of keys
    Key::Key() {
      filler = true;
      on = false;
    }
};

Key melody[20];

int buttons[] = {
  2, 4, 7, 8
};
int notes[] = {
  NOTE_C4, NOTE_G3, NOTE_A3, NOTE_B3
};

// array of buttons corresponding to the notes

void playRecording(Key note) {
  unsigned long tempMillis = millis();
  while (millis() - tempMillis <= note.duration) {
    play(note.noteNumber);
    // plays the note for its duration
  }
  noTone(5);
}


void play(int note) {
  tone(5, notes[note]);
}

void setup() {
}

void loop() {
  if (digitalRead(recordSwitch))  {
    int temp = 0; // this checks if it looped through all buttons.
    for (int i = 0; i < 4; i++) {
      if (digitalRead(buttons[i])) {
        melody[n].startMillis = millis();
        melody[n].noteNumber = i;
        melody[n].on = true;
        melody[n].filler = false;
        while (digitalRead(buttons[i])) {
          play(i);
        }
        melody[n].duration = millis() - melody[n].startMillis;
        noTone(5);
        n++;
      }
      else {
        temp ++;
      }
    }
    if (temp == 3) {
      melody[n].startMillis = millis();
      bool check = true;
      while (check) {
        noTone(5);
        for (int i = 0; i < 4; i++) {
          if (digitalRead(buttons[i]) || !digitalRead(recordSwitch)) {
            check = false;
            break;
          }
        }
      }
      melody[n].duration = millis() - melody[n].startMillis;
      melody[n].on = false;
      n++; // goes to next note
    }
  }
  else if (n >= 1 and melody[0].on) {
    for (int i = 0; i < n; i++) {
      if (!melody[i].on) {
        unsigned long tempMillis = millis();
        while (millis() - tempMillis <= melody[i].duration) {
          noTone(5);
        }
        // plays pause note
      }
      else {
        playRecording(melody[i]);
      }
    }
  }
  else {
    for (int i = 0; i < 4; i++) {
      while (digitalRead(buttons[i])) {
        play(i);
      }
      noTone(5);
    }
  }
}

//else {
//  while (digitalRead(buttons[i])) {
//    play(i);
//  }
//  noTone(5);
//}
//}
//if (!digitalRead(recordSwitch) && !melody[0].filler) {
//  for (Key note : melody) {
//    if (!note.filler) {
//      playRecording(note);
//    }
//    else {
//      break;
//    }
//  }
