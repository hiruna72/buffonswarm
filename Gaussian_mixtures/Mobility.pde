
void generate_clusters(){
  for(int i = 0; i< no_of_targets; i++){
    int t_x = (int)random(width);
    int t_y = (int)random(height);
    int iter_around_target = (int)random(min_iter_around_target,max_iter_around_target);
    for(int j = 0; j<iter_around_target;j++){
        float xloc = randomGaussian();
        float yloc = randomGaussian();
      
        float sd = 60;                // Define a standard deviation
        xloc = ( xloc * sd ) + t_x;  // Scale the gaussian random number by standard deviation and mean
        yloc = ( yloc * sd ) + t_y;  // Scale the gaussian random number by standard deviation and mean
        if(abs(xloc-t_x)<2*sd && abs(yloc-t_y)<sd){
          points.add(new PVector(xloc,yloc));
          noffs.add(new PVector(random(1000),random(1000)));
        }
    }
  }
  for(PVector point : points) {
    original_points.add(new PVector(point.x,point.y));
  }
}

void move(){
  int i =0;
  for(PVector point : points){
    PVector org_point = original_points.get(i);
    PVector noff = noffs.get(i++); 
    
    point.x = map(noise(noff.x),0,1,org_point.x-10,org_point.x+10);
    point.y = map(noise(noff.y),0,1,org_point.y-10,org_point.y+10);
    noff.add(0.01,0.01,0);
  }
}
