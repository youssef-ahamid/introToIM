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
  if (keyCode == LEFT) player.direction = -1;  // set the direction to -1 (left)                                             
  else if (keyCode == RIGHT) player.direction = 1; // set the direction to 1 (right)                                                           
  else if (key == ' ') player.jump();

  if (main.currentScreen == game_screen && player.dead) { // if the player is dead
    if (main.game.name.length() > 0) { // if the name is not empty
      if (key == DELETE || key == BACKSPACE) main.game.name = main.game.name.substring(0, main.game.name.length() - 1); // delete last letter
      else if (key == RETURN || key == ENTER) main.game.gotName = true; // done with name getting
      else if ( key == ' ') main.game.name += str(key); // space only if the name is not empty (as player is dying, user will tend to spam the spacebar, therefor adding an unwanted space at the beginning of his name. This prevents that).
    }
    if ( (int) key < 123 && (int) key >= 97) { // casting the character to its ASCII key and checking if it is a lowercase letter (between 97 and 123 in the ASCII table)
      if (main.game.name.length() == 0) main.game.name += str(key).toUpperCase(); // capatilizing first letter
      else main.game.name += str(key); // adding the letter to the name
    }
  }
}
void keyReleased() {
  if (keyCode == LEFT && player.velocity.x < 0) player.direction = 0; // pause moving if the player releases the lft key and was moving to the left                                              
  else if (keyCode == RIGHT&& player.velocity.x > 0) player.direction = 0; // likewise
}
