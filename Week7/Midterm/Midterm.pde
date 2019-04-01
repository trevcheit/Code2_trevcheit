//class based approach
//global state
//move values into external data
//open ended beynod this:
  //child button class
  //have button states respresented more visually

int state = 0;

Button[] buttons = new Button[2];

JSONObject data;
JSONArray xPos;
JSONArray text;
String displayText;
color bgColor;

void setup() {
  size(600, 600);
  
  data = loadJSONObject("data.json");
  
  xPos = data.getJSONArray("xPos");
  text = data.getJSONArray("text");
}

void draw() {
  background(bgColor);
  
  for(int i = 0; i < buttons.length; i++){
    buttons[i] = new Button(xPos.getInt(i));
    buttons[i].display();
  }
  
  switch(state) {
    case 0:
      bgColor = 230;
      displayText = text.getString(0);
      break;
    case 1:
      bgColor = color(230, 255, 200);
      displayText = text.getString(1);
      break;
    case 2:
      bgColor = color(255, 200, 230);
      displayText = text.getString(2);
      break;
  }
  
  fill(0);
  textAlign(CENTER);
  textSize(28);
  text(displayText, width/2, 400);
}

void mousePressed(){
  for(int i = 0; i < buttons.length; i++){
    if(dist(mouseX, mouseY, buttons[i].xPos, buttons[i].yPos) < buttons[i].buttonSize/2){
      state = i+1;
    }
  }
}

class Button {
  int xPos;
  int yPos = 200;
  int buttonSize = 125;
  int txt;
  
  Button(int _xPos){
    xPos = _xPos;
  }
  
  void display() {
    if (dist(mouseX, mouseY, xPos, yPos) < buttonSize/2 && mousePressed) {
      fill(0);
    }else{
      fill(255);
    }
    ellipse(xPos, yPos, buttonSize, buttonSize);
  }
}
