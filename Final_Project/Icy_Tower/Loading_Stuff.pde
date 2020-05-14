Character player;
PImage[] platforms = new PImage[4]; // array of floor images
Main main;
// Declaring images
PImage playimg, instructionsimg, play_againimg, main_menuimg, leaderimg, 
  optionsimg, backimg, options_screenimg, bg1, bg2, bg3, bg4, bg5, transparentimg, gameOverimg, highScoreImg;
// Declaring buttons
Button pause, play, instructions, sound, play_again, main_menu, leader, options, musicOn, soundFxOn, 
  musicOff, soundFxOff, rookie, amateur, pro, legend, character1, character2, back;
// Declaring Screens
Screen options_screen, home_screen, instructions_screen, game_screen, leaderboard_screen;
SoundFile THEME, JUMP, JUMP2, DIE, PRESS, SELECT, SPIN;
Sprite[] haroldSprite = new Sprite[6]; // Sprite for harold (character 1)
Sprite[] discoDaveSprite = new Sprite[6]; // Sprite for Disco Dave (character 2)
PFont myFont;
Table leaderboard; 

void loadStuff() {
  // loading images
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
  highScoreImg = loadImage("images/highscore.png");
  // Initializing buttons
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
  // creating arrays of buttons for each screen
  Button[] optionsbuttons = {musicOn, soundFxOn, musicOff, soundFxOff, rookie, amateur, pro, legend, character1, character2, back};
  Button[] homeButtons = {play, instructions, leader, options};
  Button[] backButton = {back};
  Button[] inGameButtons = {play_again, main_menu};
  // Initializing screens
  options_screen = new Screen(bg3, optionsbuttons);
  home_screen = new Screen(bg1, homeButtons);
  instructions_screen = new Screen(bg4, backButton);
  game_screen = new Screen(bg2, inGameButtons);
  leaderboard_screen = new Screen(bg5, backButton);
  // Populationg the array of sprites with new sprites
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
  THEME = new SoundFile(this, "audio/theme-song.mp3");
  JUMP = new SoundFile(this, "audio/jump.wav");
  JUMP2 = new SoundFile(this, "audio/jump2.wav");
  DIE = new SoundFile(this, "audio/die.wav");
  SPIN = new SoundFile(this, "audio/spin.wav");
  SELECT = new SoundFile(this, "audio/select.wav");
  PRESS = new SoundFile(this, "audio/press.wav");

  myFont = createFont("RoteFlora.ttf", 50);

  // Loading leaderboard
  leaderboard = loadTable("leaderboard.csv", "header");
}
