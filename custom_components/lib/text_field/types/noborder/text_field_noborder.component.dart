import 'package:flutter/material.dart';

import '../../../components.imports.dart';

class TextFieldNoborder extends ICustomTextField {
//

  @override
  TextFieldPreferences preferences;

  ///[=================== CONSTRUTOR ===================]

  TextFieldNoborder({
    @required this.preferences,
  }) {
    setInputDecoration;
  }

  ///[-------------------------- SET INPUT DECORATION --------------------------]

  @override
  get setInputDecoration {
    ///============================ BOOLEANS ==========================
    ///================================================================
    ///
    bool haveFocusBorder = false;
    if (preferences.borderStyle.focusedBorderColor != null) haveFocusBorder = true;

    bool haveEnableBorder = false;
    if (preferences.borderStyle.enableBorderColor != null) haveEnableBorder = true;

    bool haveErrorBorder = false;
    if (preferences.borderStyle.errorBorderColor != null) haveErrorBorder = true;

    bool haveLeftIcon = false;
    if (preferences.leftIcon != null) haveLeftIcon = true;

    preferences.inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.11),
      hoverColor: Colors.green,
      focusColor: Colors.blue,
      border: InputBorder.none,
      icon: haveLeftIcon ? preferences.leftIcon : null,
      //
      hintText: preferences.hintText.hintText,
      hintStyle: TextStyle(
        fontSize: preferences.hintText.hintTextSize,
        color: preferences.hintText.hintTextColor,
      ),

      ///============================ BORDERS ===========================
      ///================================================================
      //
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(preferences.borderRadius)),
      //
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(preferences.borderRadius)),
      //
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(preferences.borderRadius)),
    );
  }
}

//================================================================================================================================================
