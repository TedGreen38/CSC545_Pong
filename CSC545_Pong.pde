int nballs = 1;
Ball[] b = new Ball[nballs];
boolean frozen = false;  //Controls freeze
int x1 = 20;
int y1 = 20;
int paddlew = 10;
int paddleh = 150;
int x2 = width - 20;
int y2 = y1;
int paddle_speed = 10;
boolean[] keys;
PFont f;
int fontSize = 36;
int p1_score = 0;
int p2_score = 0;

void setup() {
  size(600, 400);
  x2 = width - x1 - paddlew;
  colorMode(HSB, 360, 100, 100);
  keys=new boolean[4];
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
  keys[3]=false;
  f = createFont("Arial", fontSize);
  textFont(f);
  //noStroke();  //No border around ball
  for (int i = 0; i < nballs; i++) {
    b[i] = new Ball();
  }
  background(0);
}
void draw() {
  background(0);
  fill(255);
  textAlign(RIGHT);
  text(p1_score, width/2 - 20, fontSize + 20);
  textAlign(LEFT);
  text(p2_score, width/2 + 20, fontSize + 20);
  for (int i = 0; i < b.length; i++) {
    b[i].move();
    b[i].display();
  }
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
  rect(x1, y1, paddlew, paddleh);
  rect(x2, y2, paddlew, paddleh);
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
  if(key == 'q' || key == 'Q')
    keys[0]=true;
  if(key == 'a' || key == 'A')
    keys[1]=true;
  if(key == 'o' || key == 'O')
    keys[2]=true;
  if(key == 'l' || key == 'L')
    keys[3]=true;
}
void keyReleased()
{
  if(key == 'q' || key == 'Q')
    keys[0]=false;
  if(key == 'a' || key == 'A')
    keys[1]=false;
  if(key == 'o' || key == 'O')
    keys[2]=false;
  if(key == 'l' || key == 'L')
    keys[3]=false;
} 