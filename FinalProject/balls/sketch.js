//SCENE 0: START MENU
//SCENE 1: GAME OPTIONS MENU
  //PRESET 0: NORMAL
  //PRESET 1: POWERUP SPAWN RATE INCREASED
  //PRESET 2: LENGTH OF POWERUPS INCREASED (BUT SPAWN RATE DECREASED?)
  //PRESET 3: PADDLE EXPANDS (UP TO 1.5X) WHEN BALLS ARE ADDED
  //PRESET 4: PERMANENT POINTERS
  //PRESET 5: START WITH EXTRA LIVES
//SCENE 2: GAME
  //STATE 3A: COUNTDOWN TIMER
  //STATE 3B: GAME
  //STATE 3B-1: SCORE MULTIPLIER POWERUP
  //STATE 3B-2: LOW GRAVITY POWERUP
  //STATE 3B-3: PADDLE EXTENDER POWERUP
  //STATE 3B-4: BALL POINTER POWERUP
  //STATE 3B-5: WIND
  //STATE 3B-6: HIGH GRAVITY
  //OTHER HAZARDS
//SCENE 3: GAME OVER SCREEN
  //DATA DISPLAYED: SCORE, HIGHEST STREAK, HIGHEST BOUNCE, TOTAL BOUNCES(?)
  //DATA STORED: HIGH SCORE, BEST STREAK

var scene = 0;
var preset = 0;

var balls = [];
var paddle;
var powerups = [];
var powerupDropOdds;

var streak = 0;
var score = 0;

//CAN BE CHANGED VIA STATE
var lives;
var dropOdds;
var scoreMultiplier;
var paddleWidth;
var ballGravity;
var powerupLength;

function setup() {
  createCanvas(600, 1000);

  //PRESET
  if(preset == 0){
    lives = 10;
    dropOdds = 50;
    scoreMultiplier = 1;
    paddleWidth = 200;
    ballGravity = .4;
    powerupLength = 15;
  }
  if(preset == 1){
    lives = 10;
    dropOdds = 25;
    scoreMultiplier = 1;
    paddleWidth = 200;
    ballGravity = .4;
    powerupLength = 15;
  }
  if(preset == 2){
    lives = 10;
    dropOdds = 50;
    scoreMultiplier = 1;
    paddleWidth = 200;
    ballGravity = .4;
    powerupLength = 30;
  }

  if(scene == 2){
    paddle = new Paddle();
  }
}

function draw() {
  background(255, 247, 238);

  if(scene == 2){
    paddle.display();
    text("Lives: " + lives, 20, height-80);
    text("Streak: " + streak, 20, height-100);
    text("Score: " + score, 20, height-120);

    for (var i = 0; i < balls.length; i++){
      balls[i].update();
      balls[i].display();

      if(collideRectCircle(mouseX-paddleWidth/2, paddle.y-paddle.h/2, paddleWidth, paddle.h, balls[i].position.x, balls[i].position.y, balls[i].size)){
        balls[i].bounce();
        streak++;

        if(balls.length == 1){
          score += 1*scoreMultiplier;
          if(streak == 5){
            balls.push(new Ball());
          }
        }
        if(balls.length == 2){
          score += 2*scoreMultiplier;
          if(streak == 16){
            balls.push(new Ball());
          }
        }
        if(balls.length == 3){
          score += 4*scoreMultiplier;
          if(streak == 32){
            balls.push(new Ball());
          }
        }
        if(balls.length == 4){
          score += 8*scoreMultiplier;
          if(streak == 50){
            balls.push(new Ball());
          }
        }
        if(balls.length == 5){
          score += 16*scoreMultiplier;
        }

        powerupDropOdds = int(random(dropOdds));
        if(powerupDropOdds == 1){
          powerups.push(new Powerup());
        }
      }

      if(balls[i].position.y > height){
        balls.splice(i, 1);
        streak = 0;
        if(lives > 0){
          lives--;
        }
      }
    }

    for(var i = 0; i < powerups.length; i++){
      powerups[i].update();
      powerups[i].display();

      if(collideRectCircle(mouseX-paddleWidth/2, paddle.y-paddle.h/2, paddleWidth, paddle.h, powerups[i].position.x, powerups[i].position.y, powerups[i].size)){
        if(powerups[i].type < 6){
          lives++;
        }
        else if(powerups[i].type == 6){
          paddle.extend();
        }
        // else if(powerups[i].type == 7){
        //   balls.lowGrav();
        // }
        // else if(powerups[i].type == 8){
        //   balls.pointer();
        // }
        else if(powerups[i].type == 9){
          scoreMultiplier *= 2;
        }

        powerups.splice(i, 1);
      }

      else if(powerups[i].position.y > height){
        powerups.splice(i, 1);
      }
    }
  }
}

function mousePressed() {
  if(balls.length == 0 && lives > 0){
    balls.push(new Ball());
  }
}

class Ball {
  constructor() {
    this.position = new createVector(width/2, 100);
    this.velocity = new createVector(random(-5,5), random(1,5));
    this.gravity = new createVector(0, ballGravity);
    this.size = 50;
    this.col = color(random(255), random(255), random(255));

    this.eyeY;
    this.eyeSize = 2.3;
    this.pupilY;
    this.pupilX = random(7, 12);
    this.pupilSize = 5;

    this.mouthY;
    this.mouthSize;
  }

