boolean horizontal = true;
float ellipseX, ellipseY;
float theta = 0;
int size = 100;

void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  theta += .02;
  
  if(horizontal == true){
    ellipseX = width/2;
    ellipseY = (sin(theta) + 1) * height/2;
  }else if(horizontal == false){
    ellipseY = height/2;
    ellipseX = (sin(theta) + 1) * width/2;
  }
  
  if(dist(ellipseX, ellipseY, mouseY, mouseY) < size/2){
    fill(0);
  }else{
    fill(255);
  }
  
  ellipse(ellipseX, ellipseY, size, size);
}

void mousePressed() {
  if(dist(ellipseX, ellipseY, mouseY, mouseY) < size/2){
    horizontal = !horizontal;
  }
}
