enum TrainerSubtype { trainer, goods, equipment, }

extension TrainerSubtypeExt on TrainerSubtype {
  String get name {
    switch (this) {
      case TrainerSubtype.trainer:
        return 'trainer';
      case TrainerSubtype.goods:
        return 'goods';
      case TrainerSubtype.equipment:
        return 'equipment';
      default:
        return null;
    }
  }
}
