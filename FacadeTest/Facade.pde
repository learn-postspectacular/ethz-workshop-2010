class Facade {
  
  List<FacadeSegment> segments=new ArrayList<FacadeSegment>();
  
  int width,height;
  
  Facade(int w, int h) {
    this.width=w;
    this.height=h;
  }
  
  void init() {
    segments.clear();
    int numSegments=config.getInt("segments.count",1);
    float offset=0;
    for(int i=0; i<numSegments; i++) {
      println("segment: "+i);
      float segWidth=config.getFloat("segments."+i,1.0)*this.width;
      float light=config.getFloat("segments."+i+".light",1.0);
      boolean hasExit=config.getBoolean("segments."+i+".exit",false);
      FacadeSegment s=new FacadeSegment(offset,segWidth,height,hasExit,light);
      s.createWindows();
      segments.add(s);
      // update position offset
      offset+=segWidth;
    }
  }
  
  void draw() {
    stroke(0);
    noFill();
    for(FacadeSegment s : segments) {
      //fill(s.lightReq*255);
      rect(s.offset,0,s.width,height);
      float bleed=config.getFloat("windows.bleed",5);
      for(Rect r : s.windows) {
        rect(r.x+bleed,r.y+bleed,r.width-bleed*2,r.height-bleed*2);
      }
    }
  }
}

