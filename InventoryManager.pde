class InventoryManager {

  Dialogue[] DialoguePool; //All Dialogue in the game

  Dialogue[] AvailableDialogue; //dialogue available this round

  int InventorySize = 5; //How many available Dialogues per round

  InventoryManager() {
    DialoguePool = new Dialogue[5];
    AvailableDialogue = new Dialogue[InventorySize];
    DefineAllDialogues();
  }

  void NewRound() {
    SetAvailableDialogue();
  }

  void ReRollDialogue() {
    //TODO: More stuff I presume
    SetAvailableDialogue();
  }



  void SetAvailableDialogue() {
    for (int i = 0; i < InventorySize; i++) {
      int randomIndex = int(random(DialoguePool.length));
      if (DialoguePool[randomIndex] != null) {
        AvailableDialogue[i] = DialoguePool[randomIndex];
      } else {
        AvailableDialogue[i] = new Dialogue(DialogueType.COMMENT, new CharacterAspect[]{}, new CharacterAspect[]{}); // ✅ Fallback dialogue
      }
    }
  }

  String getDialogueType(int index) {
    if (AvailableDialogue != null && index >= 0 && index < AvailableDialogue.length) {
      if (AvailableDialogue[index] != null) {
        return AvailableDialogue[index].Type.name();
      }
    }
    return "Unknown";
  }
  
  void DefineAllDialogues() {
    DialoguePool = new Dialogue[5];
    //DialogueType
    //Liked CharacterAspects
    //Disliked CharacterAspects


    DialoguePool[0] = new Dialogue(DialogueType.BOAST-WEALTH,
      new CharacterAspect[]{CharacterAspect.POSH},
      new CharacterAspect[]{CharacterAspect.NULL}
      );

    DialoguePool[1] = new Dialogue(DialogueType.BOAST-APPEARANCE,
      new CharacterAspect[]{CharacterAspect.FIT, CharacterAspect.FASHIONABLE},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[2] = new Dialogue(DialogueType.COMPLIMENT-FASHION,
      new CharacterAspect[]{CharacterAspect.FASHIONABLE},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[3] = new Dialogue(DialogueType.COMPLIMENT-PERSONALITY,
      new CharacterAspect[]{CharacterAspect.SHY},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[4] = new Dialogue(DialogueType.COMMENT,
      new CharacterAspect[]{CharacterAspect.SHY},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    //TODO: Add all the dialogue options, add more character types
  }
}
