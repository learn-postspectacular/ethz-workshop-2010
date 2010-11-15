// ETHZ CAAD workshop, day #1
// using an array to create a temporary history of values
// same principle as used in Shape3D exercise

int[] memory=new int[3];

for(int i=0; i<5; i++) {
  println("outer: "+i);
  for(int j=0; j<3; j++) {
    // compute value for current j in current slice i
    int x=i*10+j;
    // if not first slice, display current and memorized values
    if (i>0) {
      println("inner: "+j+": "+ x+" -> "+memory[j]);
    }
    // keep current value in history (override previous one)
    memory[j]=x;
  }
}
