import toxi.physics2d.constraints.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.*;

import toxi.math.conversion.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.geom.mesh2d.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.math.noise.*;

import processing.opengl.*;

VerletPhysics2D physics;
VerletParticle2D mousePos;

void setup() {
  size(800,600,OPENGL);
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0.1)));
  physics.setWorldBounds(new Rect(100,20,width-100-20,height-20-20));
  for(int i=0; i<100; i++) {
    physics.addParticle(new VerletParticle2D(random(width),random(height)));
  }
}

void draw() {
  physics.update();
  background(255);
  fill(51,0,255);
  noStroke();
  // old skool
  //  for(int i=0; i<physics.particles.size(); i++) {
  //    VerletParticle p=physics.particles.get(i);
  //    ellipse(p.x,p.y,5,5);
  //  }
  // new skool (since 2004)
  for(VerletParticle2D p : physics.particles) {
    ellipse(p.x,p.y,5,5);
  }
  stroke(255,0,255);
  for(VerletSpring2D s : physics.springs) {
    line(s.a.x,s.a.y, s.b.x, s.b.y);
  }
}

void mousePressed() {
  // find closest particle to mouse
  mousePos=new VerletParticle2D(mouseX,mouseY);
  for(VerletParticle2D p : physics.particles) {
    float d=mousePos.distanceTo(p);
    if (d<100) {
      VerletSpring2D s=new VerletSpring2D(mousePos,p,100,0.1);
      physics.addSpring(s);
    }
  }
  
}

void mouseDragged() {
  
}

void mouseReleased() {
  
}
