// bryan ma for code 2 sp 19

int scene = 0;
Button button;

float boxX, boxY;

void setup() {
  size(600, 600);
  boxX = random(50, width-50);
  boxY = random(50, height-50);
}

void draw() {
  background(255);
  noStroke();
  fill(0);
  switch (scene) {
    case 0:
      button = new Button();
      fill(50);
      text("Press Me", 20, height-20);
      break;
    case 1:
      rectMode(CENTER);
      noFill();
      stroke(50);
      rect(boxX, boxY, 100, 100);
      noStroke();
      fill(50);
      rect(mouseX, mouseY, 100, 100);
      
      fill(50);
      text("Overlap us", 20, height-20);
      
      if(dist(mouseX, mouseY, boxX, boxY) <= 5){
        advance();
      }
      break;
    case 2:
      triangle(0, 0, width, 0, width/2, height);
      fill(50);
      text("Press Down", 20, height-20);
      break;
    case 3:
      fill(50);
      text("fin", 100, 100);
      break;
    default:
      break;
  }
  println(scene);
}

void mousePressed() {
  if(dist(mouseX, mouseY, button.x, button.y) < button.w/2){
    switch (scene) {
    case 0:
      advance();
      break;
    }
  }
}

void keyPressed() {
  switch (scene) {
    //case 1:
    case 2:
      if(keyCode == DOWN){
        advance();
        break;
      }
    case 3:
      break;
    default:
      break;
  }
}

void advance() {
  scene++;
}

class Button{
  float w = 100;
  float x = 200;
  float y = 200;
  
  Button(){    
    if(dist(mouseX, mouseY, x, y) < w/2){
      fill(100);
    }else{
      fill(175);
    }    
    ellipse(x, y, w, w); 
  } 
}
