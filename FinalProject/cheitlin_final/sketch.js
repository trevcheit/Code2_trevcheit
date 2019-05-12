var scene = 0;
var lemonMilk, lemonMilkLight;
var data; 

//SCENE 0:
var startButton;
var startBallsCol = [];

var lives;
var dropOdds;
var scoreMultiplier;
var paddleWidth;
var powerupLength;

//SCENE 1:
var balls = [];
var paddle;
var notification = [];
var powerups = [];
var powerupDropOdds;
var paddleExtenderOn = false;
var lowGravityOn = false;
var ballPointerOn = false;
var startTimer, startTimerOn;
var extenderTimer, extenderTimerOn;
var gravityTimer, gravityTimerOn;
var pointerTimer, pointerTimerOn;
var multiplierTimer, multiplierTimerOn;

var paddle_img, paddle_ext_img, heart_img, pointer_img, extender_img, gravity_img;

var streak = 0;
var score = 0;
var longestStreak, highestBounce;
var highScore_alltime, longestStreak_alltime, highestBounce_alltime;

//SCENE 2:
var restartButton, backButton;

function preload() {
  data = loadJSON('assets/data.json');   
    
  lemonMilk = loadFont('assets/LemonMilk.otf');
  lemonMilkLight = loadFont('assets/LemonMilkLight.otf');
    
  paddle_img = loadImage('assets/paddle.png');
  paddle_ext_img = loadImage('assets/paddle-extended.png');
  heart_img = loadImage('assets/lives.png');
  pointer_img = loadImage('assets/balltracker.png');
  extender_img = loadImage('assets/extender.png');    
  gravity_img = loadImage('assets/lowgravity.png');
}

function setup() {
  createCanvas(500, 800);

  lives = 10;
  dropOdds = 30;
  scoreMultiplier = 1;
  paddleWidth = 175;
  powerupLength = 15;

  //SCENE 0
  startButton = new Clickable();
  startButton.resize(180, 80);
  startButton.locate(width/2 - 90, height/2 - 150);
  startButton.text = "Start";
    
  for (var i = 0; i < 2; i++){
    startBallsCol[i] = color(random(255), random(255), random(255));
  }

  //SCENE 1
  paddle = new Paddle();
  startTimer = new Timer(3, width/2, height/2 - 150, 100);
  extenderTimer = new Timer(0, 30, 30, 15);
  gravityTimer = new Timer(0, 30, 70, 15);
  pointerTimer = new Timer(0, 30, 110, 15);
  multiplierTimer = new Timer(0, 30, 150, 15);
    
  //SCENE 2
  restartButton = new Clickable();
  restartButton.resize(180, 80);
  restartButton.locate(width/2 - 90, height/2 + 60);
  restartButton.text = "Play again";

  backButton = new Clickable();
  backButton.resize(150, 60);
  backButton.locate(width/2 - 75, height/2 + 170);
  backButton.text = "Back to start";
}

