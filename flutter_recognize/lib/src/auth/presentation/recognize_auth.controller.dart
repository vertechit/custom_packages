import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../src.imports.dart';
import '../auth.imports.dart';

class RecognizeAuthController {
  IAuth usecaseAuth;

  Future Function({@required UserRecognize user}) onAuthenticate;

  RecognizeAuthController({
    @required this.onAuthenticate,
  });

  //================================================== INIT AUTH ==================================================

  Future initAuth({
    @required List<UserRecognize> users,
    AppBar header,
    Widget Function(Widget child) cameraFrame,
    bool useCameraDefaultAppbar = false,
    String defaultAppbarText = "",
    Future Function() onClickEmergencyButton,
  }) async {
    //Definir useCase
    usecaseAuth = Auth(
      onAuthenticate: onAuthenticate,
    );

    cameras = await availableCameras();
    var p = "";
    await usecaseAuth(
      users: users,
      header: header,
      cameraFrame: cameraFrame,
      useCameraDefaultAppbar: useCameraDefaultAppbar,
      defaultAppbarText: defaultAppbarText,
      onClickEmergencyButton: onClickEmergencyButton,
    );
  }

  //=============================================== REINICIAR PROCESSO ===============================================

  Future restart() async {
    await usecaseAuth.restart();
  }

  // Future _onAuthenticate() async {
  //   //
  // }
}
