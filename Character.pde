enum CharacterAspect {
  NULL, SHY, NAKED, POSH, FIT
};

class Character {

  PShape CharacterModel;

  CharacterAspect[] Aspects;

  int Trust = 0;
  int Patience = 0;
  int Affection = 0;

  private int _baseTrust = 0;
  private int _basePatience = 0;
  private int _baseAffection = 0;

  //Overload for when all stats just start at 0
  Character(String pModelName, CharacterAspect[] pAspects) {
    CharacterModel = loadShape(pModelName);
    CharacterModel.rotateZ(PI);
    Aspects = pAspects;
    for(int i = 0; i< Aspects.length; i++){      
    //println("Char["+pModelName+"] has Aspect: "+Aspects[i]);
    }
  }

  Character(String pModelName, CharacterAspect[] pAspects, int pTrust, int pPatience, int pAffection) {
    CharacterModel = loadShape(pModelName);
    CharacterModel.rotateZ(PI);

    Aspects = pAspects;

    _baseTrust = pTrust;
    _basePatience = pPatience;
    _baseAffection = pAffection;

    Reset();
  }

  boolean HasAspect(CharacterAspect pAspect) {

    for (int i = 0; i < Aspects.length; i++ ) {
      if (Aspects[i] == pAspect)
      {
        return true;
      }
    }

    return false;
  }

  void Reset() {
    Trust = _baseTrust;
    Patience = _basePatience;
    Affection = _baseAffection;
  }
}
