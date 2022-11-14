import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IAppNavigation {
  Future toWidgetReplacement(Widget widgetDestination, {bool customEffect = false});
}

class AppNavigation implements IAppNavigation {
  BuildContext _currentContext;
  List<BuildContext> _contextStack = [];
  static final AppNavigation instance = AppNavigation._();
  String teste = "";

  AppNavigation._() {}

  set currentContext(BuildContext context) {
    _contextStack.add(context);
    _currentContext = context;
  }

  BuildContext get currentContext {
    if (_currentContext == null) throw ("ERRO: currentIndex = null / DETALHES: todos os widgets devem passar o seu context para o app session");
    return _currentContext;
  }

  ///[============================================================== CONTEXT ==============================================================]

  ///[============================================================= NAVIGATION =============================================================]

  ///[====================================== BACK ======================================]
  // Descricao: Volta uma pagina, removendo o ultime item da pilha

  Future back({int stackAmount}) async {
    if (stackAmount == null) stackAmount = 1;

    int i = 1;
    while (i <= stackAmount) {
      print("back 1 !!!!!");
      Navigator.pop(_contextStack.last);
      _contextStack.removeLast();
      var teste = _contextStack;
      i++;
    }
  }

  ///[================================= TO NAMED ROUTE =================================]
  //Metodos utilizados para navegar a partir de uma rota

  /// Navega para uma rota especifica, adicionando a rota no topo da stack
  Future toRoute(String routeUrl) async {
    Navigator.pushNamed(
      _contextStack.last,
      routeUrl,
      // arguments: {"teste": "teste"},
    );
  }

  //Navega para uma rota, substituindo a ultima rota da stack
  Future toRouteReplacement(String routeUrl) async {
    // var lastContext = _contextStack.last;
    // _contextStack.removeLast();
    var lastContext = Get.context;
    Navigator.of(lastContext).pushReplacementNamed(routeUrl);
  }

  ///[======================================= POP =======================================]
  Future pop() async {
    // var lastContext = _contextStack.last;
    // _contextStack.removeLast();
    var lastContext = Get.context;
    Navigator.of(lastContext).pop();
  }

  ///[==================================== TO WIDGET ====================================]

  Future toWidget(Widget widgetDestination) async {
    Navigator.push(
      Get.context,
      MaterialPageRoute(builder: (context) {
        return widgetDestination;
      }),
    );
    // Navigator.
  }

  // Future toWidgetReplacement(Widget widgetDestination) async {
  //   // var lastContext = _contextStack.last;
  //   // _contextStack.removeLast();

  //   Navigator.pushReplacement(
  //     Get.context,
  //     MaterialPageRoute(builder: (context) {
  //       return widgetDestination;
  //     }),
  //   );
  // }

  Future toWidgetReplacement(Widget widgetDestination, {bool customEffect = false}) async {
    // var lastContext = _contextStack.last;
    // _contextStack.removeLast();

    if (customEffect == false) {
      Navigator.pushReplacement(
        Get.context,
        MaterialPageRoute(builder: (context) {
          return widgetDestination;
        }),
      );
    } else {
      Navigator.pushReplacement(
        Get.context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => widgetDestination,
          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 1200),
        ),
      );
    }
  }

  ///[======================================= UTILS =======================================]

  Future stackLength() async {
    return _contextStack.length;
  }
}
