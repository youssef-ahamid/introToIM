import java.util.ArrayList; 
import java.util.*;


Character player;
int ground;
PImage[] platforms = new PImage[1];
PImage img;
PImage  pauseimg, playimg, instructionsimg, soundimg, play_againimg, main_menuimg, leaderimg, 
  optionsimg, backimg, options_screenimg, bg1, bg2, bg3, bg4, bg5, transparentimg;
Main main;
Button pause;                                          
Button play;
Button instructions;
Button sound;
Button play_again;
Button main_menu;
Button leader;
Button options;
Button musicOn;
Button soundFxOn;
Button musicOff;
Button soundFxOff;
Button rookie;
Button amateur;
Button pro;
Button legend;
Button character1;
Button character2;
Button back;
Screen options_screen;
Screen home_screen;
Screen instructions_screen;
Screen game_screen;
Screen leaderboard_screen;
Sprite[] haroldSprite = new Sprite[6];

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


class Button {
  PVector position, dimentions;
  boolean on;
  PImage img;
  Button(int x, int y, int wid, int hei, PImage _img) {
    position = new PVector(x, y);
    dimentions = new PVector(wid, hei);
    img = _img;
    on = false;
  }
  Button(int x, int y, int wid, int hei, boolean isOn) {
    position = new PVector(x, y);
    dimentions = new PVector(wid, hei);
    img = transparentimg;
    on = isOn;
  }

  void display() {
    if (hoveredOver() || on) {
      noFill();
      stroke(0, 205, 0);
      strokeWeight(5);
      rect(position.x - 5, position.y - 5, dimentions.x + 10, dimentions.y + 10);
    }
    image(img, position.x, position.y, dimentions.x, dimentions.y);
  }

