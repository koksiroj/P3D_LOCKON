enum CharacterAspect {
  SHY, NAKED
};

class Character {

  CharacterAspect[] Aspects;
  int Trust = 0;
  int Patience = 0;
  int Affection = 0;

//Overload for when all stats just start at 0
  Character(CharacterAspect[] pAspects) {
    Aspects = pAspects;
  }
  
  Character(CharacterAspect[] pAspects, int pTrust, int pPatience, int pAffection) {
    Aspects = pAspects;
    Trust = pTrust;
    Patience = pPatience;
    Affection = pAffection;
  }

  boolean HasAspect(CharacterAspect pAspect) {

    for (int i = 0; i < Aspects.length; i++ ) {
      if (Aspects[i] == pAspect)
        return true;
    }

    return false;
  }
}
