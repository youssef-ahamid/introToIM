/* 
Author: Youssef Abdelhamid 
Title: Snake
Class: Intro to IM
Date: 06/04/2020 
*/

import java.util.ArrayList; // import the ArrayList class

// setting colors
color RED = color(173, 48, 32);
color YELLOW = color(251, 226, 76);
color GREEN = color(80, 153, 32);

// list of food in the game
color FOODS[] = {RED, YELLOW};


class Food 
{
  color fruitColor; // color of fruit
  int xpos; // x position
  int ypos ; // y position
  PImage img; // img of fruit 

  Food() {
    fruitColor = FOODS[int(random(0, 2))]; // randomizes the fruit
    xpos = int(random(0, ROWS-1))*UNITX; // randomizes the xposition to one of the grid locations 
    ypos = int(random(0, COLS-1))*UNITY; // randomizes the xposition to one of the grid locations 
    if (fruitColor==RED)
    {
      img = loadImage("apple.png"); // loads apple if color is red
    } else if (fruitColor==YELLOW) { 
      img = loadImage("banana.png"); // loads banana if color is yellow
    }
  }

  void display() {
    image(img, xpos, ypos, UNITX, UNITY); // displays the image of the fruit
  }
}

class SnakeBaby 
{
  color myColor; // color of snake baby
  int xpos; // x position
  int ypos ; // y position
  PImage imgLR; // head image for looking left and right
  PImage imgUD; // head image for looking up and down
  boolean isHead; // flage if snakebaby is the head of the snake

  SnakeBaby(color clr, int x, int y) {
    isHead = false; 
    myColor = clr; 
    xpos = x; 
    ypos = y;
  }

  SnakeBaby(int x, int y) { // overloaded constructor for head
    isHead = true;
    xpos = x; 
    ypos = y; 
    imgLR = loadImage("head_left.png");
    imgUD = loadImage("head_up.png"); 
    imgLR.resize(UNITX, UNITY); // resizes image to account for change of resolution
    imgUD.resize(UNITX, UNITY); // resizes image to account for change of resolution
  }

  void display() {
    if (!isHead) { // creates circles and fills them with the snake baby's color
      fill(myColor); 
      ellipse(xpos + UNITX/2, ypos + UNITY/2, UNITX, UNITY);
    } else { // displays image of snake head
      ellipse(xpos + UNITX/2, ypos + UNITY/2, UNITX, UNITY); // places circle under image of head to outline the image. seemed neater.
      if (game.snake.direction == "left") {
        image(imgLR, xpos, ypos, UNITX, UNITY); // displays head_left image
      } else if (game.snake.direction == "right") {
        image(imgLR, xpos, ypos, UNITX, UNITY, UNITX, UNITY, 0, 0); // flips head_left image to make the eyes look right and displays it
      } else if (game.snake.direction == "up") { // displays head_up image
        image(imgUD, xpos, ypos, UNITX, UNITY);
      } else if (game.snake.direction == "down") { // flips head_up image to make the eyes look down and displays it
        image(imgUD, xpos, ypos, UNITX, UNITY, UNITX, UNITY, 0, 0);
      }
    }
    wrapAround();
  }

  void wrapAround() // makes the snake wrap around the screen when it hits edges
  {
    if (xpos == RESX) {
      xpos = 0;
    } else if (xpos < 0) {
      xpos = RESX;
    } else if (ypos == RESY) {
      ypos = 0;
    } else if (ypos < 0) {
      ypos = RESY;
    }
  }
}

class Snake
{
  String direction;
  ArrayList<SnakeBaby> babies;
  SnakeBaby head;

  Snake()
  {
    direction = "left"; // initializes snake direction to left
    babies = new ArrayList<SnakeBaby>(); // arraylist of snakebabies
    babies.add(new SnakeBaby(RESX/2 - UNITX, RESY/2)); // creates head
    babies.add(new SnakeBaby(GREEN, RESX/2, RESY/2)); // adds baby
    babies.add(new SnakeBaby(GREEN, RESX/2 + UNITX, RESY/2)); // adds baby
    head = babies.get(0); // sets the head as the first element of the babies list
  }
  void display() 
  {
    eat(); // checks if snake ate fruit
    if (!game.isPaused && !game.isOver) { 
      move(); // moves the snake if the screen is not paused and the game is not over
    }
    for (int ind = babies.size() -1; ind > -1; ind--)
    {
      babies.get(ind).display(); // displays all snakebabies
    }
  }