function draw() {
  background(255, 247, 238);

  if(scene == 0){
    ellipseMode(CENTER);
    fill(startBallsCol[0]);
    ellipse(150, height-160, 200);
    fill(startBallsCol[1]);
    ellipse(360, height-230, 185);
    fill(255);
    ellipse(105, height-185, 85);
    ellipse(195, height-185, 85);
    ellipse(315, height-230, 85);
    ellipse(405, height-230, 85);  
    fill(0);
    ellipse(110, height-205, 40);
    ellipse(190, height-205, 40);
    ellipse(320, height-210, 40);
    ellipse(400, height-210, 40);
    ellipse(150, height-130, 30);
    ellipse(360, height-170, 40);
      
    textAlign(CENTER);
//    textSize(50);
//    textFont(lemonMilk);
    fill(0);
//    text("Bounce Game", width/2, height/2 - 240);

    textSize(30);
    textFont(lemonMilkLight);
    startButton.draw();
    startButton.onPress = function(){
      scene = 1;
      score = 0;
      lives = 10;
      startTimer.time = 3;
      startTimerOn = true;
      longestStreak = 0;
      highestBounce = 0;
    }
  }

  if(scene == 1){
    paddle.display();
    longestStreak_alltime = data.longestStreak;
    highestBounce_alltime = data.highestBounce;

    textFont(lemonMilk);
    startTimer.countdown();
    startTimer.display("start");

    for (var i = 0; i < balls.length; i++){
      balls[i].update();
      balls[i].display();

      if(collideRectCircle(mouseX-paddle.w/2, paddle.y-paddle.h/2, paddle.w, paddle.h, balls[i].position.x, balls[i].position.y, balls[i].size)){
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
        if(streak > longestStreak){
          longestStreak = streak;
        }
        streak = 0;
        if(lives > 0){
          lives--;
        }
        if(lives == 0){
          extenderTimer.time = 0;
          gravityTimer.time = 0;
          pointerTimer.time = 0;
          multiplierTimer.time = 0;
          balls.splice(0, balls.length);
          powerups.splice(0, powerups.length);
          scene = 2;
        }

        if(balls.length == 0 && startTimerOn == false){
          balls.push(new Ball());
        }
      }
    }

    if(startTimer.time == 0 && balls.length == 0 && lives > 0 && startTimerOn == true){
      balls.push(new Ball());
      startTimerOn == false;
    }
      
    for(var i = 0; i < notification.length; i++){
      notification[i].display();
      notification[i].animate();
        
      if(notification[i].transparency <= 0){
        notification.splice(i, 1);
      }
    }

    for(var i = 0; i < powerups.length; i++){
      powerups[i].update();
      powerups[i].display();

      if(collideRectCircle(mouseX-paddle.w/2, paddle.y-paddle.h/2, paddle.w, paddle.h, powerups[i].position.x, powerups[i].position.y, powerups[i].size)){
        if(powerups[i].type < 5){
          lives++;
          notification.push(new Notification("+1", 40, height-80, 12, "center"));
        }
        else if(powerups[i].type == 5){
          paddleExtenderOn = true;
          if(extenderTimer.time <= 0){
            notification.push(new Notification("Paddle extended!", width/2, 200, 25, "center"));
          }
          notification.push(new Notification("+" + powerupLength + " seconds", 60, 30, 12, "left")); 
          extenderTimer.time += powerupLength;
        }
        else if(powerups[i].type == 6){
          lowGravityOn = true;
          if(gravityTimer.time <= 0){
            notification.push(new Notification("Low gravity!", width/2, 200, 25, "center"));
          }
          notification.push(new Notification("+" + powerupLength + " seconds", 60, 70, 12, "left")); 
          gravityTimer.time += powerupLength;
        }
        else if(powerups[i].type == 7){
          ballPointerOn = true;
          if(pointerTimer.time <= 0){
            notification.push(new Notification("Balls tracked!", width/2, 200, 25, "center"));
          }
          notification.push(new Notification("+" + powerupLength + " seconds", 60, 110, 12, "left")); 
          pointerTimer.time += powerupLength;
        }
        else if(powerups[i].type == 8){
          scoreMultiplier = 2;
          if(multiplierTimer.time <= 0){
            notification.push(new Notification("Score multiplier!", width/2, 200, 25, "center"));
          }
          notification.push(new Notification("+" + powerupLength + " seconds", 60, 150, 12, "left")); 
          multiplierTimer.time += powerupLength;
        }

        powerups.splice(i, 1);
      }

      else if(powerups[i].position.y > height){
        powerups.splice(i, 1);
      }
    }

    if(extenderTimer.time == 0){
      paddleExtenderOn = false;
    }
    if(gravityTimer.time == 0){
      lowGravityOn = false;
    }
    if(pointerTimer.time == 0){
      ballPointerOn = false;
    }
    if(multiplierTimer.time == 0){
      scoreMultiplier = 1;
    }
      
      
    textFont(lemonMilkLight);
    extenderTimer.countdown();
    extenderTimer.display("extender");
    gravityTimer.countdown();
    gravityTimer.display("lowGrav");
    pointerTimer.countdown();
    pointerTimer.display("pointer");
    multiplierTimer.countdown();
    multiplierTimer.display("multiplier");  
      
    fill(0);
    textAlign(CENTER);
    textSize(35);
    textFont(lemonMilk);
    text(streak, width/2, height-55);
      
    textSize(15);
    textFont(lemonMilkLight);
    text(score, width/2, height-20);
      
    tint(255);
    image(heart_img, 40, height-40, heart_img.width/2, heart_img.height/2);
    fill(255);
    text(lives, 40, height-40);
  }

  if(scene == 2){
    textAlign(CENTER);
    textSize(50);
    textFont(lemonMilk);
    text("GAME OVER", width/2, 200);

    textSize(25);
    textFont(lemonMilkLight);
    text("Score: " + score, width/2, 300);
    text("Longest streak: " + longestStreak, width/2, 340);
//    text("Highest bounce: " + highestBounce, width/2, 380);
      
    if(score > highScore_alltime){
      textSize(12);
      text("New high score!", width/2, 275);
        
      saveJSON(score, highScore_alltime);
    }
    if(highestBounce > highestBounce_alltime){
      saveJSON(hightestBounce, hightestBounce_alltime);
    }

    textSize(20);
    restartButton.draw();
    restartButton.onPress = function(){
      scene = 1;
      score = 0;
      lives = 10;
      startTimer.time = 3;
      startTimerOn = true;
      longestStreak = 0;
      highestBounce = 0;
    }

    textSize(15);
    backButton.draw();
    backButton.onPress = function(){
      scene = 0;
    }
  }
}

