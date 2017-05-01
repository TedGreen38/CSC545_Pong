int game_balls = 1;//game balls
int max_balls = 30;//start menu balls visual
Ball[] b = new Ball[max_balls];
Ball[] b2 = new Ball[max_balls];
boolean frozen = false;  //Controls freeze
//Paddle start location
int x1 = 20;
int y1 = 20;
int x2 = width - 20;
int y2 = y1;
//Here are the variable for game options starting values.
int paddlew = 10;
int paddleh = 150;
int paddle_speed = 10;
int p1_score = 0;
int p2_score = 0;
int xspeed = 1;
int yspeed = 1;
int ball_radius = 50;
int winning = 10;
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
int[] ys = {100, 140, 180, 220, 260, 300};
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
int currentTime = 0;
int bin[] = {-1, 1};

void setup() {
  size(600, 400);
  x2 = width - x1 - paddlew;
  //colorMode(HSB, 360, 100, 100);
  
  //Various fonts
  f = createFont("Arial", fontSize);
  f2 = createFont("Arial", option_bar_height);
  f3 = createFont("Arial", fontSize2);
  textFont(f);
  
  // two sets of balls, one for the game balls and one for start menu graphics
  for (int i = 0; i < game_balls; i++) {
    b2[i] = new Ball(ball_radius);
  }
  for (int i = 0; i < max_balls; i++) {
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
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[1] == true ) {
       xs[1] = constrain(xs[1] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      paddleh = int(map(xs[1], indention, indention+option_bar_length- slider, 150, 50));
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[2] == true ) {
       xs[2] = constrain(xs[2] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      xspeed = bin[int(random(0,2))]*int(map(xs[2], indention, indention+option_bar_length- slider, 1, 10));
      yspeed = bin[int(random(0,2))]*int(map(xs[2], indention, indention+option_bar_length- slider, 1, 10));
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[3] == true ) {
       xs[3] = constrain(xs[3] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      game_balls = int(map(xs[3], indention, indention+option_bar_length- slider, 1, 10));
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[4] == true ) {
       xs[4] = constrain(xs[4] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      ball_radius = int(map(xs[4], indention, indention+option_bar_length- slider, 50, 10));
      for (int i = 0; i < game_balls; i++) {
        b[i].update_radius(ball_radius);
      }
    }
    if(mousePressed && (mouseButton == LEFT) && mpr[5] == true ) {
       xs[5] = constrain(xs[5] + mouseX-pmouseX, indention, indention+option_bar_length-slider);
      m = int(map(xs[5], indention, indention+option_bar_length- slider, 120, 500));
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
    text(abs(xspeed), xs[2]+slider/2, ys[2]+option_bar_text_offset);
    fill((int(map(xs[3], indention, indention+option_bar_length- slider, 0, 255))), (int(map(xs[3], indention, indention+option_bar_length- slider, 255, 0))), 0);
    text(game_balls, xs[3]+slider/2, ys[3]+option_bar_text_offset);
    fill((int(map(xs[4], indention, indention+option_bar_length- slider, 0, 255))), (int(map(xs[4], indention, indention+option_bar_length- slider, 255, 0))), 0);
    text(ball_radius, xs[4]+slider/2, ys[4]+option_bar_text_offset);
    fill((int(map(xs[5], indention, indention+option_bar_length- slider, 0, 255))), (int(map(xs[5], indention, indention+option_bar_length- slider, 255, 0))), 0);
    text(options_string, xs[5]+slider/2, ys[5]+option_bar_text_offset);
    
    //  Options Text
    textAlign(LEFT);
    fill(255);
    text(paddle_speed_string, 20, ys[0]+option_bar_text_offset);
    text(paddle_length_string, 20, ys[1]+option_bar_text_offset);
    text(ball_speed_string, 20, ys[2]+option_bar_text_offset);
    text("Number of Balls", 20, ys[3]+option_bar_text_offset);
    text("Ball Size", 20, ys[4]+option_bar_text_offset);
    
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
    fill(255);
    //Player Score
    textAlign(RIGHT);
    text(p1_score, width/2 - 20, fontSize + 20);
    textAlign(LEFT);
    text(p2_score, width/2 + 20, fontSize + 20);
    //Creation of the game ball/s
    for (int i = 0; i < game_balls; i++) {
      b[i].move();
      b[i].display();
    }
    //Reading the keypresses for paddle movement
      if( keys[0]) 
    {  
      y1 = constrain(y1 = y1 - paddle_speed, 0, height - paddleh);
    }
    if( keys[1]) 
    {
      y1 = constrain(y1 = y1 + paddle_speed, 0, height - paddleh);
    }
      if( keys[2]) 
    {  
      y2 = constrain(y2 = y2 - paddle_speed, 0, height - paddleh);
    }
    if( keys[3]) 
    {
      y2 = constrain(y2 = y2 + paddle_speed, 0, height - paddleh);
    }
    fill(255);
    //paddles
    rect(x1, y1, paddlew, paddleh);
    rect(x2, y2, paddlew, paddleh);
  }
  
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
  /*if(key == 'g' || key == 'G'){
    game = true;
    start = false;
    options = false;
    p1_score = 0;
    p2_score = 0;
  }
  if(key == 's' || key == 'S'){
    start = true;
    game = false;
    options = false;
    p1_score = 0;
    p2_score = 0;
  }*/
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
        p1_score = 0;
        p2_score = 0;
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
    if((mouseButton == LEFT) && pmouseX>xs[5] && pmouseX<xs[5]+option_bar_length && pmouseY>ys[5] && pmouseY<ys[5]+option_bar_height) {
      mpr[5] = true;
  }
  }
  //Start menu buttons
  if (start == true){
    if((mouseButton == LEFT) && pmouseX>width/4- textWidth(start_string)/2 && pmouseX<width/4+textWidth(start_string)/2 && pmouseY>3*height/4 - option_bar_height && pmouseY<3*height/4+option_bar_height/2) {
      game = true;
      start = false;
      options = false;
      p1_score = 0;
      p2_score = 0;
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