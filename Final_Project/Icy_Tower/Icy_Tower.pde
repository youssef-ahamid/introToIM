import java.util.ArrayList; 

Character player;
PImage[] platforms = new PImage[4];
PImage img;
Main main;
PImage playimg, instructionsimg, play_againimg, main_menuimg, leaderimg, 
  optionsimg, backimg, options_screenimg, bg1, bg2, bg3, bg4, bg5, transparentimg, gameOverimg;
Button pause, play, instructions, sound, play_again, main_menu, leader, options, musicOn, soundFxOn, 
  musicOff, soundFxOff, rookie, amateur, pro, legend, character1, character2, back;
Screen options_screen, home_screen, instructions_screen, game_screen, leaderboard_screen;
Sprite[] haroldSprite = new Sprite[6];
Sprite[] discoDaveSprite = new Sprite[6];
Table leaderboard;

void setup() {
  size(1150, 800);
  platforms[0] = loadImage("images/floors/platform1.png");
  platforms[1] = loadImage("images/floors/platform2.png");
  platforms[2] = loadImage("images/floors/platform3.png");
  platforms[3] = loadImage("images/floors/platform4.png");
  playimg = loadImage("images/buttons/play.png");
  instructionsimg = loadImage("images/buttons/instructions.png");
  play_againimg = loadImage("images/buttons/play-again.png"); 
  main_menuimg = loadImage("images/buttons/main-menu.png"); 
  leaderimg= loadImage("images/buttons/leader.png");
  optionsimg = loadImage("images/buttons/options.png"); 
  backimg= loadImage("images/buttons/back.png"); 
  bg1= loadImage("images/backgrounds/bg1.jpg"); 
  bg2= loadImage("images/backgrounds/bg2.jpg"); 
  bg3= loadImage("images/backgrounds/options.jpg"); 
  bg4= loadImage("images/backgrounds/instructions.jpg"); 
  bg5= loadImage("images/backgrounds/high-scores.jpg"); 
  transparentimg= loadImage("images/buttons/transparent.png");
  gameOverimg = loadImage("images/game-over.png");
  play = new Button(700, 400, 271, 76, playimg );
  instructions = new Button(700, 500, 271, 76, instructionsimg);
  play_again = new Button(415, 480, 134, 34, play_againimg);
  main_menu = new Button(415, 530, 134, 34, main_menuimg);
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
  haroldSprite[0] = new Sprite("images/sprites/harold/idle-harold.png", 38, 73, 4);
  haroldSprite[1] = new Sprite("images/sprites/harold/walking-harold.png", 38, 73, 4);
  haroldSprite[2] = new Sprite("images/sprites/harold/jumping-harold.png", 38, 71, 1);
  haroldSprite[3] = new Sprite("images/sprites/harold/jumping2-harold.png", 38, 71, 1);
  haroldSprite[4] = new Sprite("images/sprites/harold/spinning-harold.png", 60, 60, 12);
  haroldSprite[5] = new Sprite("images/sprites/harold/falling-harold.png", 38, 71, 1);
  discoDaveSprite[0] = new Sprite("images/sprites/DiscoDave/idle-DiscoDave.png", 38, 73, 4);
  discoDaveSprite[1] = new Sprite("images/sprites/DiscoDave/walking-DiscoDave.png", 38, 73, 4);
  discoDaveSprite[2] = new Sprite("images/sprites/DiscoDave/jumping-DiscoDave.png", 38, 71, 1);
  discoDaveSprite[3] = new Sprite("images/sprites/DiscoDave/jumping2-DiscoDave.png", 38, 71, 1);
  discoDaveSprite[4] = new Sprite("images/sprites/DiscoDave/spinning-DiscoDave.png", 60, 60, 12);
  discoDaveSprite[5] = new Sprite("images/sprites/DiscoDave/falling-DiscoDave.png", 38, 71, 1);
  leaderboard = loadTable("leaderboard.csv", "header");
  leaderboard.sortReverse("score");

  player = new Character(haroldSprite);
  main = new Main();
}

void draw() {
  background(100, 100, 180);
  main.run();
}
