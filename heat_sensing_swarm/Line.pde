class Line {
  PVector P1;
  PVector P2;
  
  Line(float x1,float y1,float x2,float y2) {
    //P1 = new PVector(map(x1,0,10,0,width),map(y1,0,5,0,height));
    //P2 = new PVector(map(x2,0,10,0,width),map(y2,0,5,0,height));
    if(x1 <= x2){
      P1 = new PVector(x1,y1);
      P2 = new PVector(x2,y2);
    }else{
      P2 = new PVector(x1,y1);
      P1 = new PVector(x2,y2);
    }
  }
  
  // construct y + ax + b = 0 structure
  
  float get_a(){
    float a = (P2.y-P1.y)/(P1.x-P2.x);
    return a;
  }
  
  float get_b(){
    float b = (P2.y*P1.x - P1.y*P2.x)/(P2.x-P1.x);
    return b;
  }
  
  boolean on_line_segment(float x){
    return P1.x <= x && x <= P2.x;
  }
  
  float length(){
    return sqrt((P1.x-P2.x)*(P1.x-P2.x) + (P1.y-P2.y)*(P1.y-P2.y));
  }
  
  float get_x(){
    return 0.5*(P1.x + P2.x);
  }
  
  float get_y(){
    return 0.5*(P1.y + P2.y);
  }
  
  void display() {
    line(P1.x, P1.y, P2.x, P2.y);
  }
}
