Brick bricks;
Ball balls;
Paddle paddle;
Lives lives;

void setup() {
  size(900, 700);
  
  bricks = new Brick();
  balls = new Ball();
  paddle = new Paddle();
  lives = new Lives();
}

void draw() {
  background(0);
  
  bricks.display();
  bricks.destroy();
  balls.display();
  balls.update();
  paddle.display();
  paddle.update();
  lives.display();
  lives.endGame();
}
