// Raindrop class to represent individual raindrops
class Raindrop {
  PVector position;
  float speed;
  float length;

  Raindrop(float x, float y) {
    position = new PVector(x, y);
    speed = random(4, 10); // Random falling speed
    length = random(10, 20); // Random raindrop length
  }

  void update() {
    position.y += speed; // Fall downward
    wrapAround();
  }

  void wrapAround() {
    // Reset the raindrop when it moves off the bottom of the screen
    if (position.y > height) {
      position.y = random(-20, 0); // Start slightly above the screen
      position.x = random(width); // Randomize horizontal position
    }
  }

  void display() {
    stroke(135, 206, 250); // Light blue color for rain
    strokeWeight(2);
    line(position.x, position.y, position.x, position.y + length);
  }
}

Raindrop[] raindrops;

void setup() {
  size(800, 600);
  
  int numRaindrops = 200; // Number of raindrops
  raindrops = new Raindrop[numRaindrops];
  
  // Initialize raindrops at random positions
  for (int i = 0; i < raindrops.length; i++) {
    raindrops[i] = new Raindrop(random(width), random(-height, height));
  }
}

void draw() {
  background(30); // Dark background for contrast
  
  // Update and display all raindrops
  for (Raindrop r : raindrops) {
    r.update();
    r.display();
  }
}
