public class Dot {
  PVector pos, vel;
  float vMax, aMax, radius;
  
  public Dot(PVector p, PVector v, float vm, float am, float r){
    pos = p;
    vel = v;
    vMax = max(abs(vm), 0.0000001);  // Must be a positive value
    radius = abs(r);
    aMax = abs(am);
    
    vel.normalize();
    vel.mult(vMax);
    normalizePos();
  }
  
  public PVector getPos(){
    return pos;
  }
  
  public PVector getVel(){
    return vel;
  }
  
  public void step(PVector a){
    PVector acc = a.copy();
    acc.normalize();
    acc.mult(aMax);
    
    // Update velocity
    vel.div(vMax);
    vel.add(acc);
    vel.normalize();
    vel.mult(vMax);
    
    // Update position
    pos.add(vel);
    normalizePos();
  }
  
  private void normalizePos(){
    PVector xShift = new PVector(width, height*(random(1)-0.5));
    if (pos.x < 0) { pos.add(xShift); }
    else if (pos.x > width) { pos.sub(xShift); }
    
    PVector yShift = new PVector(0, height);
    if (pos.y < 0) { pos.add(yShift); }
    else if (pos.y > height) { pos.sub(yShift); }
  }
  
  public void draw(){
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}
