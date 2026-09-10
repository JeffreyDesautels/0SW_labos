class Emitter {
  PVector position;
  int particleRate;
  int lastParticleTime;
  ArrayList<Particle> particles;
  int maxParticles;

  Emitter(PVector l, int rate, int maxParticles) {
    position = l.copy();
    particleRate = rate;
    lastParticleTime = 0;
    particles = new ArrayList<Particle>();
    this.maxParticles = maxParticles;
  }

  void update(int deltaTime) {
    if (millis() - lastParticleTime > particleRate && particles.size() < maxParticles) {
      lastParticleTime = millis();
      particles.add(new Particle(position));
    }

    for (Particle p : particles) {
      p.update(deltaTime, position);
    }
  }

  void display() {
    for (Particle p : particles) {
      p.display();
    }
  }
}
