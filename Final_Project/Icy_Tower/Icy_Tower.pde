/* 
  Author: Youssef Abdelhamid
  Date: 05/17/2020
  Project Name: Icy Tower Clone
  Intro To IM
  
  Note: Displaying the game screen's background image slows down the game significantly. That is why It has no background 
  and the game is played on a solid color. Bummer!
  
  DISCLAIMER: While you're reading through this code, you will stumble across many numbers that seem to have no meaning. 
  This is because most of the numbers used here are purely the product of experimentation and there is nothing mathematically 
  sound going on. Please feel free to play around with those numbers and see what you get!
*/







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
