import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/user_session.model.dart';
import 'v1.imports.dart';

// abstract class ICustomAuthControllerRequireds {
//   AuthPreferences authPreferences;
// }

class CustomAuthController {
  //
  AuthPreferences authPreferences;

  UserSessionModel _userSession = UserSessionModel();

  String publicRoute = "/login";

  CustomAuthController({
    @required this.authPreferences,
  });

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  UserModel get user => _userSession.user;

  ///[------ RECUPERAR ULTIMA SESSAO ------]
  ///
  Future retrieveSession() async {
    await _userSession.recoverSession();
  }

  ///[-------- AUTENTICAR USUARIO --------]

  Future authenticateUser(UserModel userData) async {
    await _userSession.authenticateUser(userData);
    await CustomLoad().hide();
    await Get.toNamed(authPreferences.privateRoute);
    // await onAuthenticate();
  }

  ///[-------- AUTENTICAR USUARIO --------]

  ///[------- DESCONECTAR USUARIO -------]

  Future disconnectUser() async {
    //
  }

  ///[------- VERIFICAR AUTH STATUS -------]

  Future<AuthStatus> checkAuthStatus() async {
    AuthStatus status = await _userSession.checkAuthStatus();
    return status;
  }

  ///[--------- ATUALIZAR TOKEN ----------]
  ///
  Future updateJwt(String newToken) async {
    user.tokenJwt = newToken;
    await _userSession.saveSession();
  }
}
