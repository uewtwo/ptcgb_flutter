enum PokemonSubtype { basic, stage1, stage2, gigamax,}

extension PokemonSubtypeExt on PokemonSubtype {
  String get name {
    switch (this) {
      case PokemonSubtype.basic:
        return 'basic';
      case PokemonSubtype.stage1:
        return 'stage1';
      case PokemonSubtype.stage2:
        return 'stage2';
      case PokemonSubtype.gigamax:
        return 'gigamax';
      default:
        return null;
    }
  }
}
