class Ball{
  PVector position;
  PVector velocity;
  PVector gravity;
  float ballSize = 50;
  
  int state;
  int bottomBounces = 0;
  int sideBounces = 0;
  
  Ball(){
    position = new PVector(width/2, 75);
    
    velocity = new PVector(random(-5,5), random(1,5));
    gravity = new PVector(0, .4);
  }
  
  void display(){
    ellipseMode(CENTER);
    noStroke(); 
    
    switch(state) {
      case 0:
        fill(255, 0, 0);
        break;
      case 1:
        fill(0, 255, 0);
        break;
      case 2:
        fill(0, 0, 255);
        break;
      case 3:
        fill(0);
        break;
    }
    
    ellipse(position.x, position.y, ballSize, ballSize);
  }
  
  void update(){
    position.add(velocity);
    velocity.add(gravity);
    
    if(position.y >= height){
      velocity.y = -velocity.y;
      bottomBounces++;
    }
    if(position.x <= 0 || position.x >= width){
      velocity.x = -velocity.x; 
      sideBounces++;
    }
    
    if(bottomBounces % 2 == 0 && sideBounces % 2 == 0){
      state = 0;
    }else if(bottomBounces % 2 != 0 && sideBounces % 2 == 0){
      state = 1;
    }else if(bottomBounces % 2 == 0 && sideBounces % 2 != 0){
      state = 2;
    }
    else if(bottomBounces % 2 != 0 && sideBounces % 2 != 0){
      state = 3;
    }
    
    //switch (state) {
    //  case 0:
    //    break;
    //}
    
  }
  
}
