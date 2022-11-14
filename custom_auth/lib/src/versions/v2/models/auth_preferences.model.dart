import '../v2.imports.dart';

class AuthPreferences {
  String privateRoute;
  String publicRoute;
  String afterDisconnectRoute;
  UserModel userModel;
  AuthClient authClient;

  AuthPreferences({
    this.privateRoute,
    this.publicRoute,
    this.afterDisconnectRoute,
    this.userModel,
    this.authClient,
  }) {
    if (userModel == null) this.userModel = UserModel();
  }
}
