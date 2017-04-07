class Ball {

  int xpos, ypos;
  int w, h;
  int xspeed = xspeed2;
  int yspeed = yspeed2;
  color c;
  int bin[] = {-1, 1};
  
  Ball() {
    w = int(random(10, 51));
    h = w;
    //xpos = int(random(w, width-w));
    //ypos = int(random(h, height-h));
    xpos = width/2;
    ypos = height/2;
    xspeed = 1;
    yspeed = 1;
    xspeed = int(random(1, 6));
    yspeed = int(random(1, 6));
    int hu = int(random(0, 360));
    int sat = 100; //int(random(0, 101));
    int br = 100; //int(random(0, 101));
    c = color(hu, sat, br);
  }
  void move() {
    xpos += this.xspeed;
    ypos += this.yspeed;
    if ((xpos > width-w/2 || xpos < w/2) || (game == true && ((xpos <= x1 + paddlew + w/2 && (ypos > y1 && (ypos < paddleh + y1))) && this.xspeed <0 ) || game == true &&((xpos >= x2 - w/2 && (ypos > y2 && (ypos < paddleh + y2))) && this.xspeed >0)) ) {
      this.xspeed = -this.xspeed;
      println(this.xspeed);
    }

    if (ypos > height-h/2 || ypos < h/2) {
      this.yspeed = -this.yspeed;
      println(this.yspeed);

    }
    if (xpos > width-w/2 && game == true)
    {
      p1_score +=1;
      xpos = width/2;
      ypos = height/2;
      
    }
    if (xpos < w/2 && game == true)
    {
      p2_score +=1;
      xpos = width/2;
      ypos = height/2;
      
    }
  }
  void display() {
    fill(c);
    ellipse(xpos, ypos, w, h);
  }
}