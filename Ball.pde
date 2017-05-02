//Basic ball class
class Ball {
  float xpos, ypos;
  float xspeed, yspeed;
  int x_start_speed = 1;
  float y_start_speed = random(0,2);
  int radius, diameter;
  int currentTime = 0;
  float x_direction, y_direction;
  //If there are multiple balls, we need to keep track of whether or not they were scored
  boolean scored = false;
  //The next 2 bools keep track of reflecting off paddles and the ceiling/ground
  boolean reflectable = true;
  boolean ceil_ground = true;
  color c; 
  int bin[] = {-1, 1};
  
  Ball(int r) {
    //starting x and y positions
    xpos = width/2;
    ypos = height/2;
    //starting radius and diameter. These can be updated in the menu
    radius = r;
    diameter = radius*2;
    //starting x/y speeds and directions
    x_direction = bin[int(random(0,2))];
    y_direction = bin[int(random(0,2))];
    xspeed = x_direction*x_start_speed;
    yspeed = y_direction*y_start_speed;
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
      //if (ypos > height-ball_radius || ypos < ball_radius) {
      //  ypos -= yspeed;
      //}
    }
  }
  
  //update start speed from the options menu
  void update_speed(int speed){
    xspeed = speed*x_direction;
    yspeed = speed*y_direction;
    x_start_speed = speed;
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
    currentTime = millis();
    x_direction = bin[int(random(0,2))];
    y_direction = bin[int(random(0,2))];
    y_start_speed = random(0,2);
    xspeed = x_direction*x_start_speed;
    yspeed = y_direction*y_start_speed;
  }
  
  //reverse the xspeed when the ball hits a paddle
  void reverse_x_speed(){
    x_direction = -x_direction;
    xspeed = -xspeed;
  }
  
  //reverse y speed when ball hits the ceiling or floor  
  void reverse_y_speed(){
    y_direction = -y_direction;
    yspeed = -yspeed;   
  }
  
  //Give the ball a speed boost based on where it hit the paddle
  void boost(int speed){
    if (speed == 0){
      //If the ball hits the center of the paddle, boost the xspeed, and reset the y speed
      xspeed = sqrt(xspeed*xspeed+yspeed*yspeed)*x_direction;
      yspeed = y_start_speed*y_direction;
    } else {
      yspeed += speed*y_direction/5.0;
      constrain(yspeed, 0, 20);
    }
  }
  
  //display the ball
  void display() {
    if(!scored){
      fill(c);
      ellipse(xpos, ypos, diameter, diameter);
    }
  }
}