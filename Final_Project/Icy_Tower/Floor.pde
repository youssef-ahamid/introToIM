class Floor {
  PVector position, dimentions;
  float speed;
  int floor;

  Floor(int floor_nmbr, int y) {
    speed = 0.01;
    floor = floor_nmbr;
    dimentions = new PVector(random(200, 600 - 75*(int(floor/100)+1)), 50);
    position = new PVector(random(width - dimentions.x), y);
  }
  Floor() {
    dimentions = new PVector(width, 50);
    position = new PVector(0, height - 50);
    speed = 0;
    floor = 0;
  }

  void display() {
    image(platforms[int(floor/100) % 4], position.x, position.y+main.game.screenShift, dimentions.x, dimentions.y);
    update();
  }
  void update() {
    position.y += speed;
  }
}
