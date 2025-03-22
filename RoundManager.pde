class RoundManager {

  Character[] CharacterPool; //All characters in the game

  Character[] ActiveCharacters;

  int RoundCount = 1;
  int CurrentCharacter = 0;
  int ActiveCharacterCount = 4;

  RoundManager() {

    SetAllCharacters();
    NewGame();
  }

  void NewGame() {
    RoundCount = 1;
    CurrentCharacter = 0;

    for (int i = 0; i < CharacterPool.length; i++) {
      CharacterPool[i].Reset();
    }

    SetActiveCharacters();
  }


  void PickDialogue(Dialogue pDialogue) {

    boolean affected = false;

    for (int i = 0; i < pDialogue.Aspects.length; i++) {
      if (ActiveCharacters[CurrentCharacter].HasAspect(pDialogue.Aspects[i])) {
      }
      ActiveCharacters[CurrentCharacter].Affection += pDialogue.EffectValues[i];
      affected =true;
    }

    if (!affected)
      ActiveCharacters[CurrentCharacter].Affection += pDialogue.NeutralEffect;

    ProgressCharacter();
  }

  Character GetCurrentCharacter() {
    return  ActiveCharacters[CurrentCharacter];
  }

  void ProgressCharacter() {

    if (CurrentCharacter >= ActiveCharacters.length)
      NextRound();
    else
      CurrentCharacter++;
  }

  void NextRound() {
    RoundCount++;
    CurrentCharacter = 0;
     println("Round:" + RoundCount);
    //TODO: ProgressRound
  }

  void SetAllCharacters() {

    CharacterPool = new Character[2];

    CharacterPool[0] = new Character("MermanLowP.obj", new CharacterAspect[] {CharacterAspect.SHY});
    CharacterPool[1] = new Character("ShrromGirl.obj", new CharacterAspect[] {CharacterAspect.NAKED});
  }

  void SetActiveCharacters() {
    ActiveCharacters = new Character[ActiveCharacterCount];

    for (int i = 0; i < ActiveCharacterCount; i++) {
      ActiveCharacters[i] = CharacterPool[int(random(CharacterPool.length))];
    }
  }

  void DrawCharacters() {
    hint(ENABLE_DEPTH_TEST);
    float[][] positions = new float[4][2]; // Store (X, Z) coordinates

    // Calculate object positions
    for (int i = 0; i < ActiveCharacterCount; i++) {
      float objAngle = angle + i * HALF_PI;
      positions[i][0] = centerX + cos(objAngle) * radius; // X coordinate
      positions[i][1] = centerY + sin(objAngle) * radius; // Z coordinate
    }

    // Find the closest object (smallest Z value)
    int closestIndex = 0;
    float minZ = positions[0][1];

    for (int i = 1; i < ActiveCharacterCount; i++) {
      if (positions[i][1] > minZ) { // Smaller Z means closer to the camera //Swapped the '<' for a '>'
        minZ = positions[i][1];
        closestIndex = i;
      }
    }

    // Gradually adjust highlight intensity
    for (int i = 0; i < ActiveCharacterCount; i++) {
      if (i == closestIndex) {
        highlightIntensity[i] = lerp(highlightIntensity[i], 1, 0.1); // Increase highlight smoothly
      } else {
        highlightIntensity[i] = lerp(highlightIntensity[i], 0, 0.1); // Decrease smoothly
      }
    }

    // Draw objects with smooth effects
    color[] colors = {#ff0000, #00ff00, #0000ff, #ff00ff};

    for (int i = 0; i < ActiveCharacterCount; i++) {
      pushMatrix();
      translate(positions[i][0], centerY + 50, positions[i][1]);

      float scaleFactor = baseSize + (highlightIntensity[i] * (maxSize - baseSize)); // Scale from 30 to 50
      float heightOffset = (scaleFactor - baseSize) / 2; // Adjust for base scaling

      // Move down before scaling, then back up
      translate(0, heightOffset, 0);
      scale(scaleFactor); // Normalize scaling factor
      translate(0, -heightOffset, 0);

      // Interpolate between normal color and white
      color blendedColor = lerpColor(colors[i], #FFFFFF, highlightIntensity[i]);
      ActiveCharacters[i].CharacterModel.setFill(blendedColor);

      shape(ActiveCharacters[i].CharacterModel, 0, 0);
      popMatrix();
      ActiveCharacters[i].CharacterModel.rotateY(.01);
    }
    hint(DISABLE_DEPTH_TEST);
  }
}
