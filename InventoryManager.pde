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
        AvailableDialogue[i] = new Dialogue(DialogueType.LISTEN, new CharacterAspect[]{}, new CharacterAspect[]{});
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
    DialoguePool = new Dialogue[10];
    //DialogueType
    //Liked CharacterAspects
    //Disliked CharacterAspects


    DialoguePool[0] = new Dialogue(DialogueType.BOAST_WEALTH,
      new CharacterAspect[]{CharacterAspect.POSH},
      new CharacterAspect[]{CharacterAspect.NULL}
      );

    DialoguePool[1] = new Dialogue(DialogueType.BOAST_APPEARANCE,
      new CharacterAspect[]{CharacterAspect.FIT, CharacterAspect.FASHIONABLE},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[2] = new Dialogue(DialogueType.COMPLIMENT_FASHION,
      new CharacterAspect[]{CharacterAspect.FASHIONABLE},
      new CharacterAspect[]{CharacterAspect.NAKED}
      );

    DialoguePool[3] = new Dialogue(DialogueType.COMPLIMENT_PERSONALITY,
      new CharacterAspect[]{CharacterAspect.NULL},
      new CharacterAspect[]{CharacterAspect.SHY}
      );

    DialoguePool[4] = new Dialogue(DialogueType.COMPLIMENT_APPEARANCE,
      new CharacterAspect[]{CharacterAspect.FIT, CharacterAspect.FASHIONABLE},
      new CharacterAspect[]{CharacterAspect.SHY}
      );
      
    DialoguePool[5] = new Dialogue(DialogueType.JOKE_DARK, true,
      new CharacterAspect[]{CharacterAspect.FIT, CharacterAspect.SHY},
      new CharacterAspect[]{CharacterAspect.NULL}
      );
      
    DialoguePool[6] = new Dialogue(DialogueType.JOKE_LIGHT,
      new CharacterAspect[]{CharacterAspect.NULL},
      new CharacterAspect[]{CharacterAspect.NULL}
      );  
      
    DialoguePool[7] = new Dialogue(DialogueType.LISTEN,
      new CharacterAspect[]{CharacterAspect.NULL},
      new CharacterAspect[]{CharacterAspect.NULL}
      ); 
      
    DialoguePool[8] = new Dialogue(DialogueType.COMMENT_FLIRT, true,
      new CharacterAspect[]{CharacterAspect.FASHIONABLE, CharacterAspect.FIT},
      new CharacterAspect[]{CharacterAspect.NULL}
      );  
    
    DialoguePool[9] = new Dialogue(DialogueType.COMMENT_RELATABLE,
      new CharacterAspect[]{CharacterAspect.NULL},
      new CharacterAspect[]{CharacterAspect.NULL}
      );  

    //TODO: Add all the dialogue options, add more character types
  }
}
