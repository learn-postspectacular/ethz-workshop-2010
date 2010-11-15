// ETHZ CAAD workshop, day #1
// mesh generation with trigonometry
// radius modulation with additional sine wave

import processing.opengl.*;

// number of slices in form
int numSlices=20;
// distance between slices
int sliceGap=10;
// number of vertices per slice
int sliceRes=90;
// angle step between each vertex
float sliceResDelta=360.0/sliceRes;

// offset to center form vertically on Y axis
float offsetY=-numSlices*sliceGap/2;

// basic radius (unmodulated)
float baseRadius=50;
// amplitude of radius modulation function
float radiusAmplitude=30;
// max possible radius
float maxRadius=baseRadius+radiusAmplitude;

void setup() {
  size(1000,720,OPENGL);
  // switch to HSB color mode using normalized value range (0.0 ... 1.0 = 0% - 100%)
  colorMode(HSB,1.0);
}

void draw() {
  // 1.0 = white
  background(1.0);
  // move coordinate system to centre of screen (in 3D)
  translate(width/2,height/2,0);
  // rotate camera using mouse position
  rotateX(mouseY*0.01);
  rotateY(mouseX*0.01);
  // make everything 2x as big
  scale(2);
  // turn on simple light model for better shading
  lights();
  noStroke();

  // animation phase (offset) for radius modulation
  // frameCount == number of frames displayed so far (since program start)
  float phase=frameCount*0.05;
  // this array will store vertex positions of previous slice
  PVector[] memory=new PVector[sliceRes];

  // outer loop will iterate over all slices
  for(int i=0; i<numSlices; i++) {
    // compute y position for current slice
    float y=offsetY+i*sliceGap;
    // create a single slice as triangle strip
    beginShape(TRIANGLE_STRIP);
    // keep track of 1st vertex in memory (needed to close slice visually)
    PVector prev0=memory[0];
    // inner loop will iterate to create vertices clockwise
    for(int j=0; j<sliceRes; j++) {
      // compute angle of current vertex in radians
      float theta=radians(j*sliceResDelta);
      // use angle to compute radius for this vertex (also based on slice ID)
      float radius=50+sin(theta*3+(i*0.5)+phase)*radiusAmplitude;
      // apply taper effect to radius, so that higher slices shrink in size
      radius*=1f-((float)i/numSlices);
      // calculate actual position in XZ plane
      float x=cos(theta+radius*0.04)*radius;
      float z=sin(theta+radius*0.04)*radius;
      PVector currVertex=new PVector(x,y,z);
      // if not the currently in the first slice, connect vertex to point of previous slice
      if (i>0) {
        // 1st create vertex in current slice
        coloredVertex(currVertex,theta,i);
        // and connect to vertex of previous (i-1)
        coloredVertex(memory[j],theta,i-1);
      }
      // store current vertex in memory for next slice (overrides previous slice values)
      memory[j]=currVertex;
      // end inner loop
    }
    // again, if not in first slice, make sure shape is being closed
    // by connecting last vertex of each slice to first vertex
    if (i>0) {
      // 1st point of current ring
      coloredVertex(memory[0],0,i);
      // 1st point of previous ring
      coloredVertex(prev0,0,i-1);
    }
    // at this point a single slice is finished, end the shape definition
    endShape();
    // end outer loop
  }
}

void coloredVertex(PVector v, float theta, int sliceID) {
  // set vertex color based on its position in the HSB color cylinder
  // theta = hue
  // radius = saturation, equals sqrt(x*x+z*z), equals dist(0,0,x,z)
  // slice index = brightness
  // (force brightness calculation to be in floating point domain)
  fill(theta/TWO_PI,sqrt(v.x*v.x+v.z*v.z)/maxRadius,(float)sliceID/numSlices);
  // create vertex in current slice/ring
  vertex(v.x,v.y,v.z);
}

