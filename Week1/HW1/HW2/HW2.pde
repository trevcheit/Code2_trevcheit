int numOfTiles = 20;
int tileSize;
color c[][] = new color[numOfTiles][numOfTiles];

void setup() {
  size(500, 500);
  tileSize = width/numOfTiles;
  
  for(int i = 0; i < numOfTiles; i++){
    for(int j = 0; j < numOfTiles; j++){
      c[i][j] = 255;
    }
  }
}

void draw() {
  background(255);
  
  for(int i = numOfTiles-1; i > -1; i--){
    for(int j = numOfTiles-1; j > -1; j--){
      noStroke();
      fill(c[i][j]);
      rect(i*tileSize, j*tileSize, tileSize, tileSize);
    }
  }
}

void mousePressed(){
  for(int i = numOfTiles-1; i > -1; i--){
    for(int j = numOfTiles-1; j > -1; j--){
      if(mouseX > i*tileSize && mouseX <= (i+1)*tileSize && mouseY > j*tileSize && mouseY <=(j+1)*tileSize){
        c[i][j] = color(random(0, 255), random(0, 255), random(0, 255));
      }
    }
  }
}
