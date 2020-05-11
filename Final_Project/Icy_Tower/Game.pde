class Game {
  boolean gotHighScore, gotName, flag;
  String name;
  int score, leaderboardpos;
  float screenShift;
  ArrayList<Floor> floors;
  Game() {
    name = "";
    gotHighScore = gotName = false;
    floors = new ArrayList<Floor>();
    screenShift = 0;
    floors.add(new Floor());
    floors.add(new Floor(1, 550));
    floors.add(new Floor(2, 400));
    floors.add(new Floor(3, 250));
    floors.add(new Floor(4, 100));
  }
  void display() {
    score = int(player.floor*10*main.difficulty);
    for ( Floor floor : floors) {
      floor.display();
    }
    if (!player.dead) {
      if (player.position.y <= 0) {
        if (screenShift + player.position.y <= 100) {
          screenShift -= player.velocity.y - 2;
        } else {
          if ( player.velocity.y>0) {
            screenShift += main.difficulty*1.5;
          } else {
            screenShift -=int(player.velocity.y/6)- main.difficulty*1.5;
          }
        }
      }
      player.display();
      update();
    } else gameOver();
  }

  void update() {
    if ( floors.get(floors.size()-1).position.y >= 150 - screenShift) {
      floors.add(new Floor(floors.get(floors.size()-1).floor+1, -int(screenShift)));
      floors.remove(0);
    }
  }

  void gameOver() {
    if (!gotHighScore) {
      int index = 7;
      while (!flag && index > -1 && score > leaderboard.getRow(index).getInt("score")) {
        TableRow row = leaderboard.getRow(index);
        leaderboard.getRow(index+1).setString("Name", row.getString("Name"));
        leaderboard.getRow(index+1).setInt("score", row.getInt("score"));
        leaderboard.getRow(index+1).setInt("floor", row.getInt("floor"));
        leaderboard.getRow(index+1).setString("difficulty", row.getString("difficulty"));
        leaderboardpos = index;
        index-=1;
      }
      flag = true;
      if (leaderboardpos  > -1) {
        getName();
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
      textSize(50);
      textAlign(CENTER);
      text("Enter Name", width/2, height/2 - 100);
      text(name, width/2, height/2 + 50);
    } else {
      leaderboard.getRow(leaderboardpos).setString("Name", main.game.name);
      leaderboard.getRow(leaderboardpos).setInt("score", score);
      leaderboard.getRow(leaderboardpos).setInt("floor", player.floor);
      if (main.difficulty == 1) leaderboard.getRow(leaderboardpos).setString("difficulty", "rookie");
      else if (main.difficulty == 1.25) leaderboard.getRow(leaderboardpos).setString("difficulty", "amateur");
      else if (main.difficulty == 1.5) leaderboard.getRow(leaderboardpos).setString("difficulty", "pro");
      else if (main.difficulty == 2) leaderboard.getRow(leaderboardpos).setString("difficulty", "legend");
      leaderboard.sortReverse("score");
      saveTable(leaderboard, "leaderboard.csv");
      leaderboardpos = 8;
      gotHighScore = true;
    }
  }
}
