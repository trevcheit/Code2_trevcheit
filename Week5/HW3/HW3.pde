Ball b;

void setup(){
  size(300, 800);
  b = new Ball();
  
}

void draw() {
  background(255);
  
  b.display();
  b.update();
  
  fill(0);
  text("Bottom bounces: " + b.bottomBounces, 50, height-70);
  text("Side bounces: " + b.sideBounces, 50, height-50);
  text("State: " + b.state, 50, height-30);
}
