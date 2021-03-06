ArrayList<Line> line_set1,line_set2;
float scale_factor = 50;
void setup() {
  size(640, 360);
  noLoop();
  
  line_set1 = new ArrayList<Line>();
  line_set2 = new ArrayList<Line>();
  
  //Line l = new Line(1,1,3,1);
  //line_set1.add(l);
  //l = new Line(1,3,3,3);
  //line_set2.add(l);
  // add some lines
  Line l = new Line(0,1,2,5);
  line_set1.add(l);
  //l = new Line(3,1,2,4);
  //line_set1.add(l);
  l = new Line(1,1,2,2);
  line_set1.add(l);
  l = new Line(5,1,2,0);
  line_set1.add(l);
  
  //for set 2
  l = new Line(1,5,5,3);
  line_set2.add(l);
  l = new Line(1,4,2,1);
  line_set2.add(l);
  l = new Line(2,0.5,5,0.5);
  line_set2.add(l);
  l = new Line(1,4,5,2);
  line_set2.add(l);
}

void draw() {
  background(255);
  translate(0+50, height-50);
  line(-width/2,0,width,0);
  line(0, -height,0, height/2);
  stroke(255,0,0);
  for(Line l : line_set1) {
      l.display();
  }
  stroke(0,255,0);
  for(Line l : line_set2) {
      l.display();
  }
  stroke(0);
  fill(0);
  textAlign(LEFT);
  for(int i =0;i<10;i++){
    text(i+"-",-12,-50*i);
  }
    for(int i =0;i<10;i++){
    text(i,50*i,12);
  }
  noFill();
  float area = buffons_area_estimation();
  float radius = calculate_radius(area);
  point(average_x()*scale_factor,-average_y()*scale_factor);
  circle(average_x()*scale_factor,-average_y()*scale_factor,radius*scale_factor*2);
  
  text("avg: "+average_x()+", "+average_y(),300,-160);
  //text("no.of intersections: "+no_intersections(),300,-140);
  text("radius: "+radius,300,-120);
  text("area: "+area,300,-100);
  
}
