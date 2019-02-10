//variables: x, y, size, velX, velY, angle
//methods: collide, update, display

class Ball {
  PVector position;
  PVector velocity;
  int size = 20;

  Ball(){
    position = new PVector(width/2, height/2);
    velocity = new PVector(random(-5,5), random(5,7));
  }
  
  void display(){
    fill(255);
    rect(position.x, position.y, size, size);
  }
  
  void update(){
    position.add(velocity);
    
    if(position.x > width-size/2 || position.x < size/2) {
      velocity.x *= -1;
    }
    if(position.y < size/2) {
      bounce();
    }
    if(position.y > height-size/2) {
      if(lives.num > 1){
        position = new PVector(width/2, height/2);
        velocity = new PVector(random(-5,5), random(1,5));
        lives.num -= 1;
      }else if(lives.num == 1){
        lives.num -= 1;
      }
    }
  }
  
  void bounce(){
    velocity.y *= -1;
  }

}
