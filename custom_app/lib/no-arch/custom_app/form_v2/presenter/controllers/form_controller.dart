import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin FormController {
  ///[=================== VARIAVEIS ===================]
  ///

  final formKey = GlobalKey<FormState>();

  RxBool autoValidate = false.obs;

  ///[-------------------------------- VALIDACAO --------------------------------]

  List<String> validationsFailsList = [];

  ///Metodo que inicializa a validacao de um formulario
  Future validateForm() async {
    ///A lista de mensagens de falha é zerada. A cada checagem essa lista é montada novamente
    validationsFailsList.clear();

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      return "1";
    } else {
      autoValidate.value = true;
      return "0";
    }
  }

  /// Cada input com falha ira chamar esse metodo passando o seu texto de falha (String validationOutputMessage),
  /// a mensagem sera adicionada a uma lista que contem todas as mensagens de erro de validacao.
  /// String validationOutputMessage -> mensagem emitida quando a validacao falha
  Future accountFormFail(String validationOutputMessage) async {
    validationsFailsList.add(validationOutputMessage);
  }
}
