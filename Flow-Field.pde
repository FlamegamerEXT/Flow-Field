int RAD = 10, step = 0;
float PERLIN_SCALE = 0.015, VARIANCE = 4, SIDE = 0.2;
ArrayList<Dot> dots = new ArrayList<Dot>();

void setup(){
  size(960, 600);
  //noFill();
  for (int i = 0; i < 2000; i++){
    PVector pos = new PVector(random(width), random(height));
    float angle = random(TWO_PI);
    PVector vel = new PVector(cos(angle), sin(angle));
    float random = 0.7+random(0.6);
    dots.add(new Dot(pos, vel, 1*random, 0.02*random*random, 2/random));
  }
}

void draw(){
  clear();
  
  // Draw flow markers
  stroke(102);
  for (int y = RAD; y < height; y += 2*RAD){
    for (int x = RAD; x < width; x += 2*RAD){
      float angle = getAngle(x, y);
      float dx = -cos(angle)*RAD, dy = sin(angle)*RAD;
      line(x, y, x+dx, y+dy);
      line(x-dy*SIDE, y+dx*SIDE, x+dy*SIDE, y-dx*SIDE);
    }
  }
  
  // Draw dots
  stroke(255, 182, 193);
  for (Dot d : dots){
    d.step(getForce(d.getPos()));
    d.draw();
  }
  
  // Increment step
  step++;
}

public float getAngle(PVector vec){
  return getAngle(vec.x, vec.y);
}
public float getAngle(float x, float y){
  float ans = -PI*(VARIANCE-2)/2;  // So that it is biased towards the right
  for (int i = 0; i < 2; i++){
    float newY = y - i*height;
    ans += VARIANCE*PI*noise(x*PERLIN_SCALE, newY*PERLIN_SCALE, step*0.002)*abs(newY)/height;
  }
  return ans;
}

public PVector getForce(float angle){
  return new PVector(-cos(angle), sin(angle));
}
public PVector getForce(PVector pos){
  return getForce(getAngle(pos));
}
