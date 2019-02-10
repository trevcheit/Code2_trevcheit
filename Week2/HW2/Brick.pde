//variables: x, y, w, h
//methods: active, collider
class Brick {
  int col = 10;
  int rows = 5;
  
  PVector[][] position = new PVector[col][rows];
  boolean[][] isActive = new boolean[col][rows];
  
  int w = 70;
  int h = 25;
  
  Brick(){
    for(int i = 0; i < col; i++){
      for(int j = 0; j < rows; j++){
        position[i][j] = new PVector(1.317*i*w+w/2, 1.5*j*h+30);
        isActive[i][j] = true;
      }
    }
  }
  
  void display() {
    for(int i = 0; i < col; i++){
      for(int j = 0; j < rows; j++){
        if(isActive[i][j]){
          rectMode(CENTER);
          stroke(255);
          noFill();
          rect(position[i][j].x, position[i][j].y, w, h);
        }
      }
    }
  }
  
  void destroy() {
    for(int i = 0; i < col; i++){
      for(int j = 0; j < rows; j++){
        if(balls.position.x < position[i][j].x + w/2 && balls.position.x > position[i][j].x - w/2
          && balls.position.y < position[i][j].y + h/2 && balls.position.x > position[i][j].x - h/2){
            isActive[i][j] = false;
            balls.bounce();
        }
      }
    }
  }
  
}
