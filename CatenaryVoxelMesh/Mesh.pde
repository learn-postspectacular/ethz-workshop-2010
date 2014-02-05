class ParticleMesh {

  List<VerletParticle> particles=new ArrayList<VerletParticle>();
  WETriangleMesh mesh;
  int gridSize;
  
  ParticleMesh(VerletPhysics physics, int gridSize, int restLength, float strength) {
    this.gridSize=gridSize;
    int totalWidth=gridSize*restLength;
    for(int y=0,idx=0; y<gridSize; y++) {
      for(int x=0; x<gridSize; x++) {
        VerletParticle p=new VerletParticle(x*restLength-totalWidth/2,y*restLength-totalWidth/2,0);
        physics.addParticle(p);
        particles.add(p);
        if (x>0) {
          VerletSpring s=new VerletSpring(p,particles.get(idx-1),restLength,strength);
          physics.addSpring(s);
        }
        if (y>0) {
          VerletSpring s=new VerletSpring(p,particles.get(idx-gridSize),restLength,strength);
          physics.addSpring(s);
        }
        idx++;
      }
    }
  }
  
  void buildMesh() {
    mesh=new WETriangleMesh();
    for(int y=0,idx=0; y<gridSize; y++) {
      for(int x=0; x<gridSize; x++) {
        if (x>0 && y>0) {
          VerletParticle a=particles.get(idx-gridSize-1);
          VerletParticle b=particles.get(idx-1);
          VerletParticle c=particles.get(idx);
          VerletParticle d=particles.get(idx-gridSize);
          mesh.addFace(a,b,c);
          mesh.addFace(a,c,d);
        }
        idx++;
      }
    }
//    List<Face> faces=new ArrayList<Face>(mesh.getFaces());
//    for(Face f : faces) {
//      mesh.perforateFace(f,0.75);
//    }
  }
}

