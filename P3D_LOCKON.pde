import processing.sound.*;
SoundFile audpos;
SoundFile audneg;
SoundFile ost;

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
  size(1280, 720, P3D);

  CirceBold = createFont("CirceRounded-Bold.otf", 64);
  textFont(CirceBold);

  centerX = width / 2;
  centerY = height / 2;

  roundManager =  new RoundManager();

  inventory = new InventoryManager();
  inventory.NewRound();

  for (int i = 0; i < 5; i++) {
    buttons[i] = new Button(width/2 - 220*2.5 + i * 240, height*0.78, 220, 50);
  };

  
  audpos = new SoundFile(this, "sfx/accepted_sfx.wav");
  audneg = new SoundFile(this, "sfx/rejected_sfx.wav");
  ost = new SoundFile(this, "sfx/gamejamxp_2025_revert_Vmix.mp3");
  ost.amp(0.5);
  ost.loop();
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

  if (roundManager.AddAngle <= 0) {
    boolean clickedButton = false;
    boolean disabled = false;

    for (int i = 0; i < 5; i++) {
      if (buttons[i].isClicked(mouseX, mouseY)) {
        if (!buttons[i].CanInteract) { 
          disabled = true;
          //println("this button is disabled");
        } else {
          clickedButton = true;
          //println("Selected Dialogue: " + inventory.getDialogueType(i));
          roundManager.PickDialogue(inventory.AvailableDialogue[i]);
          if (roundManager.TurnCount != 1) {//Hardcoded turncount check
            buttons[i].CanInteract = false;
          }
        }
      }
    }
    if (!clickedButton && !disabled) {
      roundManager.ProgressTurn();
    }
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
    String labelRaw = inventory.getDialogueType(i);
    String labelProc = labelRaw.replace("_", " ");
    buttons[i].display(labelProc);
  }
}

void ResetButtonDisplay() {
  for (int i = 0; i < 5; i++) {
    buttons[i].CanInteract = true;
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
  popMatrix();
}

void audioPlay(boolean pog){
  if (pog){audpos.play();}else{audneg.play();}
}
