int depth = 60; // depth of l shape (white part)
int NMBRHLINES = 10; // (# of horizontal lines on the white parts)
int interval = 150; // interval of L shapes

// widths and heights of different rectangles
int HWIDTH1 = 120;
int HWIDTH2 = 200;
int VWIDTH = 20;
int VHEIGHT1 = 120;
int VHEIGHT2 = 60;
int HHEIGHT1 = 20;
int HHEIGHT2 = 40;

void drawLShape(int x, int y, int vWidth, int vHeight, int hWidth, int hHeight) { 
  pushMatrix(); // pushes all the translations into the matrix
  translate(x, y); // translates to the top left corner of the L
  fill(0);
  noStroke();
  rect(0, 0, vWidth, vHeight + hHeight); // draws vertical rect with vwidth and vheight
  rect(vWidth, vHeight, hWidth - vWidth, hHeight); // draws horizontal rect at the bottom of the vertical rectangle with hwidth - vWidth and hheight
  fill(255);
  quad(vWidth, 0, vWidth + depth, -depth, depth, -depth, 0, 0); // draws white parallelogram #1
  pushMatrix(); // pushes the translations below into the matrix and pops them afterward to go back to the original translation
  horizontalLines(vWidth);
  popMatrix();
  noStroke();
  quad(vWidth, 0, vWidth + depth, -depth, vWidth + depth, vHeight - depth, vWidth, vHeight); // draws white parallelogram #2
  quad(vWidth, vHeight, vWidth + depth, vHeight - depth, hWidth + depth, vHeight - depth, hWidth, vHeight); // draws white parallelogram #3
  pushMatrix(); // pushes the translations below into the matrix and pops them afterward to go back to the original translation
  translate(vWidth, vHeight);
  horizontalLines(hWidth);
  popMatrix();
  noStroke();
  quad(hWidth + depth, vHeight - depth, hWidth, vHeight, hWidth, vHeight + hHeight, hWidth + depth, vHeight + hHeight - depth); // draws white parallelogram #4
  popMatrix();
}

void horizontalLines(int w) {
  for ( int counter = 0; counter < NMBRHLINES; counter++) {
    translate(depth/NMBRHLINES, - depth/NMBRHLINES); // divides space into units for lines and moves to the left and up by that much for every line
    stroke(0);
    strokeWeight(depth/(NMBRHLINES*2)); // the line weight takes half that space, creating the illusion of alternating black and white lines
    line(0, 0, w, 0);// draw line with the same width as rect of L
  }
}

void setup() {
  size(600, 600); //width and height
}

void draw() {
  background(255); // white background
  strokeWeight(10); 
  stroke(0); 
  int angle = 45; // angle of rotation of lines (diagonal)
  pushMatrix(); 
  translate(width*2, 0); // starts drawing lines at twice the width (using pythagorean, the first line will land just at the point (width, height) 
  rotate(radians(angle)); 
  for (int counter = 0; counter < 850; counter+= 15) { // 850 is the length of the diagonal -> 600*root(2)
    translate(-15, 0); // steps of 15
    line(0, 0, 0, 850*2); // draws line
  }
  popMatrix();
  drawLShape(0, 400, 0, 0, width, HHEIGHT1); // draws first shape
  drawLShape(0, 120, VWIDTH, VHEIGHT1, HWIDTH2, HHEIGHT1); // draws second set of shapes
  for ( int counter = 0; counter < width; counter += interval) { // draws second set of shapes
    drawLShape(interval + counter, 180, VWIDTH, VHEIGHT2, HWIDTH2, HHEIGHT1);
  }
  // draws third set of shapes
  drawLShape(interval, 0, VWIDTH, VHEIGHT1, HWIDTH1, HHEIGHT2); 
  drawLShape(interval*2, 60, VWIDTH, VHEIGHT2, HWIDTH1, HHEIGHT2); 
  drawLShape(interval*3, 60, VWIDTH, VHEIGHT2, HWIDTH1, HHEIGHT2); 
  // draws fourth set of shapes
  drawLShape(interval*2, 0, 0, 0, HWIDTH1, HHEIGHT2); 
  drawLShape(interval*3, 0, 0, 0, HWIDTH1, HHEIGHT2);
}
