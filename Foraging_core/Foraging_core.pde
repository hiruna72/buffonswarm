// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

boolean showvalues = true;
boolean scrollbar = true;
int no_of_line_segments = 10;
int no_of_points = 2*no_of_line_segments;
ArrayList<Boid> boids; // An ArrayList for all the boids
ArrayList<Line> line_set1,line_set2;
float scale_factor = 50;
float average_x,average_y,radius;
void setup() {
  size(600, 600);
  frameRate(100);
  setupScrollbars();
  // Create a walker object
  boids = new ArrayList<Boid>(); // Initialize the ArrayList
  Boid b = new Boid();
  boids.add(b);
}

void draw() {
  background(255);
  drawScrollbars();
  
  // Run the walker object
  for (Boid b : boids) {
      b.walk();
      b.display();
  }

  if (showvalues) {
    fill(0);
    textAlign(LEFT);
    text("Total boids: " + boids.size() + "\n" + "search_radius: " + search_radius +"\n" + "Framerate: " + round(frameRate)+ "\nPress 'c' to levy_fly",5,40);// + "\nPress any key to show/hide sliders and text\nClick mouse to add more boids",5,100);
  }
  
  point(average_x*scale_factor,average_y*scale_factor);
  circle(average_x*scale_factor,average_y*scale_factor,radius*scale_factor*2);
}


void keyPressed() {
  if (key =='c') {
    for (Boid b : boids) {
      b.levy_flight();
    }
  }
  if (key =='a') {
    for (Boid b : boids) {
      line_set1 = new ArrayList<Line>();
      line_set2 = new ArrayList<Line>();
      ArrayList<PVector> path = b.get_history();
      print("no.of path points: "+path.size()+"\n");
      int step_size = path.size()/(no_of_points);
      print("step_size: "+step_size+"\n");
      for(int i = 0; i<no_of_points; i++){
        
        PVector P1 = path.get(step_size*i++);
        PVector P2 = path.get(step_size*i);
        //print("point 1: "+path.get(step_size*i++)+" point 2: "+path.get(step_size*i)+"\n");        
        Line l = new Line(P1.x,P1.y,P2.x,P2.y);
        if(i<no_of_points/2)
          line_set1.add(l);  
        else
          line_set2.add(l);
      }
      float area = buffons_area_estimation();
      float radius = calculate_radius(area);
      print("area : "+ area+" radius : "+radius+"\n");
      average_x = average_x();
      average_y = average_y();
    }
  }
}
