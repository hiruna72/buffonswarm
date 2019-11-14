// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

boolean showvalues = true;
boolean scrollbar = true;
ArrayList<Boid> boids; // An ArrayList for all the boids
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
}


void keyPressed() {
  if (key =='c') {
    for (Boid b : boids) {
      b.levy_flight();
    }
  }
}
