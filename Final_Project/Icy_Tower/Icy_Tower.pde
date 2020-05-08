import java.util.ArrayList; 
import java.util.*;

ArrayList<Floor> floors;
Character harold;
Game game;
int ground;
PImage[] platforms = new PImage[1];
PImage img;
PImage bg;
Sprite harold_still;
Sprite harold_walking;
Sprite harold_jumpingUp;
Sprite harold_jumpingSideways;
Sprite harold_spinning;
Sprite harold_falling;


class Sprite{
  PImage img;
  int wid, hei, numimgs, index = 0;
  Sprite(String name, int _wid, int _hei, int _numimgs){
    img = loadImage(name);
    wid = _wid;
    hei = _hei;
    numimgs = _numimgs;
  }
  void playAnimation(PVector pos, int direction){
    if (direction == 1){
      image(img, pos.x, pos.y+game.screenShift, wid*1.5, hei*1.5, wid*index, 0, wid*(index+1), hei);
    } else {
      image(img, pos.x, pos.y+game.screenShift, wid*1.5, hei*1.5, wid*(index+1), 0, wid*index, hei);
    }
    if (frameCount % 12 == 0) index = (index + 1) % numimgs;
  }
  void rewind(){
    index = 0;
  }
}


class Floor {
  PVector position, dimentions;
  float speed;
  // PImage img;
  int floor;

  Floor(int floor_nmbr, int y) {
    dimentions = new PVector(random(200, 600), 50);
    position = new PVector(random(width - dimentions.x), y);
    speed = 0.01;
    floor = floor_nmbr;
  }
  Floor() {
    dimentions = new PVector(width, 50);
    position = new PVector(0, height - 50);
    speed = 0;
    floor = 0;
  }

  void display() {
    //fill(0, 130, 210);
    //rect(position.x, position.y+game.screenShift, dimentions.x, dimentions.y);
    //img.resize(int(dimentions.x), int(dimentions.y));
    image(img, position.x, position.y+game.screenShift, dimentions.x, dimentions.y);
    update();
  }
  void update() {
    position.y += speed;
  }
}


class Character {
  PVector position, velocity, acceleration;
  boolean boostMode;
  float diameter;
  PImage img;
  float ground;
  int direction = 0;
  Sprite idle;
  Sprite walk;
  Sprite jump;
  Sprite jumpSideways;
  Sprite spin;
  Sprite fall;

  Character() {
    idle = harold_still;
    walk = harold_walking;
    jump = harold_jumpingUp;
    jumpSideways = harold_jumpingSideways;
    spin = harold_spinning;
    fall = harold_falling;
    diameter =  150;
    ground = height - diameter/2 - 50;
    position = new PVector(width/2, ground);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);   
  }

  void display() {
    // fill(210, 130, 0);
    // circle(position.x, position.y+game.screenShift, diameter);
    if (boostMode) {
      spin.playAnimation(position, 1);
      if (velocity.y > 3) boostMode = false;
    }
    else if(velocity.y < - 50) {
      spin.playAnimation(position, 1);
      boostMode = true;
    }
    else if(velocity.y < 0 && abs(velocity.x) < 0.5) jump.playAnimation(position, 1);
    else if(velocity.y < 0 && velocity.x > 0.5) jumpSideways.playAnimation(position, 1);
    else if(velocity.y < 0 && velocity.x < - 0.5) jumpSideways.playAnimation(position, -1);
    else if(velocity.y > 3 && velocity.x < 0) fall.playAnimation(position, -1);
    else if(velocity.y > 3 && velocity.x >= 0) fall.playAnimation(position, 1);
    else if(abs(velocity.x) < 0.5) idle.playAnimation(position, 1);
    else if(velocity.x < 0.5) walk.playAnimation(position, -1);
    else if(velocity.x > 0.5) walk.playAnimation(position, 1);
    //idle.playAnimation(position, 1);
    update();
  }
  void update() {
    position.add(velocity);
    velocity.add(acceleration);
    hitGround();
    if (position.y==ground) {
      position.y = ground;
      velocity.y = 0;
      acceleration.y = 0;
    } else {
      if (position.y + velocity.y > ground) velocity.y = ground - position.y;
      acceleration.y = 2;
    }


    if (abs(velocity.x) < 1) {
      velocity.x = 0;
      acceleration.x = 0;
    }
    if (position.x > width - diameter/2) {
      position.x = width - diameter/2; 
      velocity.x = - velocity.x*.75;
      acceleration.x = - acceleration.x;
    } else if (position.x < diameter/2) {
      position.x = diameter/2; 
      velocity.x = - velocity.x*.75;
      acceleration.x = - acceleration.x;
    }
  }
  void jump() {
    if (abs(position.y - ground) < 3) {
      velocity.y += -40-abs(velocity.x);
      position.y -= 0.5;
    }
  }
  void moveLeft() {
    velocity.x = -abs(velocity.x);
    velocity.x -= 3;
  }

  void moveRight() {
    velocity.x = abs(velocity.x);
    velocity.x += 3;
  }
  void hitGround() {
    for (int i = floors.size() - 1; i>= 0; i--) {
      if (position.y + diameter/2   < floors.get(i).position.y && 
        position.x >= floors.get(i).position.x && 
        position.x <= floors.get(i).position.x + floors.get(i).dimentions.x) {
        ground = floors.get(i).position.y - diameter/2;
        //velocity.y =  floors.get(i).speed;
        return;
        //position.y = ground;
      }
    }
    if (game.screenShift > 0) ground = height - diameter/2;
    else ground = floors.get(0).position.y - diameter/2;
  }
}

