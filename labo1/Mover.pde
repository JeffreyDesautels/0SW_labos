class Mover {
  PVector location;                // Position (Location)
  PVector velocity;                // Vitesse (Velocity)
  PVector acceleration;            // Accélération (Acceleration)

  color fillColor = color(0);      // Couleur de remplissage (Fill color)
  color strokeColor = color(255);  // Couleur du contour (Stroke color)
  float strokeWeight = 1;          // Épaisseur du contour (Stroke weight)

  int diameter = 20;
  int radius = diameter / 2;

  float activationDistance;
  float deactivationDistance;


  Mover() {
    location = new PVector(0 + radius, height - radius);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  Mover(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  // Fonction servant à valider les bordures.
  // Vérifier les bordures (Check edge)
  void checkEdge() {
    var tempLoc = location.copy().add(velocity);

    if (tempLoc.x + diameter / 2 > width || tempLoc.x - diameter / 2 < 0) {
      velocity.x *= -1;
    }

    if (tempLoc.y + diameter / 2 > height || tempLoc.y - diameter / 2 < 0) {
      velocity.y *= -1;
    }
  }

  void update(int deltaTime) {
    velocity.x = 0;

    if (keyPressed) {
      if (key == 'a' || key == 'A') velocity.x -= 3;
      else if (key == 'd' || key == 'D') velocity.x += 3;
    }
    
    checkEdge();

    location.add(velocity); // Déplacement de l'objet
    acceleration.mult(0);
  }

  void display() {
    stroke(strokeColor);
    fill(fillColor);
    strokeWeight(strokeWeight);

    ellipse(location.x, location.y, diameter, diameter);
  }
}
