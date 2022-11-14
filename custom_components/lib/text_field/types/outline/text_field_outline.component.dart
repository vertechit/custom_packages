import 'package:flutter/material.dart';

import '../../../components.imports.dart';

class TextFieldOutline extends ICustomTextField {
//

  @override
  TextFieldPreferences preferences;

  ///[=================== CONSTRUTOR ===================]

  TextFieldOutline({
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
      contentPadding: preferences.hasContentPadding ? preferences.contentPadding : null,
      isDense: preferences.hasContentPadding ? true : false,

      // border: InputBorder.none,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.yellow,
          width: 0.5,
        ),
        // borderRadius: BorderRadius.circular(10.0),
      ),
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
      enabledBorder: haveEnableBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(
                color: preferences.borderStyle.enableBorderColor,
                width: preferences.borderStyle.borderStroke,
              ),
              borderRadius: BorderRadius.circular(preferences.borderRadius),
            )
          : null,

      //
      focusedBorder: haveFocusBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(
                color: preferences.borderStyle.focusedBorderColor,
                width: preferences.borderStyle.borderStroke,
              ),
              borderRadius: BorderRadius.circular(preferences.borderRadius),
            )
          : null,

      //
      errorBorder: haveErrorBorder
          ? OutlineInputBorder(
              borderSide: BorderSide(
                color: preferences.borderStyle.errorBorderColor,
                width: preferences.borderStyle.borderStroke,
              ),
              borderRadius: BorderRadius.circular(preferences.borderRadius),
            )
          : null,
    );
  }
}

//================================================================================================================================================
