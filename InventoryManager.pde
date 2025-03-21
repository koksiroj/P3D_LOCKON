class InventoryManager {

  Dialogue[] DialoguePool; //All Dialogue in the game

  Dialogue[] AvailableDialogue; //dialogue available this round

  int InventorySize = 5; //How many available Dialogues per round

  InventoryManager() {
    DefineAllDialogues();
  }

  void NewRound() {
    SetAvailableDialogue();
  }

  void ReRollDialogue() {
    //TODO: More stuff I presume
    SetAvailableDialogue();
  }

  void DefineAllDialogues() {
    DialoguePool = new Dialogue[5];
    //DialogueType
    //Liked CharacterAspects
    //Disliked CharacterAspects


    DialoguePool[0] = new Dialogue(DialogueType.COMPLIMENT,
      new CharacterAspect[]{CharacterAspect.SHY},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[1] = new Dialogue(DialogueType.FASHION,
      new CharacterAspect[]{CharacterAspect.SHY},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[2] = new Dialogue(DialogueType.PERSONALITY,
      new CharacterAspect[]{CharacterAspect.SHY},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[3] = new Dialogue(DialogueType.APPEARANCE,
      new CharacterAspect[]{CharacterAspect.SHY},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[4] = new Dialogue(DialogueType.COMMENT,
      new CharacterAspect[]{CharacterAspect.SHY},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    //TODO: Add all the dialogue options, add more character types
  }

  void SetAvailableDialogue() {

    for (int i = 0; i < InventorySize; i++) {
      AvailableDialogue[i] = DialoguePool[int(random(DialoguePool.length))];
    }
  }
}
