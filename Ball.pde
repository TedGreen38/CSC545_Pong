class Ball {

  int xpos, ypos;
  
  int xspeed2 = xspeed;
  int yspeed2 = yspeed;
  color c;
  
  Ball() {
    //w = int(random(10, 51));
    //xpos = int(random(w, width-w));
    //ypos = int(random(h, height-h));
    xpos = width/2;
    ypos = height/2;
    xspeed = bin[int(random(0,2))]*1;
    yspeed = bin[int(random(0,2))]*1;
    //xspeed = int(random(1, 6));
    //yspeed = int(random(1, 6));

    int hu = int(random(0, 360));
    int sat = 100; //int(random(0, 101));
    int br = 100; //int(random(0, 101));
    c = color(hu, sat, br);
  }
  void move() {
    if (millis()-1500 > currentTime){
      xpos += xspeed;
      ypos += yspeed;
    }
    if ((xpos > width-w/2 || xpos < w/2) || (game == true && ((xpos <= x1 + paddlew + w/2 && (ypos > y1 && (ypos < paddleh + y1))) && xspeed <0 ) || game == true &&((xpos >= x2 - w/2 && (ypos > y2 && (ypos < paddleh + y2))) && xspeed >0)) ) {
      xspeed = -xspeed;
      println(xspeed);
    }

    if (ypos > height-h/2 || ypos < h/2) {
      yspeed = -yspeed;
      println(yspeed);

    }
    if (xpos > width-w/2 && game == true)
    {
      p1_score +=1;
      xpos = width/2;
      ypos = height/2;
      currentTime = millis();
      
    }
    if (xpos < w/2 && game == true)
    {
      p2_score +=1;
      xpos = width/2;
      ypos = height/2;
      currentTime = millis();
      
    }
  }
  void display() {
    fill(c);
    ellipse(xpos, ypos, w, h);
  }
}