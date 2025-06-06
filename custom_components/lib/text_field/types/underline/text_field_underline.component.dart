import 'package:flutter/material.dart';

import '../../../components.imports.dart';

///

class TextFieldUnderline {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  HintTextModel hintText;
  TextStyleModel? textStyle;
  bool autoFocus;
  Icon? icon;
  CustomBorderStyle? borderStyle;
  late InputDecoration inputDecoration;
  Icon? leftIcon;
  double? width;
  TextEditingController textFieldController;
  ///[=================== CONSTRUTOR ===================]

  TextFieldUnderline({
    required this.textFieldController,
    required this.hintText,
    this.textStyle,
    this.autoFocus = false,
    this.icon,
    this.borderStyle,
    this.leftIcon,
    this.width,
  }) {
    // if (textFieldController == null) throw ("ERRO: textFieldController não pode ser null");

    if (hintText == null) throw ("ERRO: hint text não pode ser null");

    if (autoFocus == null) autoFocus = false;
    if (borderStyle == null) borderStyle = CustomBorderStyle();

    setInputDecoration;
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  ///[------------------------------ WIDGET BUILD ------------------------------]

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    if (width == null) width = w * 100;
    return Container(
      width: width,
      child: TextFormField(
        controller: textFieldController,
        autofocus: autoFocus, ////[ <==== AUTO FOCUS ]
        decoration: inputDecoration,
        style: TextStyle(
          fontSize: textStyle!.textSize,
          color: textStyle!.textColor,
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
    if (borderStyle!.focusedBorderColor != null) haveFocusBorder = true;

    bool haveEnableBorder = false;
    if (borderStyle!.enableBorderColor != null) haveEnableBorder = true;

    bool haveErrorBorder = false;
    if (borderStyle!.errorBorderColor != null) haveErrorBorder = true;

    bool haveLeftIcon = false;
    if (leftIcon != null) haveLeftIcon = true;

    inputDecoration = InputDecoration(
      border: InputBorder.none,
      icon: haveLeftIcon ? leftIcon : null,
      //
      hintText: hintText.hintText,
      hintStyle: TextStyle(
        fontSize: hintText.hintTextSize,
        color: hintText.hintTextColor,
      ),

      ///============================ BORDERS ===========================
      ///================================================================
      //
      enabledBorder: haveEnableBorder
          ? UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderStyle!.enableBorderColor!,
                width: borderStyle!.borderStroke!,
              ),
              borderRadius: BorderRadius.circular(10.0),
            )
          : null,

      //
      focusedBorder: haveFocusBorder
          ? UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderStyle!.focusedBorderColor!,
                width: borderStyle!.borderStroke!,
              ),
              borderRadius: BorderRadius.circular(10.0),
            )
          : null,

      //
      errorBorder: haveErrorBorder
          ? UnderlineInputBorder(
              borderSide: BorderSide(
                color: borderStyle!.errorBorderColor!,
                width: borderStyle!.borderStroke!,
              ),
              borderRadius: BorderRadius.circular(10.0),
            )
          : null,
    );
  }
}
