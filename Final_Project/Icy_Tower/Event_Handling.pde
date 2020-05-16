void mouseClicked() {
  // println(mouseX, "    ", mouseY);
  for (Button bt : main.currentScreen.buttons) {
    if (bt.hoveredOver()) { // if a buttons is hovered over when the mouse is clicked
      main.buttonClicked(bt);
      if (soundFxOn.on) PRESS.play(); 
      break; // break to prevent unnecessary checking
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) player.direction = -1;                                               
  else if (keyCode == RIGHT) player.direction = 1;                                                         
  else if (key == ' ') player.jump();

  if (main.currentScreen == game_screen && player.dead) { // if the player is dead
    if (main.game.name.length() > 0) { // if the name is not empty
      if (key == DELETE || key == BACKSPACE) main.game.name = main.game.name.substring(0, main.game.name.length() - 1); // delete last letter
      else if (key == RETURN || key == ENTER) main.game.gotName = true; 
      else if ( key == ' ') main.game.name += str(key);
    }
    if ( (int) key < 123 && (int) key >= 97) {
      if (main.game.name.length() == 0) main.game.name += str(key).toUpperCase();
      else main.game.name += str(key);
    }
  }
}
void keyReleased() {
  if (keyCode == LEFT && player.velocity.x < 0) player.direction = 0;                                               
  else if (keyCode == RIGHT&& player.velocity.x > 0) player.direction = 0;
}
