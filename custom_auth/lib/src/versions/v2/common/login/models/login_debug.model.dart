import 'login_models.imports.dart';

class LoginDebug {
  bool debugActive;
  LoginMock? mock;
  LoginDebug({
    this.debugActive = false,
    this.mock,
  });
}
