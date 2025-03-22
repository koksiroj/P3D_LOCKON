// GAMERS
import processing.sound.*;

PShape modelLaika;
SoundFile sfxTestSound1;

void setup() {
  size(400, 400, P3D);

  modelLaika = loadShape("models/laika/laika.obj");
  sfxTestSound1 = new SoundFile(this, "sfx/test_sound1.wav");
}

void setupCamera() {
  float fovy = radians(90);
  float aspect = float(width)/float(height);
  float zNear = 1;
  float zFar = 100;
  perspective(fovy, aspect, zNear, zFar);
  translate(width/2, height/2, 340);
  scale(1, -1, 1); //set Y up properly
}

void draw() {
  background(204);

  lights();
  setupCamera();

  rotateY(radians(millis()/2));
  shape(modelLaika, 0, 0);
}

void mousePressed() {
  sfxTestSound1.play();
}
