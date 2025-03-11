// Particle class to represent gas molecules
class Particle {
  PVector position;
  PVector velocity;
  float radius;

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D(); // Random initial direction
    velocity.mult(random(1, 3));  // Random speed
    radius = 10; // Size of the particle
  }

  void update() {
    position.add(velocity); // Update position with velocity
    checkCollision();
  }

  void checkCollision() {
    // Bounce off the container walls
    if (position.x < radius || position.x > width - radius) {
      velocity.x *= -1; // Reverse horizontal direction
    }
    if (position.y < radius || position.y > height - radius) {
      velocity.y *= -1; // Reverse vertical direction
    }
  }

  void display() {
    fill(0, 255, 0);
    noStroke();
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}

Particle[] particles;

void setup() {
  size(800, 600);
  
  int numParticles = 50; // Number of gas molecules
  particles = new Particle[numParticles];
  
  // Create particles with random initial positions
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
}

void draw() {
  background(30); // Dark background
  
  // Update and display all particles
  for (Particle p : particles) {
    p.update();
    p.display();
  }
}
