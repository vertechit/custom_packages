import 'package:custom_app/lib.imports.dart';

import '../../v2.imports.dart';

abstract class CustomLoginController {
  //
  ///[=================== VARIAVEIS ===================]
  ///
  // @override
  FormHandler formHandler;

  String loginInputHintText; //// O [hint text] padrao é 'Usuário', mas caso deseje personalizar, é só definir um valor para essa variável

  LoginDebug loginDebug = LoginDebug(debugActive: false);

  CustomAppController appController;

  Function onClickSignup;

  ///[=================== CONSTRUTOR ===================]
  ///
  CustomLoginController() {
    formHandler = FormHandler(
      source: [
        FormSource(hintText: loginInputHintText ?? "Usuário", id: "user", pos: 0),
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
