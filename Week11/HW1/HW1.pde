//ArrayList<Lightning> lightning;

//void setup(){
//  size(700, 800);
  
//  lightning = new ArrayList<Lightning>();
//}

//void draw(){
//  background(255);

//  for(int i = 0; i < lightning.size(); i++){
//    Lightning l = lightning.get(i);
//    l.display();
//  }
//}

//void mousePressed() {  
//  lightning.add(new Lightning(200));
//}

//class Lightning {
//  float len;
//  float theta = 0;

//  Lightning(float _len){
//    len = _len;
//  }
  
//  void display(){
//    strokeWeight(1);
//    translate(width/2, 50);
//    rotate(random(radians(160), radians(200)));
//    lightning(len);
//  }
  
//  void lightning(float leng){
//  line(0, 0, 0, -leng);
//  theta = random(5, 40);
//  translate(0, -leng);
//  leng *= random(0.5, 0.8);
  
//  if (leng > 60){
//    pushMatrix();
//    rotate(radians(theta));
//    lightning(leng);
//      pushMatrix();
//      rotate(radians(-theta));
//      lightning(leng);
//      popMatrix();
//    popMatrix();
//  }
//  }
  
//}

float[] dist = new float[4];
int[] div = new int[4];
int random;

void setup() {
  size(600, 600);
  
  random = int(random(10, 25));
  for(int i = 0; i < dist.length; i++){ dist[i] = random(1.5, 2.5); }
  for(int i = 0; i < div.length; i++){ div[i] = int(random(2, 7)); }
}

void draw() {
  background(255);
  rectMode(CENTER);
  noFill();
  square(width/2, height/2, 300);
}

void square(float x, float y, float size){
  rect(x, y, size, size);
  if(size > random) {
    square(x + size/dist[0], y, size/div[0]);
    square(x - size/dist[1], y, size/div[1]);
    square(x, y + size/dist[2], size/div[2]);
    square(x, y - size/dist[3], size/div[3]);
  }
}
