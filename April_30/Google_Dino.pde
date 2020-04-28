import java.util.ArrayList;

Game myGame;

PImage dino_sprite;
PImage small_cacti;
PImage tall_cacti;
PImage mix_cacti;
PImage floor_img;
PImage cloud;
PImage game_over;
PImage restart;

PFont font;

int cloud_speed;
int LEEWAY;

int high_score;

Table t;



class Dino {
  PVector position, velocity;
  PImage img;
  float floor, gravity;
  int wid, hei, ind;
  boolean start, dead;

  Dino(int x, float y) {
    wid = 44;
    hei = 47;
    position = new PVector(x, y );
    velocity = new PVector(0, 0);
    floor = y;
    gravity = 0.5;
    img = dino_sprite;
    ind = 0;
  }

  void display() {
    image(img, position.x, position.y - hei, wid, hei, wid*ind, 0, wid* (ind+1), hei);
    position.y -= velocity.y;

    if (position.y >= floor) {
      position.y = floor;
      velocity.y = 0;
    } else {
      velocity.y -= gravity;
    }

    if (isDead()) {
      ind = 4;
      dead = true;
      velocity.set(0, 0);
    } else if (frameCount % 3 == 0 && start && velocity.y == 0) {
      ind = (ind + 1) % 4;
    }
  }

  void jump() {
    if (position.y == floor && !dead) {
      velocity.y = 10;
      ind = 0;
      velocity.x = 5 + myGame.level * 2;
      start = true;
    }
  }

  boolean isDead() {
    for (Cacti obstacle : myGame.obstacles) 
      if (!obstacle.survived && obstacle.position - position.x < wid - LEEWAY && obstacle.position - position.x > 0 && position.y > floor - obstacle.hei) return true;
    return false;
  }
}

class Cacti {
  int type, position, timer, ind, wid, hei;
  boolean survived;
  PImage img;

  Cacti() {
    survived = false;
    timer = 0;
    type = int(random(3));
    position = width;
    switch(type) {
    case 0: 
      img = tall_cacti;
      ind = int(random(4));
      wid = 25;
      hei = 50;
      break;
    case 1: 
      img = small_cacti;
      ind = int(random(6));
      wid = 17;
      hei = 35;
      break;
    case 2: 
      img = mix_cacti;
      ind = 0;
      wid = 51;
      hei = 50;
      break;
    }
  }

  void display() {
    timer ++;
    if (myGame.dino.ind != 4) {
      position -= myGame.dino.velocity.x;
    }
    image(img, position, myGame.floor - hei, wid, hei, wid*ind, 0, wid* (ind+1), hei);
  }
}


class Cloud {
  PVector position;

  Cloud() {
    position =  new PVector(width, random(myGame.floor - 100));
  }

  Cloud(float x, float y) {
    position =  new PVector(x, y);
  }

  void display() {
    image(cloud, position.x, position.y, 46, 13);
    if (myGame.dino.velocity.x != 0) position.x -= cloud_speed;
  }
}

class Game {
  Dino dino;
  float floor;
  ArrayList<Cacti> obstacles;
  ArrayList<Cloud> clouds;
  int level;
  float shift_floor;
  int score;

  Game() {
    score = 0;
    shift_floor = 0;
    level = 1;
    floor = 250;
    obstacles = new ArrayList<Cacti>();
    clouds = new ArrayList<Cloud>();
    dino = new Dino(50, floor);
    obstacles.add(new Cacti());
    clouds.add(new Cloud(random(100, width), random(floor - 100)));
    clouds.add(new Cloud(random(100, width), random(floor - 100)));
  }

