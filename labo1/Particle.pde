class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  // couleurs pour particules selon
  color normalColor = color(0, 0, 255);
  color attractedColor = color(0, 255, 0);
  color currentColor;

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
    acceleration = new PVector(0, 0);
    lifespan = 500;
    currentColor = normalColor;
  }

  void update(int deltaTime, PVector pos) {
    applyForce(new PVector(0, 0.05));

    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);

    lifespan -= 2.0;

    if (isDead()) {
      reset(pos);
    }
  }

  void display() {
    stroke(0, lifespan);
    fill(currentColor, lifespan);
    ellipse(position.x, position.y, 10, 10);
  }

  boolean isDead() {
    return lifespan < 0.0;
  }

  void reset(PVector pos) {
    position.set(pos);
    velocity.set(random(-1, 1), random(-2, 0));
    lifespan = 500;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void attract(PVector moverPos, float activationDistance) {
    float distance = PVector.dist(moverPos, position);

    if (distance <= activationDistance) {
      // attract
      PVector force = PVector.sub(moverPos, position);

      force.normalize();
      force.mult(1);

      applyForce(force);

      currentColor = attractedColor;
    } else {
      currentColor = normalColor;
    }
  }

  void attractMagnitude(PVector moverPos, float activationDistance) {
    PVector force = PVector.sub(moverPos, position);
    float distance = force.mag();
    
    if (distance <= activationDistance) {
      float magnitude = (1 * 2500) / (distance * distance);

      force.setMag(magnitude);

      applyForce(force);

      currentColor = attractedColor;
    } else {
      currentColor = normalColor;
    }
  }
}
