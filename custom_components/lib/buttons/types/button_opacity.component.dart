import 'package:flutter/material.dart';

import '../buttons.imports.dart';

class ButtonOpacity{
  //
  @override
  ButtonsPreferences preferences;

  ButtonOpacity({
    required this.preferences,
  }) {
    if (preferences.borderRadius == null) preferences.borderRadius = 30;
    if (preferences.width == null) preferences.width = 200;
    if (preferences.height == null) preferences.height = 60;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return Container(
      width: preferences.width,
      height: preferences.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: preferences.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(preferences.borderRadius!),
          ),
        ),
        child: Text(
          preferences!.text!,
          style: TextStyle(
            color: preferences!.textPreferences!.textColor,
            fontSize: preferences!.textPreferences!.size,
          ),
        ),
        onPressed: () {
          preferences.onClick;
        },
      ),
    );
  }
}
