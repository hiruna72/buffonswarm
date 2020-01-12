// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

//heatmap 
float increment = 0.02;
int roix = 50;
int roiy = 100;
int limit = 360000+60000;
float [] heats = new float[limit];
boolean ROIchange = false;
int heat_threshold = 90;

//drawing area
int width_ = 600;
int height_ = 600;

//convexhull
ArrayList<Point> hull;
float polygon_area = 0;
float polygon_radius = 0;

boolean showvalues = true;
boolean scrollbar = true;
boolean showestimations = false;


int no_of_line_segments = 10;
int no_of_points = 2*no_of_line_segments;
ArrayList<Boid> boids; // An ArrayList for all the boids
Boid activebot;
int botno = 0;
int no_of_boids = 4;
ArrayList<Line> line_set1,line_set2;
float scale_factor = 50;
float average_x,average_y,estimated_radius,estimated_area,no_intersections;
float search_radius,offset;


void setup() {
  size(600, 800);
  frameRate(100);
  setupScrollbars();
  // Create a walker object
  boids = new ArrayList<Boid>(); // Initialize the ArrayList
  line_set1 = new ArrayList<Line>();
  line_set2 = new ArrayList<Line>();
  //for(int i = 0; i < no_of_boids; i++){
  //  Boid b = new Boid();
  //  boids.add(b);
  //}
  
  //hard coded origins
  Boid b0 = new Boid(150,150);
  Boid b1 = new Boid(450,150);
  Boid b2 = new Boid(150,450);
  Boid b3 = new Boid(450,450);
  boids.add(b0);
  boids.add(b1);
  boids.add(b2);
  boids.add(b3);
  activebot = b0;
  
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
  
  for (Boid b : boids) {
    b.display();
  }
  // Run the walker object
  //for (Boid b : boids) {
      if(!activebot.detect()){
        activebot.walk();
      }  
      activebot.display();
  //}
  
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
    fill(255);
    textAlign(LEFT);
    //text("Total boids: " + boids.size() + "\n" + "offset: " + offset +"\nsearch_radius: " + search_radius +"\n"+ "search_area: " + calculate_area(search_radius) +"\n" + "Framerate: " + round(frameRate)+ "\nPress 'c' to levy_fly",5,60);// + "\nPress any key to show/hide sliders and text\nClick mouse to add more boids",5,100);
    text("Total bots: " + boids.size() + "\n" + "true search_area: " + (int)calculate_area(search_radius) +"\n",5,640);// + "\nPress any key to show/hide sliders and text\nClick mouse to add more boids",5,100);
    if(showestimations){
      //text("avg: "+average_x()+", "+average_y(),5,145);
      text("no.of intersections: "+no_intersections+"\n"+"estimated radius: "+(int)estimated_radius+"\n"+"estimated area: "+(int)estimated_area,315,615);
      float radius_error = (estimated_radius-search_radius)/search_radius*100;
      text("radius error : "+nf(abs(radius_error),0,2)+"%",465,615);
      float radius_difference = (estimated_radius-polygon_radius)/polygon_radius*100;
      text("radius difference : "+nf(abs(radius_difference),0,2)+"%",465,630);
       
    }
    text("press 'a' to estimate area | press 'p' then a mouse click to change ROI | press 'c' to change bot",15,670);
  }
  
  point(average_x*scale_factor,average_y*scale_factor);
  circle(average_x*scale_factor,average_y*scale_factor,estimated_radius*scale_factor*2);
  
}


void keyPressed() {
  if (key =='p') {
    ROIchange = true;
  }
  
  if (key =='c') {
    //for (Boid b : boids) {
    //  b.levy_flight();
    //  b.clear_history();
    //}
    activebot = boids.get(botno%no_of_boids);
    botno++;
  }
  if (key =='a') {
    int t0 = millis();
    line_set1 = new ArrayList<Line>();
    line_set2 = new ArrayList<Line>();
    ArrayList<PVector> path = activebot.get_history();
    print("no.of path points: "+path.size()+"\n");
    int step_size = path.size()/(no_of_points);
    print("step_size: "+step_size+"\n");
    if(path.size() > 0){
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
      estimated_area = buffons_area_estimation();
      estimated_radius = calculate_radius(estimated_area);
      
      int t1 = millis();
      
      //Jarvi's algorithm for convex hull area
      if(path.size() > 0){
        Point points[] = new Point[path.size()];
        int index = 0;
        for(PVector p : path){
          points[index++] = new Point(p.x,p.y);
        }
        convexHull(points, path.size()); 
        //print("polygon area ",polygonArea(hull));
        polygon_area = polygonArea(hull);
        polygon_radius = calculate_radius(polygon_area);
        
        int t2 = millis();
        print("time ",t1-t0,"ms, ",t2-t1,"ms");
      }
      
    }
    showestimations = true;
  }
}

void setHeatMap(){
  int index = 0;
  float xoff = 0.0; // Start xoff at 0
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width_; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height_; y++) {
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
  for (int x = roix; x < roix+100 && x < width_; x++) {
    for (int y = roiy; y < roiy+100 && y < height_; y++) {
      float bright = heats[x+y*width_];
      if(paint && bright < heat_threshold){
        pixels[x+y*width_] = color(0);      
      }
      else{
        pixels[x+y*width_] = color(bright);
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
