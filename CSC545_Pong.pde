int window_width = 600;
int window_height = 400;
int game_balls = 1;//game balls
int balls_left = game_balls;
int max_balls = 10;//start menu balls visual
Ball[] b = new Ball[max_balls];
Ball[] b2 = new Ball[max_balls];
boolean frozen = false;  //Controls freeze

//Here are the variable for game options starting values.
int paddlew = 10;
int paddleh = 150;
int paddle_speed = 10;
int p1_score = 0;
int p2_score = 0;
int ball_speed = 1;
int ball_radius = 50;
int winning = 10;

//Paddle variables 
int paddle1_start_x = 20;
int paddle2_start_x = window_width - 20-paddlew;
int paddles_start_y = 20;
Paddle player1 = new Paddle(paddle1_start_x, paddles_start_y, paddlew, paddleh);
Paddle player2 = new Paddle(paddle2_start_x, paddles_start_y, paddlew, paddleh);

//Variables for text
PFont f, f2, f3;
int fontSize = 36;
int fontSize2 = 60;
String options_string = "Options";
String start_string = "Start";
String paddle_speed_string = "Paddle Speed";
String paddle_length_string = "Paddle Length";
String ball_speed_string = "Ball Speed";
String pongchamp = "PongChamp";
int indention = 220;
int slider = 50;
int[] xs = {indention, indention, indention, indention, indention, indention};
int[] ys = {100, 140, 180, 220, 260};
int option_bar_length = 300;
int option_bar_height = 20;
int option_bar_text_offset = option_bar_height - 2;

//Booleans for States
boolean options = false;
boolean start = true;
boolean game = false;
boolean[] mpr = {false, false, false, false, false, false};//Paddle control flags
boolean[] keys = {false, false, false, false}; //Keys to move to paddles
int m;

//paddle-ball collision logic variables
int collision_check1 = 0, collision_check2 =0;
int speed_boost = 0;

//powerup variables
int randomType = 0; //variable to randomly change type creation
boolean powerupsEnabled = true; //var for enabling/disabling powerups
boolean powerup = false; //var for if a powerup is active
int leftBound = 0 + 65;
int rightBound = window_width - 85;
PowerUps currentPowerUp = new PowerUps(randomType, leftBound, 0);

