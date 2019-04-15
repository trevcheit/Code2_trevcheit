int state = 0;

Ball[] balls = new Ball[20];
Levitator[] bottomLev = new Levitator[20];
Levitator[] topLev = new Levitator[20];

void setup() {
  size(800,800);
  for (int i = 0; i < 20; i++){
    balls[i] = new Ball();
    bottomLev[i] = new Levitator(balls[i].pos.x, height);
    topLev[i] = new Levitator(balls[i].pos.x, 0);
  }
  
}

void draw() {
  background(255);
  
  for (int i = 0; i < 20; i++){
    balls[i].update();
    balls[i].display();
    bottomLev[i].display();
    topLev[i].display();
    
    switch(state) {
      case 0:
        break;
      case 1:
        PVector bottomForce = new PVector(bottomLev[i].pos.x, bottomLev[i].pos.y);
        PVector topForce = new PVector(topLev[i].pos.x, topLev[i].pos.y);
        
        //WANT THE BALL TO LEVITATE IN THE MIDDLE OF THE SCREEN
        
        bottomForce.sub(balls[i].pos);
        topForce.sub(balls[i].pos);
        
        float bottomDistance = bottomForce.mag();
        //float topDistance = topForce.mag();
        if(bottomDistance < height/2){
          bottomForce.normalize();
          bottomForce.mult(-.1);
          balls[i].applyForce(bottomForce);
        } else if(bottomDistance > height/2) {
          topForce.normalize();
          topForce.mult(-.1);
          balls[i].applyForce(topForce);
        }
        break;
    }
  }
  
}

void keyPressed() {
  if(state == 0){ state = 1; }
  else if(state == 1){ state = 0; }
  println(state);
}

class Levitator {
  PVector pos;
  
  Levitator(float x, float y){
    pos = new PVector(x, y);
  }
  
  void display(){
    fill(100);
    ellipse(pos.x, pos.y, 25, 25);
  }
  
}
