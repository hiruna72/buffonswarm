boolean intersects(Line l1, Line l2){
  float l1_a,l1_b,l2_a,l2_b;
  l1_a = l1.get_a();
  l1_b = l1.get_b();
  l2_a = l2.get_a();
  l2_b = l2.get_b();
  // if l1 is vertical and l2 is not, then 
  if(l1_a == Double.POSITIVE_INFINITY && l2_a != Double.POSITIVE_INFINITY)
    return l1.on_line_segment(l1.get_x()) && l2.on_line_segment(l1.get_x());
  // if l2 is vertical and l1 is not, then 
  if(l2_a == Double.POSITIVE_INFINITY && l1_a != Double.POSITIVE_INFINITY)
    return l1.on_line_segment(l2.get_x()) && l2.on_line_segment(l2.get_x());
  // if l1 and l2 are vertical 
  if(l1_a == Double.POSITIVE_INFINITY && l2_a == Double.POSITIVE_INFINITY)
    return false;
  // if l1 and l2 are horizontal 
  if(l1_a == 0 && l2_a == 0)
    return false;
  float point_x = (l2_b-l1_b)/(l1_a-l2_a);
  return l1.on_line_segment(point_x) && l2.on_line_segment(point_x);
}

int no_intersections(){
  int no_intersections = 0;
  //print("length l1: "+line_set1.size()+" length l2: "+line_set2.size()+"\n");
  for(Line l1 : line_set1) {
      for(Line l2 : line_set2) {
        if(intersects(l1,l2))
          no_intersections++;
      }
  }
  return no_intersections;
}

float L1_L2(){
  float total_length1 = 0;
  float total_length2 = 0;  
  for(Line l : line_set1) {
    total_length1 += l.length();
  }
  for(Line l : line_set2) {
    total_length2 += l.length();
  }
  return total_length1*total_length2;
}

float buffons_area_estimation(){
  return 2*L1_L2()/(PI*no_intersections());
}

float average_x(){
  float avg_x = 0;  
  for(Line l : line_set1) {
    avg_x += l.get_x();
  }
  for(Line l : line_set2) {
     avg_x += l.get_x();
  }
  return avg_x/(line_set1.size()+line_set2.size());
}

float average_y(){
  float avg_y = 0;  
  for(Line l : line_set1) {
    avg_y += l.get_y();
  }
  for(Line l : line_set2) {
     avg_y += l.get_y();
  }
  return avg_y/(line_set1.size()+line_set2.size());
}

float calculate_radius(float area){
  return sqrt(area/PI);
}

float calculate_area(float radius){
  return PI*radius*radius;
}
