//variables: x, y, w, h
//methods: update, display, responds to input, collider

class Paddle {
  PVector position;
  int w = 100;
  int h = 20;
  
  Paddle(){
    position = new PVector(width/2, height-80);
  }
  
  void display() {
    rectMode(CENTER);
    fill(255);
    rect(position.x, position.y, w, h);
  }
  
  void update() { 
    if(keyPressed){
      if(keyCode == LEFT && position.x>w/2){
        position.x -= 8;
      }else if(keyCode == RIGHT && position.x<width-w/2){
        position.x += 8;
      }
    }
    
    if(balls.position.x > position.x-w/2 && balls.position.x < position.x+w/2
      && balls.position.y > position.y-h/2 && balls.position.y < position.y+h/2){
        balls.bounce();
    }
  }
}
