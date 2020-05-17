class Character { // character object
  PVector position, velocity, acceleration;
  boolean boostMode, dead; // is the player in boost mode? Is the player dead?
  float diameter;
  PImage img;
  float ground;
  int direction = 0, floor = 0; // direction is 0 if idle, -1 if left, 1 if right. Floor is the current floor
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
      main.game.bonus += .5; // add bonus if player in boost mode
      if (soundFxOn.on && !SPIN.isPlaying()) SPIN.play(); // play the spinning sound if it is not already playing
      mySprite[4].playAnimation(position, 1); // play the spinning animation
      if (velocity.y > 3) { // if the player is falling
        boostMode = false; // reset boost mode
        SPIN.stop(); // stop playing the spin sound
      }
    } else if (velocity.y < - 50) {
      mySprite[4].playAnimation(position, 1); // if player jumps very fast turn on boost mode and play spin animation
      boostMode = true;
    } else if (velocity.y < 0 && abs(velocity.x) < 0.5) { // play an upward jump animation if horizontal vel is close to 0 and y vel < 0 (jump)
      mySprite[2].playAnimation(position, 1);
      if (soundFxOn.on && !JUMP.isPlaying() && !JUMP2.isPlaying()) JUMP.play(); // soundFX
    } else if (velocity.y < 0 && velocity.x > 0.5) { // play an horizontal jump to the right animation if horizontal vel > 0 and y vel < 0 (jump)
      mySprite[3].playAnimation(position, 1);
      if (soundFxOn.on && !JUMP2.isPlaying()) JUMP2.play(); // soundFX
    } else if (velocity.y < 0 && velocity.x < - 0.5) { // play an horizontal jump to the left animation if horizontal vel < 0 and y vel < 0 (jump)
      mySprite[3].playAnimation(position, -1);
      if (soundFxOn.on && !JUMP2.isPlaying()) JUMP2.play(); // soundFX
    } else if (velocity.y > 3 && velocity.x < 0) mySprite[5].playAnimation(position, -1); // fall to the left
    else if (velocity.y > 3 && velocity.x >= 0) mySprite[5].playAnimation(position, 1); // fall to the right
    else if (abs(velocity.x) < 0.5) mySprite[0].playAnimation(position, 1); // idle
    else if (velocity.x < 0.5) mySprite[1].playAnimation(position, -1); // walk left
    else if (velocity.x > 0.5) mySprite[1].playAnimation(position, 1); // walk right
    update();
  }

  void update() {
    if (position.y >  height - main.game.screenShift) { // if the player is out of the screen
      dead = true;
      if (soundFxOn.on && !DIE.isPlaying()) DIE.play(); // play dead soundFX
    }
    position.add(velocity);
    velocity.add(acceleration);
    hitGround();
    if (direction == 1) {
      if (velocity.x < 0) velocity.x *= -.8; // flip direction with .8 of the current speed 
      velocity.x += .5;
    } else if (direction == -1) {
      if (velocity.x > 0) velocity.x *= -.8;
      velocity.x -= .5;
    } else {
      acceleration.x = 0;
      velocity.x = 0;
    }
    if (velocity.x  > 40) velocity.x = 40; // limit x velocity
    if (position.y==ground) {
      position.y = ground;
      velocity.y = 0;
      acceleration.y = 0;
    } else {
      if (position.y + velocity.y > ground) velocity.y = ground - position.y; // to make sure player falls right onto the ground not above or below it
      acceleration.y = 2; // gravity
    }
    if (abs(velocity.x) < .5) { // stop moving if speed is close to 0
      velocity.x = 0;
      acceleration.x = 0;
    }
    // keep in boundaries
    if (position.x > width - diameter/2) { 
      position.x = width - diameter/2;
    } else if (position.x < diameter/2) {
      position.x = diameter/2;
    }
  }

  void jump() {
    if (abs(position.y - ground) < 3) { // if position is close to ground
      velocity.y += -40-abs(velocity.x); // jump with boost from x velocity
      position.y -= 0.5; // fixes error
    }
  }

  void hitGround() {
    for (int i = main.game.floors.size() - 1; i>= 0; i--) { // iterating over all floors from top to bottom and setting the ground to the highest floor the player is over
      if (position.y + diameter/2   < main.game.floors.get(i).position.y && position.x >= main.game.floors.get(i).position.x - diameter/2 && position.x <= main.game.floors.get(i).position.x + main.game.floors.get(i).dimentions.x) {
        ground = main.game.floors.get(i).position.y - diameter/2;
        if (main.game.floors.get(i).floor > floor) floor = main.game.floors.get(i).floor; // set the current floor to this floor if it's higher
        return; // exit the funtion
      }
    }
    if (main.game.screenShift > 0) ground = height - diameter/2; // if none is found the ground is the height of the screen 
    else ground = main.game.floors.get(0).position.y - diameter/2;
  }
}
