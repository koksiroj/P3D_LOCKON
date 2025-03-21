class RoundManager {

  Character[] CharacterPool; //All characters in the game

  Character[] ActiveCharacters;

  int RoundCount = 0;
  int CurrentCharacter = 0;

  RoundManager() {
  }

  void PickDialogue(Dialogue pDialogue)  {
    
    boolean affected = false;
    
    for (int i = 0; i < pDialogue.Aspects.length; i++){      
    if(ActiveCharacters[CurrentCharacter].HasAspect(pDialogue.Aspects[i])){
    }
      ActiveCharacters[CurrentCharacter].Affection += pDialogue.EffectValues[i];
      affected =true;
    }
    
    if(!affected)
    ActiveCharacters[CurrentCharacter].Affection += pDialogue.NeutralEffect;    
    
  }

  void ProgressCharacter() {

    if (ActiveCharacters.length >= CurrentCharacter)
      NextRound();
    else
      CurrentCharacter++;
  }

  void NextRound() {
    RoundCount++;
    //TODO: ProgressRound
  }
}
