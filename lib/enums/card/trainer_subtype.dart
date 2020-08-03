enum TrainerSubtype { support, goods, equipment, }

extension TrainerSubtypeExt on TrainerSubtype {
  String get name {
    switch (this) {
      case TrainerSubtype.support:
        return 'support';
      case TrainerSubtype.goods:
        return 'goods';
      case TrainerSubtype.equipment:
        return 'equipment';
      default:
        return null;
    }
  }
}
