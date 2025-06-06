import 'dart:async';

import '../../custom_app.imports.dart';
import '../web_app.imports.dart';

abstract class IWebAppControllerRequireds {
  AppConfig? appConfig;
  IAppComponents? components;
  IStyleTheme? style;
  IAppDebug? debug;
}

abstract class WebAppController implements IWebAppControllerRequireds {
  StreamController<int> streamNavigate = new StreamController.broadcast();

  DeviceInfoModel deviceInfo = DeviceInfoModel();

  double? pagesHeight;

  IDebugPreferences? debugPreferences;

  @override
  Future<String> initializeApp() async {
    return "/load_system";
  }

  Future navigateTo({int? idModulo}) async {
    ///Futuramente podem ser usados outras referencia de navegacao, além do id
    print("disparado metodo navigaTo() !!!");
    streamNavigate.add(idModulo!);
  }
}
