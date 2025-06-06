import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../text_field.imports.dart';

///[======================== PREFERENCES ====================]
///[=========================================================]

class TextFieldPreferences {
  //
  //
  //[=================== VARIAVEIS ===================]
  ///
  late InputDecoration inputDecoration;
  HintTextModel hintText;
  TextStyleModel? textStyle;
  Color? backgroundColor;
  bool autoFocus;
  Icon? icon;
  CustomBorderStyle? borderStyle;
  Icon? leftIcon;
  double? width;
  TextEditingController textFieldController;
  bool isObscure;
  double? borderRadius;
  String? txtValidate;
  List<TextInputFormatter>? formatters;
  TextCapitalization? textCapitalization;
  EdgeInsetsGeometry? contentPadding;
  bool hasContentPadding = true;
  /// Indica se o textField é obrigatorio. Se for true, sera aplicada a validacao ( utilizado no antigo processo de validação, disponivel até a versão 0.0.2 )
  bool isRequired;
  /// Classe responsavel por fazer a validacao do formulario (algumas opcoes disponiveis: NotEmptyValidation(), CPFvalidation() )
  ITextFieldValidation? validation;

  // ///[=================== CONSTRUTOR ===================]

  TextFieldPreferences({
    required this.textFieldController,
    required this.hintText,
    this.textStyle,
    this.autoFocus = false,
    this.icon,
    this.borderStyle,
    this.leftIcon,
    this.width,
    this.isObscure = false,
    this.backgroundColor,
    this.borderRadius,
    this.txtValidate,
    this.formatters,
    this.textCapitalization,
    this.contentPadding,
    this.isRequired = false,
    this.validation,
  }) {
    if (textFieldController == null) throw ("ERRO: textFieldController não pode ser null");

    if (hintText == null) throw ("ERRO: hint text não pode ser null");

    if (isObscure == null) isObscure = false;

    if (autoFocus == null) autoFocus = false;

    if (backgroundColor == null) backgroundColor = Colors.transparent;

    if (borderStyle == null) borderStyle = CustomBorderStyle();

    if (borderRadius == null) borderRadius = 0.0;

    if (txtValidate == null) txtValidate = "Esse campo deve ser preenchido";

    if (textCapitalization == null) textCapitalization = TextCapitalization.none;

    if (contentPadding == null) hasContentPadding = false;
    if (isRequired == null) isRequired = false;

    // setInputDecoration;
  }
}

///[======================= BORDER STYLE ====================]
///[=========================================================]
///
class CustomBorderStyle {
  Color? focusedBorderColor;
  Color? enableBorderColor;
  Color? errorBorderColor;
  double? borderStroke;

  CustomBorderStyle({
    this.focusedBorderColor,
    this.enableBorderColor,
    this.errorBorderColor,
    this.borderStroke,
  }) {
    if (focusedBorderColor == null) focusedBorderColor = null;
    if (enableBorderColor == null) enableBorderColor = null;
    if (errorBorderColor == null) errorBorderColor = null;
    if (borderStroke == null) borderStroke = 1.0;
  }
}

///[======================== HINT TEXT ======================]
///[=========================================================]
///
class HintTextModel {
  //
  String? hintText;
  Color? hintTextColor;
  double? hintTextStroke;
  double? hintTextSize;

  HintTextModel({
    this.hintText,
    this.hintTextColor,
    this.hintTextStroke,
    this.hintTextSize,
  }) {
    if (hintTextColor == null) hintTextColor = Colors.black;
    if (hintTextStroke == null) hintTextStroke = 1.0;
    if (hintTextSize == null) hintTextSize = 20.0;
  }
}

///[======================== TEXT STYLE =====================]
///[=========================================================]
///
class TextStyleModel {
  //
  Color? textColor;
  double? textSize;

  TextStyleModel({
    this.textColor,
    this.textSize,
  }) {
    if (textColor == null) textColor = Colors.black;
    if (textSize == null) textSize = 8.0;
  }
}
