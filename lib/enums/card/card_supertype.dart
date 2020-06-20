enum CardSupertype {
  POKEMON,
  TRAINER,
  ENERGY
}
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
  String get name_jp {
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
}