int round = 1;
int turn = 1;
float angle;
float centerX, centerY;
float speed = 0.05;
float radius = 100;
float addAngle;

PShape TestBox;
PImage TestBoxTxtr;
PFont CirceBold;

float baseSize = 0.7;
float maxSize = 0.9;

float[] highlightIntensity = {0, 0, 0, 0};

InventoryManager inventory;
Button[] buttons = new Button[5];

void setup() {
  size(1280, 720, P3D);
  TestBox = loadShape("MermanLowP.obj");
  TestBox.rotateZ(PI);

  CirceBold = createFont("CirceRounded-Bold.otf", 64);
  textFont(CirceBold);

  centerX = width / 2;
  centerY = height / 2;

  inventory = new InventoryManager();
  inventory.NewRound();
}

void draw() {
  background(0xFFB0D8);
  roundDisplay();
  if (addAngle > 0) {
    angle += PI*0.5/90;
    addAngle -= 1;
  }

  lights();

  drawCharacters();
  TestBox.rotateY(.01);

  inventoryDisplay();
  statsDisplay();
}

void turnChange() {
  addAngle = 90;
}

void roundChange() {
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
    translate(positions[i][0], centerY + 100, positions[i][1]);

    float scaleFactor = baseSize + (highlightIntensity[i] * (maxSize - baseSize)); // Scale from 30 to 50
    float heightOffset = (scaleFactor - baseSize) / 2; // Adjust for base scaling

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

void mouseClicked() {
  if (turn < 4) {
    turnChange();
  } else {
    round += 1;
    roundChange();
    turn = 1;
  }
}

void mousePressed() {
  for (int i = 0; i < 5; i++) {
    if (buttons[i].isClicked(mouseX, mouseY)) {
      println("Selected Dialogue: " + inventory.getDialogueType(i));
    }
  }
}

void roundDisplay() {
  pushMatrix();
  String roundS = "Round:" + round;
  textSize(64);
  fill(255);
  text(roundS, 20, 40);
  popMatrix();
}

void inventoryDisplay() {
  for (int i = 0; i < 5; i++) {
    buttons[i] = new Button(width/2 - 160*2.5 + i * 160, height*0.78, 150, 50);
  }
  for (int i = 0; i < 5; i++) {
    buttons[i].display(inventory.getDialogueType(i));
  }
}

void statsDisplay() {
  //Affection bar
  pushMatrix();
  int affectionC = 5;
  int trustC = 3;
  int currentAffection = 2;
  translate(width/2 - 100*(affectionC + trustC)/2, height*0.865);
  
  for (int i = 0; i < affectionC + trustC; i++) {
    smooth();
    noStroke();
    
    if(i < trustC){
      fill(#C681B7);
    }else{
      fill(#EDA6D0);
    }
    if(i < currentAffection){
      fill(#FC1F88);
    }
    pushMatrix();
    translate(i * 100, 0);
    beginShape();
    vertex(50, 15);
    bezierVertex(64, -15, 120, 25, 50, 60);
    vertex(50, 15);
    bezierVertex(36, -15, -20, 25, 50, 60);
    endShape();
    popMatrix();
  }

  /*fill(#93527F);
   rect(0,0,
   fill(#F5EBFF);
   rect(0, 0, 600, 60, 30);
   noFill();
   stroke(#9680C1);
   strokeWeight(12);
   rect(0, 0, 600, 60, 30);
   stroke(#A791C9);
   strokeWeight(8);
   rect(0, 0, 600, 60, 30);*/
  popMatrix();
}
