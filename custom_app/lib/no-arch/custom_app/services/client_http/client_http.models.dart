import 'package:flutter/material.dart';

import '../../custom_app.imports.dart';

///Resultado da requisicao:

class HttpRequestResult {
  ResultStatus status; ///// Indica se a requisicao foi bem sucedida
  var result;
  HttpRequestResult({
    @required this.status,
    @required this.result,
  });
}

// enum ResultStatus {
//   success, //// Sucesso
//   error, //// Requisicao retornou erro
//   connectionFail, ///// Falha de conexao
// }
