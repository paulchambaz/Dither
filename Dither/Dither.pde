Matrix matrix;
PImage img;

void setup () {
  size(512, 512);
  
  //matrix = Simple();
  matrix = Bayer(2);
  
  //matrix.Print();
  //matrix.PrintFormat();

  img = Grey(loadImage("img.png"));
}

void draw () {
  Update();
}

void Update () {
  loadPixels();
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      PVector screen = new PVector(i, j);      
      //int value = Dithering(128, screen, new PVector(6, 3), 1);

      //int value = Gradient(screen);
      //value = Vignette(value, screen, .6, 1);
      //value = Dithering(value, screen, new PVector(1, 1), 2);

      int value = Image(screen, img);
      //value = Dithering(value, screen, new PVector(1, 1), 2);
      //value = Threshold(value, 128);
      value = Lerp(Dithering(value, screen, new PVector(1, 1), 2), Threshold(value, 128), mouseX / (float) width);

      pixels[i + j * width] = color(value);
    }
  }
  updatePixels();
}

int Lerp (int a, int b, float t) {
  int out = 0;
  out = (int) lerp(a, b, t);
  return out;
}

int Threshold (int value, int threshold) {
  int out = 0;
  out = (value > threshold) ? 255 : 0;
  return out;
}

int Vignette (int value, PVector screen, float threshold, float smooth) {
  int out = 0;
  float dist = dist(screen.x / width, screen.y / height, .5, .5);
  dist = map(dist, 0, sqrt(2)/2, 0, 1);
  out = (dist - threshold < 0) ? value : (int) lerp(value, 0, map(dist - threshold, 0, 1 - threshold, 0, 1));
  return out;
}

int Gradient (PVector screen) {
  int out = 0;
  out = (int) screen.x * 255 /  width;
  return out;
}

int Dithering (int value, PVector screen, PVector ditherSize, int ditherMatrix) {
  int out = 0;

  int x = (int) (screen.x / ditherSize.x);
  int y = (int) (screen.y / ditherSize.y);

  x %= pow(2, ditherMatrix);
  y %= pow(2, ditherMatrix);

  out = (value > 256 * matrix.value[x][y] / pow(4, ditherMatrix)) ? 255 : 0;

  return out;
}

int Image (PVector screen, PImage image) {
  int out = 0;
  image.loadPixels();
  out = image.pixels[(int) (screen.x + screen.y * width)];
  return out;
}

Matrix Simple () {
  int[][] simple = {{0, 2}, {2, 0}};
  return new Matrix(simple);
}

Matrix Bayer (int n) {
  Matrix bayer = new Matrix(1);
  for (int i=0; i<n; i++) {
    bayer = new Matrix(bayer.Mult(4), bayer.Mult(4).Add(2), bayer.Mult(4).Add(3), bayer.Mult(4).Add(1));
  }
  return bayer;
}

PImage Grey (PImage image) {
  PImage grey = new PImage(image.width, image.height);
  grey.loadPixels();
  image.loadPixels();
  for (int i=0; i<grey.pixels.length; i++) {
    grey.pixels[i] = Brightness(image.pixels[i]);
  }
  grey.updatePixels();
  return grey;
}

color Brightness (color c) {
  return (int) (red(c) + green(c) + blue(c)) / 3;
}
