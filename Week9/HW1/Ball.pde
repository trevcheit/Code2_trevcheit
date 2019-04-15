class Ball {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  int size = 50;
  
  int state = 0;
  
  Ball() {
    pos = new PVector(random(size/2, width-size/2), random(50, 100));
    vel = new PVector(0, .1);
    acc = new PVector(0, .2);
    mass = 10;
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel);
    
    if(pos.y > height-size/2) {
      vel.y *= -.5;
      pos.y = height-size/2;
    }
  }
  
  void display() {
    fill(0);
    ellipse(pos.x, pos.y, size, size);
  }
  
}
