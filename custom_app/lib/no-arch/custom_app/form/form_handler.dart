import 'package:flutter/material.dart';

import 'form.imports.dart';

class FormHandler {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  List<FormInput> formInputs = [];
  List<FormSource> source = [];

  Function? onInputChange;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool autoValidate = false;

  ///[=================== CONSTRUTOR ===================]

  FormHandler({
    required this.source,
    this.onInputChange,
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
      itemInput.controller!.addListener(() => onInputChange);
    }
  }

  ///[---------------------- GERAR LISTA DE INPUTS ----------------------]

  Future<void> generateFormInputs() async {
    // Method body commented out as it's already handled in the constructor
  }

  ///[------------------------ RECUPERAR UM INPUT -----------------------]

  Future<TextEditingController?> input(String id) async {
    for (FormInput itemInput in formInputs) {
      if (itemInput.id == id) {
        return itemInput.controller;
      }
    }
    return null; // Return null if no matching input is found
  }

  ///[----------------------- ESCREVER EM UM INPUT -----------------------]

  Future<void> inputWrite({String? text, String? inputId}) async {
    if (inputId == null) return;

    for (FormInput itemInput in formInputs) {
      if (itemInput.id == inputId) {
        itemInput.controller?.text = text ?? '';
      }
    }
  }

  ///[------------------------- VALIDAR FORMULARIO -------------------------]

  Future<ValidateResult> validateInputs() async {
    if (formKey.currentState?.validate() ?? false) {
      //If all data are correct then save data to out variables
      formKey.currentState?.save();
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
  int? pos; //// Posicao na lista (decidir se será usado)
  String hintText;
  bool isObscure;

  FormSource({
    required this.id,
    this.pos,
    required this.hintText,
    bool? isObscure,
  }) : isObscure = isObscure ?? false;
}

//===================================================================================================================================
///[Objeto usado para armazenas os inputs criados ]
///
class FormInput {
  TextEditingController? controller;
  String? id;
  String? hintText;
  bool? isObscure;
  FormInput({
    this.controller,
    this.id,
    this.hintText,
    this.isObscure,
  });
}
