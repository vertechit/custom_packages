import 'out/out.imports.dart';

class CustomAppConfig {
  //

  bool configured = false;

  late CustomAppController appController;

  ///[=================== CONSTRUTOR ===================]

  static final CustomAppConfig instance = CustomAppConfig._();

  CustomAppConfig._() {}

  Future initialize({
    required CustomAppController appController,
  }) async {
    configured = true;
    if (appController != null) this.appController = appController;
  }
}
