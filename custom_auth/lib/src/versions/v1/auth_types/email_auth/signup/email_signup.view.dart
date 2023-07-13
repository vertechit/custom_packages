import 'package:custom_app/lib.imports.dart';

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
