class Button { // Button object
  PVector position, dimentions;
  boolean on, playSound = false; // flag to check if button is turned on (options menu)
  PImage img;
  Button(int x, int y, int wid, int hei, PImage _img) { // constructor for buttons
    position = new PVector(x, y);
    dimentions = new PVector(wid, hei);
    img = _img;
    on = false;
  }
  Button(int x, int y, int wid, int hei, boolean isOn) { // constructor for options menu buttons
    position = new PVector(x, y);
    dimentions = new PVector(wid, hei);
    img = transparentimg; // giving a transparent img to a button just to be able to track its borders if it doesn't have an image
    on = isOn; // is the button selected?
  }

  void display() {
    if (hoveredOver() || on) { //if mouse over button or button is turned on draw green rectangle around it
      noFill();
      stroke(0, 205, 0);
      strokeWeight(5);
      rect(position.x - 5, position.y - 5, dimentions.x + 10, dimentions.y + 10); // draw green outline
      if (!playSound && !on && soundFxOn.on) {
        SELECT.play(); // sound for hovering over a button
        playSound = true; // flag that the sound has been played so that the sound doesn't keep playing over and over again
      }
    } else playSound = false; // resets the flag to false if the mouse no longer hovers over the button
    image(img, position.x, position.y, dimentions.x, dimentions.y);
  }

  boolean hoveredOver() { // check if the mouse is over the button
    return (mouseX > position.x && mouseX < position.x + dimentions.x && mouseY < position.y + dimentions.y && mouseY > position.y); // returns true if the mouse is in the buttons boundaries and false otherwise
  }
}
