class Box {
  int[] val = {100, 250, 400};
  PVector[] pos = new PVector[NUM];
  float[] size = new float[NUM];
  color[] col = new color[NUM];
  
  Box(int i){
    size[i] = random(50, 100);
    col[i] = color(random(255), random(255), random(255));
    pos[0] = new PVector(val[0], val[0]);
    pos[1] = new PVector(val[2], val[0]);
    pos[2] = new PVector(val[1], val[1]);
    pos[3] = new PVector(val[0], val[2]);
    pos[4] = new PVector(val[2], val[2]);
  }
  
  void display(){
    for(int i = 0; i < NUM; i++){
      pushMatrix();
        translate(pos[i].x, pos[i].y, 0);
        rotateY(mouseX * .01);
        rotateX(mouseY * .01);
        fill(col[i]);
        box(size[i]);
      popMatrix();
    }
  }
  
  void onClick(){
    for(int i = 0; i < NUM; i++){     
      if(dist(mouseX, mouseY, pos[i].x, pos[i].y) < size[i] && mousePressed){
        col[i] = color(random(255), random(255), random(255));
      }
    }
  }
  
}
