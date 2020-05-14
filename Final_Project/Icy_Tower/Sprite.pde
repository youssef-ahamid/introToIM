class Sprite { // Sprite object
  PImage img;
  int wid, hei, numimgs, index = 0; 
  Sprite(String name, int _wid, int _hei, int _numimgs) {
    img = loadImage(name);
    wid = _wid;
    hei = _hei;
    numimgs = _numimgs; // number of individual images in a sprite
  }
  void playAnimation(PVector pos, int direction) { 
    if (direction == 1) { // if the sprite image is looking to the right
      image(img, pos.x, pos.y+main.game.screenShift, wid*1.5, hei*1.5, wid*index, 0, wid*(index+1), hei); // Explained in README (TODO)
    } else {
      image(img, pos.x, pos.y+main.game.screenShift, wid*1.5, hei*1.5, wid*(index+1), 0, wid*index, hei); // Explained in README (TODO)
    }
    if (frameCount % (36/numimgs) == 0) // The speed of the animation as a function of the number of images
      index = (index + 1) % numimgs; // go to next image by incrementing the index
  }
}
