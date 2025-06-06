import 'package:flutter/material.dart';

import '../custom_app.imports.dart';
import 'interfaces/interfaces.imports.dart';

class WebAppConfig {
  late WebAppController appController;

  late IAppComponents components;

  late IStyleTheme style;

  bool configured = false; //// Indica se o package ja foi configurado

  ///[=================== CONSTRUTOR ===================]

  static final WebAppConfig instance = WebAppConfig._();

  WebAppConfig._() {}

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  Future initialize({
    required WebAppController appController,
  }) async {
    configured = true;
    if (appController != null) this.appController = appController;
    this.components = appController.components!;
    this.style = appController.style!;
  }
}