  boolean hoveredOver() {
    if (mouseX > position.x && mouseX < position.x + dimentions.x && mouseY < position.y + dimentions.y && mouseY > position.y) return true;
    return false;
  }
}


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
    image(img, position.x, position.y+main.game.screenShift, dimentions.x, dimentions.y);
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
  int direction = 0, floor = 0;
  Sprite [] mySprite;

  Character(Sprite [] sprite) {
    mySprite = sprite;
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
      mySprite[4].playAnimation(position, 1);
      if (velocity.y > 3) boostMode = false;
    } else if (velocity.y < - 50) {
      mySprite[4].playAnimation(position, 1);
      boostMode = true;
    } else if (velocity.y < 0 && abs(velocity.x) < 0.5) mySprite[2].playAnimation(position, 1);
    else if (velocity.y < 0 && velocity.x > 0.5) mySprite[3].playAnimation(position, 1);
    else if (velocity.y < 0 && velocity.x < - 0.5) mySprite[3].playAnimation(position, -1);
    else if (velocity.y > 3 && velocity.x < 0) mySprite[5].playAnimation(position, -1);
    else if (velocity.y > 3 && velocity.x >= 0) mySprite[5].playAnimation(position, 1);
    else if (abs(velocity.x) < 0.5) mySprite[0].playAnimation(position, 1);
    else if (velocity.x < 0.5) mySprite[1].playAnimation(position, -1);
    else if (velocity.x > 0.5) mySprite[1].playAnimation(position, 1);
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
    for (int i = main.game.floors.size() - 1; i>= 0; i--) {
      if (position.y + diameter/2   < main.game.floors.get(i).position.y && 
        position.x >= main.game.floors.get(i).position.x && 
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

class Game {
  int score;
  float screenShift;
  ArrayList<Floor> floors;
  ;
  Game() {
    floors = new ArrayList<Floor>();
    screenShift = 0;
    floors.add(new Floor());
    floors.add(new Floor(1, 550));
    floors.add(new Floor(2, 400));
    floors.add(new Floor(3, 250));
    floors.add(new Floor(4, 100));
  }
  void display() {
    score = player.floor*10;
    if (player.position.y <= 0) {
      if (screenShift + player.position.y <= 100) {
        screenShift -= player.velocity.y - 2;
      } else {
        if ( player.velocity.y>0) {
          screenShift += 1;
        } else {
          screenShift -= int(player.velocity.y/6)-1;
        }
      }
    }

    for ( Floor floor : floors) {
      floor.display();
    }
    player.display();
    update();
  }
  void update() {
    if ( floors.get(floors.size()-1).position.y >= 150 - screenShift) {
      floors.add(new Floor(floors.get(floors.size()-1).floor+1, -int(screenShift)));
      floors.remove(0);
    }
  }
}

class Main {
  Game game;
  Screen currentScreen;
  float difficulty;
  Sprite[] character;

  Main() {
    game = new Game();
    currentScreen = home_screen;
    difficulty = 1;
    character = haroldSprite;
  }
  void run() {
    if (currentScreen == game_screen) game.display();
    else currentScreen.run();
  }
  void buttonClicked(Button bt) {
    if (bt == back || bt == main_menu) {
      currentScreen = home_screen;
    } else if (bt == play) {
      currentScreen = game_screen;
    } else if (bt == instructions) {
      currentScreen = instructions_screen;
    } else if (bt == options) {
      currentScreen = options_screen;
    } else if (bt == leader) {
      currentScreen = leaderboard_screen;
    } else if (bt == play_again) {
      restartGame();
    } else if (bt == musicOn) {
      musicOn.on = true;
      musicOff.on = false;
    } else if (bt == musicOff) {
      musicOn.on = false;
      musicOff.on = true;
    } else if (bt == soundFxOn) {
      soundFxOn.on = true;
      soundFxOff.on = false;
    } else if (bt == soundFxOff) {
      soundFxOn.on = false;
      soundFxOff.on = true;
    } else if (bt == rookie){
      difficulty = 1;
      rookie.on = true;
      amateur.on = false;
      pro.on = false;
      legend.on = false;
    } else if (bt == amateur){
      difficulty = 1.25;
      rookie.on = false;
      amateur.on = true;
      pro.on = false;
      legend.on = false;
    } else if (bt == pro){
      difficulty = 1.5;
      rookie.on = false;
      amateur.on = false;
      pro.on = true;
      legend.on = false;
    } else if (bt == legend){
      difficulty = 2;
      rookie.on = false;
      amateur.on = false;
      pro.on = false;
      legend.on = true;
    } else if (bt == character1){
      character1.on = true;
      character2.on = false;
      player.mySprite = haroldSprite;
    } else if (bt == character2){
      character1.on = false;
      character2.on = true;
      player.mySprite = haroldSprite;
    }
    
  }
  
  void restartGame() {
    player = new Character(character);
    game = new Game();
  }
}


void setup() {
  size(1150, 800);
  img = loadImage("floor1.png");
  playimg = loadImage("play.png");
  instructionsimg = loadImage("instructions.png");
  play_againimg = loadImage("play-again.png"); 
  main_menuimg = loadImage("main-menu.png"); 
  leaderimg= loadImage("leader.png");
  optionsimg = loadImage("options.png"); 
  backimg= loadImage("back.png"); 
  bg1= loadImage("bg1.jpg"); 
  bg2= loadImage("bg2.jpg"); 
  bg3= loadImage("options.jpg"); 
  bg4= loadImage("instructions.jpg"); 
  bg5= loadImage("high-scores.jpg"); 
  transparentimg= loadImage("transparent.png");
  play = new Button(700, 400, 271, 76, playimg );
  instructions = new Button(700, 500, 271, 76, instructionsimg);
  play_again = new Button(400, 550, 134, 34, play_againimg);
  main_menu = new Button(400, 600, 134, 34, main_menuimg);
  leader = new Button(700, 600, 271, 76, leaderimg);
  options = new Button(700, 700, 192, 58, optionsimg);
  musicOn = new Button(750, 105, 90, 60, true);
  soundFxOn = new Button(750, 245, 90, 60, true);
  musicOff = new Button(895, 100, 105, 60, false);
  soundFxOff = new Button(895, 245, 105, 60, false);
  rookie = new Button(240, 495, 165, 55, true);
  amateur = new Button(410, 495, 220, 55, false);
  pro = new Button(645, 495, 90, 50, false);
  legend = new Button(745, 495, 160, 50, false);
  character1 = new Button(795, 560, 60, 100, true);
  character2 = new Button(900, 560, 60, 100, false);
  back = new Button(200, 700, 195, 60, backimg);
  Button[] optionsbuttons = {musicOn, soundFxOn, musicOff, soundFxOff, rookie, amateur, pro, legend, character1, character2, back};
  options_screen = new Screen(bg3, optionsbuttons);
  Button[] homeButtons = {play, instructions, leader, options};
  home_screen = new Screen(bg1, homeButtons);
  Button[] backButton = {back};
  instructions_screen = new Screen(bg4, backButton);
  Button[] inGameButtons = {play_again, main_menu};
  game_screen = new Screen(transparentimg, inGameButtons);
  leaderboard_screen = new Screen(bg5, backButton);
  haroldSprite[0] = new Sprite("idle-harold.png", 38, 73, 4);
  haroldSprite[1] = new Sprite("walking-harold.png", 38, 73, 4);
  haroldSprite[2] = new Sprite("jumping-harold.png", 38, 71, 1);
  haroldSprite[3] = new Sprite("jumping2-harold.png", 38, 71, 1);
  haroldSprite[4] = new Sprite("spinning-harold.png", 60, 60, 12);
  haroldSprite[5] = new Sprite("falling-harold.png", 38, 71, 1);

  player = new Character(haroldSprite);
  main = new Main();
}

void draw() {
  background(100, 100, 180);
  main.run();
}

void mouseClicked() {
  for (Button bt : main.currentScreen.buttons) {
    if (bt.hoveredOver()) {
      main.buttonClicked(bt);
      break;
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) player.moveLeft();                                               
  else if (keyCode == RIGHT) player.moveRight();                                                         
  else if (key == ' ') player.jump();
}
void keyReleased() {
  if (keyCode == LEFT && player.velocity.x < 0) player.velocity.x = 0;                                               
  else if (keyCode == RIGHT&& player.velocity.x > 0) player.velocity.x = 0;                                                         
  else if (key == ' ') player.jump();
}
