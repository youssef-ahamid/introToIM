import java.util.ArrayList; 
import java.util.*;

ArrayList<Floor> floors;
Character harold;
Game game;
int ground;

class Floor {
  PVector position, dimentions;
  float speed;
  PImage img;
  int floor;

  Floor(int floor_nmbr, int y) {
    dimentions = new PVector(random(200, 600), 50);
    position = new PVector(random(width - dimentions.x), y);
    speed = 1;
    floor = floor_nmbr;
  }
  Floor() {
    dimentions = new PVector(width, 50);
    position = new PVector(0, height - 50);
    speed = 0;
    floor = 0;
  }

  void display() {
    fill(0, 130, 210);
    rect(position.x, position.y+game.screenShift, dimentions.x, dimentions.y);
    update();
  }
  void update() {
    position.y += speed;
  }
}


class Character {
  PVector position, velocity, acceleration;
  float diameter;
  PImage img;
  float ground;
  int direction = 0;
  Hashtable<String, String> key_handler = new Hashtable<String, String>();


  Character() {
    diameter = 100;
    ground = height - diameter/2 - 50;
    position = new PVector(width/2, ground);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);   
    key_handler.put("LEFT", "");
    key_handler.put("RIGHT", "");
    key_handler.put("UP", "");
  }

  void display() {
    fill(210, 130, 0);
    circle(position.x, position.y+game.screenShift, diameter);
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
      velocity.y += -40;
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
        position.x - diameter/2 <= floors.get(i).position.x + floors.get(i).dimentions.x) {
        ground = floors.get(i).position.y - diameter/2;
        //velocity.y =  floors.get(i).speed;
        return;
        //position.y = ground;
      }
    }
    ground = floors.get(0).position.y - diameter/2;
  }
}

class Game {
  float screenShift;
  Game() {
    screenShift = 0;
    floors.add(new Floor());
    floors.add(new Floor(1, 550));
    floors.add(new Floor(2, 300));
    floors.add(new Floor(3, 50));
  }
  void display() {
    if (harold.position.y <= 0) {
      if (screenShift + harold.position.y <= 100) {
        screenShift -= harold.velocity.y - 2;
      } else {
        if ( harold.velocity.y>0) {
          screenShift += 1;
        } else {
          screenShift -= harold.velocity.y/3-2;
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
    println(screenShift);
    if ( floors.get(floors.size()-1).position.y >= 250 - screenShift) {
      floors.add(new Floor(floors.get(floors.size()-1).floor+1, -int(screenShift)));
      floors.add(new Floor(floors.get(floors.size()-1).floor+1, -int(screenShift)-250));
      floors.add(new Floor(floors.get(floors.size()-1).floor+1, -int(screenShift)-500));
    }
  }
}


void setup() {
  size(1000, 800);
  floors = new ArrayList<Floor>();
  harold = new Character();
  game = new Game();
  ground = height;
}

void draw() {
  background(235);
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
  if (keyCode == LEFT) harold.velocity.x = 0;                                               
  else if (keyCode == RIGHT) harold.velocity.x = 0;                                                         
  else if (key == ' ') harold.jump();
}
