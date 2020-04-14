/* 
Author: Youssef Abdelhamid 
Title: Data Visualization
Class: Intro to IM
Date: 14/04/2020 
Description: bar graph of nba salaries per year from 1990 till 2017. move mouse over bar to see average salary
*/

Year[] years = new Year[28]; // array of 28 years

void setup() {
  size(1000, 800);
  loadData();
}

void draw() {
  background(255);
  textAlign(CENTER);
  textSize(40);
  text("Player Salaries per Year (1990 - 2017)", width/2, 50); // title
  int x = 20; //first x coordinate value of bar
  for(int i = 0; i < years.length; i ++){
    years[i].display(x); // display year
    x+= 35; // take step of 35 pixels
  }
}

void loadData() {
  String[] data = loadStrings("Player Salaries per Year (1990 - 2017).csv"); // load data
  int x = 0; // index of array years
  for( int i = 1; i < data.length; i++){
    String[] line = data[i].split(","); // creates array from row
    int year = int(line[1]); // year is second element
    int newYear = year; // newYear checks if next year is same as current
    long yearSum = 0; // sum of all salaries
    int count = 0; // number of players
    while(year == newYear && i < data.length-1){ // stays in loop as long as the year is the same
      yearSum += int(line[2]); // adds salary
      count++; // increments number of players
      i++; // increments i (row)
      line = data[i].split(","); // gets a new line
      newYear = int(line[1]); // new year is the year of the new line
    }
    years[x] = new Year(year, yearSum/count); // creates new instance at index x
    x++; // moves to index after it
  }
}
class Year{
  int year; 
  long average;
  Year(int yr, long avrg){
    year = yr;
    average = avrg;
  }
  
  void display(int x){
    float y = map(average, 200000, 7000000, 0, height); // maps the average to the height of the program
    if(mouseX > x && mouseX < 20 + x && mouseY > height-y && mouseY < height){ // checks if mouse if over this bar and shows average
      fill(0, 255, 0);
      textAlign(CENTER);
      textSize(60);
      text(int(average), width/2, 150);
    }
    // draws rect
    pushMatrix();
    translate(x, height-y);
    textAlign(CENTER);
    textSize(8);
    text(year, 10, - 10);
    rect(0, 0, 20, y);
    popMatrix();
    fill(0);
  }
}