  update() {
    this.position.add(this.velocity);
    this.velocity.add(this.gravity);

    if ((this.position.x > width - this.size/2) || (this.position.x < this.size/2)) {
      this.velocity.x = this.velocity.x * -1;
    }
  }

  bounce() {
    this.velocity.y = this.velocity.y * -1;
  }

  display() {
    ellipseMode(CENTER);
    noStroke();
    fill(this.col);
    ellipse(this.position.x, this.position.y, this.size, this.size);

    //ANIMATION - MOVE TO SUBCLASS - STATES TO RANDOMIZE APPEARANCE
    if(this.velocity.y < -10){
      this.eyeY = this.position.y - 8;
      this.pupilY = this.eyeY - 5;
      this.mouthY = this.position.y + 9;
      this.mouthSize = 6;
    }
    if(this.velocity.y < -7.5 && this.velocity.y >= -10){
      this.eyeY = this.position.y - 7;
      this.pupilY = this.eyeY - 4;
      this.mouthY = this.position.y + 10;
      this.mouthSize = 6;
    }
    if(this.velocity.y < -5 && this.velocity.y >= -7.5){
      this.eyeY = this.position.y - 6;
      this.pupilY = this.eyeY - 3;
      this.mouthY = this.position.y + 11;
      this.mouthSize = 6;
    }
    if(this.velocity.y < -2.5 && this.velocity.y >= -5){
      this.eyeY = this.position.y - 5;
      this.pupilY = this.eyeY - 2;
      this.mouthY = this.position.y + 12;
      this.mouthSize = 6;
    }
    if(this.velocity.y < 0 && this.velocity.y >= -2.5){
      this.eyeY = this.position.y - 4;
      this.pupilY = this.eyeY - 1;
      this.mouthY = this.position.y + 13;
      this.mouthSize = 6;
    }
    if(this.velocity.y < 2.5 && this.velocity.y >= 0){
      this.eyeY = this.position.y - 3;
      this.pupilY = this.eyeY;
      this.mouthY = this.position.y + 14;
      this.mouthSize = 5;
    }
    if(this.velocity.y > 2.5 && this.velocity.y <= 5){
      this.eyeY = this.position.y - 2;
      this.pupilY = this.eyeY + 1;
      this.mouthY = this.position.y + 15;
      this.mouthSize = 4.5;
    }
    if(this.velocity.y > 5 && this.velocity.y <= 7.5){
      this.eyeY = this.position.y -1;
      this.pupilY = this.eyeY + 2;
      this.mouthY = this.position.y + 16;
      this.mouthSize = 4.4;
    }
    if(this.velocity.y > 7.5 && this.velocity.y <= 10){
      this.eyeY = this.position.y;
      this.pupilY = this.eyeY + 3;
      this.mouthY = this.position.y + 17;
      this.mouthSize = 4.2;
    }
    if(this.velocity.y > 10){
      this.eyeY = this.position.y + 1;
      this.pupilY = this.eyeY + 4;
      this.mouthY = this.position.y + 18;
      this.mouthSize = 4;
    }

    //EYES
    fill(255);
    ellipse(this.position.x - (this.size/4.5), this.eyeY, this.size/this.eyeSize, this.size/this.eyeSize);
    ellipse(this.position.x + (this.size/4.5), this.eyeY, this.size/this.eyeSize, this.size/this.eyeSize);
    //PUPILS
    fill(0);
    ellipse(this.position.x - this.pupilX, this.pupilY, this.size/this.pupilSize, this.size/this.pupilSize);
    ellipse(this.position.x + this.pupilX, this.pupilY, this.size/this.pupilSize, this.size/this.pupilSize);

    //MOUTH
    fill(0);
    ellipse(this.position.x, this.mouthY, this.size/this.mouthSize, this.size/this.mouthSize);
  }

  lowGrav() {
    ballGravity = .2;
  }

}

class Paddle {
  constructor() {
    this.x = width/2;
    this.y = height-150;
    // this.w = 200;
    this.h = 35;
  }

  display() {
    noStroke();
    rectMode(CENTER);
    fill(0);
    rect(mouseX, this.y, paddleWidth, this.h);
  }

  extend() {
    paddleWidth = 400;
  }

}

class Powerup {
  constructor(){
    var plusOneLife = color(208, 2, 27);
    var paddleExtender = color(126, 211, 33);
    var lowGravity = color(74, 144, 226);
    var ballPointer = color(245, 166, 35);
    var scoreMult = color(230, 38, 211)

    this.type = int(random(10));
    this.position = new createVector(width/2, 100);
    this.velocity = new createVector(random(-5,5), random(1,5));
    this.gravity = new createVector(0, .1);
    this.size = 20;

    if(this.type < 6){
      this.col = plusOneLife;
    }else if(this.type == 6){
      this.col = paddleExtender;
    }else if(this.type == 7){
      this.col = lowGravity;
    }else if(this.type == 8){
      this.col = ballPointer;
    }else if(this.type == 9){
      this.col = scoreMult;
    }
  }

  update() {
    this.position.add(this.velocity);
    this.velocity.add(this.gravity);

    if ((this.position.x > width - this.size/2) || (this.position.x < this.size/2)) {
      this.velocity.x = this.velocity.x * -1;
    }
  }

  display() {
    ellipseMode(CENTER);
    fill(this.col);
    ellipse(this.position.x, this.position.y, this.size, this.size);

  }
}
