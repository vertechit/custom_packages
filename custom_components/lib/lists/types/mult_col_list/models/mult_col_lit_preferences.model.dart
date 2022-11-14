import 'package:flutter/material.dart';

class MultColListPreferences {
  Color backgroundPageColor;
  BoxDecoration clickedDecoration;
  BoxDecoration defaultDecoration;
  MultColListPreferences({
    @required this.clickedDecoration,
    @required this.defaultDecoration,
    this.backgroundPageColor,
  }) {
    if (defaultDecoration == null) defaultDecoration = BoxDecoration();
    if (backgroundPageColor == null) backgroundPageColor = Colors.white;
  }
}
