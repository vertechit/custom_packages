// import 'package:get_version/get_version.dart';
import 'package:custom_auth/src/versions/v2/v2.imports.dart';
import '../../custom_app.imports.dart';
import '../out.imports.dart';
import 'app_config.model.dart';
import 'app_services.model.dart';
import 'device_info.model.dart';

abstract class ICustomAppControllerRequireds {
  AuthPreferences authPreferences;
  // AppConfig appConfig; ///// [ <<*** POR ENQUANTO NÃO UTILIZADO ]
  IAppComponents components;
  IStyleTheme style;
  IAppDebug debug;
}

abstract class CustomAppController implements ICustomAppControllerRequireds {
  //

  ///[=================== VARIAVEIS ===================]
  ///
  //------
  AuthPreferences authPreferences;
  // AppConfig appConfig; ///// [ <<*** POR ENQUANTO NÃO UTILIZADO ]
  //------

  DeviceInfoModel deviceInfo = DeviceInfoModel();

  AppSession appSession = AppSession.instance;

  CustomAuthController auth;

  IAppServices appServices;

  IAppNavigation navigation = AppNavigation.instance;

  CustomAppController() {
    auth = CustomAuthController(authPreferences: authPreferences);
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  ///[----------------------------------- INICIAR APP -----------------------------------]
  bool appIsLoad = false;

  Future implInitialize() async {
    //
  }

  Future<String> initializeApp() async {
    // if (appIsLoad == true) return throw ("ERRO : APP JA ESTA INICIADO! ");
    if (appIsLoad == true) return "";

    appIsLoad = true;

    await implInitialize();

    await debug.init();

    await readDeviceInfo(); //// Obter informações do device

    //-------- AUTH ---------

    await auth.retrieveSession(); //// AUTH - Recuperar sessão

    if (await checkAuthStatus() == AuthStatus.logged) {
      await authenticatedInitInternal();
    } else {
      await unAuthorizedInitInternal();
    }
    //------------------------

    // String initialRoute = await appConfig.setInitialRoute(); //// Disparar metodo de incializacao

    // return initialRoute;
  }

  //Verificar status de autenticacao
  Future<AuthStatus> checkAuthStatus() async {
    AuthStatus stAuth = await auth.checkAuthStatus();
    return stAuth;
  }

  //------------------------------------------------
  ///[Inicializacao disparada com o app autenticado]
  ///
  Future authenticatedInitInternal() async {
    await authenticatedInit();
    // configureServices(true);
    // return auth.authPreferences.privateRoute;
  }

  Future authenticatedInit() async {}

  //-------------------------------------------------
  ///[Inicializacao disparada quando nao ha autenticacao]
  ///
  Future unAuthorizedInitInternal() async {
    await unAuthorizedInit();
    configureServices(false);
    // return auth.publicRoute;
  }

  Future unAuthorizedInit() async {}

  ///[------------------------------- CONFIGURE SERVICES -------------------------------]

  Future configureServices(bool userAuthenticated) async {
    // for (var itemService in appServices.servicesList) {
    //   itemService.initService();
    // }
  }

  ///[-------------------------------- READ DEVICE INFO --------------------------------]

  Future readDeviceInfo() async {
    // String platformVersion = await GetVersion.platformVersion;
    // var platInfoSlipt = platformVersion.split(" ");
    // var platform = platInfoSlipt[0];
    // var platVersao = platInfoSlipt[1];

    // deviceInfo.platInfo.so = platform;
    // deviceInfo.platInfo.version = platVersao;

    return "ok";
  }
}
