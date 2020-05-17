class Main {
  Screen currentScreen; // holds the current screen 
  float difficulty = 1; // initializes the difficulty to 1
  Game game;
  Sprite[] character;

  Main() {
    currentScreen = home_screen;
    character = haroldSprite; // initializes the character to harold ( change this to disco dave if you want him to be the default)
  }

  void run() {
    if (currentScreen == game_screen) game.display(); // display game if the current screen is game screen
    else {
      currentScreen.run();
      if (musicOn.on && !THEME.isPlaying()) THEME.play();
      else if (musicOff.on) THEME.stop();
    }
    if (currentScreen == leaderboard_screen) {
      displayLeaderboard();
    }
  }

  void displayLeaderboard() { // displays all data of high scores
    fill(0);
    textSize(40);
    textAlign(LEFT);
    text("Name", 250, 250);
    text("Score", 450, 250);
    text("Floor", 600, 250);
    text("Difficulty", 750, 250);
    textSize(26);
    for (int i = 0; i < 8; i++) {
      TableRow row = leaderboard.getRow(i); 
      text(row.getString("Name"), 250, 300 + 50*i);
      text(row.getInt("score"), 450, 300 + 50*i);
      text(row.getInt("floor"), 600, 300 + 50*i);
      text(row.getString("difficulty"), 750, 300 + 50*i);
    }
  }

  void buttonClicked(Button bt) { // function to handle button clicks
    // changing between screens
    if (bt == back || bt == main_menu) {
      currentScreen = home_screen;
    } else if (bt == play) {
      restartGame();
      currentScreen = game_screen;
    } else if (bt == instructions) {
      currentScreen = instructions_screen;
    } else if (bt == options) {
      currentScreen = options_screen;
    } else if (bt == leader) {
      currentScreen = leaderboard_screen;
    }
    // restarting
    else if (bt == play_again) {
      restartGame();
    } 
    // music and soundFX on and off
    else if (bt == musicOn) {
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
    } 
    // changing difficulty
    else if (bt == rookie) {
      difficulty = 1;
      rookie.on = true;
      amateur.on = false;
      pro.on = false;
      legend.on = false;
    } else if (bt == amateur) {
      difficulty = 1.25;
      rookie.on = false;
      amateur.on = true;
      pro.on = false;
      legend.on = false;
    } else if (bt == pro) {
      difficulty = 1.5;
      rookie.on = false;
      amateur.on = false;
      pro.on = true;
      legend.on = false;
    } else if (bt == legend) {
      difficulty = 2;
      rookie.on = false;
      amateur.on = false;
      pro.on = false;
      legend.on = true;
    } 
    // changing character
    else if (bt == character1) {
      character1.on = true;
      character2.on = false;
      character = haroldSprite;
    } else if (bt == character2) {
      character1.on = false;
      character2.on = true;
      character = discoDaveSprite;
    }
  }

  void restartGame() { // creates new character and new game
    player = new Character(character);
    game = new Game();
  }
}
