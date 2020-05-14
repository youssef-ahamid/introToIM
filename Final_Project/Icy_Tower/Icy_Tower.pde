import java.util.ArrayList; 
import processing.sound.*;

void setup() {
  size(1150, 800);
  loadStuff(); // declaring variables and loading assets
  player = new Character(haroldSprite);
  main = new Main();
}

void draw() {
  background(100, 100, 180);
  main.run();
}