class Ball {
  constructor() {
    this.position = new createVector(width/2, 100);
    this.velocity = new createVector(random(-5,5), random(1,5));
    this.gravity = new createVector(0, .4);
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
    if(lowGravityOn == true){
      this.gravity.y = .2;
    }else if(lowGravityOn == false){
      this.gravity.y = .4;
    }
    this.position.add(this.velocity);
    this.velocity.add(this.gravity);

    if((this.position.x > width - this.size/2) || (this.position.x < this.size/2)) {
      this.velocity.x = this.velocity.x * -1;
    }
  }

  bounce() {
    this.velocity.y = this.velocity.y * -1;
  }
    
//  trackHeight() {
//    var viewableHeight = int((paddle.y-(paddle.h/2)/this.size)/this.size);
//    var ballHeight = int((-this.position.y/this.size) + viewableHeight);
//    if(ballHeight > highestBounce){
//      highestBounce = ballHeight;
//    } 
//    console.log(ballHeight);
//  }

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

    if(ballPointerOn == true){
      var viewableAreaHeight = int(paddle.y-(paddle.h/2)/this.size);
      var bounceHeight = int((-this.position.y/this.size) + viewableAreaHeight);
      if(this.position.y < -this.size/2){
        fill(this.col);
        triangle(this.position.x, 10, this.position.x+15, 25, this.position.x-15, 25);
        textSize(15);
        textAlign(CENTER);
        textFont(lemonMilkLight);
        text(bounceHeight-viewableAreaHeight, this.position.x, 40);
      }
    }
  }

}

class Paddle {
  constructor() {
    this.x = width/2;
    this.y = height-110;
    this.h = 35;
    this.w = paddleWidth;
  }

  display() {
    imageMode(CENTER);
    if(paddleExtenderOn == false){
      this.w = paddleWidth;
      image(paddle_img, mouseX, this.y, this.w, this.h);
    }else if(paddleExtenderOn == true){
      this.w = 350;
      image(paddle_ext_img, mouseX, this.y, this.w, this.h);
    }
  }
}

class Powerup {
  constructor(){
    var plusOneLife = color(208, 2, 27);
    var paddleExtender = color(126, 211, 33);
    var lowGravity = color(74, 144, 226);
    var ballPointer = color(245, 166, 35);
    var scoreMult = color(230, 38, 211)

    this.type = int(random(9));
    this.position = new createVector(width/2, 100);
    this.velocity = new createVector(random(-5,5), random(1,5));
    this.gravity = new createVector(0, .1);
    this.size = 20;

    if(this.type < 5){
      this.col = plusOneLife;
    }else if(this.type == 5){
      this.col = paddleExtender;
    }else if(this.type == 6){
      this.col = lowGravity;
    }else if(this.type == 7){
      this.col = ballPointer;
    }else if(this.type == 8){
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

class Timer {
  constructor(_time, _x, _y, _size){
    this.time = _time;
    this.x = _x;
    this.y = _y;
    this.size = _size;
  }

  countdown(){
    if(frameCount % 60 == 0 && this.time > 0){
      this.time--;
    }
  }

  display(type){
    if(this.time > 0){      
//      imageMode(CENTER);
      ellipseMode(CENTER);
      tint(255, 150);
      if(type == "extender"){
//        image(extender_img, this.x, this.y, 35, 35);
        fill(126, 211, 33, 150);
        ellipse(this.x, this.y, 35, 35);
      }else if(type == "lowGrav"){
//        image(gravity_img, this.x, this.y, 35, 35);
        fill(74, 144, 226, 150);
        ellipse(this.x, this.y, 35, 35);
      }else if(type == "pointer"){
//        image(pointer_img, this.x, this.y, 35, 35);
        fill(245, 166, 35, 150);
        ellipse(this.x, this.y, 35, 35);
      }else if(type == "multiplier"){
        fill(230, 38, 211, 150);
        ellipse(this.x, this.y, 35, 35);
      }else{
        noFill();
      }

      textSize(this.size);
      textAlign(CENTER);
      if(type == "start"){
        fill(0);
      }
      else{
        fill(255);
      }
      text(this.time, this.x, this.y);
    }
  }
}

class Notification {
  constructor(_text, _xPos, _yPos, _size, _type){
    this.text = _text;
    this.xPos = _xPos;
    this.yPos = _yPos; 
    this.size = _size;
    this.type = _type;
    this.transparency = 255;
  }
    
  display(){
    textFont(lemonMilkLight);
    textSize(this.size);
    if(this.type == "left"){
      textAlign(LEFT);
    }else{
      textAlign(CENTER);
    }
    fill(0, 0, 0, this.transparency);
    text(this.text, this.xPos, this.yPos);
  }
    
  animate(){
    this.yPos -= .5;
    this.transparency -= 5;
  }
}
