class RoundManager {

  Character[] CharacterPool; //All characters in the game

  Character[] ActiveCharacters;

  int RoundCount = 0;
  int CurrentCharacter = 0;
  int ActiveCharacterCount = 4;

  RoundManager() {

    SetAllCharacters();
    NewGame();
  }

  void NewGame() {
    RoundCount = 0;
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

  void ProgressCharacter() {

    if (CurrentCharacter >= ActiveCharacters.length)
      NextRound();
    else
      CurrentCharacter++;
  }

  void NextRound() {
    RoundCount++;
    //TODO: ProgressRound
  }

  void SetAllCharacters() {

    CharacterPool = new Character[2];

    CharacterPool[0] = new Character(new CharacterAspect[] {CharacterAspect.SHY});
    CharacterPool[1] = new Character(new CharacterAspect[] {CharacterAspect.NAKED});
  }

  void SetActiveCharacters() {
    for (int i = 0; i < ActiveCharacterCount; i++) {
      ActiveCharacters[i] = CharacterPool[int(random(CharacterPool.length))];
    }
  }
}
