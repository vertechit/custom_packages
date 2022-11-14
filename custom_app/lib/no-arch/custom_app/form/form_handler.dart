import 'package:flutter/material.dart';

import 'form.imports.dart';

class FormHandler {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  List<FormInput> formInputs = [];
  List<FormSource> source = [];

  Function onInputChange;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  ///[=================== CONSTRUTOR ===================]

  FormHandler({
    @required this.source,
    @required this.onInputChange,
  }) {
    for (FormSource itemSource in source) {
      formInputs.add(
        FormInput(
          controller: TextEditingController(),
          id: itemSource.id,
          hintText: itemSource.hintText,
          isObscure: itemSource.isObscure,
        ),
      );
    }
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  ///[---------------------- LISTEN INPUT CHANGES ----------------------]
  //Observar alteracoes feitas nos inputs

  Future listenInputsChanges() async {
    for (FormInput itemInput in formInputs) {
      itemInput.controller.addListener(onInputChange);
    }
  }

  ///[---------------------- GERAR LISTA DE INPUTS ----------------------]

  Future generateFormInputs() async {
    // for (FormSource itemSource in source) {
    //   formInputs.add(
    //     FormInput(
    //       controller: TextEditingController(),
    //       id: itemSource.id,
    //       hintText: itemSource.hintText,
    //       isObscure: itemSource.isObscure,
    //     ),
    //   );
    // }
  }

  ///[------------------------ RECUPERAR UM INPUT -----------------------]

  Future<TextEditingController> input(String id) async {
    for (FormInput itemInput in formInputs) {
      if (itemInput.id == id) {
        return itemInput.controller;
      }
    }
  }

  ///[----------------------- ESCREVER EM UM INPUT -----------------------]

  Future inputWrite({String text, String inputId}) async {
    for (FormInput itemInput in formInputs) {
      if (itemInput.id == inputId) {
        itemInput.controller.text = text;
      }
    }
  }

  ///[------------------------- VALIDAR FORMULARIO -------------------------]

  Future<ValidateResult> validateInputs() async {
    if (formKey.currentState.validate()) {
      //If all data are correct then save data to out variables
      formKey.currentState.save();
      return ValidateResult.Approved;
    } else {
      //If all data are not valid then start auto validation.
      autoValidate = true;
      return ValidateResult.Refused;
    }
  }
}

//===================================================================================================================================
///[Objeto usado para setar os inputs existentes no Form]
///
class FormSource {
  String id; ///// Identificacao
  int pos; //// Posicao na lista (decidir se será usado)
  String hintText;
  bool isObscure;
  FormSource({
    this.id,
    this.pos,
    this.hintText,
    this.isObscure,
  }) {
    if (isObscure == null) isObscure = false;
  }
}

//===================================================================================================================================
///[Objeto usado para armazenas os inputs criados ]
///
class FormInput {
  TextEditingController controller;
  String id;
  String hintText;
  bool isObscure;
  FormInput({
    this.controller,
    this.id,
    this.hintText,
    this.isObscure,
  });
}
