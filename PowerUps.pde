//Class to represent a powerup object
class PowerUps {
  int powertype;
  int xpos;
  int ypos;
  color c;
  
  PowerUps(int type, int startX, int startY) {
    xpos = startX;
    ypos = startY;
    powertype = type;
    if (type == 0) {
      c = color(255, 0, 0);
    }
    else if (type == 1) {
      c = color(0, 255, 0);
    }
    else if (type == 2) {
      c = color(0, 0, 255);
    }
    else if (type == 3) {
      c = color(255, 255, 0);
    }
  }
  
  //draws the powerup (startX and startY are randomly generated)
  void display() {
    fill(c);
    rect(xpos, ypos, 20, 20);
  }
  
  int getType() {
    return powertype;
  }
}