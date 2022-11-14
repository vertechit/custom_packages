import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';

import '../custom_app.imports.dart';

class CustomLoadConfig {
  CustomAppController appController;

  IAppComponents components;

  IStyleTheme style;

  bool configured = false; //// Indica se o package ja foi configurado

  ///[=================== CONSTRUTOR ===================]

  static final CustomLoadConfig instance = CustomLoadConfig._();

  CustomLoadConfig._() {}

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  Future initialize({
    @required CustomAppController appController,
  }) async {
    configured = true;
    if (appController != null) this.appController = appController;
    this.components = appController.components;
    this.style = appController.style;
  }
}
