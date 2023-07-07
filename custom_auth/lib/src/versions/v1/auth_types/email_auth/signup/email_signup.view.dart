import 'package:custom_app/no-arch/custom_app/out/app_controller/app.controller.interface.dart';
import 'package:custom_app/no-arch/custom_app/out/view/custom_widget.view.dart';

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
