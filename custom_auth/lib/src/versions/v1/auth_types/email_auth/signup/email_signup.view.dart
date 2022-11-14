import 'package:custom_app/custom_app/custom_app.imports.dart';

abstract class EmailSignupViewRequireds {
  //
  Future onclickSignUp() {}
}

class EmailSignUpView extends CustomWidget implements EmailSignupViewRequireds {
  @override
  Future onclickSignUp() {
    // TODO: implement onclickSignUp
    print("onclickSignUp");
  }

  @override
  CustomAppController appController;
}
