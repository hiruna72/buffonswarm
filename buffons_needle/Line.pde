class Line {
  PVector P1;
  PVector P2;
  
  Line(float x1,float y1,float x2,float y2) {
    //P1 = new PVector(map(x1,0,10,0,width),map(y1,0,5,0,height));
    //P2 = new PVector(map(x2,0,10,0,width),map(y2,0,5,0,height));
    P1 = new PVector(x1*50,-y1*50);
    P2 = new PVector(x2*50,-y2*50);
  }

  void display() {
    line(P1.x, P1.y, P2.x, P2.y);
  }
}
