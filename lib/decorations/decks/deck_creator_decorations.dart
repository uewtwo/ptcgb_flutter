import 'package:flutter/material.dart';

class DeckCreatorDecorations {
  InputDecoration enterDeckNameDecoration() {
    return InputDecoration(
      labelText: 'Enter Deck Name',
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        // when the TextField in unfocused
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
        // when the TextField in focused
      ),
      border: UnderlineInputBorder(),
    );
  }
}
