// import 'package:custom_app/custom_app/web_app/web_app.imports.dart';
import 'package:custom_app/no-arch/no-arch.imports.dart';
import 'package:flutter/material.dart';

import '../../components.imports.dart';

///[ MASTER CLASS: ]

abstract class ICustomTextField extends StatelessWidget {
  //

  TextFieldPreferences preferences;

  ///[=================== VARIAVEIS ===================]
  ///
  // HintTextModel hintText;

  // TextStyleModel textStyle;

  // bool autoFocus = false;
  // Icon icon;
  // CustomBorderStyle borderStyle;

  // InputDecoration inputDecoration;

  // Icon leftIcon;

  // double width;

  // TextEditingController textFieldController;

  ///[=================== CONSTRUTOR ===================]

  ICustomTextField({
    @required this.preferences,
  }) {
    // // if (textFieldController == null) throw ("ERRO: textFieldController não pode ser null");

    // if (hintText == null) throw ("ERRO: hint text não pode ser null");

    // if (autoFocus == null) autoFocus = false;
    // if (borderStyle == null) borderStyle = CustomBorderStyle();

    // setInputDecoration;
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  ///[------------------------------ WIDGET BUILD ------------------------------]

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    if (preferences.width == null) preferences.width = w * 100;

    final ThemeData theme = ThemeData();

    return Container(
      width: preferences.width,
      child: Theme(
        // data: Theme.of(context).copyWith(splashColor: Colors.transparent, primaryColor: WebAppConfig.instance.appController.style.colors.primary, accentColor: Colors.red),
        data: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            secondary: Colors.red,
            // primary: WebAppConfig.instance.appController.style.colors.primary,
          ),
        ), //[FLUTTER > 2.0]
        child: TextFormField(
          textCapitalization: preferences.textCapitalization ?? preferences.textCapitalization,
          inputFormatters: preferences.formatters,
          obscureText: preferences.isObscure,
          controller: preferences.textFieldController,
          autofocus: preferences.autoFocus, ////[ <==== AUTO FOCUS ]
          decoration: preferences.inputDecoration,
          style: TextStyle(
            fontSize: preferences.textStyle.textSize,
            color: preferences.textStyle.textColor,
          ),
          validator: (String arg) {
            // if (arg.length < 1)
            //   return preferences.txtValidate;
            // else
            //   return null;

            // print("***************************  arg: " + arg);
            // if (preferences.isRequired == true) {
            //   if (arg.length < 1)
            //     return preferences.txtValidate;
            //   else
            //     return null;
            // } else {
            //   return null;
            // }

            if (preferences?.validation != null) {
              return preferences.validation.call(arg);
              // return preferences.validation.validationFailTxt;
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  ///[-------------------------- SET INPUT DECORATION --------------------------]

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
      border: InputBorder.none,
      icon: haveLeftIcon ? preferences.leftIcon : null,
      //
      hintText: preferences.hintText.hintText,
      labelText: preferences.hintText.hintText,
      hintStyle: TextStyle(
        fontSize: preferences.hintText.hintTextSize,
        color: preferences.hintText.hintTextColor,
      ),

      ///============================ BORDERS ===========================
      ///================================================================
      //
      enabledBorder: haveEnableBorder
          ? UnderlineInputBorder(
              borderSide: BorderSide(
                color: preferences.borderStyle.enableBorderColor,
                width: preferences.borderStyle.borderStroke,
              ),
              borderRadius: BorderRadius.circular(preferences.borderRadius),
            )
          : null,

      //
      focusedBorder: haveFocusBorder
          ? UnderlineInputBorder(
              borderSide: BorderSide(
                color: preferences.borderStyle.focusedBorderColor,
                width: preferences.borderStyle.borderStroke,
              ),
              borderRadius: BorderRadius.circular(preferences.borderRadius),
            )
          : null,

      //
      errorBorder: haveErrorBorder
          ? UnderlineInputBorder(
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
