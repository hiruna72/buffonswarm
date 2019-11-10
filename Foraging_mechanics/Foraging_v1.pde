// Calculate heuristic to seek a target using Buffon's Needle
// Hiruna Samarakoon


// Implements Craig Reynold's autonomous steering behaviors
// One vehicle "seeks"
// See: http://www.red3d.com/cwr/

Vehicle v;
PVector target;
PVector starting_pos;
int frame_count = 0;
int num_iter = 5;
int iter = 0;
PrintWriter output;

void setup() {
  size(640, 360);
  target = new PVector(random(0,width), random(0,height));
  starting_pos = new PVector(random(0,width), random(0,height));
  v = new Vehicle(starting_pos.x,starting_pos.y);
  // Create a new file in the sketch directory
  output = createWriter("positions.txt"); 
}

void draw() {
  background(255);
  frame_count++;
  
  // Draw an ellipse at the target position
  fill(200);
  stroke(0);
  strokeWeight(2);
  ellipse(target.x,target.y, 20, 20);
  
  // Call the appropriate steering behaviors for our agents
  v.update();
  if(v.seek(target)){
    output.println(iter + " \t " + frame_count);
    println(iter + " \t " + frame_count);
    iter++;
    frame_count = 0;
    v.change_pos(starting_pos);
  }
  if(iter > num_iter){
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    exit(); // Stops the program
  }
  v.display();
}