void setup() {
  size(600, 400);
  surface.setResizable(true);
  surface.setSize(window_width, window_height);
  //colorMode(HSB, 360, 100, 100);
  frameRate(60);
  
  //Various fonts
  f = createFont("Arial", fontSize);
  f2 = createFont("Arial", option_bar_height);
  f3 = createFont("Arial", fontSize2);
  textFont(f);
  
  // two sets of balls, one for the game balls and one for start menu graphics
  for (int i = 0; i < max_balls; i++) {
    b2[i] = new Ball(ball_radius);
  }
  for (int i = 0; i < game_balls; i++) {
    b[i] = new Ball(ball_radius);
  }
  background(0);
}
/*
The draw function revolves around three basic states: Start Screen, Options Menu, and the Game.
These states can be triggered with clicking buttons on cetain states.
To add a new state if needed: add an "if (state == true)" here, add similiar in mousePressed if you need to implement a button.
*/
void draw() {
  // Determines who won and resets to start screen
  if (p1_score >= winning || p2_score >= winning) {
    game = false;
    start = true;
    options = false;
  }
  //=======================================================Start Screen============================================================
  if (start == true) {
    background(0);
    stroke(0);
    //Was Trying to make the start screen more interesting by having a bunch of balls flying around, couldnt get implemented
    //for (int i = 0; i < max_balls; i++) {
    //  b[i].move();
    //  b[i].display();  
    //}
    
    // Creating buttons on start screen to go to Game state or Options Menu state.
    textFont(f3);
    textAlign(CENTER);
    fill(0, 255, 0);
    rect(width/2 - textWidth(pongchamp)/2, fontSize2/2, textWidth(pongchamp), 3*fontSize2/2);
    textFont(f2);
    rect(width/4 - textWidth(start_string)/2, 3*height/4 -option_bar_height, textWidth(start_string), 3*option_bar_height/2);
    rect(3*width/4 - textWidth(options_string)/2, 3*height/4 -option_bar_height, textWidth(options_string), 3*option_bar_height/2);
    fill(255);
    //rectMode(CENTER);
    textFont(f3);
    text(pongchamp, width/2, fontSize2 + fontSize2/2);
    textFont(f2);
    //Prints on start screen the winner of the last played game.
    if (p1_score >= winning ) {
      text("Player 1 Wins!!!", width/2, fontSize2 + 2*fontSize2);
    }
    if (p2_score >= winning) {
      text("Player 2 Wins!!!", width/2, fontSize2 + 2*fontSize2);
    }
    text(start_string, width/4, 3*height/4);
    text(options_string, 3*width/4, 3*height/4);
    
  }
  
  //===================================================Options Menu==========================================================
  else if (options == true) {
    textFont(f);
    background(0);
    textAlign(CENTER);
    text(options_string, width/2, fontSize2);
    rect(width/2 - textWidth(start_string)/2, height -2*option_bar_height, textWidth(start_string), 3*option_bar_height/2);
    fill(255);
    textFont(f2);
    text(start_string, width/2, height - option_bar_height);
    //Create all the sliders for options
    //To Add or remove sliders, go to "ys" up in the variables and adjust the length of the array there.
    for (int i = 0; i < ys.length; i++){
      fill(255);
      stroke(0);
      rect(xs[i], ys[i], 50, 20);
      noFill();
      stroke(255);
      rect(indention, ys[i], option_bar_length, 20);
    }
    
    
    /*
    This next block of code is what takes the position of the slider and maps it to the appropriate variable it is to change.
    Its fairly easy to expand the options, just follow the trend of the existing ones.
    You will also need to add a couple lines down in mousePressed to add a new slider.
    */
    if(mousePressed && (mouseButton == LEFT) && mpr[0] == true ) {
       xs[0] = constrain(xs[0] + mouseX-pmouseX, indention, indention+option_bar_length - slider);
      paddle_speed = int(map(xs[0], indention, indention+option_bar_length - slider, 10, 50));
      player1.update_speed(paddle_speed);
      player2.update_speed(paddle_speed);
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[1] == true ) {
      xs[1] = constrain(xs[1] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      paddleh = int(map(xs[1], indention, indention+option_bar_length- slider, 150, 50));
      player1.update_length(paddleh);
      player2.update_length(paddleh);
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[2] == true ) {
      xs[2] = constrain(xs[2] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      ball_speed = int(map(xs[2], indention, indention+option_bar_length- slider, 1, 10));
      for (int i = 0; i < game_balls; i++) {
        b[i].update_speed(ball_speed);
      }
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[3] == true ) {
       xs[3] = constrain(xs[3] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      game_balls = int(map(xs[3], indention, indention+option_bar_length- slider, 1, 10));
      for (int i = 0; i < game_balls; i++) {
        b[i] = new Ball(ball_radius);
        b[i].update_speed(ball_speed);
        b[i].update_radius(ball_radius);
      }
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[4] == true ) {
       xs[4] = constrain(xs[4] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      ball_radius = int(map(xs[4], indention, indention+option_bar_length- slider, 50, 10));
      for (int i = 0; i < game_balls; i++) {
        b[i].update_radius(ball_radius);
      }
    }
    
    //Here are all the text elements to go along with the options sliders
    textFont(f2);
    fill(0);
    textAlign(CENTER);
    stroke(0);
    strokeWeight(2);
    fill((int(map(xs[0], indention, indention+option_bar_length- slider, 0, 255))), (int(map(xs[0], indention, indention+option_bar_length- slider, 255, 0))), 0);
    text(paddle_speed, xs[0]+slider/2, ys[0]+option_bar_text_offset);
    fill((int(map(xs[1], indention, indention+option_bar_length- slider, 0, 255))), (int(map(xs[1], indention, indention+option_bar_length- slider, 255, 0))), 0);
    text(paddleh, xs[1]+slider/2, ys[1]+option_bar_text_offset);
    fill((int(map(xs[2], indention, indention+option_bar_length- slider, 0, 255))), (int(map(xs[2], indention, indention+option_bar_length- slider, 255, 0))), 0);
    text(abs(ball_speed), xs[2]+slider/2, ys[2]+option_bar_text_offset);
    fill((int(map(xs[3], indention, indention+option_bar_length- slider, 0, 255))), (int(map(xs[3], indention, indention+option_bar_length- slider, 255, 0))), 0);
    text(game_balls, xs[3]+slider/2, ys[3]+option_bar_text_offset);
    fill((int(map(xs[4], indention, indention+option_bar_length- slider, 0, 255))), (int(map(xs[4], indention, indention+option_bar_length- slider, 255, 0))), 0);
    text(ball_radius, xs[4]+slider/2, ys[4]+option_bar_text_offset);
    
    //Powerup button!
    fill(255);
    rect(xs[5], 300, 50, 20);
    noFill();
    stroke(255);
    rect(indention, 300, 50, 20);
    if (powerupsEnabled) {
      fill(0, 255, 0);
      text("Yes!", xs[5]+slider/2, 300+option_bar_text_offset);
    }
    else {
      fill(255, 0, 0);
      text("No!", xs[5]+slider/2, 300+option_bar_text_offset);
    }
    
    // Options Text
    textAlign(LEFT);
    stroke(0);
    fill(255);
    text(paddle_speed_string, 20, ys[0]+option_bar_text_offset);
    text(paddle_length_string, 20, ys[1]+option_bar_text_offset);
    text(ball_speed_string, 20, ys[2]+option_bar_text_offset);
    text("Number of Balls", 20, ys[3]+option_bar_text_offset);
    text("Ball Size", 20, ys[4]+option_bar_text_offset);
    text("PowerUps?", 20, 300+option_bar_text_offset);
    
    //  Hard/Max values to the right of bar
    fill(255, 0, 0);
    text(50, indention+option_bar_length +5, ys[0]+option_bar_text_offset);
    text(50, indention+option_bar_length +5, ys[1]+option_bar_text_offset);
    text(10, indention+option_bar_length +5, ys[2]+option_bar_text_offset);
    text(10, indention+option_bar_length +5, ys[3]+option_bar_text_offset);
    text(10, indention+option_bar_length +5, ys[4]+option_bar_text_offset);
    
    //  Min/Easy Values to the left of bar
    textAlign(RIGHT);
    fill(0, 255, 0);
    text(10, indention-5, ys[0]+option_bar_text_offset);
    text(150, indention-5, ys[1]+option_bar_text_offset);
    text(1, indention-5, ys[2]+option_bar_text_offset);
    text(1, indention-5, ys[3]+option_bar_text_offset);
    text(50, indention-5, ys[4]+option_bar_text_offset);
  }
  //================================================Game state=================================================
  else if (game == true){
  
    background(0);
    stroke(255);
    fill(255);
    //Player Score
    textAlign(RIGHT);
    text(p1_score, width/2 - 20, fontSize + 20);
    textAlign(LEFT);
    text(p2_score, width/2 + 20, fontSize + 20);
    //Collision Checking of balls and paddles
    for (int i = 0; i < game_balls; i++) {
      collision_check1 = paddle_ball_collision(b[i], player1);
      collision_check2 =  paddle_ball_collision(b[i], player2);
      if(collision_check1 == 0 && collision_check2 == 0){
        //set reflectable to true if it's not touching anything
        b[i].reflectable = true;
      }
      if(b[i].reflectable){ 
        //If the ball hit player1's paddle
        if(collision_check1 > 0){
          b[i].reflectable = false;
          b[i].reverse_x_speed();
          if(b[i].ypos >= player1.ypos+player1.pheight/2){
            speed_boost = constrain(int(map(b[i].ypos, player1.ypos+player1.pheight/2, player1.ypos+player1.pheight, 0, 5)), 0, 5);
          } else if (b[i].ypos <= player1.ypos+player1.pheight/2){
            speed_boost = constrain(int(map(b[i].ypos, player1.ypos+player1.pheight/2, player1.ypos, 0, 5)), 0, 5);
          }
          b[i].boost(speed_boost);
          if(collision_check1 == 2 && b[i].yspeed < 0){
            //this if the ball hits the top corner and the ball is moving against the paddle
            b[i].reverse_y_speed();
          }
          if(collision_check1 == 3 && b[i].yspeed > 0) {
            ////this if the ball hits the bottom corner and the ball is moving against the paddle
            b[i].reverse_y_speed();
          }
        }
        //If the ball hit player2's paddle
        else if(collision_check2 > 0){
          b[i].reflectable = false;
          b[i].reverse_x_speed();
          if(b[i].ypos >= player2.ypos+player2.pheight/2){
            speed_boost = constrain(int(map(b[i].ypos, player2.ypos+player2.pheight/2, player2.ypos+player2.pheight, 0, 5)), 0, 5);
          } else if (b[i].ypos <= player2.ypos+player2.pheight/2){
            speed_boost = constrain(int(map(b[i].ypos, player2.ypos+player2.pheight/2, player2.ypos, 0, 5)), 0, 5);
          }
          b[i].boost(speed_boost);
          if(collision_check2 == 2 && b[i].yspeed < 0){
            //this if the ball hits the top corner and the ball is moving against the paddle
            b[i].reverse_y_speed();
          }
          if(collision_check2 == 3 && b[i].yspeed > 0) {
            //this if the ball hits the bottom corner and the ball is moving against the paddle
            b[i].reverse_y_speed();
          }
        }        
      } 
      //Speed update is done on check_collisions
      check_collisions(b[i]);
      b[i].move();
      b[i].display();  
    }
    //Randomly generating powerups
    if (powerupsEnabled) {
      if (powerup) {
        currentPowerUp.display();
        for (int i = 0; i < game_balls; i++) {
          if (powerup_ball_collision(b[i], currentPowerUp)) {
            int currentType = currentPowerUp.getType();
            Paddle hinderedPaddle;
            if (b[i].xspeed < 0) hinderedPaddle = player1;
            else hinderedPaddle = player2;
            if (currentType == 0) { //decrease paddle length
              hinderedPaddle.update_length(hinderedPaddle.pheight - 10);
            }
            if (currentType == 1) { //increase ball speed
              if (b[i].xspeed < 0) b[i].xspeed -= 2;
              else b[i].xspeed += 2;
            }
            if (currentType == 2) { //decrease ball size
              b[i].update_radius(b[i].radius - 5);  
            }
            if (currentType == 3) { //reverse speed
            b[i].reverse_x_speed();
            }
            powerup = false;
          }
        }
      }
      else {
        int randomSpawn = (int) random(0, 500);
        if (randomSpawn == 250) {
          currentPowerUp = createPowerUp();
          powerup = true;
        }
      }
    }
    
    //Reading the keypresses for paddle movement
    if( keys[0]) player1.move_up();
    if( keys[1]) player1.move_down();
    if( keys[2]) player2.move_up();
    if( keys[3]) player2.move_down();
    //paddles
    player1.display();
    player2.display();
    //reset the game when we are out of balls
    if(balls_left == 0){
      balls_left = game_balls;
      for (int i = 0; i < game_balls; i++) {
        b[i].scored = false;
        b[i].start_ball();
      }
    }
  }
}

//Handle general collisions: top/bottom screen, and goals
void check_collisions(Ball ball){
    //All balls should bouce off the ceiling and ground
    if ((ball.ypos >= height-ball.radius || ball.ypos <= ball.radius) && ball.ceil_ground) {
      ball.ceil_ground = false;
      ball.reverse_y_speed();
    }
    else if (ball.ypos < height-ball.radius && ball.ypos > ball.radius){
      ball.ceil_ground = true;
    }
  //This is used for the menu balls
  if(!game){
    if(ball.xpos > width-ball.radius || ball.xpos < ball.radius)
      ball.reverse_x_speed();
  }
  else if(game){
    //when the ball hits the wall, player 1 a point
    if (ball.xpos >= width-ball.radius && game == true)
    {
      balls_left -= 1;
      p1_score +=1;
      ball.scored = true;
      ball.reset_ball();
    }
    //when the ball hits the wall, player 2 a point
    if (ball.xpos <= ball.radius && game == true)
    {
      balls_left -= 1;
      p2_score +=1;
      ball.scored = true;
      ball.reset_ball();
    }
  }
}

/* Handle Paddle-Ball Collision logic
  Checks to see if the paddle is colliding with the ball and returns a number
*/
int paddle_ball_collision(Ball ball, Paddle paddle){
  float distX = abs(ball.xpos - paddle.xpos-paddle.pwidth/2);
  float distY = abs(ball.ypos - paddle.ypos-paddle.pheight/2);
  //It's definitely not hitting the paddle here
  if (distX > (paddle.pwidth/2 + ball.radius)) { return 0; }
  if (distY > (paddle.pheight/2 + ball.radius)) { return 0; }
  
  //check if the ball is hitting the paddle
  if (distX <= (paddle.pwidth/2)) { return 1; } 
  if (distY <= (paddle.pheight/2)) { return 1; }

  float dx=distX-paddle.pwidth/2;
  float dy=distY-paddle.pheight/2;
  if((dx*dx+dy*dy)<=(ball.radius*ball.radius)){
    //ball is hitting the bottom side of the paddle
    if(ball.ypos > paddle.ypos){
      return 2;}
    else { //ball hit the top side of the paddle
      return 3;
    }
  }
  else {
    return 0;
  }
}

boolean powerup_ball_collision(Ball ball, PowerUps powerup) {
  float distX = abs(ball.xpos - powerup.xpos-20/2);
  float distY = abs(ball.ypos - powerup.ypos-20/2);
  //It's definitely not hitting the paddle here
  if (distX > (20/2 + ball.radius)) { return false; }
  if (distY > (20/2 + ball.radius)) { return false; }
  
  //check if the ball is hitting the paddle
  if (distX <= (20/2)) { return true; } 
  if (distY <= (20/2)) { return true; }

  float dx=distX-20/2;
  float dy=distY-20/2;
  if((dx*dx+dy*dy)<=(ball.radius*ball.radius)){
    return true;
  }
  else {
    return false;
  }
}

//Returns a random powerup and a random position
PowerUps createPowerUp() {
  randomType = (int) random(0, 4);
  int randomX = (int) random (leftBound, rightBound);
  int randomY = (int) random (0, height - 20);
  return new PowerUps(randomType, randomX, randomY);
}

void keyPressed() {
  if (key == ' ') {
    if (frozen) {
      frozen = false;
      loop();
    } else {
      frozen = true;
      noLoop();
    }
  } else if (key == 'r' || key == 'R') {
    background(0);
  }
  //Keypresses for paddle movement
  if(key == 'w' || key == 'W')
    keys[0]=true;
  if(key == 's' || key == 'S')
    keys[1]=true;
  if(key == CODED){
    if(keyCode == UP)
      keys[2]=true;
    if(keyCode == DOWN)
      keys[3]=true;
  }
    
  //Keypress to change states, was planning to remove, was only using for troubleshooting
  if(key == 'g' || key == 'G'){
    game = true;
    start = false;
    options = false;
    p1_score = 0;
    p2_score = 0;
  }
  if(key == 'h' || key == 'H'){
    start = true;
    game = false;
    options = false;
    p1_score = 0;
    p2_score = 0;
  }
  if(key == 'f' || key == 'F'){
    options = true;
    start = false;
    game = false;
    p1_score = 0;
    p2_score = 0;
  }//*/
}
void keyReleased()
{
  //for paddle movement
  if(key == 'w' || key == 'W')
    keys[0]=false;
  if(key == 's' || key == 'S')
    keys[1]=false;
  if(key == CODED){
    if(keyCode == UP)
      keys[2]=false;
    if(keyCode == DOWN)
      keys[3]=false;
  }
}
void mousePressed() {
  //This is where i implemented clicking of buttons
  textFont(f2);
  //Buttons for options menu
  if (options == true){
    if((mouseButton == LEFT) && pmouseX>width/2- textWidth(start_string) && pmouseX<width/2+textWidth(start_string) && pmouseY>height - 2*option_bar_height && pmouseY<height-option_bar_height/2) {
        game = true;
        start = false;
        options = false;
        player1.update_length(paddleh);
        player2.update_length(paddleh);
        p1_score = 0;
        p2_score = 0;
        balls_left = game_balls;
        for (int i = 0; i < game_balls; i++) {
          b[i].scored = false;
          b[i].reset_ball();
          b[i].update_radius(ball_radius);
          b[i].start_ball();
      }
    }
    if((mouseButton == LEFT) && pmouseX>xs[0] && pmouseX<xs[0]+option_bar_length && pmouseY>ys[0] && pmouseY<ys[0]+option_bar_height) {
      mpr[0] = true;
    }
    if((mouseButton == LEFT) && pmouseX>xs[1] && pmouseX<xs[1]+option_bar_length && pmouseY>ys[1] && pmouseY<ys[1]+option_bar_height) {
      mpr[1] = true;
    }
    if((mouseButton == LEFT) && pmouseX>xs[2] && pmouseX<xs[2]+option_bar_length && pmouseY>ys[2] && pmouseY<ys[2]+option_bar_height) {
      mpr[2] = true;
    }
    if((mouseButton == LEFT) && pmouseX>xs[3] && pmouseX<xs[3]+option_bar_length && pmouseY>ys[3] && pmouseY<ys[3]+option_bar_height) {
      mpr[3] = true;
    }
    if((mouseButton == LEFT) && pmouseX>xs[4] && pmouseX<xs[4]+option_bar_length && pmouseY>ys[4] && pmouseY<ys[4]+option_bar_height) {
      mpr[4] = true;
    }
    if((mouseButton == LEFT) && pmouseX>xs[5] && pmouseX<xs[5]+50 && pmouseY > 300 && pmouseY< 300 + 20) {
      if (powerupsEnabled) {
        powerupsEnabled = false;
        
      }
      else {
        powerupsEnabled = true;
      }
    }
  }
  //Start menu buttons
  if (start == true){
    if((mouseButton == LEFT) && pmouseX>width/4- textWidth(start_string)/2 && pmouseX<width/4+textWidth(start_string)/2 && pmouseY>3*height/4 - option_bar_height && pmouseY<3*height/4+option_bar_height/2) {
      game = true;
      start = false;
      options = false;
      player1.update_length(paddleh);
      player2.update_length(paddleh);
      p1_score = 0;
      p2_score = 0;
      balls_left = game_balls;
      for (int i = 0; i < game_balls; i++) {
          b[i].scored = false;
          b[i].reset_ball();
          b[i].update_radius(ball_radius);
          b[i].start_ball();
      }
    }
    if((mouseButton == LEFT) && pmouseX>3*width/4- textWidth(options_string)/2 && pmouseX<3*width/4+textWidth(options_string)/2 && pmouseY>3*height/4 - option_bar_height && pmouseY<3*height/4+option_bar_height/2) {
      game = false;
      start = false;
      options = true;
      p1_score = 0;
      p2_score = 0;
    }
  }
}
void mouseReleased() {
  //here is where the sliders in Options stop sliding on mouse release.
   mpr[1] = false;
   mpr[2] = false;
   mpr[3] = false;
   mpr[4] = false;
   mpr[5] = false;
   mpr[0] = false;
}