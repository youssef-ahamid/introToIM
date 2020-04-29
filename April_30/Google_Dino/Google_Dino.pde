/*
 Author: Youssef Abdelhamid 
 Title: Google Dinosaur game clone
 Class: Intro to IM
 Date: 30/04/2020 
 */

import java.util.ArrayList; 

Game myGame;                                                   // initializing a game

//images
PImage dino_sprite;
PImage small_cacti;
PImage tall_cacti;
PImage mix_cacti;
PImage floor_img;
PImage cloud;
PImage game_over;
PImage restart;

// font
PFont font;

int LEEWAY;                                                     // leeway for hitting the obstacles; has to be less than 8 for collisions to work properly.

int high_score;                                                 // highest score achieved

Table t;                                                        // loading the score with a table



class Dino {                                                    // dino object
  PVector position, velocity;
  PImage img;
  float floor, gravity;
  int wid, hei, ind;
  boolean start, dead;

  Dino(int x, float y) {
    dead = false;                                                // is the dino dead?
    start = false;                                               // did the dino start moving?
    wid = 44;                                                    // width of img
    hei = 47;                                                    // height of img
    position = new PVector(x, y);                                // initializing the position to an x and a y
    velocity = new PVector(0, 0);                                // intitializing the velocity to 0
    gravity = 0.5;                                               // gravity to pull dino down after jumping
    img = dino_sprite;                                           // setting the image
    ind = 0;                                                     // starting index for sprite (first image)
  }

  void display() {                                               // display the dino
    image(img, position.x, position.y - hei, // the top left corner of the image is the position subtracted by the height 
      wid, hei, // width and height
      wid*ind, 0, // cropping the image from the index * width 
      wid* (ind+1), hei);                                        // to the next index *width
    update();
  }

  void update() {                                                 // update the dino                                         
    if (isDead()) {                                               // if the call to the isDead() function returns true
      ind = 4;                                                    // goes to index four which is the last image of the dead dinosaur
      dead = true;                                                // dino is now dead
      velocity.set(0, 0);                                         // stops all motion
    } else if (frameCount % 3 == 0 && start && velocity.y == 0) { // if dino is moving and not jumping
      ind = (ind + 1) % 4;                                        // go to the next image
    }
    position.y += velocity.y;                                     // updating position
    if (position.y >= myGame.floor) {                             // if dino touches the ground
      position.y = myGame.floor;                                  // make sure it is still on the ground
      velocity.y = 0;                                             // stopping vertical motion
    } else {
      velocity.y += gravity;                                      // updating velocity
    }
  }

  void jump() {                                                   // function for jumping
    if (position.y == myGame.floor && !dead) {                    // if the dino is not dead and not jumping
      velocity.y = -10;                                           // giving the dino some upward velocity
      ind = 0;                                                    // setting ind to 0; changing the image back to the first image
      velocity.x = 5 + myGame.level * 2;                          // setting the horizontal velocity to 5 + twice the game level
      start = true;                                               // jumping starts the game
    }
  }

  boolean isDead() {                                               // checks if dino is dead
    for (Cacti obstacle : myGame.obstacles) {                      // for every obstacle
      if (obstacle.position < position.x                           // if dino's xpos is between the xpos of the obstacle and it's xpos + its width
        && obstacle.position + obstacle.wid > position.x                        
        && position.y > myGame.floor - obstacle.hei) return true;  // and the dino's y pos is more (underneath) than floor minus the obstacles height return true
    }
    return false;                                                  // if obstacles have been traversed and the condition was never met return false
  }
}

class Cacti {                                                      // cactus object
  int type, position, ind, wid, hei;                        
  PImage img;                                                       

