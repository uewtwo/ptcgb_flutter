enum CardSupertypeEnum { POKEMON, TRAINER, ENERGY }

extension CardSupertypeExt on CardSupertypeEnum {
  String get name {
    switch (this) {
      case CardSupertypeEnum.POKEMON:
        return 'pokemon';
      case CardSupertypeEnum.TRAINER:
        return 'trainer';
      case CardSupertypeEnum.ENERGY:
        return 'energy';
      default:
        return null;
    }
  }

  String get nameJp {
    switch (this) {
      case CardSupertypeEnum.POKEMON:
        return 'ポケモン';
      case CardSupertypeEnum.TRAINER:
        return 'トレーナー';
      case CardSupertypeEnum.ENERGY:
        return 'エネルギー';
      default:
        return null;
    }
  }

  // enum の index でとりあえずソートするから不要?
//  int get sortVal {
//    switch (this) {
//      case CardSupertype.POKEMON:
//        return 0;
//      case CardSupertype.TRAINER:
//        return 10;
//      case CardSupertype.ENERGY:
//        return 20;
//      default:
//        return null;
//    }
//  }
}
