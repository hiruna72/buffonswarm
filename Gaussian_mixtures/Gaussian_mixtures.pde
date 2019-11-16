// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

int no_of_targets = 3;
int min_iter_around_target = 10;
int max_iter_around_target = 100;
ArrayList<PVector> points  = new ArrayList<PVector>();
ArrayList<PVector> noffs  = new ArrayList<PVector>();
ArrayList<PVector> original_points = new ArrayList<PVector>();;
void setup() {
  size(640, 360);
  background(255);
  //noLoop();
  frameRate(100);
  generate_clusters();  
}

void draw() {
  background(255);
  fill(0);
  noStroke();

  for(PVector point : points){
    ellipse(point.x,point.y,3,3);
  }
  move();
}
