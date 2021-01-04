import 'package:ptcgb_flutter/models/cards/card_contents.dart';
import 'package:state_notifier/state_notifier.dart';

class TextRepository extends StateNotifier<String> {
  TextRepository(_) : super(_);

  void exportResult(String text) => state = text;
}
