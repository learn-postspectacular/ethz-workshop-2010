class FacadeSegment {
  
  float offset;
  float width,height;
  boolean hasExit;
  float lightReq;
  
  List<Rect> windows=new ArrayList<Rect>();
  
  FacadeSegment(float o,float w, float h, boolean e, float l) {
    this.offset=o;
    this.width=w;
    this.height=h;
    this.hasExit=e;
    this.lightReq=l;
  }
  
  void createWindows() {
    // populate the list of windows
    // calculate total area available for windows based on light requirements
    float areaLeft=width*height*lightReq;
    float totalArea=areaLeft;
    float minHeight=config.getFloat("window.height.min",50);
    boolean isExitOkay=false;
    int numIterations=0;
    do {
      // create a single window
      // check for intersections with existing
      // check for intersection with segment boundary
      // check size against remaining area
      // consider exit flag
      float h=windowHeight.pickRandom();
      float w=h*windowAspect.pickRandom();
      boolean needsExit=hasExit && !isExitOkay;
      if (!needsExit) {
        while(w*h > areaLeft && h > minHeight) {
          w*=0.9;
          h*=0.9;
        }
      } else {
        // enforce min width/height for exits
        w=max(w,config.getFloat("exit.width.min",80));
        h=max(h,config.getFloat("exit.height.min",210));
      }
      if (w*h < areaLeft || needsExit) {
      float border=config.getFloat("segments.border",50);
      float x=random(border,width-w-border);
      if (x+w>width-border) {
        w=width-border-x;
      } 
      x+=offset;
      float y;
      if (needsExit) {
        y=height-h;
      } else {
        y=random(h,height-h)-h;
      }
      Rect candidate=new Rect(x,y,w,h);
      if (validateRectangle(candidate)) {
        windows.add(candidate);
        areaLeft-=candidate.getArea();
        numIterations=0;
        if (hasExit && !isExitOkay) {
          isExitOkay=true;
        }
        println(candidate);
      }
      }
      numIterations++;
    } while(areaLeft>0 && numIterations<1000);
    float error=abs(areaLeft/totalArea);
    println("area unused: "+error);
  }
  
  // check rect against all existing
  // return true, if rect doesn't collide (is okay)
  boolean validateRectangle(Rect check) {
    for(Rect r : windows) {
      if (intersectRects(check,r)) {
        return false;
      }
    }
    return true;
  }
}

boolean intersectRects(Rect a, Rect b) {
  return !(a.x > b.x+b.width || a.x+a.width < b.x || a.y > b.y+b.height || a.y+a.height < b.y);
}
