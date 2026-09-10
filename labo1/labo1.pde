int currentTime;
int deltaTime;
int previousTime;

Mover mover;
Emitter emitter;

void setup() {
  size(800, 600);
  
  mover = new Mover();
  
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
  emitter.update(deltaTime);
}

void display() {
  background(255);

  mover.display();
  emitter.display();
}