  void move() // controls movement of the snake
  {
    for (int ind = babies.size() -1; ind > 0; ind--) // moves babies starting from the tail
    {
      babies.get(ind).xpos = babies.get(ind-1).xpos; // sets the snakebaby position to the one infront of it, similar movement to that of a train 
      babies.get(ind).ypos = babies.get(ind-1).ypos;
    }
    // head is moved depending on the direction
    if (direction == "left") {
      head.xpos -= UNITX; // moves one step to the left
    } else if (direction == "right") {
      head.xpos += UNITX; // moves one step to the right
    } else if (direction == "up") {
      head.ypos -= UNITY; // moves one step up
    } else if (direction == "down") {
      head.ypos += UNITY; // moves one step down
    }
  }

  void eat() // checks if snake ate fruit
  {
    if ( head.xpos == game.fruit.xpos && head.ypos == game.fruit.ypos) 
    {
      babies.add(new SnakeBaby(game.fruit.fruitColor, RESX, RESY)); // adds member to tail
      game.fruit = new Food(); // creates new fruit to replace the eaten fruit
    }
  }

  boolean isDead() // checks if snake ate itself
  {
    for ( int ind = 1; ind < babies.size(); ind ++)
    {
      if (babies.get(ind).xpos  == head.xpos && babies.get(ind).ypos  == head.ypos) // iterates over the snake and checks if head intersects any of its tail members
      {
        return true;
      }
    }
    return false;
  }
}

class Game
{
  Snake snake; // game's snake
  boolean isOver; // flag if game is over 
  Food fruit; // the fruit currently in the game
  boolean isPaused; // flag for pausing game
  int score; 

  Game()
  {
    snake = new Snake();
    isOver = false; 
    fruit = new Food();
    isPaused = false;
    score = 0;
  }

  void display()
  {
    fruit.display(); // displays the fruit
    snake.display(); // displays the snake
    if (snake.isDead()) 
    {
      isOver = true; // ends the game if the snake is dead (eats itself)
      gameOver(); // calls game over function
    } else {
      score = (snake.babies.size()-3)*10; // calculates the score. a bit repetitive but calculations are always very simple
      showScore(); // displays the score
    }
  }

  void showScore() // displays score at the bottom left corner of the screen
  {
    textAlign(LEFT);
    textSize(RESX/20);
    text("SCORE: " + score, 20, RESY - 20);
  }

  void gameOver() // Game Over message and displays score and option to restart
  {
    textAlign(CENTER);
    textSize(48);
    text("GAME OVER", RESX/2, RESY/2);
    textSize(36);
    text("Your score was: " + game.score, RESX/2, RESY/2 + 60);
    textSize(24);
    text("Click to restart", RESX/2, RESY/2 + 120);
  }
}

void keyPressed() { // tracks key events
  /*
    first condition checks the key pressed
   second condition prevents the snake from flipping its direction and eating itself
   third and final condition prevents the snake from changing direction when the game is paused 
   */
  if (keyCode == DOWN && game.snake.direction != "up" && !game.isPaused) { 
    game.snake.direction = "down";
  } else if (keyCode == UP && game.snake.direction != "down" && !game.isPaused) {
    game.snake.direction = "up";
  } else if (keyCode == LEFT && game.snake.direction != "right" && !game.isPaused) {
    game.snake.direction = "left";
  } else if (keyCode == RIGHT && game.snake.direction != "left" && !game.isPaused) {
    game.snake.direction = "right";
  } else if (key == ' ') { // checks if space is pressed and changes the state of the game from paused to !paused and vice versa
    game.isPaused = !game.isPaused;
  }
}

void mouseClicked() {
  if (game.isOver)
    game = new Game(); // restarts the game by reseting the variable game to a new instance of the Game class
}



int RESX = 600, RESY = 600; // resolution 
int ROWS = 20, COLS = 20; // number of slots snake can move in horizontally and vertically 
int UNITX = RESX/ROWS, UNITY = RESY/COLS; // step size 
Game game; // creating a Game instance

void setup() {
  size(600, 600); 
  background(205); // gray background
  frameRate(5); // slowing down frame rate to 5 frames per second to slow down snake's movement
  game = new Game(); //creating a new game
}

void draw() {
  background(205);
  game.display(); // displays the game
}
