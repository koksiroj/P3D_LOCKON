enum CharacterAspect {
  SHY, NAKED
};

class Character {

  CharacterAspect[] Aspects;

  int Trust = 0;
  int Patience = 0;
  int Affection = 0;

  private int _baseTrust = 0;
  private int _basePatience = 0;
  private int _baseAffection = 0;

  //Overload for when all stats just start at 0
  Character(CharacterAspect[] pAspects) {
    Aspects = pAspects;
  }

  Character(CharacterAspect[] pAspects, int pTrust, int pPatience, int pAffection) {
    Aspects = pAspects;

    _baseTrust = pTrust;
    _basePatience = pPatience;
    _baseAffection = pAffection;
    
    Reset();
  }

  boolean HasAspect(CharacterAspect pAspect) {

    for (int i = 0; i < Aspects.length; i++ ) {
      if (Aspects[i] == pAspect)
        return true;
    }

    return false;
  }

  void Reset() {    
    Trust = _baseTrust;
    Patience = _basePatience;
    Affection = _baseAffection;
  }
}
