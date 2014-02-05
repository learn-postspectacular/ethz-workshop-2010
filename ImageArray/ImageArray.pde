PImage img;
int brushW=20;

void setup() {
  size(640,480,P3D);
  img=loadImage("test.jpg");
}

void draw() {
  image(img,0,0,width,height);
  int ix=(int)map(mouseX,0,width,0,img.width);
  int iy=(int)map(mouseY,0,height,0,img.height);
  // calculate 1D array index in pixels array
  for(int y=iy-brushW; y<iy+brushW; y++) {
    for(int x=ix-brushW; x<ix+brushW; x++) {
      int idx=y*img.width + x;
      if (idx>=0 && idx<img.pixels.length) {
        color c=img.pixels[idx];
        img.pixels[idx]=color(red(c)-2,green(c),blue(c));
      }
    }
  }
  img.updatePixels();
}

