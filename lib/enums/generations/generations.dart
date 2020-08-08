enum GenerationsEnum { SA, SM, }

extension GenerationsExt on GenerationsEnum {
  String get name {
    switch (this) {
      case GenerationsEnum.SA:
        return 'sa';
      case GenerationsEnum.SM:
        return 'sm';
      default:
        return null;
    }
  }

  String get displayName {
    switch (this) {
      case GenerationsEnum.SA:
        return 'ソード&シールド';
      case GenerationsEnum.SM:
        return 'サン&ムーン';
      default:
        return null;
    }
  }
}
