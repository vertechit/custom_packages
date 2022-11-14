import 'package:flutter/material.dart';

class SignUpForm {
  List<FormFieldSignup> formFieldList = [];
  SignUpForm({
    this.formFieldList,
  });
  Future mountForm(bool useDefaultFormFields) async {
    //
  }
}

class FormFieldSignup {
  TextEditingController textEditingController;
  String hintText;
  String validateText;
  bool obscureText;
  FormFieldSignup({
    this.textEditingController,
    this.hintText,
    this.validateText,
    this.obscureText,
  });
}
