int currentTime;
int deltaTime;
int previousTime;

Mover mover;
Emitter emitter;

void setup() {
  size(800, 600, P2D);
  
  mover = new Mover();
  mover.setDistance(100);
  
  emitter = new Emitter(new PVector(width / 2, height * 0.75), 10, 1000);
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  update(deltaTime);
  display();
}

void update(int deltaTime) {
  mover.update(deltaTime);
  emitter.update(deltaTime, mover.location, mover.getDistance());
}

void display() {
  background(255);
  
  fill(0);
  textSize(16);
  text("Particules : " + emitter.particles.size(), 10, 20);
  text("Dist activation : " + mover.activationDistance + " (K = ↑, L = ↓)", 10, 40);

  mover.display();
  emitter.display();
}
