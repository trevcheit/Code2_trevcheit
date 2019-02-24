class Brick {
  float x;
  float y;
  float w;
  float h;
  boolean active;
  color c;
  color r = color(255, 0, 0);
  color b = color(0, 0, 255);
  
  Brick(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    active = true;
  }

  void display() {
    rectMode(CORNER);
    stroke(255);
    fill(0);
    rect(x, y, w, h);
  }
}

class blueBrick extends Brick {
  
  blueBrick(float x, float y, float w, float h) {
    super(x, y, w, h);
  }
  
  void display() {
    c = b;
    fill(c);
    rect(x, y, w, h);
  }
}

class redBrick extends Brick {
  
  redBrick(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void display() {
    c = r;
    fill(c);
    rect(x, y, w, h);
  }
}
