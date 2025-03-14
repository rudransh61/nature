int NUM_PARTICLES = 10;  // Number of fluid particles
float H = 10;             // Smoothing radius
float MASS = 1000.0;         // Mass of each particle
float REST_DENSITY = 10.0; // Rest density
float K = 200.0;          // Stiffness coefficient for pressure
float MU = 0.1;           // Viscosity coefficient
PVector GRAVITY = new PVector(0, 1); // Gravity force

Particle[] particles;

void setup() {
  size(600, 600);
  particles = new Particle[NUM_PARTICLES];

  // Initialize particles in a grid
  for (int i = 0; i < NUM_PARTICLES; i++) {
    float x = random(width * 0.3, width * 0.7);
    float y = random(height * 0.2, height * 0.5);
    particles[i] = new Particle(x, y);
  }
}

void draw() {
  background(0);
  
  // Compute density and pressure
  for (Particle p : particles) {
    p.computeDensityPressure();
  }

  // Compute forces
  for (Particle p : particles) {
    p.computeForces();
  }

  // Update positions
  for (Particle p : particles) {
    p.update();
    p.display();
  }
}

// Particle class
class Particle {
  PVector position, velocity, force;
  float density, pressure;

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    force = new PVector(0, 0);
    density = REST_DENSITY;
    pressure = 0;
  }

  void computeDensityPressure() {
    density = 0;
    for (Particle p : particles) {
      float r = PVector.dist(this.position, p.position);
      if (r < H) {
        density += MASS * poly6Kernel(r);
      }
    }
    pressure = K * (density - REST_DENSITY);
  }

  void computeForces() {
    PVector pressureForce = new PVector(0, 0);
    PVector viscosityForce = new PVector(0, 0);

    for (Particle p : particles) {
      if (p == this) continue;
      float r = PVector.dist(this.position, p.position);
      
      if (r < H) {
        // Compute pressure force
        PVector dir = PVector.sub(this.position, p.position);
        dir.normalize();
        pressureForce.add(dir.mult(-MASS * (this.pressure + p.pressure) / (2 * density) * spikyGradient(r)));
        
        // Compute viscosity force
        PVector velocityDiff = PVector.sub(p.velocity, this.velocity);
        viscosityForce.add(velocityDiff.mult(MASS * MU / density * viscosityLaplacian(r)));
      }
    }

    // Apply forces
    force.set(pressureForce.add(viscosityForce).add(PVector.mult(GRAVITY, density)));
  }

  void update() {
    PVector acceleration = PVector.div(force, density);
    velocity.add(acceleration);
    position.add(velocity);
    
    // Boundary conditions (simple reflection)
    if (position.x < 0 || position.x > width) {
      velocity.x = -0.7*abs(velocity.x);
      position.x = constrain(position.x, 0, width);
    }
    if (position.y < 0 || position.y > height) {
      velocity.y= -0.7*abs(velocity.y);
      position.y = constrain(position.y, 0, height);
    }
  }

  void display() {
    fill(100, 200, 255);
    noStroke();
    ellipse(position.x, position.y, 5, 5);
  }

  // Poly6 Kernel for Density Calculation
  float poly6Kernel(float r) {
    float coef = 315 / (64 * PI * pow(H, 9));
    return (r >= 0 && r <= H) ? coef * pow(H * H - r * r, 3) : 0;
  }

  // Spiky Kernel Gradient for Pressure Force
  float spikyGradient(float r) {
    float coef = -15 / (PI * pow(H, 6));
    return (r > 0 && r <= H) ? coef * pow(H - r, 2) : 0;
  }

  // Viscosity Kernel Laplacian
  float viscosityLaplacian(float r) {
    float coef = 15 / (PI * pow(H, 6));
    return (r >= 0 && r <= H) ? coef * (H - r) : 0;
  }
}
