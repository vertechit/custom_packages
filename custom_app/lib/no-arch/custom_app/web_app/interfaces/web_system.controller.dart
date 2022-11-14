import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../web_app.imports.dart';
import 'interfaces.imports.dart';

class WebPopup {
  //
}

abstract class WebSystemControllerRequireds {
  WebAppController appController;
  List<WebAppModulo> systemModules;
  WebSystemControllerRequireds() {
    if (appController == null) throw ("ERRO: A variavel 'appController' não pode ser null");
  }
}

abstract class WebSystemController implements WebSystemControllerRequireds {
  //

  WebSystemController() {
    initializeSystem();
  }

  ///============================================== INITIALIZE SYSTEM ==============================================

  Future initializeSystem() async {
    await sortModulesList();
    await initPageNavigateHandler();
  }

  ///========================================= ORGANIZAR ORDEM DOS MODULOS =========================================
  //  Reorganiza a ordem da lista de modulos, de forma que a pagina inicial seja colocada no topo da lista

  Future sortModulesList() async {
    for (WebAppModulo teste in systemModules) {
      var t1 = teste.toString();
      var point = "";
    }

    var point1 = "";
    systemModules.sort((WebAppModulo a, WebAppModulo b) => a.idModulo.compareTo(appController.debugPreferences.initialPage.idModulo));
    var point2 = "";
  }

  ///============================================ PAGE NAVIGATE HANDLER ============================================

  bool listenNavigateStreamStarted = false;

  // Inicializa o controle de navegacao. Faz a troca de tabs ao receber evento da stream navigateTo; Exibi paginas do tipo dialog
  Future initPageNavigateHandler() async {
    listenNavigateStreamStarted = true;
    appController.streamNavigate.stream.listen((event) async {
      await receiveNavigationEvent(event);
    });
  }

  Future receiveNavigationEvent(int idModulo) async {
    //
    var teste = systemModules;

    for (WebAppModulo modulo in systemModules) {
      var teste = modulo;
      if (modulo.idModulo == idModulo) {
        if (modulo.view.type == PageType.modal) {
          //Modulo do tipo modal
          showModalModule(modulo);
        }
      }
    }
  }

  Future showModalModule(WebAppModulo modulo) async {
    return await showDialog(
      barrierDismissible: true,
      context: Get.context,
      builder: (BuildContext context) {
        var h = MediaQuery.of(context).size.height / 100;
        var w = MediaQuery.of(context).size.width / 100;
        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // contentPadding: EdgeInsets.zero
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            child: Stack(
              children: [
                ///[****************** OUT TAP ****************]
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: w * 100,
                    height: h * 100,
                    color: Colors.transparent,
                  ),
                ),

                ///[*******************************************]
                Container(
                  width: w * 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //----------- POPUP WINDOW STYLE ----------
                        width: modulo.view.width,
                        // height: modulo.view.widget.,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          // color: Colors.green,
                        ),
                        //-----------------------------------------
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: modulo.view.widget,
                        ),
                        // child: Container(
                        //   height: 40,
                        //   width: 100,
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      // tapClose();
    });
  }

  ///================================================== MOUNT TABS ==================================================

  //Monta as tabs que irao compor o sistema
  Future<List<WebAppModulo>> mountTabs() async {
    List<WebAppModulo> baseTabsList = [];
    for (WebAppModulo modulo in systemModules) {
      if (modulo?.view?.type == PageType.basic) {
        baseTabsList.add(modulo); ///// Se for uma pagina do tipo basic, adiciona ela a lista de tabs
      } //
      ///---- PERCORRER SUB MODULOS ----
      // for (WebAppModulo subModulo in modulo.subModulos) {
      //   if (subModulo?.view?.type == PageType.basic) {
      //     baseTabsList.add(subModulo); ///// Se for uma pagina do tipo basic, adiciona ela a lista de tabs
      //   }
      // }
    }
    // print("**** baseTabsList lenght : " + baseTabsList.length.toString());
    return baseTabsList;
  }
}
