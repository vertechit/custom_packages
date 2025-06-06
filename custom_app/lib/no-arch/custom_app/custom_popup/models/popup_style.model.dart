import 'package:flutter/material.dart';

class PopupStyle {
  double borderRadius;
  Widget? buttonOk;
  Widget? buttonCancel;
  TextStyle? styleText;
  TextStyle? styleTitle;
  PopupStyle({
    required this.borderRadius,
    this.buttonOk,
    this.buttonCancel,
    this.styleText,
    this.styleTitle,
  });
}
