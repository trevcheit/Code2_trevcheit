int num = 5;

int[] pos = {100, 250, 400};
float[] size = new float[num];
color[] col = new color[num];

void setup() {
  size(500, 500, P3D);
  
  for(int i = 0; i < num; i++){
    size[i] = random(50, 100);
    col[i] = color(random(255), random(255), random(255));
  }
  
}

void draw() {
  background(255);
  
  pushMatrix();
    translate(pos[0], pos[0], 0);
    rotateY(mouseX * .01);
    rotateX(mouseY * .01);
    fill(col[0]);
    box(size[0]);
  popMatrix();
  
  pushMatrix();
    translate(pos[2], pos[0], 0);
    rotateY(mouseX * .01);
    rotateX(mouseY * .01);
    fill(col[1]);
    box(size[1]);
  popMatrix();
 
  pushMatrix();
    translate(pos[1], pos[1], 0);
    rotateY(mouseX * .01);
    rotateX(mouseY * .01);
    fill(col[2]);
    box(size[2]);
  popMatrix();
  
  pushMatrix();
    translate(pos[0], pos[2], 0);
    rotateY(mouseX * .01);
    rotateX(mouseY * .01);
    fill(col[3]);
    box(size[3]);
  popMatrix();
  
  pushMatrix();
    translate(pos[2], pos[2], 0);
    rotateY(mouseX * .01);
    rotateX(mouseY * .01);
    fill(col[4]);
    box(size[4]);
  popMatrix();
}
