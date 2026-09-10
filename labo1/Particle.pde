class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle() {
    position = new PVector(width/2, height/3);
    initialize();
  }

  Particle(PVector l) {
    position = l.copy();
    initialize();
  }

  void initialize() {
    velocity = new PVector(random(-1, 1), random(-2, 0));
    acceleration = new PVector(0, 0.05);
    lifespan = 255;
  }

  void update(int deltaTime, PVector pos) {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;

    if(isDead()) {
      reset(pos);
    }
  }

  void display() {
    stroke(0, lifespan);
    fill(0, 0, 255, lifespan);
    ellipse(position.x, position.y, 10, 10);
  }

  boolean isDead() {
    return lifespan < 0.0;
  }

  void reset(PVector pos) {
    position.set (pos);
    velocity.set (random(-1, 1), random(-2, 0));    
    lifespan = 255;
  }
}
