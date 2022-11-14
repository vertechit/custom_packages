import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_load.imports.dart';

class CustomLoad {
  // BuildContext loadContext;

  LoadContext loadContext = LoadContext.instance;

  ///[=================== EXIBIR LOAD ===================]

  Future show() async {
    print("CUSTOM LOAD - SHOW   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    showDialog(
      context: Get.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loadContext.context = context;
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new CircularProgressIndicator(
                backgroundColor: CustomLoadConfig.instance.appController.style.colors.primary,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        );
      },
    );
    await Future.delayed(const Duration(milliseconds: 600), () {});
    // new Future.delayed(new Duration(seconds: 4), () {
    //   Navigator.pop(newContext); //pop dialog
    //   // _login();
    // });
  }

  ///[==================== FECHAR LOAD ====================]

  Future hide() async {
    if (loadContext.context == null) return;
    await Navigator.pop(loadContext.context);
    loadContext.context = null;
  }
}

class LoadContext {
  //
  static final LoadContext instance = LoadContext._();
  BuildContext context;
  LoadContext._({
    this.context,
  }) {}
}
