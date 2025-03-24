enum DialogueType {
  BOAST_WEALTH, BOAST_APPEARANCE, COMPLIMENT_FASHION, COMPLIMENT_APPEARANCE, COMPLIMENT_PERSONALITY, JOKE_DARK, JOKE_LIGHT, COMMENT_RELATABLE, COMMENT_FLIRT, LISTEN
};

class Dialogue {

  DialogueType Type;

  int GoodEffect = 2; //How much a Character's Affection increases through this dialogue;
  int NeutralEffect = 1; //How much a Character's Affection increases through this dialogue;
  int BadEffect = -2; //How much a Character's Affection increases through this dialogue;

  CharacterAspect[] Aspects; //All Character Aspects that are not neutral to this dialogue;
  int[] EffectValues;

  Boolean IsBallsy = false;

  //Overloads for aspects just using default effect values
  Dialogue(DialogueType pType, CharacterAspect[] pLiked, CharacterAspect[] pDisliked) {
    Init(pType, false, GoodEffect, NeutralEffect, BadEffect, pLiked, pDisliked);
  }

  Dialogue(DialogueType pType, Boolean pIsBallsy, CharacterAspect[] pLiked, CharacterAspect[] pDisliked) {
    Init(pType, pIsBallsy, GoodEffect, NeutralEffect, BadEffect, pLiked, pDisliked);
  }

  Dialogue(DialogueType pType, Boolean pIsBallsy, int pGoodEffect, int pNeutralEffect, int pBadEffect, CharacterAspect[] pLiked, CharacterAspect[] pDisliked) {
    Init(pType, pIsBallsy, pGoodEffect, pNeutralEffect, pBadEffect, pLiked, pDisliked);
  }

  void Init(DialogueType pType, Boolean pIsBallsy, int pGoodEffect, int pNeutralEffect, int pBadEffect, CharacterAspect[] pLiked, CharacterAspect[] pDisliked) {
    Type = pType;
    IsBallsy = pIsBallsy;

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
      Aspects[i+pLiked.length] = pDisliked[i]; //Disliked aspects index is offset by the length of the liked ones
      EffectValues[i] = BadEffect;
    }
  }
}
