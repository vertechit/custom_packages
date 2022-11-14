import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';

import '../../v2.imports.dart';

mixin LoginEmailController on CustomLoginController {
  LoginEmailPreferences loginEmailPreferences;

  ///[====================================== EFETUAR LOGIN ======================================]

  Future loginWithEmail() async {
    //

    String user = (await formHandler.input("user")).text;
    String pass = (await formHandler.input("pass")).text;

    // return;

    ///[1. run debug]
    ///
    if (loginDebug.debugActive == true && loginDebug.mock.active == true) {
      user = loginDebug.mock.user;
      pass = loginDebug.mock.pass;
    } else {
      ///[2. realiza validacoes] Só realiza validacoes se o debug E o mock não estiverem ativos
      ///
      ValidateResult validateResult = await formHandler.validateInputs();
      if (validateResult == ValidateResult.Refused) {
        return; //// Retorna se a validacao de formulario nao for aprovada
      }
    }

    CustomLoad().show();

    ///[3. Chama funcao do repository selecionado]

    try {
      UserModel userData;

      if (appController.auth.authPreferences.userModel == null) {
        //SE FOI SETADO UM USER MODEL PERSONALIZADO
        userData = await loginEmailPreferences.repository.login(
          userModel: UserModel(), //// Passa o userModel padrao
          credentials: LoginAttemptCredentials(
            user: user,
            pass: pass,
          ),
        );
      } else {
        //SE NAO FOI SETADO UM USER MODEL PERSONALIZADO
        userData = await loginEmailPreferences.repository.login(
          userModel: appController.auth.authPreferences.userModel, //// Passa o userModel personalizado
          credentials: LoginAttemptCredentials(
            user: user,
            pass: pass,
          ),
        );
      }

      await processLoginSucess(userData);
    } catch (e) {
      var point = e;
      await processLoginError(e);
    }
  }

  ///[======================================= TRATAR SUCESSO =======================================]

  Future processLoginSucess(UserModel userData) async {
    // await CustomLoad().hide(); *** O LOAD Ë FECHADO PELO AUTH_CONTROLLER
    var teste = userData;
    var point;
    await appController.auth.authenticateUser(userData);

    //
  }

  ///[======================================== TRATAR ERRO ========================================]

  Future processLoginError(String error) async {
    await CustomLoad().hide();

    await CustomPopup(
      type: PopupType.OkButton,
      txtTitle: "Não foi possivel acessar.",
      txtText: error,
    ).show();
    var point;
  }
}

//______________________________________________________________________________________________________________________________________________________

//
///[************************]
///        [ IDEIAS ]
/// Criar metodo que recebe os metodos que compoe uma rotina padrao de login ( validacao, metodo do client, etc )
// Future formLoginProcess() async {
//   //
// }

/// - Utilizar o termo formLogin/formAuth, para se referir a logins baseados em form (email_auth, local_auth, etc )
///
/// - Model LoginAttemptCredentials --> Model que armazena os dados que serao usados na tentativa de login ( Usuario a senha )
///[************************]
///

////[POSTERIORMENTE SEPRAR EM OUTROS ARQUIVOS: ]

//model

// enum LoginEmailClients {
//   FirebaseLoginEmail,
// }
