class Game {
  boolean gotHighScore, gotName, flag;
  String name;
  int score, leaderboardpos;
  float screenShift, bonus; // screen shift is what shifts the screen up
  ArrayList<Floor> floors;
  Game() {
    name = "";
    gotHighScore = gotName = false;
    floors = new ArrayList<Floor>();
    screenShift = bonus = 0;
    floors.add(new Floor());
    floors.add(new Floor(1, 550));
    floors.add(new Floor(2, 400));
    floors.add(new Floor(3, 250));
    floors.add(new Floor(4, 100));
  }

  void display() {
    score = int(player.floor*10*main.difficulty + bonus); // score is difficulty * the floor * 10 + the bonus

    for ( Floor floor : floors) {
      floor.display();
    }
    if (!player.dead) {
      if (player.position.y <= 0) {
        if (screenShift + player.position.y <= 100) { // if the player passes a certain point
          screenShift -= player.velocity.y - 2; // move up by this much
        } else {
          if ( player.velocity.y>0) {
            screenShift += main.difficulty*2.5; // screen moves faster if the game has higher difficulty
          } else {
            screenShift -=int(player.velocity.y/6)- main.difficulty*1.5;
          }
        }
      }
      displayScore();
      player.display();
      update();
    } else gameOver();
  }

  void update() {
    if ( floors.get(floors.size()-1).position.y >= 150 - screenShift) { // create new floor if player near the top and remove the first one (lowest)
      floors.add(new Floor(floors.get(floors.size()-1).floor+1, -int(screenShift)));
      floors.remove(0);
    }
  } 

  void displayScore() {
    fill(255);
    pushStyle();
    textFont(myFont);
    textAlign(LEFT);
    text("Score: " + score, 30, height-50);
    popStyle();
  }

  void gameOver() {
    if (score > leaderboard.getRow(7).getInt("score")) image(highScoreImg, width/2 - 230, height/2 - 200); // if the score is higher than the lowest one (since it is sorted this means it is a high score. just think about it) then display the high score image
    if (!gotHighScore) { // if the high score has not yet been found
      int index = 7;
      if (!flag) { // flag so this is done once 
        while (index > -1 && score > leaderboard.getRow(index).getInt("score")) { // keep moving up if this score is higher than the current score and shift the current score down
          TableRow row = leaderboard.getRow(index);
          leaderboard.getRow(index+1).setString("Name", row.getString("Name"));
          leaderboard.getRow(index+1).setInt("score", row.getInt("score"));
          leaderboard.getRow(index+1).setInt("floor", row.getInt("floor"));
          leaderboard.getRow(index+1).setString("difficulty", row.getString("difficulty"));
          leaderboardpos = index; // the position on the leaderboard
          index-=1;
        }
        leaderboard.removeRow(8); // delete the lowest one ( the one this high score took its place)
      }
      flag = true;
      if (leaderboardpos  > -1 && leaderboardpos < 8) {
        getName(); // get the name of the user
      }
    } else {
      image(gameOverimg, width/2 - 200, height/2 - 170, 400, 340);
      textSize(30);
      textAlign(LEFT);
      fill(0);
      text(score, width/2 + 50, height/2 - 40);
      text(player.floor, width/2 + 50, height/2+20);
      for (Button bt : game_screen.buttons) bt.display();
    }
  }

  void getName() {
    if (!gotName) {
      textAlign(CENTER);
      textSize(50);
      text(name, width/2, height/2 + 50); // show the name of the user as he types
      pushStyle();      
      textFont(myFont);
      text("Enter Name", width/2, height/2 - 50);
      popStyle();
    } else { // set the user data
      leaderboard.getRow(leaderboardpos).setString("Name", main.game.name);
      leaderboard.getRow(leaderboardpos).setInt("score", score);
      leaderboard.getRow(leaderboardpos).setInt("floor", player.floor);
      if (main.difficulty == 1) leaderboard.getRow(leaderboardpos).setString("difficulty", "rookie");
      else if (main.difficulty == 1.25) leaderboard.getRow(leaderboardpos).setString("difficulty", "amateur");
      else if (main.difficulty == 1.5) leaderboard.getRow(leaderboardpos).setString("difficulty", "pro");
      else if (main.difficulty == 2) leaderboard.getRow(leaderboardpos).setString("difficulty", "legend");
      saveTable(leaderboard, "leaderboard.csv"); // save
      leaderboardpos = 7; 
      gotHighScore = true;
    }
  }
}
