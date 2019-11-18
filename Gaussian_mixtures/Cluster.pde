class Cluster{
  float t_x;
  float t_y;
  int iter_around_target;
  ArrayList<PVector> points  = new ArrayList<PVector>();
  ArrayList<PVector> noffs  = new ArrayList<PVector>();
  ArrayList<PVector> original_points = new ArrayList<PVector>();
  PVector noise_cluster = new PVector(random(1000),random(1000));

  Cluster(){
    t_x = (int)random(width);
    t_y = (int)random(height);
    iter_around_target = (int)random(min_iter_around_target,max_iter_around_target);
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
    for(PVector point : points) {
      original_points.add(new PVector(point.x,point.y));
    }
  }
  
  void move(){
    int i =0;
    PVector cluster_shift = new PVector();
    cluster_shift.x = map(noise(noise_cluster.x),0,1,0,width);
    cluster_shift.y = map(noise(noise_cluster.y),0,1,0,height);
    noise_cluster.add(0.001,0.001,0);
    for(PVector point : points){
      PVector org_point = original_points.get(i);
      PVector noff = noffs.get(i++); 
      
      point.x = map(noise(noff.x),0,1,org_point.x-10,org_point.x+10);
      point.y = map(noise(noff.y),0,1,org_point.y-10,org_point.y+10);
      point.add(cluster_shift);
      noff.add(0.01,0.01,0);
      
      // Stay on the screen
      point.x = point.x%width;
      point.y = point.y%height;
      noff.add(0.01,0.01,0);
    }
  }
  
  void display(){
    for(PVector point : points){
      ellipse(point.x,point.y,3,3);
    }
  }
  
  
}
