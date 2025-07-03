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
        this.appController = appController;
  }
}
