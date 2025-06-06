// import 'package:get_version/get_version.dart';
import 'package:custom_auth/src/versions/v2/v2.imports.dart';
import '../../custom_app.imports.dart';

abstract class ICustomAppControllerRequireds {
  late AuthPreferences authPreferences;
  late IAppComponents components;
  late IStyleTheme style;
  late IAppDebug debug;
}

abstract class CustomAppController implements ICustomAppControllerRequireds {
  //

  ///[=================== VARIAVEIS ===================]
  ///
  //------
  late AuthPreferences authPreferences;

  DeviceInfoModel deviceInfo = DeviceInfoModel();

  AppSession appSession = AppSession.instance;

  late CustomAuthController auth;

  late IAppServices appServices;

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

    return "";
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
