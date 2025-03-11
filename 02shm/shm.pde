// Particle class for SHM
class Particle {
  PVector position;  // Position vector
  float amplitude;   // Amplitude of SHM
  float angularFrequency; // Angular frequency (ω)
  float time;        // Time variable
  float equilibriumY; // Equilibrium Y position
  float radius;

  Particle(float startX, float startY, float amplitude, float angularFrequency) {
    position = new PVector(startX, startY);
    this.amplitude = amplitude;
    this.angularFrequency = angularFrequency;
    this.time = 0;  // Initialize time
    this.equilibriumY = startY; // Store the equilibrium Y position
    this.radius = 20;
  }

  void update() {
    // Horizontal SHM: x = A * cos(ωt)
    position.x = amplitude * cos(angularFrequency * time);
    position.y = equilibriumY; // Keep constant Y for horizontal SHM

    // Increase time for motion
    time += 0.05;
  }

  void display() {
    fill(0, 0, 255);
    ellipse(position.x + width / 2, position.y, radius * 2, radius * 2);
  }
}

Particle particle;

void setup() {
  size(800, 400);
  // Create a Particle for SHM with amplitude and angular frequency
  particle = new Particle(0, height / 2, 150, 1);
}

void draw() {
  background(200);
  
  particle.update(); // Update SHM position
  particle.display(); // Display the particle
}
