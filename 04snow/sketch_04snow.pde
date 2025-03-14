// Snowflake class to represent individual snowflakes
class Snowflake {
  PVector position;
  float radius;
  float speed;
  float drift; // Horizontal drift factor

  Snowflake(float x, float y) {
    position = new PVector(x, y);
    radius = random(2, 5); // Random size for variation
    speed = random(1, 3);  // Random falling speed
    drift = random(-1, 1); // Random horizontal drift
  }

  void update() {
    position.y += speed;   // Fall downward
    position.x += drift;   // Drift sideways
    wrapAround();          // Reset when it goes off the screen
  }

  void wrapAround() {
    // Wrap around when the snowflake moves out of bounds
    if (position.y > height) {
      position.y = -radius; // Reappear at the top
      position.x = random(width); // Randomize horizontal position
    }
    if (position.x < 0) {
      position.x = width;
    } else if (position.x > width) {
      position.x = 0;
    }
  }

  void display() {
    fill(255); // Snow is white
    noStroke();
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}

Snowflake[] snowflakes;

void setup() {
  size(800, 600);
  int numSnowflakes = 200; // Number of snowflakes
  snowflakes = new Snowflake[numSnowflakes];

  // Initialize snowflakes at random positions
  for (int i = 0; i < snowflakes.length; i++) {
    snowflakes[i] = new Snowflake(random(width), random(height));
  }
}

void draw() {
  background(20, 20, 50); // Night sky color
  
  // Update and display all snowflakes
  for (Snowflake s : snowflakes) {
    s.update();
    s.display();
  }
}
