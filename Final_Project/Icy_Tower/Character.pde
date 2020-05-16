class Character {
  PVector position, velocity, acceleration;
  boolean boostMode, dead;
  float diameter;
  PImage img;
  float ground;
  int direction = 0, floor = 0;
  Sprite [] mySprite;

  Character(Sprite [] sprite) {

    mySprite = sprite;
    diameter =  150;
    ground = height - diameter/2 - 50;
    position = new PVector(width/2, ground);
    velocity = new PVector(0.0, 0.0);
    acceleration = new PVector(0, 0);
  }

  void display() {
    if (boostMode) {
      main.game.bonus += .5;
      if (soundFxOn.on && !SPIN.isPlaying()) SPIN.play();
      mySprite[4].playAnimation(position, 1);
      if (velocity.y > 3) {
        boostMode = false;
        SPIN.stop();
      }
    } else if (velocity.y < - 50) {
      mySprite[4].playAnimation(position, 1);
      boostMode = true;
    } else if (velocity.y < 0 && abs(velocity.x) < 0.5) {
      mySprite[2].playAnimation(position, 1);
      if (soundFxOn.on && !JUMP.isPlaying() && !JUMP2.isPlaying()) JUMP.play();
    } else if (velocity.y < 0 && velocity.x > 0.5) {
      mySprite[3].playAnimation(position, 1);
      if (soundFxOn.on && !JUMP2.isPlaying()) JUMP2.play();
    } else if (velocity.y < 0 && velocity.x < - 0.5) {
      mySprite[3].playAnimation(position, -1);
      if (soundFxOn.on && !JUMP2.isPlaying()) JUMP2.play();
    } else if (velocity.y > 3 && velocity.x < 0) mySprite[5].playAnimation(position, -1);
    else if (velocity.y > 3 && velocity.x >= 0) mySprite[5].playAnimation(position, 1);
    else if (abs(velocity.x) < 0.5) mySprite[0].playAnimation(position, 1);
    else if (velocity.x < 0.5) mySprite[1].playAnimation(position, -1);
    else if (velocity.x > 0.5) mySprite[1].playAnimation(position, 1);
    update();
  }

  void update() {
    if (position.y >  height - main.game.screenShift) {
      dead = true;
      if (soundFxOn.on && !DIE.isPlaying()) DIE.play();
    }
    position.add(velocity);
    velocity.add(acceleration);
    hitGround();
    if (direction == 1) {
      if (velocity.x < 0) velocity.x *= -.8;
      velocity.x += .5;
    } else if (direction == -1) {
      if (velocity.x > 0) velocity.x *= -.8;
      velocity.x -= .5;
    } else {
      acceleration.x = 0;
      velocity.x = 0;
    }
    if (velocity.x  > 40) velocity.x = 40;
    if (position.y==ground) {
      position.y = ground;
      velocity.y = 0;
      acceleration.y = 0;
    } else {
      if (position.y + velocity.y > ground) velocity.y = ground - position.y;
      acceleration.y = 2;
    }
    if (abs(velocity.x) < .5) {
      velocity.x = 0;
      acceleration.x = 0;
    }
    if (position.x > width - diameter/2) {
      position.x = width - diameter/2;
    } else if (position.x < diameter/2) {
      position.x = diameter/2;
    }
  }

  void jump() {
    if (abs(position.y - ground) < 3) {
      velocity.y += -40-abs(velocity.x);
      position.y -= 0.5;
    }
  }

  void hitGround() {
    for (int i = main.game.floors.size() - 1; i>= 0; i--) {
      if (position.y + diameter/2   < main.game.floors.get(i).position.y && 
        position.x >= main.game.floors.get(i).position.x - diameter/2 && 
        position.x <= main.game.floors.get(i).position.x + main.game.floors.get(i).dimentions.x) {
        ground = main.game.floors.get(i).position.y - diameter/2;
        if (main.game.floors.get(i).floor > floor) floor = main.game.floors.get(i).floor;
        return;
      }
    }
    if (main.game.screenShift > 0) ground = height - diameter/2;
    else ground = main.game.floors.get(0).position.y - diameter/2;
  }
}
