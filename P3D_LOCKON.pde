float centerX, centerY;
float radius = 100;

PShape TestBox;
PImage TestBoxTxtr;
PFont CirceBold;

float baseSize = 0.7;
float maxSize = 0.9;

float[] highlightIntensity = {0, 0, 0, 0};

RoundManager roundManager;
InventoryManager inventory;
Button[] buttons = new Button[5];

void setup() {
  size(800, 800, P3D);

  CirceBold = createFont("CirceRounded-Bold.otf", 64);
  textFont(CirceBold);

  centerX = width / 2;
  centerY = height / 2;

  roundManager =  new RoundManager();

  inventory = new InventoryManager();
  inventory.NewRound();
}

void draw() {
  background(0xFFB0D8);
  roundDisplay();

  lights();

  roundManager.DrawCharacters();

  inventoryDisplay();
  statsDisplay();

  if (roundManager.Zoom) {
    pushMatrix();
    int oX = 100;
    String roundT = "Round " + roundManager.RoundCount + "!";
    fill(#FC1F88);
    stroke(#E21380);
    strokeWeight(4);
    rect(width/2 - oX, height/2, 0, 8);

    textSize(64);
    noStroke();
    fill(255);
    textAlign(CENTER, CENTER);
    text(roundT, width/2, height/2 + 10);
    popMatrix();
  }
}

void mousePressed() {
  boolean clickedButton = false;
  for (int i = 0; i < 5; i++) {
    if (buttons[i].isClicked(mouseX, mouseY)) {
      clickedButton = true;
      //println("Selected Dialogue: " + inventory.getDialogueType(i));
      roundManager.PickDialogue(inventory.AvailableDialogue[i]);
    }
  }
  if (!clickedButton && roundManager.AddAngle <= 0) {
    roundManager.ProgressTurn();
  }
}

void roundDisplay() {
  pushMatrix();
  String roundS = "Round: " + roundManager.RoundCount;
  textSize(50);
  fill(255);
  text(roundS, 100, 40);
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
  int currentAffection = roundManager.GetCurrentCharacter().Affection;
  translate(width/2 - 100*(affectionC + trustC)/2, height*0.865);

  for (int i = 0; i < affectionC + trustC; i++) {
    smooth();
    noStroke();

    if (i < trustC) {
      fill(#C681B7);
    } else {
      fill(#EDA6D0);
      //d
    }
    if (i < currentAffection) {
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
