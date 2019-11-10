// The "Vehicle" class

class Vehicle {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float roaming_coefficient;
  color car_color;

  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,-2);
    position = new PVector(x,y);
    r = 6;
    maxspeed = 2;
    maxforce = 0.1;
    roaming_coefficient = 0.2;
    car_color = color(255,0,0);
  }
  
  Boolean seek(PVector target){
    roaming_coefficient = 0.2;
    car_color = color(255,0,0);
    if(PVector.sub(target,position).mag() < 5)
      return true;
    if(PVector.sub(target,position).mag() < 100)
      car_color = color(0,255,0);
      roaming_coefficient = 0.5;
    return false;

  }
   
  void change_pos(PVector starting_pos){
    position = starting_pos;
  }
  
  // Method to update position
  void update() {
    // Update velocity
    acceleration = new PVector(random(-1,1),random(-1,1));
    if(random(0,1) < 0.3){
      velocity.add(acceleration);
    }  
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    if(position.x < 10 || position.x > width - 10)
      position.add(velocity.mult(-2));
    if(position.y < 10 || position.y > height - 10)
      position.add(velocity.mult(-2));
    // Reset accelerationelertion to 0 each cycle
    //acceleration.mult(0);
  }

    
  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + PI/2;
    fill(car_color);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(position.x,position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
    
    
  }
}
