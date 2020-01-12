// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A random walker class!



class Boid {
  PVector position;
  PVector centric_pos;
  PVector noff;
  PVector noff_center;
  ArrayList<PVector> history;
  int timer,time_interval;
  
  Boid() {
    position = new PVector(width/2, height/2);
    centric_pos = position.copy();
    history = new ArrayList<PVector>();
    noff = new PVector(random(1000),random(1000));
    noff_center = new PVector(random(1000),random(1000));
    time_interval = 50;
    timer = time_interval;
  }
  Boid(int x, int y) {
    position = new PVector(x,y);
    centric_pos = position.copy();
    history = new ArrayList<PVector>();
    noff = new PVector(random(1000),random(1000));
    noff_center = new PVector(random(1000),random(1000));
    time_interval = 50;
    timer = time_interval;
  }

  void display() {
    strokeWeight(2);
    fill(255,255,0);
    stroke(0);
    ellipse(position.x, position.y, 10, 10);
    
    //draw history
    beginShape();
    stroke(0);
    noFill();
    for (PVector v: history) {
      vertex(v.x, v.y);
    }
    endShape();
    
    //draw search cirle
    circle(centric_pos.x, centric_pos.y, search_radius*2);
    //ellipse(centric_pos.x, centric_pos.y, search_radius, search_radius);
    //text((int)centric_pos.x+","+(int)centric_pos.y,(int)centric_pos.x,(int)centric_pos.y); 
    text("bot 1",(int)centric_pos.x,(int)centric_pos.y); 
}

  boolean detect(){
    if(position.x > roix && position.x < roix+100 && position.y > roiy && position.y < roiy+100){
        float bright = heats[(int)position.x+(int)position.y*width];
        if(bright < heat_threshold){
          return true;      
      }
    }
    return false;
  }

  // Randomly move up, down, left, right, or stay in one place
  void walk() {
    
    position.x = map(noise(noff.x),0,1,centric_pos.x-search_radius-offset,centric_pos.x+search_radius+offset);
    position.y = map(noise(noff.y),0,1,centric_pos.y-search_radius-offset,centric_pos.y+search_radius+offset);
    
    
    //if area is not covered change center slightly
    //if(random(1000)<10){
    //  centric_pos.x = centric_pos.x+map(noise(noff.x),0,1,-1,1);
    //  centric_pos.y = centric_pos.y+map(noise(noff.y),0,1,-1,1);
    //}
    
    
    noff.add(0.01,0.01,0);
    
     // Stay on the screen
    //position.x = constrain(position.x, 0, width-1);
    //position.y = constrain(position.y, 0, height-1);
    if(timer-- < 0){
        history.add(position.get());
        timer = time_interval;
    }
    //history.add(position.get());
    if (history.size() > 30) {
      history.remove(0);
    }
  }
  
    // Perform a big step jump
  void levy_flight() {
    
    position.x = map(random(1),0,1,0,width_);
    position.y = map(random(1),0,1,0,height_);
    
    centric_pos = position.copy();
    print("levy fligth performed "+position+"\n");
  }
  
  ArrayList<PVector> get_history(){
    return history;
  }
  
  void clear_history(){
    history = new ArrayList<PVector>();
  }
}
