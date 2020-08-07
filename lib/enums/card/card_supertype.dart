enum CardSupertype { POKEMON, TRAINER, ENERGY }

extension CardSupertypeExt on CardSupertype {
  String get name {
    switch (this) {
      case CardSupertype.POKEMON:
        return 'pokemon';
      case CardSupertype.TRAINER:
        return 'trainer';
      case CardSupertype.ENERGY:
        return 'energy';
      default:
        return null;
    }
  }

  String get nameJp {
    switch (this) {
      case CardSupertype.POKEMON:
        return 'ポケモン';
      case CardSupertype.TRAINER:
        return 'トレーナー';
      case CardSupertype.ENERGY:
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
