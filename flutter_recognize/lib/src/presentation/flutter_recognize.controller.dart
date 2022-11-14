import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../src.imports.dart';

List<CameraDescription> cameras = [];

class FlutterRecognize {
  //
  RxList<CameraLensDirection> cameraDirection = List<CameraLensDirection>().obs;

  IChangeCameraDirection usecaseChangeCameraDirection = ChangeCameraDirection();

  SharedPreferencesDriver localStorageDriver = SharedPreferencesDriver();

  static final FlutterRecognize instance = FlutterRecognize._(); //// Armazena a instancia utilizada no singleton
  FlutterRecognize._() {}

  //============================================ INIT =============================================

  Future init() async {
    await loadConfig();
  }

  //========================================== REGISTER ===========================================

  Future<List> register() async {
    IRegister usecaseRegister = Register();
    cameras = await availableCameras();
    List predictedData = await usecaseRegister();
    if (usecaseRegister.registerComplete) {
      return predictedData;
    } else {
      return [];
    }
  }

  //============================================ AUTH =============================================

  Future<UserRecognize> auth({
    @required RecognizeAuthController controller,
    @required List<UserRecognize> users,
    AppBar header,
    Widget Function(Widget child) cameraFrame,
    bool useCameraDefaultAppbar = false,
    String defaultAppbarText = "",
    Future Function() onClickEmergencyButton,
  }) async {
    await controller.initAuth(
      users: users,
      header: header,
      cameraFrame: cameraFrame,
      useCameraDefaultAppbar: useCameraDefaultAppbar,
      defaultAppbarText: defaultAppbarText,
      onClickEmergencyButton: onClickEmergencyButton,
    );
  }

  //=================================== CARREGAR CONFIGURACOES ====================================

  Future loadConfig() async {
    await loadCameraDirectionConfig();
  }

  //--------------- CAMERA DIRECTION ---------------

  Future loadCameraDirectionConfig() async {
    String storageValue = await localStorageDriver.getData(key: "config_camera_direction");
    if (storageValue == null) {
      cameraDirection.add(CameraLensDirection.front);
    } else if (storageValue == "front") {
      cameraDirection.add(CameraLensDirection.front);
    } else if (storageValue == "back") {
      cameraDirection.add(CameraLensDirection.back);
    }
  }

  //--------------- CAMERA RESOLUTION ---------------

  //================================= DEFINIR DIRECAO DA CAMERA ===================================

  Future changeCameraDirection() async {
    CameraLensDirection newDirection = await usecaseChangeCameraDirection(currentDirection: cameraDirection.last);
    if (newDirection != null) {
      cameraDirection.add(newDirection);
    }
  }
}
