class Button {
  PVector position, dimentions;
  boolean on;
  PImage img;
  Button(int x, int y, int wid, int hei, PImage _img) {
    position = new PVector(x, y);
    dimentions = new PVector(wid, hei);
    img = _img;
    on = false;
  }
  Button(int x, int y, int wid, int hei, boolean isOn) {
    position = new PVector(x, y);
    dimentions = new PVector(wid, hei);
    img = transparentimg;
    on = isOn;
  }

  void display() {
    if (hoveredOver() || on) {
      noFill();
      stroke(0, 205, 0);
      strokeWeight(5);
      rect(position.x - 5, position.y - 5, dimentions.x + 10, dimentions.y + 10);
    }
    image(img, position.x, position.y, dimentions.x, dimentions.y);
  }

  boolean hoveredOver() {
    if (mouseX > position.x && mouseX < position.x + dimentions.x && mouseY < position.y + dimentions.y && mouseY > position.y) return true;
    return false;
  }
}
