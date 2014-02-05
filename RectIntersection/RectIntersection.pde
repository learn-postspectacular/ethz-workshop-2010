import toxi.geom.*;
import toxi.processing.*;

ToxiclibsSupport gfx;

Rect a=new Rect(100,100,60,50);

void setup() {
  size(200,200);
  gfx=new ToxiclibsSupport(this);
}

void draw() {
  background(255);
  noFill();
  Rect b=new Rect(mouseX,mouseY,20,70);
  stroke(a.intersectsRect(b) ? color(#ff0000) : color(#0000ff));
  gfx.rect(a);
  gfx.rect(b);
}
