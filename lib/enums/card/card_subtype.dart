enum CardSubtype {
  basic, stage1, stage2, gigamax,
  support, goods, equipment,
  basEne, speEne,
}

extension CardSubtypeExt on CardSubtype {
  String get name {
    switch (this) {
      case CardSubtype.basic:
        return 'basic';
      case CardSubtype.stage1:
        return 'stage1';
      case CardSubtype.stage2:
        return 'stage2';
      case CardSubtype.gigamax:
        return 'gigamax';
      case CardSubtype.support:
        return 'support';
      case CardSubtype.goods:
        return 'goods';
      case CardSubtype.equipment:
        return 'equipment';
      case CardSubtype.basEne:
        return 'baseEnery';
      case CardSubtype.speEne:
        return 'specialEnergy';
      default:
        return null;
    }
  }

  String get namePokemon {
    switch (this) {
      case CardSubtype.basic:
        return 'basic';
      case CardSubtype.stage1:
        return 'stage1';
      case CardSubtype.stage2:
        return 'stage2';
      case CardSubtype.gigamax:
        return 'gigamax';
      default:
        return null;
    }
  }

  String get nameTrainer {
    switch (this) {
      case CardSubtype.support:
        return 'support';
      case CardSubtype.goods:
        return 'goods';
      case CardSubtype.equipment:
        return 'equipment';
      default:
        return null;
    }
  }

  String get nameEnergy {
    switch (this) {
      case CardSubtype.basEne:
        return 'baseEnery';
      case CardSubtype.speEne:
        return 'specialEnergy';
      default:
        return null;
    }
  }
}
