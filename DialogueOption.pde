enum DialogueType {
  COMPLIMENT, FASHION, PERSONALITY, APPEARANCE, COMMENT, FLIRT, RELATABLE, BOAST, WEALTH, BODY, JOKE, DARK, LIGHT, LISTEN
};

class Dialogue {

  DialogueType Type;

  int GoodEffect = 2; //How much a Character's Affection increases through this dialogue;
  int NeutralEffect = 1; //How much a Character's Affection increases through this dialogue;
  int BadEffect = -2; //How much a Character's Affection increases through this dialogue;

  CharacterAspect[] Aspects; //All Character Aspects that are not neutral to this dialogue;
  int[] EffectValues;

  //Overload for aspects just using default effect values
  Dialogue(DialogueType pType, CharacterAspect[] pLiked, CharacterAspect[] pDisliked) {

    Type = pType;

    Aspects = new CharacterAspect[pLiked.length + pDisliked.length];
    EffectValues = new int[Aspects.length];

    for (int i = 0; i < pLiked.length; i++) {
      Aspects[i] = pLiked[i];
      EffectValues[i] = GoodEffect;
    }

    for (int i = 0; i < pDisliked.length; i++) {
      Aspects[i+pLiked.length] = pDisliked[i]; //Disliked aspects index is offset by the length of the liked ones
      EffectValues[i+pLiked.length] = BadEffect;
    }
  }

  Dialogue(DialogueType pType, int pGoodEffect, int pNeutralEffect, int pBadEffect, CharacterAspect[] pLiked, CharacterAspect[] pDisliked) {
    
    Type = pType;
    GoodEffect = pGoodEffect;
    NeutralEffect = pNeutralEffect;
    BadEffect = pBadEffect;

    Aspects = new CharacterAspect[pLiked.length + pDisliked.length];
    EffectValues = new int[Aspects.length];

    for (int i = 0; i < pLiked.length; i++) {
      Aspects[i] = pLiked[i];
      EffectValues[i] = GoodEffect;
    }

    for (int i = 0; i < pDisliked.length; i++) {
      Aspects[i+pLiked.length] = pDisliked[i];
      EffectValues[i] = BadEffect;
    }
  }
}
