import processing.opengl.*;

import toxi.volume.*;
import toxi.processing.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;

VerletPhysics physics;

int DIM=40;
int REST_LENGTH=10;
float STRENGTH = 0.9;

int normalLength;
boolean doUpdate=true;

ToxiclibsSupport gfx;

List<ParticleMesh> meshes=new ArrayList<ParticleMesh>();

int idxA, idxB, idxC, idxD;

void setup() {
  size(800,600,P3D);
  gfx=new ToxiclibsSupport(this);
  physics=new VerletPhysics();
  physics.addBehavior(new GravityBehavior(new Vec3D(0,0,0.1)));
  physics.setWorldBounds(new AABB(new Vec3D(0,0,0),500));
  
  ParticleMesh m = new ParticleMesh(physics,DIM,REST_LENGTH,STRENGTH);
  meshes.add(m);
  
  // pin corners in space
  m.particles.get(0).lock();
  m.particles.get(DIM-1).lock();
  m.particles.get(DIM*DIM-1).lock();
  m.particles.get(DIM*DIM-DIM).lock();
  m.particles.get(DIM*DIM/2-DIM/2).lock();
  
  m = new ParticleMesh(physics,DIM/2,REST_LENGTH,STRENGTH);
  meshes.add(m);
  
  int x=(DIM-DIM/2)/2;
  int y=(DIM-DIM/2)/2;
  
  idxA = x+y*DIM;
  idxB = x+(DIM-1-y)*DIM;
  idxC = (DIM-1-x)+(DIM-1-y)*DIM;
  idxD = (DIM-1-x)+y*DIM;
  println(idxA+" "+idxB+" "+idxC+" "+idxD);
  for(int i=1; i<500; i++) {
    joinMeshes();
    physics.update();
  }
}

void draw() {
  if (doUpdate) {
    joinMeshes();
    physics.update();
  }
  background(255);
  noStroke();
  translate(width/2,height/2,0);
  rotateX(mouseY*0.01);
  rotateY(mouseX*0.01);
  lights();
  for(int i=0; i<meshes.size(); i++) {
    ParticleMesh m=meshes.get(i);
    m.buildMesh();
    fill(255,i*160,0);
    gfx.mesh(m.mesh,true,normalLength);
  }
}

void keyPressed() {
  if (key==' ') {
    TriangleMesh export=new TriangleMesh();
    for(ParticleMesh m : meshes) {
      export.addMesh(m.mesh);
    }
    export.saveAsSTL(sketchPath("catanary.stl"));
  }
  if (key=='n') {
    if (normalLength==0) {
      normalLength=10;
    } else {
      normalLength=0;
    }
  }
  if (key=='u') {
    doUpdate=!doUpdate;
  }
  if (key=='v') {
    saveVoxelized();
  }
}

void joinMeshes() {
  // particles in big/parent mesh
  VerletParticle a=meshes.get(0).particles.get(idxA);
  VerletParticle b=meshes.get(0).particles.get(idxB);
  VerletParticle c=meshes.get(0).particles.get(idxC);
  VerletParticle d=meshes.get(0).particles.get(idxD);
  
  // modify particles in smaller mesh
  ParticleMesh m=meshes.get(1);
  m.particles.get(0).lock().set(a);
  m.particles.get(m.gridSize-1).lock().set(b);
  m.particles.get(m.gridSize*m.gridSize-1).lock().set(c);
  m.particles.get(m.gridSize*m.gridSize-m.gridSize).lock().set(d);
  
}