  Cacti() {                                                         
    type = int(random(3));                                         // type of cactus - (0,3)  
    position = width;                                              // setting the initial position of the cactus to width  
    switch(type) {                    
    case 0:                                                        // if type is 0
      img = tall_cacti;                                            // tall cactus    
      ind = int(random(4));                                        // random ind for random image of cactus within the sprite                 
      wid = 25;                                                    // setting width                                                            
      hei = 50;                                                    // setting height    
      break;                                                        
    case 1:                                                        // if type is 1 
      img = small_cacti;                                           // small cactus             
      ind = int(random(6));                                        // random ind for random image of cactus within the sprite                 
      wid = 17;                                                    // setting width    
      hei = 35;                                                    // setting height    
      break;                                                        
    case 2:                                                        // if type is 2 
      img = mix_cacti;                                             // mixed cacti           
      ind = 0;                                                     // setting ind to 0 since it is only one image   
      wid = 51;                                                    // setting width    
      hei = 50;                                                    // setting height
      break;
    }
  }                                                        

  void display() {                                                 // display cactus       
    if (!myGame.dino.dead) {                                       // if dino is alive                 
      position -= myGame.dino.velocity.x;                          // move the cactus to the left by the x velocity of the dinosaur
    }                                                        
    image(img, position, myGame.floor - hei, wid, hei, // the top left corner of the image is the position subtracted by the height 
      wid*ind, 0, wid* (ind+1), hei);                                // cropping the image from the index * width
  }                                                                // to the next index * width
}


class Cloud {                                                      // cload object  
  PVector position;                                                        
  Cloud() {                                                        
    position =  new PVector(width, random(myGame.floor - 100));    // random position that is higher than the ground by at least 100
  }                                                        

  Cloud(float x, float y) {                                        // overloaded constructor given an x and a y position           
    position = new PVector(x, y);                                  // set position to the x and y
  }                                                        

  void display() {                                                 // display cloud       
    image(cloud, position.x, position.y, 46, 13);                  // display image                                      
    if (myGame.dino.start && !myGame.dino.dead) position.x -= 1;   // move cloud if dino starts moving and is not dead
  }
}                                                        

class Game {                                                       // Game object 
  Dino dino;                                                        
  float floor;                                                        
  ArrayList<Cacti> obstacles;                                                        
  ArrayList<Cloud> clouds;                                                        
  int level, timer;                                                        
  float shift_floor;                                                        
  int score;                                                        

  Game() { 
    timer = 0;                                                     // timer to count frames                    
    score = 0;                                                     // score   
    shift_floor = 0;                                               // how much the floor shifts to the right         
    level = 1;                                                     // game level   
    floor = 250;                                                   // the y coordinate of the floor    
    obstacles = new ArrayList<Cacti>();                            // Arraylist of obstacles                                                                                    
    clouds = new ArrayList<Cloud>();                               // Arraylist of clouds                         
    dino = new Dino(50, floor);                                    // instantiating a new dino                    
    obstacles.add(new Cacti());                                    // add a new obstacle                    
    clouds.add(new Cloud(random(100, width), random(floor - 100)));// add cloud                                                        
    clouds.add(new Cloud(random(100, width), random(floor - 100)));// add cloud
  }                                                        

  void display() {                                                 // display game       
    image(floor_img, 0 + shift_floor, floor-8, 1200, 15);          // draw the image at shift floor and the floor coordiate                                              
    image(floor_img, 1200 + shift_floor, floor-8, 1200, 15);       // draw another image next to it so when the first floor shifts this image fills the empty space                                                 
    for (Cloud cloud : clouds)        cloud.display();             // for every cloud display the cloud                                                                             
    for (Cacti obstacle : obstacles)  obstacle.display();          // for every obstacle display the obstacle                                                                                                                                                          
    dino.display();                                                // display the dino        
    if (!dino.dead && dino.start)     update();                    // call update if the game started and the dino is not dead                                  
    else if (dino.dead)               restartScreen();             // call restart screen if dino is dead                                           
    displayScore();                                                // display the score
  }                                                        

  void update() {                                                  // update game          
    timer ++;                                                        
    if (timer % int(random(60, 140) / level) == 0 && dino.start) { // spawning new cacti when the timer is divisible by some random int. division by level will increase                                                         
      obstacles.add(new Cacti());                                  // frequency of spawning as level increases to increase difficulty                      
      timer = 0;                                                   // reseting the timer when cactus is spawned
    }                                                              
    if (frameCount % 200 == 0) {                                                         
      clouds.add(new Cloud());                                     // spawning cloud                 
      timer = 0;                                                   // reseting the timer when cloud is spawned
    }                                                         
    if (frameCount % 10 == 0) {                                    // incrementing score every 10 frames               
      score++;                                                        
      if (score > high_score) high_score = score;                  // setting the high score as the current score if current score is higher
    }                                                        
    shift_floor = (shift_floor-dino.velocity.x)%-1200;             // shifting the floor by dino's x vel, and resting it every 1200                                                                                                  
    level = int(score/100) + 1;                                       // level is the number of 100's in the score + 1
  }                                                        

