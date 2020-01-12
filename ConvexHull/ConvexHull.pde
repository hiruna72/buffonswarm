ArrayList<Point> hull;

void setup() {
  size(300, 400);
  
  Point points[] = new Point[7]; 
  points[0]=new Point(0, 3); 
  points[1]=new Point(2, 3); 
  points[2]=new Point(1, 1); 
  points[3]=new Point(2, 1); 
  points[4]=new Point(3, 0); 
  points[5]=new Point(0, 0); 
  points[6]=new Point(3, 3); 
  
  int n = points.length; 
  convexHull(points, n); 
  
  ArrayList<Point> pts = new ArrayList<Point>();
  Point p = new Point(0,0);
  pts.add(p);
  p = new Point(1,0);
  pts.add(p);
  p = new Point(0.5,0.5);
  pts.add(p);
  print("polygon area ",polygonArea(pts));
}

class Point 
{ 
  float x, y; 
  Point(float x, float y){ 
    this.x=x; 
    this.y=y; 
  } 
} 

float polygonArea(ArrayList<Point> points) 
{ 
  float area = 0;   // Accumulates area 
  int j = points.size()-1; 

  for (int i=0; i<points.size(); i++)
  { 
    area +=  (points.get(j).x+points.get(i).x) * (points.get(j).y-points.get(i).y); 
    j = i;  //j is previous vertex to i
  }
  return abs(area/2);
}

int orientation(Point p, Point q, Point r) 
  { 
    float val = (q.y - p.y) * (r.x - q.x) - 
        (q.x - p.x) * (r.y - q.y); 
  
    if (val == 0) return 0; // collinear 
    return (val > 0)? 1: 2; // clock or counterclock wise 
  } 

void convexHull(Point points[], int n) 
  { 
    // There must be at least 3 points 
    if (n < 3) return; 
  
    // Initialize Result 
    hull = new ArrayList<Point>(); 
  
    // Find the leftmost point 
    int l = 0; 
    for (int i = 1; i < n; i++) 
      if (points[i].x < points[l].x) 
        l = i; 
  
    // Start from leftmost point, keep moving 
    // counterclockwise until reach the start point 
    // again. This loop runs O(h) times where h is 
    // number of points in result or output. 
    int p = l, q; 
    do
    { 
      // Add current point to result 
      hull.add(points[p]); 
  
      // Search for a point 'q' such that 
      // orientation(p, x, q) is counterclockwise 
      // for all points 'x'. The idea is to keep 
      // track of last visited most counterclock- 
      // wise point in q. If any point 'i' is more 
      // counterclock-wise than q, then update q. 
      q = (p + 1) % n; 
      
      for (int i = 0; i < n; i++) 
      { 
      // If i is more counterclockwise than 
      // current q, then update q 
      if (orientation(points[p], points[i], points[q])== 2) 
        q = i; 
      } 
  
      // Now q is the most counterclockwise with 
      // respect to p. Set p as q for next iteration, 
      // so that q is added to result 'hull' 
      p = q; 
  
    } while (p != l); // While we don't come to first point 
  
    // Print Result 
    for (Point temp : hull) 
      System.out.println("(" + temp.x + ", " +temp.y + ")"); 
  } 
