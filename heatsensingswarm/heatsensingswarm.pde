// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

//heatmap 
float increment = 0.02;
int roix = 50;
int roiy = 100;
int limit = 360000;
float [] heats = new float[limit];
boolean ROIchange = false;


boolean showvalues = true;
boolean scrollbar = true;
boolean showestimations = false;


int no_of_line_segments = 10;
int no_of_points = 2*no_of_line_segments;
ArrayList<Boid> boids; // An ArrayList for all the boids
ArrayList<Line> line_set1,line_set2;
float scale_factor = 50;
float average_x,average_y,radius,area,no_intersections;
float search_radius,offset;

int no_of_boids = 3;
void setup() {
  size(600, 600);
  frameRate(100);
  setupScrollbars();
  // Create a walker object
  boids = new ArrayList<Boid>(); // Initialize the ArrayList
  line_set1 = new ArrayList<Line>();
  line_set2 = new ArrayList<Line>();
  for(int i = 0; i < no_of_boids; i++){
    Boid b = new Boid();
    boids.add(b);
  }
  //heat map stuff
  setHeatMap();
}

void draw() {
  //background(255);
  loadPixels();
  drawHeatMap();
  changeROI(true);  
  updatePixels();
  drawScrollbars();
  
  // Run the walker object
  for (Boid b : boids) {
      b.walk();
      b.display();
  }
  
  stroke(255,0,0);
  for(Line l : line_set1) {
    l.display();
  }
  stroke(0,255,0);
  for(Line l : line_set2) {
    l.display();
  }
  stroke(0);

  if (showvalues) {
    fill(255,255,0);
    textAlign(LEFT);
    //text("Total boids: " + boids.size() + "\n" + "offset: " + offset +"\nsearch_radius: " + search_radius +"\n"+ "search_area: " + calculate_area(search_radius) +"\n" + "Framerate: " + round(frameRate)+ "\nPress 'c' to levy_fly",5,60);// + "\nPress any key to show/hide sliders and text\nClick mouse to add more boids",5,100);
    text("Total boids: " + boids.size() + "\n" +"\ntrue search_radius: " + (int)search_radius +"\n"+ "true search_area: " + (int)calculate_area(search_radius) +"\n",5,60);// + "\nPress any key to show/hide sliders and text\nClick mouse to add more boids",5,100);
    if(showestimations){
      text("avg: "+average_x()+", "+average_y(),5,145);
      text("no.of intersections: "+no_intersections,5,160);
      text("radius: "+radius,5,180);
      text("area: "+area,5,200);
    }
  }
  
  point(average_x*scale_factor,average_y*scale_factor);
  circle(average_x*scale_factor,average_y*scale_factor,radius*scale_factor*2);
  
}


void keyPressed() {
  if (key =='p') {
    ROIchange = true;
  }
  
  if (key =='c') {
    for (Boid b : boids) {
      b.levy_flight();
      b.clear_history();
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

      average_x = average_x();
      average_y = average_y();
      no_intersections = no_intersections();
      area = buffons_area_estimation();
      radius = calculate_radius(area);
      print("area : "+ area+" radius : "+radius+"\n");      
    }
    showestimations = true;
  }
}

void setHeatMap(){
  int index = 0;
  float xoff = 0.0; // Start xoff at 0
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff,yoff)*255;
      heats[index++] = bright;
    }
  } 
}

void drawHeatMap(){
  int index = 0;
  while(index < limit){
    pixels[index] = color(heats[index++]);
  }
}

void changeROI(boolean paint){
  for (int x = roix; x < roix+100 && x < width; x++) {
    for (int y = roiy; y < roiy+100 && y < height; y++) {
      float bright = heats[x+y*width];
      if(paint && bright < 90){
        pixels[x+y*width] = color(0);      
      }
      else{
        pixels[x+y*width] = color(bright);
      }    
    }
  }
}

void mousePressed() {
 if(ROIchange){
   changeROI(false);
   roix = mouseX;
   roiy = mouseY;
   changeROI(true);
   circle(roix,roiy,10);
   ROIchange = false;
 }
}
