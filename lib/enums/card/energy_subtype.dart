enum EnergySubtype { basEne, speEne, }

extension EnergySubtypeExt on EnergySubtype {
  String get name {
    switch (this) {
      case EnergySubtype.basEne:
        return 'baseEnery';
      case EnergySubtype.speEne:
        return 'specialEnergy';
      default:
        return null;
    }
  }
}
