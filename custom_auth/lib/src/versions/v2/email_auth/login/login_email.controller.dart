import 'package:custom_app/lib.imports.dart';
import '../../v2.imports.dart';

mixin LoginEmailController on CustomLoginController {
  late LoginEmailPreferences loginEmailPreferences;

  ///[====================================== EFETUAR LOGIN ======================================]

  Future loginWithEmail() async {
    //

    String user = (await formHandler.input("user"))!.text;
    String pass = (await formHandler.input("pass"))!.text;

    ValidateResult validateResult = await formHandler.validateInputs();
    if (validateResult == ValidateResult.Refused) {
      return; //// Retorna se a validacao de formulario nao for aprovada
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
      await processLoginError(e.toString());
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