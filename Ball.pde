//Basic ball class
class Ball {
  int xpos, ypos;
  int xspeed, yspeed;
  int start_speed;
  int radius, diameter;
  int currentTime = 0;
  boolean scored = false, reflectable = true;
  color c; 
  int bin[] = {-1, 1};
  Ball(int r) {
    //starting x and y positions
    xpos = width/2;
    ypos = height/2;
    //starting radius and diameter. These can be updated in the menu
    radius = r;
    diameter = radius*2;
    //starting x/y speeds
    xspeed = bin[int(random(0,2))];
    yspeed = bin[int(random(0,2))];
    start_speed = abs(xspeed);

    int hu = int(random(0, 360));
    int sat = 100; //int(random(0, 101));
    int br = 100; //int(random(0, 101));
    c = color(hu, sat, br);
  }
  
  //move the ball based on speed
  void move() {    
    //Pauses ball movement at center after a point is scored
    if (millis()-1500 > currentTime){
      xpos += xspeed;
      ypos += yspeed;
    }
  }
  
  //update start speed from the options menu
  void update_speed(int speed){
    xspeed = speed;
    yspeed = speed;
    start_speed = speed;
  }
  
  //update the radius from the options menu
  void update_radius(int r){
    radius = r;
    diameter = radius*2;
  }
  
  //reset the ball to the center and wait for the game to start parameters
  void reset_ball(){
     xpos = width/2;
     ypos = height/2;
     xspeed = 0;
     yspeed = 0;
  }
  
  //start ball movement
  void start_ball(){
    xspeed = bin[int(random(0,2))]*start_speed;
    yspeed = bin[int(random(0,2))]*start_speed;
    currentTime = millis();
  }
  
  //reverse the xspeed when the ball hits a paddle
  void reverse_x_speed(){
    xspeed = -xspeed;
  }
  
  //reverse y speed when ball hits the ceiling or floor  
  void reverse_y_speed(){
    yspeed = -yspeed;
  }
  
  //display the ball
  void display() {
    if(!scored){
      fill(c);
      ellipse(xpos, ypos, diameter, diameter);
    }
  }
}