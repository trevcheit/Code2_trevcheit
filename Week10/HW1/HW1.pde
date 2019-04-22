Ball ball = new Ball();
ArrayList <Blob> blobs;

int wallPos = -2000;

void setup(){
  size(600, 600, P3D);
  
  blobs = new ArrayList<Blob>();
}

void draw(){
  background(0);
  lights();
  
  for(int i = 0; i < blobs.size(); i++){
    Blob b = blobs.get(i);
    b.display();
  }
  
  pushMatrix();
    translate(width/2, height/2, ball.pos.z);
    ball.update();
    ball.display();
    if(ball.pos.z < wallPos + ball.size/2){
      ball.bounce();
      blobs.add(new Blob());
    }
    
    if(ball.vel.z > 0 && mousePressed){
      ball.bounce();
    }
  popMatrix();
 
  pushMatrix();
    translate(0, 0, wallPos);
    rectMode(CENTER);
    noStroke();
    rect(width/2, height/2, 3000, 3000);
  popMatrix();
}

class Ball {
  PVector pos;
  PVector vel;
  PVector acc;
  int size = 100;
  
  Ball(){
    pos = new PVector(width/2, height/2, 0);
    vel = new PVector(0, 0, -.1);
    acc = new PVector(0, 0, -.8);
  }
  
  void update(){
    vel.add(acc);
    pos.add(vel);
  }
  
  void bounce() {
    vel.z *= -1;
    //acc.z *= -.001;
  }
  
  void display(){
    noStroke();
    fill(255);
    sphere(size);
  }
  
}


//MEAN TO CHANGE THIS INTO A BLOB (SEE DANIEL SHIFFMAN'S "BLOBBY" TUTORIAL)
class Blob {
  color c;
  float growth = 10;
  float radius = 0;
  
  Blob() {
    c = color(random(0, 255), random(0, 255), random(0, 255));
  }
  
  void display(){
    pushMatrix();
    strokeWeight(4);
    stroke(c);
    noFill();
    translate(width/2, height/2, wallPos);
    ellipse(0, 0, radius, radius);
    radius += growth;
    
    //translate(width/2, height/2, wallPos);
    //beginShape();
    //float xoff = 0;
    //for (int i = 0; i < TWO_PI; i += 0.1){
    //  float offset = map(noise(xoff), 0, 1, -25, 25);
    //  float r = radius + offset;
    //  float x = r * cos(i);
    //  float y = r * sin(i);
    //  vertex(x, y);
    //  xoff += 0.1;
    //}
    //endShape();
    popMatrix();
  }
}