  void display() {
    image(floor_img, 0 + shift_floor, floor-8, 1200, 15);
    image(floor_img, 1200 + shift_floor, floor-8, 1200, 15);
    textFont(font);
    fill(0);
    text("Score: " + score, 20, 20);
    pushStyle();
    textAlign(RIGHT);
    text("HI: " + high_score, width - 20, 20);
    popStyle();
    shift_floor = (shift_floor-dino.velocity.x)%-1200;
    level = int(score/100) + 1;
    for (Cacti obstacle : obstacles) {
      obstacle.display();
      if (obstacle.position < dino.position.x) {
        obstacle.survived = true;
      }
    }
    for (Cloud cloud : clouds) {
      cloud.display();
    }
    dino.display();
    if (!dino.dead) {
      if (obstacles.get(0).timer > random(50, 140) && frameCount % 12 == 0) {
        obstacles.add(new Cacti());
        obstacles.get(0).timer = 0;
      }
      if (frameCount % 200 == 0) {
        clouds.add(new Cloud());
      } 
      if (frameCount % 10 == 0 && dino.start) {
        score++;
        if (score > high_score) high_score = score;
      }
    } else { 
      restartScreen();
    }
  }

  void restartScreen() {
    pushStyle();
    imageMode(CENTER);
    image(restart, width/2, height/2, 36, 32);
    image(game_over, width/2, height/2 - 50, 400, 22);
    popStyle();
  }
}

void changeColor(PImage img) {
  img.loadPixels();
  float r = random(255);
  float g = random(255);
  float b = random(255);
  for (int i = 0; i < img.pixels.length; i++) {
    if (img.pixels[i] == color(255) || img.pixels[i] == color(0)){
      continue;
    } else if (alpha(img.pixels[i]) != 0){
      color new_color = color(r, g, b);
      img.pixels[i] = new_color;
      img.updatePixels();
    } 
  }
  
}

void setup() {
  //ellipseMode(CENTER);
  size(600, 360);

  dino_sprite = loadImage("run.png");
  tall_cacti = loadImage("tall_cactus.png");
  small_cacti = loadImage("small_cactus.png");
  mix_cacti = loadImage("cactus_mix.png");
  floor_img = loadImage("floor.png");
  cloud = loadImage("cloud.png");
  restart = loadImage("restart.png");
  game_over = loadImage("game_over.png");

  font = createFont("dinofont.ttf", 16);

  cloud_speed = 1;

  LEEWAY = 5;

  loadPixels();

  t = loadTable("HI.csv", "header");
  TableRow row = t.getRow(0);
  high_score = int(row.getInt("HI"));

  myGame = new Game();
}

void draw() {
  background(255);
  myGame.display();

  
}

void keyPressed() {
  if (key == ' ') myGame.dino.jump();
}

void mouseClicked() {
  if (myGame.dino.dead && mouseX < width/2 + 18 && mouseX > width/2 - 18 && mouseY < height/2 + 16 && mouseY > height/2 - 16) {
    myGame = new Game();
    t.getRow(0).setInt("HI", high_score);
    saveTable(t, "HI.csv");
  } else if (mouseX > myGame.dino.position.x && mouseX < myGame.dino.position.x + myGame.dino.wid && mouseY > myGame.dino.position.y && mouseY < myGame.dino.position.y + myGame.dino.hei){
    changeColor(dino_sprite);
  } else if (mouseX > myGame.obstacles.get(0).position && mouseX < myGame.obstacles.get(0).position + myGame.obstacles.get(0).wid && mouseY > myGame.floor - myGame.obstacles.get(0).hei && mouseY < myGame.floor){
    changeColor(tall_cacti);
    changeColor(small_cacti);
    changeColor(mix_cacti);
  } else if (mouseX > myGame.dino.position.x && mouseX < myGame.dino.position.x + myGame.dino.wid && mouseY > myGame.dino.position.y && mouseY < myGame.dino.position.y + myGame.dino.hei){
    changeColor(cloud);
  } else if (mouseX > myGame.dino.position.x && mouseX < myGame.dino.position.x + myGame.dino.wid && mouseY > myGame.dino.position.y && mouseY < myGame.dino.position.y + myGame.dino.hei){
    changeColor(dino_sprite);
  }
}
