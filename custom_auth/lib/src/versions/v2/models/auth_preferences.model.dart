import '../v2.imports.dart';

class AuthPreferences {
  String privateRoute;
  String publicRoute;
  String afterDisconnectRoute;
  UserModel userModel;
  AuthClient authClient;

  AuthPreferences({
    required this.privateRoute,
    required this.publicRoute,
    required this.afterDisconnectRoute,
    required this.userModel,
    required this.authClient,
  }) {
  }
}