  void displayScore() {                                             // display the score and the high score           
    textFont(font);                                                 // font       
    fill(0);                                                        
    text("Score: " + score, 20, 20);                                                        
    pushStyle();                                                        
    textAlign(RIGHT);                                                        
    text("HI: " + high_score, width - 20, 20);                                                        
    popStyle();
  }                                                        

  void restartScreen() {                                               // showing the game over screen          
    pushStyle();                                                        
    imageMode(CENTER);
    image(restart, width/2, height/2, 36, 32);                          // displaying restart image                              
    image(game_over, width/2, height/2 - 50, 400, 22);                  // displaying game over image                                         
    popStyle();
  }
}

void changeColor(PImage img) {                                           // changes the color of the image            
  img.loadPixels();                                                      // load image pixels 
  float r = random(255);                                                 // random red       
  float g = random(255);                                                 // random green
  float b = random(255);                                                 // random blue       
  for (int i = 0; i < img.pixels.length; i++) {                          // iterate over the pixels of the image                              
    if (img.pixels[i] == color(255) || img.pixels[i] == color(0)) {      // if the color is white or black                                                 
      continue;                                                          // skip
    } else if (alpha(img.pixels[i]) != 0) {                              // if the pixel is not transparent (because image type is png with transparent backgrounds                          
      img.pixels[i] = color(r, g, b);
      ;                                   // changing the color of the pixel                     
      img.updatePixels();                                                // update the image
    }
  }
}

void setup() {
  size(600, 360);
  // loading images
  dino_sprite = loadImage("run.png");
  tall_cacti = loadImage("tall_cactus.png");
  small_cacti = loadImage("small_cactus.png");
  mix_cacti = loadImage("cactus_mix.png");
  floor_img = loadImage("floor.png");
  cloud = loadImage("cloud.png");
  restart = loadImage("restart.png");
  game_over = loadImage("game_over.png");

  font = createFont("dinofont.ttf", 16);                                 // load font                       

  LEEWAY = 5;                                                            

  t = loadTable("HI.csv", "header");                                     // loading high score                   
  TableRow row = t.getRow(0);                                            // get first row            
  high_score = int(row.getInt("HI"));                                    // get high score                    

  myGame = new Game();                                                   // initialize a new game
}

void draw() {
  background(255);
  myGame.display();                                                      // display game
}

void keyPressed() {
  switch(key) {
  case 'd':                                                              // if d is pressed
    changeColor(dino_sprite);                                            // change the color of the dino            
    break;
  case 'c':                                                              // if c is pressed
    changeColor(tall_cacti);                                             // change the color of the tall cactus           
    changeColor(small_cacti);                                            // change the color of the small cactus            
    changeColor(mix_cacti);                                              // change the color of the mixed cactus          
    break;
  case 's':                                                              // if s is pressed
    changeColor(cloud);                                                  // change the color of the cloud      
    break;
  case ' ':                                                              // if space is pressed
    myGame.dino.jump();                                                  // jump!
  }
}

void mouseClicked() {
  if (myGame.dino.dead && mouseX < width/2 + 18 && mouseX > width/2 - 18 // if dino is dead and x is between the restart button's x coordinates (its center is width/2 and width is 36)
    && mouseY < height/2 + 11 && mouseY > height/2 - 11) {                 // and y is between the restart button's x coordinates (its center is height/2 and height is 22)
    myGame = new Game();                                                 // set myGame as a new instance of the game
    t.getRow(0).setInt("HI", high_score);                                // updating the high score. will stay the same if score did not exceed it                        
    saveTable(t, "HI.csv");                                              // saves updated table
  }
}
