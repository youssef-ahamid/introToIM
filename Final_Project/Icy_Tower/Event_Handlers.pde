void mouseClicked() {
  // println(mouseX, "    ", mouseY);
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

  if (main.currentScreen == game_screen  && player.dead) {
    if (key == DELETE || key == BACKSPACE && main.game.name.length() > 0) main.game.name = main.game.name.substring(0, main.game.name.length() - 1);
    else if (key == RETURN || key == ENTER) main.game.gotName = true;
    else if ( (int) key < 123 && (int) key >= 97 || key == ' ') main.game.name += key;
  }
}
void keyReleased() {
  if (keyCode == LEFT && player.velocity.x < 0) player.velocity.x = 0;                                               
  else if (keyCode == RIGHT&& player.velocity.x > 0) player.velocity.x = 0;                                                         
  else if (key == ' ') player.jump();
}
