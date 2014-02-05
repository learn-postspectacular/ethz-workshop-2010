import controlP5.*;

import toxi.geom.*;
import toxi.util.*;
import toxi.util.datatypes.*;

TypedProperties config;
Facade facade;

FloatRange windowHeight;
FloatRange windowAspect;

void setup() {
  size(600,400);
  initGUI();
  loadConfig();
}

void draw() {
  background(128);
  if (facade!=null) {
    pushMatrix();
    float facadeScale=(float)width/facade.width;
    scale(facadeScale);
    facade.draw();
    popMatrix();
  }
}

void keyPressed() {
  if (key=='r') {
    facade.init();
  }
}
