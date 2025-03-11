// Particle class to encapsulate position, velocity, and behavior
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float radius;
  float damping; // Energy loss on bounce

  Particle(float x, float y, float vx, float vy) {
    position = new PVector(x, y);
    velocity = new PVector(vx, vy);
    acceleration = new PVector(0, 0.2); // Gravity
    radius = 25;
    damping = 0.7; // Energy loss factor
  }

  void update() {
    velocity.add(acceleration); // Apply acceleration to velocity
    position.add(velocity); // Update position
    checkCollision();
  }

  void checkCollision() {
    // Collision with the ground
    if (position.y > height - radius) {
      position.y = height - radius; // Correct position
      velocity.y *= -damping; // Reverse and dampen velocity
    }
  }

  void display() {
    fill(255, 0, 0);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}

Particle ball;

void setup() {
  size(800, 600);
  // Create a Particle with initial position and velocity
  ball = new Particle(50, height - 50, 5, -10);
}

void draw() {
  background(200);
  
  ball.update(); // Update the particle's physics
  ball.display(); // Draw the particle
}
