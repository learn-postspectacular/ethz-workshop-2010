float x,y;

void setup() {
  size(200,200);
  x=width/2;
  y=height/2;
  background(255);
}

void draw() {
  int dx=(int)random(2);
  int dy=(int)random(2);
  if (random(1)<0.5) {
    dx*=-1;
  }
  if (random(1)<0.5) {
    dy*=-1;
  }
  x+=dx;
  y+=dy;
  if (x<0) {
    x+=width;
  } else if (x>=width) {
    x-=width;
  }
  if (y<0) {
    y+=height;
  } else if (y>=height) {
    y-=height;
  }
  point(x,y);
}

