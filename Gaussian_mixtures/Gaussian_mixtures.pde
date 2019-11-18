// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

int no_of_targets = 3;
int min_iter_around_target = 10;
int max_iter_around_target = 200;
ArrayList<Cluster> clusters  = new ArrayList<Cluster>();
int no_of_clusters = 2;

void generate_clusters(){
 for(int i = 0; i < no_of_clusters; i++){
   clusters.add(new Cluster());
 }
}

void move(){
 for(Cluster cluster : clusters){
   cluster.move();
 }
}

void display(){
 for(Cluster cluster : clusters){
   cluster.display();
 }
}

void setup() {
  size(800, 600);
  background(255);
  //noLoop();
  frameRate(50);
  generate_clusters();  
}

void draw() {
  background(255);
  fill(0);
  noStroke();

  move();
  display();

}