class Game {
  float screenShift;
  Game() {
    screenShift = 0;
    floors.add(new Floor());
    floors.add(new Floor(1, 550));
    floors.add(new Floor(2, 400));
    floors.add(new Floor(3, 250));
    floors.add(new Floor(4, 100));
  }
  void display() {
    // image(bg, 0, 0, width, height);

    if (harold.position.y <= 0) {
      if (screenShift + harold.position.y <= 100) {
        screenShift -= harold.velocity.y - 2;
      } else {
        if ( harold.velocity.y>0) {
          screenShift += 1;
        } else {
          screenShift -= int(harold.velocity.y/6)-1;
        }
      }
    }

    for ( Floor floor : floors) {
      floor.display();
    }
    harold.display();
    update();
  }
  void update() {
    if ( floors.get(floors.size()-1).position.y >= 150 - screenShift) {
      floors.add(new Floor(floors.get(floors.size()-1).floor+1, -int(screenShift)));
      floors.remove(0);
    }
  }
}


void setup() {
  size(1000, 800);
  img = loadImage("floor1.png");
  bg = loadImage("bg.jpg");
  harold_still = new Sprite("idle-harold.png", 38, 73, 4);
  harold_walking = new Sprite("walking-harold.png", 38, 73, 4);
  harold_jumpingUp = new Sprite("jumping-harold.png", 38, 71, 1);
  harold_jumpingSideways = new Sprite("jumping2-harold.png", 38, 71, 1);
  harold_spinning = new Sprite("spinning-harold.png", 60, 60, 12);
  harold_falling = new Sprite("falling-harold.png", 38, 71, 1);
  floors = new ArrayList<Floor>();
  harold = new Character();
  game = new Game();
  ground = height;
}

void draw() {
  background(100, 100, 180);
  game.display();
  //for( Floor floor: floors) floor.display();
  //harold.display();
  //if (frameCount % 300 == 0) floors.add(new Floor(floors.get(floors.size()-1).floor));
}

void keyPressed() {
  if (keyCode == LEFT) harold.moveLeft();                                               
  else if (keyCode == RIGHT) harold.moveRight();                                                         
  else if (key == ' ') harold.jump();
}
void keyReleased() {
  if (keyCode == LEFT && harold.velocity.x < 0) harold.velocity.x = 0;                                               
  else if (keyCode == RIGHT&& harold.velocity.x > 0) harold.velocity.x = 0;                                                         
  else if (key == ' ') harold.jump();
}
