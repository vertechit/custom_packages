import 'package:custom_app/lib.imports.dart';
import 'v2.imports.dart';

// abstract class ICustomAuthControllerRequireds {
//   AuthPreferences authPreferences;
// }

class CustomAuthController {
  //
  late AuthPreferences authPreferences;

  late UserSessionModel _userSession;

  String publicRoute = "/login";

  CustomAuthController({
    required this.authPreferences,
  }) {
    _userSession = UserSessionModel(authPreferences: authPreferences);
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  UserModel get user => _userSession.user;

  ///[------ RECUPERAR ULTIMA SESSAO ------]
  ///
  Future retrieveSession() async {
    await _userSession.recoverSession();
  }

  ///[-------- AUTENTICAR USUARIO --------]

  Future authenticateUser(var userData) async {
    await _userSession.authenticateUser(userData);
    await CustomLoad().hide();
    // await Get.toNamed(authPreferences.privateRoute);
    await AppNavigation.instance.toRouteReplacement(authPreferences.privateRoute);
  }

  ///[------- DESCONECTAR USUARIO -------]

  Future disconnectUser() async {
    await CustomLoad().show();
    await _userSession.disconnectUser();
    await CustomLoad().hide();
    await AppNavigation.instance.toRouteReplacement(authPreferences.afterDisconnectRoute);
  }

  ///[------- VERIFICAR AUTH STATUS -------]

  Future<AuthStatus> checkAuthStatus() async {
    AuthStatus status = await _userSession.checkAuthStatus();
    return status;
  }

  ///[---------- INITIALIZATION ----------]
  /// Metodo usado na inicializacao do app

  Future<String> authInitialization() async {
    AuthStatus authStatus = await checkAuthStatus();
    if (authStatus == AuthStatus.logged) {
      return authPreferences.privateRoute; //// Se estiver logado, retorna a rota privada
    } else {
      return authPreferences.publicRoute; //// Se nao estiver logado, retorna a rota publica
    }
  }

  ///[--------- ATUALIZAR TOKEN ----------]
  ///
  Future updateJwt(String newToken) async {
    user.tokenJwt = newToken;
    await _userSession.saveSession();
  }
}
