// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

int no_of_targets = 20;
int iter_around_target = 10;

void setup() {
  size(640, 360);
  background(255);
  //noLoop();
  frameRate(0.5);
}

void draw() {
  background(255);
  fill(0);
  noStroke();
  for(int i = 0; i< no_of_targets; i++){
    int t_x = (int)random(width);
    int t_y = (int)random(height);

    for(int j = 0; j<iter_around_target;j++){
      float xloc = randomGaussian();
      float yloc = randomGaussian();
  
      float sd = 60;                // Define a standard deviation
      xloc = ( xloc * sd ) + t_x;  // Scale the gaussian random number by standard deviation and mean
      yloc = ( yloc * sd ) + t_y;  // Scale the gaussian random number by standard deviation and mean
      if(abs(xloc-t_x)<2*sd && abs(yloc-t_y)<sd)
        ellipse(t_x, t_y, 5, 5);   // Draw an ellipse at our "normal" random position
    }
  }
   
  //// Get a gaussian random number w/ mean of 0 and standard deviation of 1.0
  //float xloc = randomGaussian();

  //float sd = 60;                // Define a standard deviation
  //float mean = width/2;         // Define a mean value (middle of the screen along the x-axis)
  //xloc = ( xloc * sd ) + mean;  // Scale the gaussian random number by standard deviation and mean



}
