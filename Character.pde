enum CharacterAspect {
  SHY, NAKED
};

class Character {

  CharacterAspect[] Aspects;
  int Trust = 0;
  int Patience = 0;

  Character(CharacterAspect[] pAspects, int pTrust, int pPatience) {
    Aspects = pAspects;
    Trust = pTrust;
    Patience = pPatience;
  }

  boolean HasAspect(CharacterAspect pAspect) {

    for (int i = 0; i < Aspects.length; i++ ) {
      if (Aspects[i] == pAspect)
        return true;
    }

    return false;
  }
}
