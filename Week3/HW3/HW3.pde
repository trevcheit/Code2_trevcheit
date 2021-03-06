Player player;
Ball ball;
Brick[][] bricks = new Brick[10][5];
int score;

boolean rightPressed = false;
boolean leftPressed = false;

void setup() {
  size(900, 600);
  player = new Player();
  ball = new Ball();

  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[0].length; j++) {
      if(j < 2){
        bricks[i][j] = new blueBrick(45 + i * 90, 50 + j * 40, 80, 20);
      }else{
        bricks[i][j] = new redBrick(45 + i * 90, 50 + j * 40, 80, 20);
      }
    }
  }
}

void draw() {
  background(10);
  player.update();
  player.display();

  ball.update();
  ball.display();


  // does it make sense for ball to own this?
  if (ball.pos.x > player.x - player.w/2 && ball.pos.x < player.x + player.w/2 &&
    ball.pos.y > player.y - player.h/2 && ball.pos.y < player.y + player.h/2) {
      
    ball.angle = random(PI, TWO_PI);
    ball.vel = new PVector(cos(ball.angle), sin(ball.angle));
    ball.vel.mult(ball.speed);
    ball.pos.add(ball.vel);
  }

  for (int i = 0; i < bricks.length; i++) {
    for (int j = 0; j < bricks[0].length; j++) {
      if (bricks[i][j].active) {
        bricks[i][j].display();
        if (ball.didCollideWithBrick(bricks[i][j])) {
          bricks[i][j].active = false;
          if(bricks[i][j].c == bricks[i][j].r){
            score += 1;
          }
          if(bricks[i][j].c == bricks[i][j].b){
            score += 2;
          }
        }
      }
    }
  }
  
  text(score, 50, height-50);
}
