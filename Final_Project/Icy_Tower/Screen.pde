class Screen {
  Button[] buttons;
  PImage background;
  Screen(PImage bg, Button[] _buttons) {
    buttons = _buttons;
    background = bg;
  }

  void run() {
    image(background, 0, 0, width, height);
    for (Button bt : buttons) {
      bt.display();
    }
  }
}
