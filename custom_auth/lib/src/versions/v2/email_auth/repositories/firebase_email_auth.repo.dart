import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../v2.imports.dart';

class FirebaseEmailAuth implements LoginEmailRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///[=================================== LOGIN ===================================]

  @override
  Future<UserModel> login({@required LoginAttemptCredentials credentials, @required UserModel userModel}) async {
    UserModel user;

    try {
      UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(
            email: credentials.user,
            password: credentials.pass,
          )
          .timeout(Duration(seconds: 5));

      //------- LER DADOS DO USUÁRIO --------
      var userId = credentials.user.replaceAllMapped(new RegExp(r'[@.]'), (match) {
        return '';
      });
      try {
        Map dadosUser = await ClientFirebase().read(endPoint: "USERS/" + userId);
        user = await userModel.convertFromDatabase(dadosUser);
      } catch (e) {
        var point;
      }
      //--------------------------------------

      var point;
    } catch (e) {
      //

      //----- Tratar erros de autenticacao -----

      String errorMessage = "ERRO!";
      //ERRO DE CONEXAO
      if (e.message == "Future not completed") {
        errorMessage = "Verifique sua conexão";
      }

      //OUTROS ERROS
      if (e.code != null) {
        if (e?.code == "wrong-password") errorMessage = "Senha inválida";
        if (e?.code == "ERROR_USER_NOT_FOUND") errorMessage = "E-mail não cadastrado";
        if (e?.code == "user-not-found") errorMessage = "E-mail não cadastrado";
      }

      throw (errorMessage);
      //----------------------------------------
    }

    //Se o login for bem sucedido, retorna os dados do usuário logado
    return user;
  }

  ///[=================================== LOGOUT ===================================]
}

//---------------------------------------------------

// abstract class LoginEmailClient2 {
//   //
// }

// abstract class LoginFunctions {
//   ///
// }
