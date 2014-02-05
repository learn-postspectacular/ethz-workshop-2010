void saveVoxelized() {
  WETriangleMesh combined=new WETriangleMesh();
  for(ParticleMesh m : meshes) {
    combined.addMesh(m.mesh);
  }
  int res=96;
  float iso=0.25;
  VolumetricSpace volume=new MeshVoxelizer(res).voxelizeMesh(combined);
  // create holes in voxel space
  for(int z=0; z<res; z+=2) {
    for(int x=0; x<res; x+=2) {
      for(int y=0; y<res; y++) {
        volume.setVoxelAt(x,y,z,0);
      }
    }
  }
  IsoSurface surface=new ArrayIsoSurface(volume);
  surface.computeSurfaceMesh(combined,iso);
  // voxelized mesh
  new LaplacianSmooth().filter(combined,6);
  combined.scale(1/5.5f);
  combined.saveAsSTL(sketchPath("voxelized-"+iso+".stl"));
}
