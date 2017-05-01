//Basic ball class
class Ball {
  int xpos, ypos;
  int xspeed;
  int yspeed;
  int radius;
  int diameter;
  color c; 
  Ball(int r) {
    //w = int(random(10, 51));
    //xpos = int(random(w, width-w));
    //ypos = int(random(h, height-h));
    xpos = width/2;
    ypos = height/2;
    radius = r;
    diameter = radius*2;
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
    //Pauses ball movement at center after a point is scored
    if (millis()-1500 > currentTime){
      xpos += xspeed;
      ypos += yspeed;
    }
    //This grotesque boolean checks if the ball is bouncing off anything. I'm not really sure how to break this up into more manageable pieces.
    /*if ((xpos > width-radius || xpos < radius) || (game == true && ((xpos <= x1 + paddlew + radius && (ypos > y1 && (ypos < paddleh + y1))) && xspeed <0 ) || game == true &&((xpos >= x2 - radius && (ypos > y2 && (ypos < paddleh + y2))) && xspeed >0)) ) {
      xspeed = -xspeed;
      //println(xspeed);
    }*/
    //Broke up that grotesque boolean. It's a little more manageable but still pretty ugly
    if (game == true){
      if((xpos <= x1 + paddlew + radius) && (ypos > y1) && (ypos < paddleh + y1) && (xspeed <0 ))
        xspeed = -xspeed;
      if((xpos >= x2 - radius) && (ypos > y2) && (ypos < paddleh + y2) && (xspeed >0))
        xspeed = -xspeed;
    }
    if(!game){
      if(xpos > width-radius || xpos < radius)
        xspeed = -xspeed;
    }
    if (ypos > height-radius || ypos < radius) {
      yspeed = -yspeed;
      //println(yspeed);

    }
    //when the ball hits the wall, player 1 a point
    if (xpos > width-radius && game == true)
    {
      p1_score +=1;
      xpos = width/2;
      ypos = height/2;
      currentTime = millis();
      
    }
    //when the ball hits the wall, player 2 a point
    if (xpos < radius && game == true)
    {
      p2_score +=1;
      xpos = width/2;
      ypos = height/2;
      currentTime = millis();
      
    }
  }
  void update_radius(int r){
    radius = r;
    diameter = radius*2;
  }
  void display() {
    fill(c);
    ellipse(xpos, ypos, diameter, diameter);
  }
}