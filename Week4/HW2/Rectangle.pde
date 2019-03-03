class Rectangle {
  float w = 50;
  float h;
  float x;
  float y = height/2;
  
  Rectangle(float _x, float _h){
    rectMode(CENTER);
    
    float x = _x;
    float h = _h;
    rect(x, y, w, h);
  }
  
}
