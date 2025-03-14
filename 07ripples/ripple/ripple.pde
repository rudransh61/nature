float damping = 0.98; // Adjust damping for persistent ripples
int w = 400, h = 400;
float[][] prev = new float[w][h];
float[][] curr = new float[w][h];
float[][] temp;
int pixelSize = 3; // Set pixel size to make pixels bigger

void setup() {
  size(400, 400);
  pixelDensity(1);
  noStroke(); // Remove grid lines for smoother appearance
}

void draw() {
  background(0); // Clear screen to prevent artifacts

  // Oscillating light sources
  if (frameCount % 10 == 0) { // Adjust the frequency of waves
    prev[50][25] = sin(frameCount * 0.1) * 1; 
    prev[50][75] = sin(frameCount * 0.1) * 1;
  }

  // Wave propagation
  for (int i = 1; i < w - 1; i++) {
    for (int j = 1; j < h - 1; j++) {
      curr[i][j] = (prev[i-1][j] + prev[i+1][j] + prev[i][j-1] + prev[i][j+1]) / 2 - curr[i][j];
      curr[i][j] *= damping;

      float value = constrain(curr[i][j], -1, 1);
      float brightness = (value+1 ) * 255/2; // Normalize to [0, 255]

      fill(brightness);
      rect(i * pixelSize, j * pixelSize, pixelSize, pixelSize); // Draw larger pixels
    }
  }

  // Swap buffers
  temp = prev;
  prev = curr;
  curr = temp;
}

// Allow manual wave generation with mouse
void mousePressed() {
  prev[mouseX / pixelSize][mouseY / pixelSize] = 1;
}
