void setup() {  
  // setup() runs once
  //Setting size to 500 x 500
  size(500, 500);
  frameRate(30);
  //Setting background to gray 
  background(52);
  drawHair();
  stroke(253, 241, 212);
  //Fill rect with tan color
  fill(253, 241, 212);
  ellipse(250, 225, 200, 250);
  drawFace();
}
//Used for debugging where a point was on the screen
void mouseClicked() {
  println(mouseX, mouseY);
} 
void drawHair() {
  noStroke();
  fill(111, 88, 63);
  rect(150, 75, 200, 125);
}
void draw() {
  //Draw loop to run every frame
  //Set initial position of pupils
  int leftX = 200;
  int rightX = 300;
  int y = 215;

  //Set eye size globaly 
  int eyeWidth =40;
  int eyeHeight = 40;
  //Get the position of the mouse to move the pupils around
  y = 205 + eyeHeight/2 * mouseY/500;
  leftX = 190 + eyeWidth/2 * mouseX/500;
  rightX = 290 + eyeWidth/2 * mouseX/500;

  //Left Eye
  fill(255);
  stroke(255);
  ellipse(200, 215, eyeWidth, eyeHeight);
  fill(0, 100, 150);
  ellipse(leftX, y, 10, 10);

  //Right Eye
  fill(255);
  stroke(255);
  ellipse(300, 215, eyeWidth, eyeHeight);
  fill(0, 100, 150);
  ellipse(rightX, y, 10, 10);
}
void drawFace() {
  //Draw facial features on the portrait
  //Mouth
  fill(0);
  stroke(0);
  rect(225, 285, 50, 20);
  
  //Teeth
  fill(255);
  rect(225, 285, 50, 10);
  rect(225, 300, 50, 10);
  fill(0, 150, 0);
  //braces
  line(225, 289, 275, 289);
  line(225, 304, 275, 304);
  for (int i = 0; i < 4; i++) {
    rect(233 + i*10, 287, 5, 4);
    rect(233 + i*10, 302, 5, 4);
  }


  //Nose
  stroke(111, 88, 63);
  fill(253, 241, 212);
  triangle(250, 240, 240, 270, 260, 270);

  //Beard
  fill(111, 88, 63);
  //Moustache
  rect(215, 275, 70, 10);
  rect(215, 275, 10, 75);
  rect(275, 275, 10, 75);
  //Sides
  rect(150, 250, 10, 100);
  rect(340, 250, 10, 100);
  rect(160, 300, 60, 20);
  rect(280, 300, 60, 20);
  //Side Triangles
  triangle(160, 260, 160, 300, 225, 300);
  triangle(340, 260, 340, 300, 275, 300);
  //Bottom
  rect(150, 315, 200, 35);

  //Ears
  stroke(253, 241, 212);
  fill(253, 241, 212);
  rect(140, 215, 10, 30);
  rect(350, 215, 10, 30);
}
