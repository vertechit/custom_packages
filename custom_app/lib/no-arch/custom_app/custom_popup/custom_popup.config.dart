import 'package:custom_app/lib.imports.dart';
import '../custom_app.imports.dart';

class CustomPopupConfig {
  //

  late CustomAppController appController;

  late IAppComponents components;

  late IStyleTheme style;

  bool configured = false; //// Indica se o package ja foi configurado

  late PopupDecoration decoration;

  ///[=================== CONSTRUTOR ===================]

  static final CustomPopupConfig instance = CustomPopupConfig._();

  CustomPopupConfig._() {}

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  Future initialize({
    required CustomAppController appController,
    PopupDecoration? decoration,
    // required IAppComponents components,
    // required IStyleTheme style,
  }) async {
    configured = true;
    if (appController != null) this.appController = appController;
    if (decoration != null) this.decoration = decoration;
    this.components = appController.components;
    this.style = appController.style;
    // if (components != null) this.components = components;
    // if (style != null) this.style = style;
  }
}
