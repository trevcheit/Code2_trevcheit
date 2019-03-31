Object object;

JSONArray sizes;
JSONArray rotations;
JSONArray pos;

JSONObject data;

int size = 0;
int rot = 0;
int xPos = 3;
int yPos = 3;

void setup(){
  size(600, 600);
  
  data = loadJSONObject("data.json");
  
  sizes = data.getJSONArray("sizes");
  rotations = data.getJSONArray("rotations");
  pos = data.getJSONArray("pos"); 
}

void draw(){
  background(255);
  
  rectMode(CENTER);
  object = new Object(sizes.getInt(size), rotations.getInt(rot), pos.getInt(xPos), pos.getInt(yPos));
  pushMatrix();
  object.display();
  popMatrix();
  
  fill(100);
  text("Press 1 to resize", 20, 30);
  text("Press 2 to rotate", 20, 50);
  text("Reposition with arrow keys", 20, 70);
}

void keyPressed(){
  if(keyCode == 49){
    if(size < sizes.size()-1){
      size++;
    }else if(size == sizes.size()-1){
      size = 0;
    }
  }
  
  if(keyCode == 50){
    if(rot < rotations.size()-1){
      rot++;
    }else if(rot == rotations.size()-1){
      rot = 0;
    }
  }
  
  if(keyCode == RIGHT){
    if(xPos < pos.size()-1){
      xPos++;
    }else if(xPos == pos.size()-1){
      xPos = 0;
    }
  }else if(keyCode == LEFT){
    if(xPos > 0){
      xPos--;
    }else if(xPos == 0){
      xPos = pos.size()-1;
    }
  }
  
  if(keyCode == DOWN){
    if(yPos < pos.size()-1){
      yPos++;
    }else if(yPos == pos.size()-1){
      yPos = 0;
    }
  }else if(keyCode == UP){
    if(yPos > 0){
      yPos--;
    }else if(yPos == 0){
      yPos = pos.size()-1;
    }
  }
}

class Object {
  int size;
  float rot;
  int xPos;
  int yPos;
  
  Object(int _size, float _rot, int _xPos, int _yPos){
    size = _size;
    rot = _rot;
    xPos = _xPos;
    yPos = _yPos;
  }
  
  void display(){
    fill(0);
    translate(xPos, yPos);
    rotate(radians(rot));
    rect(0, 0, size, size);
  }
}
