import 'package:custom_components/buttons/buttons.imports.dart';
import 'package:custom_components/components.imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class IAppComponents {
  //
  TextFieldComponents? textFields;
  ButtonsComponents? buttons;
}

///[====================== TEXT FIELD =====================]
///[=======================================================]
abstract class TextFieldComponents {
  //
  ///---- PRIMARY----
  ICustomTextField primary({
    required TextEditingController textController,
    required String hintText,
    String? textValidate,
    bool? isObscure,
    List<TextInputFormatter>? formatters,
    TextCapitalization? textCapitalization,
    double? width,
    bool? isRequired,
    ITextFieldValidation? validation,
  });

  ///---- SECONDARY----
  ICustomTextField secondary({
    required TextEditingController textController,
    required String hintText,
    String? textValidate,
    bool? isObscure,
    List<TextInputFormatter>? formatters,
    TextCapitalization? textCapitalization,
    double? width,
    bool? isRequired,
    ITextFieldValidation? validation,
  });
}

///[======================== BUTTONS ======================]
///[=======================================================]
abstract class ButtonsComponents {
  //
  ///---- PRIMARY----
  Widget primary({
    required String text,
    required Function onClick,
    TextPreferences? textPreferences,
  });

  ///---- SECONDARY----
  Widget secondary({
    required String text,
    required Function onClick,
    TextPreferences? textPreferences,
  });

  ///---- VOLTAR----
  Widget voltar({
    required String text,
    required Function onClick,
    TextPreferences? textPreferences,
  });

  ///---- TESTE----
  Widget add({
    required String text,
    required Function onClick,
    TextPreferences? textPreferences,
  });
}
