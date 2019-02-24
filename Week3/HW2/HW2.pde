final int NUM = 5;

Box[] boxes = new Box[NUM];

void setup() {
  size(500, 500, P3D);
  
  for(int i = 0; i < NUM; i++){
    boxes[i] = new Box(i);
  }
}

void draw() {
  background(255);
  
  for(int i = 0; i < NUM; i++){
    boxes[i].display();
    boxes[i].onClick();
  }
  
}
