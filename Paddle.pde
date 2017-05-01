//Basic Paddle class
class Paddle {
  int xpos, ypos;
  int speed = 10;
  int pheight, pwidth;
  color c = color(255); 
  Paddle(int startx, int starty, int w, int h) {
    //starting x and y positions
    xpos = startx;
    ypos = starty;
    //starting height and width
    pwidth = w;
    pheight = h;
  }
  
  //move the paddle up 
  void move_up() {
    ypos = constrain(ypos = ypos - speed, 0, height - pheight);
  }
  
  //move the paddle down
  void move_down(){
    ypos = constrain(ypos = ypos + paddle_speed, 0, height - paddleh);
  }

  //update speed from the options menu
  void update_speed(int new_speed){
    speed = new_speed;
  }
  
  //update the length from the options menu
  void update_length(int l){
    pheight = l;
  }
  
  void display() {
    fill(c);
    rect(xpos, ypos, pwidth, pheight);
  }
}