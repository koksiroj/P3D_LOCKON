enum DialogueType {
  COMPLIMENT, FASHION, PERSONALITY, APPEARANCE, COMMENT, FLIRT, RELATABLE, BOAST, WEALTH, BODY, JOKE, DARK, LIGHT, LISTEN
}

class Dialogue {

  DialogueType Type;

  CharacterAspect[] LikedAspects; //CharacterAspects that like this dialogueType
  CharacterAspect[] DislikedAspects; //CharacterAspects that dislike this dialogueType

  Dialogue(DialogueType pType, CharacterAspect[] pLiked, CharacterAspect[] pDisliked) {
    Type = pType;
    LikedAspects = pLiked;
    DislikedAspects = pDisliked;
  }
}
