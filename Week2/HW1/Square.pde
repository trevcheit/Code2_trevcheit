class Square {
  int cellSize;
  PVector position;
  boolean isActive;
  color col = color(random(255), random(255), random(255));
  
  Square(int _cellSize, PVector _position){
    cellSize = _cellSize; 
    position = _position;
  }
  
  void display(){
    isActive = false;
  }
  
  void changeColor(){
    for(int i = 0; i < COLS; i++){
      for(int j = 0; j < ROWS; j++){
        if(isActive){
          fill(col);
          rect(position.x, position.y, cellSize, cellSize);
        }else{
          if (mouseX > position.x && mouseX < position.x + cellSize
            && mouseY > position.y && mouseY < position.y + cellSize) {
              isActive = true;
          }
        }
      }
    }
  }
  
}
