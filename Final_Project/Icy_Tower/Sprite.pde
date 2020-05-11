class Sprite {
  PImage img;
  int wid, hei, numimgs, index = 0;
  Sprite(String name, int _wid, int _hei, int _numimgs) {
    img = loadImage(name);
    wid = _wid;
    hei = _hei;
    numimgs = _numimgs;
  }
  void playAnimation(PVector pos, int direction) {
    if (direction == 1) {
      image(img, pos.x, pos.y+main.game.screenShift, wid*1.5, hei*1.5, wid*index, 0, wid*(index+1), hei);
    } else {
      image(img, pos.x, pos.y+main.game.screenShift, wid*1.5, hei*1.5, wid*(index+1), 0, wid*index, hei);
    }
    if (frameCount % (36/numimgs) == 0) index = (index + 1) % numimgs;
  }
  void rewind() {
    index = 0;
  }
}
