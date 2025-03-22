int round = 1;
int turn = 1;
float angle;
float centerX, centerY;
float speed = 0.05;
float radius = 100;
float addAngle;

PShape TestBox;
PImage TestBoxTxtr;

float baseSize = 3000;
float maxSize = 4000;

float[] highlightIntensity = {0, 0, 0, 0}; 

void setup() {
  size(1280, 720, P3D);
  TestBox = loadShape("CCube.obj");
  //TestBoxTxtr = loadImage("texture/CCubeTxtr.jpg");
  //TestBox.setTexture(TestBoxTxtr);
  //TestBox.setSpecular(0xfffff7d5);
   centerX = width / 2;
   centerY = height / 2;
}

void draw() { 
  background(100);
  roundDisplay();
  if (addAngle > 0){
    angle += PI*0.5/90;
    addAngle -= 1;
  }
  lights();
  noFill();
  
  pushMatrix();
  translate(width / 2, height / 2, 0);
  box(45);
  popMatrix();
  drawCharacters();
  TestBox.rotateY(.01);
}

void turnChange(){
  addAngle = 90;
}

void roundChange(){
  
}

void drawCharacters() {
  float[][] positions = new float[4][2]; // Store (X, Z) coordinates
  
  // Calculate object positions
  for (int i = 0; i < 4; i++) {
    float objAngle = angle + i * HALF_PI;
    positions[i][0] = centerX + cos(objAngle) * radius; // X coordinate
    positions[i][1] = centerY + sin(objAngle) * radius; // Z coordinate
  }

  // Find the closest object (smallest Z value)
  int closestIndex = 0;
  float minZ = positions[0][1];
  
  for (int i = 1; i < 4; i++) {
    if (positions[i][1] > minZ) { // Smaller Z means closer to the camera //Swapped the '<' for a '>'
      minZ = positions[i][1];
      closestIndex = i;
    }
  }

  // Gradually adjust highlight intensity
  for (int i = 0; i < 4; i++) {
    if (i == closestIndex) {
      highlightIntensity[i] = lerp(highlightIntensity[i], 1, 0.1); // Increase highlight smoothly
    } else {
      highlightIntensity[i] = lerp(highlightIntensity[i], 0, 0.1); // Decrease smoothly
    }
  }

  // Draw objects with smooth effects
  color[] colors = {#ff0000, #00ff00, #0000ff, #ff00ff};
  
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    translate(positions[i][0], centerY, positions[i][1]);

    float scaleFactor = baseSize + (highlightIntensity[i] * (maxSize - baseSize)); // Scale from 30 to 50
    float heightOffset = (scaleFactor - baseSize) / 500000; // Adjust for base scaling

    // Move down before scaling, then back up
    translate(0, heightOffset, 0);
    scale(scaleFactor); // Normalize scaling factor
    translate(0, -heightOffset, 0);

    // Interpolate between normal color and white
    color blendedColor = lerpColor(colors[i], #FFFFFF, highlightIntensity[i]);
    TestBox.setFill(blendedColor);

    shape(TestBox, 0, 0);
    popMatrix();
  }
}
void mouseClicked(){
  if (turn < 4){
    turnChange();
  }else{
    round += 1;
    roundChange();
    turn = 1;
  }
}

void roundDisplay(){
  pushMatrix();
  String roundS = "Round:" + round;
  textSize(64);
  fill(255);
  text(roundS, 20,40);
  popMatrix();
}
