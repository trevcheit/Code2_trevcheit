String[] quotes = { "Quote 1", "Quote 2", "Quote 3", "Quote 4" };
float[] buttonsX = { 100, 233.33, 366.67, 500 };
float buttonsY;
int buttonSize = 100;
String stringMessage = "";

void setup() {
  size(600, 300);
  buttonsY = height/3;
}

void draw() {
  background(255);
  
  for(int i = 0; i < 4; i++){
    if(dist(mouseX, mouseY, buttonsX[i], buttonsY) < buttonSize/2){
      if(mousePressed){
        fill(255);
        stringMessage = quotes[i];
      }
    }else {
      fill(0);
    }
    ellipse(buttonsX[i], buttonsY, buttonSize, buttonSize);
  }
  
  fill(0);
  textSize(16);
  textAlign(CENTER);
  text(stringMessage, width/2, 250);
}
