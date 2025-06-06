import 'package:custom_app/lib.imports.dart';

import '../../v2.imports.dart';

abstract class CustomLoginController {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  // @override
  late FormHandler formHandler;

  String loginInputHintText = "Usuário";

  LoginDebug loginDebug = LoginDebug(debugActive: false);

  late CustomAppController appController;

  late Function onClickSignup;

  ///[=================== CONSTRUTOR ===================]
  ///
  CustomLoginController() {
    formHandler = FormHandler(
      source: [
        FormSource(hintText: loginInputHintText, id: "user", pos: 0),
        FormSource(hintText: "Senha", id: "pass", pos: 1, isObscure: true),
      ],
      onInputChange: null,
    );
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  Future onClickLogin() async {}

  Future init() async {
    await formHandler.generateFormInputs();
    return true;
  }
}
