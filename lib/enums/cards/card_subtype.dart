enum CardSubtypeEnum {
  basic,
  stage1,
  stage2,
  gigamax,
  support,
  goods,
  equipment,
  basEne,
  speEne,
}

extension CardSubtypeExt on CardSubtypeEnum {
  String get name {
    switch (this) {
      case CardSubtypeEnum.basic:
        return 'basic';
      case CardSubtypeEnum.stage1:
        return 'stage1';
      case CardSubtypeEnum.stage2:
        return 'stage2';
      case CardSubtypeEnum.gigamax:
        return 'gigamax';
      case CardSubtypeEnum.support:
        return 'support';
      case CardSubtypeEnum.goods:
        return 'goods';
      case CardSubtypeEnum.equipment:
        return 'equipment';
      case CardSubtypeEnum.basEne:
        return 'baseEne';
      case CardSubtypeEnum.speEne:
        return 'speEne';
      default:
        return null;
    }
  }

  String get namePokemon {
    switch (this) {
      case CardSubtypeEnum.basic:
        return 'basic';
      case CardSubtypeEnum.stage1:
        return 'stage1';
      case CardSubtypeEnum.stage2:
        return 'stage2';
      case CardSubtypeEnum.gigamax:
        return 'gigamax';
      default:
        return null;
    }
  }

  String get nameTrainer {
    switch (this) {
      case CardSubtypeEnum.support:
        return 'support';
      case CardSubtypeEnum.goods:
        return 'goods';
      case CardSubtypeEnum.equipment:
        return 'equipment';
      default:
        return null;
    }
  }

  String get nameEnergy {
    switch (this) {
      case CardSubtypeEnum.basEne:
        return 'basEne';
      case CardSubtypeEnum.speEne:
        return 'speEne';
      default:
        return null;
    }
  }
}
