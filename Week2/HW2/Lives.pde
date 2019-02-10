class Lives {
  int num = 10;
  
  Lives(){
  
  }
  
  void display(){
    fill(255);
    textSize(16);
    text(num, 25, height-25); 
  }
  
  void endGame(){
    if(num == 0){
      textAlign(CENTER);
      text("Game Over", width/2, height/2);
    }
  }
}
