// Daniel Shiffman
// The Nature of Code
// http://natureofcode.com

float increment = 0.02;
int roix = 50;
int roiy = 100;

void setup() {
  size(640,360);
  //noLoop();
  setHeatMap();
  changeROI(true);
}

void setHeatMap(){
  loadPixels();

  float xoff = 0.0; // Start xoff at 0
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff,yoff)*255;

      // Try using this line instead
      //float bright = random(0,255);
      
      // Set each pixel onscreen to a grayscale value
      pixels[x+y*width] = color(bright);
    }
  } 
  
  updatePixels();
}
void draw() {

}

void changeROI(boolean paint){
  loadPixels();
  float xoff = 0.0; // Start xoff at 0
  xoff = increment*roix;
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = roix; x < roix+100 && x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    yoff = increment*roiy;
    for (int y = roiy; y < roiy+100 && y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff,yoff)*255;
      if(paint && bright < 90){
        pixels[x+y*width] = color(0);      
      }
      else{
        pixels[x+y*width] = color(bright);
      }    
    }
  }
  updatePixels();
  //stroke(255,0,0);
  

}

void mousePressed() {
 print("pressed");
 changeROI(false);
 roix = mouseX;
 roiy = mouseY;
 changeROI(true);
 circle(roix,roiy,10);
}
