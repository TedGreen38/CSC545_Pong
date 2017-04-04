class Ball {
  int xpos, ypos;
  int w, h;
  int xspeed, yspeed;
  color c;

  
  Ball() {
    w = int(random(10, 51));
    h = w;
    //xpos = int(random(w, width-w));
    //ypos = int(random(h, height-h));
    xpos = width/2;
    ypos = height/2;
    //xspeed = int(random(1, 6));
    //yspeed = int(random(1, 6));
    xspeed = 5;
    yspeed = 5;
    int hu = int(random(0, 360));
    int sat = 100; //int(random(0, 101));
    int br = 100; //int(random(0, 101));
    c = color(hu, sat, br);
  }
  void move() {
    xpos += xspeed;
    ypos += yspeed;
    if (xpos > width-w/2 || xpos < w/2 || ((xpos <= x1 + paddlew + w/2 && (ypos > y1 && (ypos < paddleh + y1))) && xspeed <0 ) || ((xpos >= x2 - w/2 && (ypos > y2 && (ypos < paddleh + y2))) && xspeed >0) ) {
      xspeed = -xspeed;
    }
    if (ypos > height-h/2 || ypos < h/2) {
      yspeed = -yspeed;
      
    }
    if (xpos > width-w/2)
    {
      p1_score +=1;
    }
    if (xpos < w/2)
    {
      p2_score +=1;
    }
  }
  void display() {
    fill(c);
    ellipse(xpos, ypos, w, h);
  }
}