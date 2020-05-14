class Screen { // Screen object
  Button[] buttons; // array of all buttons in the screen
  PImage background;
  Screen(PImage bg, Button[] _buttons) {
    buttons = _buttons;
    background = bg;
  }

  void run() {
    image(background, 0, 0, width, height);
    for (Button bt : buttons) { // display all buttons in the screen
      bt.display();
    }
  }
}
