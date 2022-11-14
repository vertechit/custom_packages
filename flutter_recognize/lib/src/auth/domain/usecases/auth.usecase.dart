import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../src.imports.dart';
import '../../auth.imports.dart';
import '../domain.imports.dart';

abstract class IAuth extends RecognizeProcess {
  Future Function({@required UserRecognize user}) onAuthenticate;
  Future Function() onClickEmergencyButton;
  RxBool authComplete;
  RxBool showEmergencyButton;
  Future call({
    @required List<UserRecognize> users,
    AppBar header,
    Widget Function(Widget child) cameraFrame,
    bool useCameraDefaultAppbar = false,
    String defaultAppbarText = "",
    Future Function() onClickEmergencyButton,
  });
  Future restart();
  Future onClickEmergency();
}

class Auth extends IAuth {
  List<UserRecognize> users = [];

  bool initCompleted = false;

  RxBool authComplete = false.obs;

  @override
  Future Function({@required UserRecognize user}) onAuthenticate;

  @override
  Future Function() onClickEmergencyButton;

  Auth({
    @required this.onAuthenticate,
  });

  //------------------------------------------------------ CALL ------------------------------------------------------

  @override
  Future call({
    @required List<UserRecognize> users,
    AppBar header,
    Widget Function(Widget child) cameraFrame,
    bool useCameraDefaultAppbar = false,
    String defaultAppbarText = "",
    Future Function() onClickEmergencyButton,
  }) async {
    this.users = users;

    this.onClickEmergencyButton = onClickEmergencyButton;

    predictedData = [];

    //Inicializar usecase prediction
    await usecaseSetPrediction.initialize();

    double emergencyButtonMarginTop;

    if (useCameraDefaultAppbar) emergencyButtonMarginTop = 19;

    cameraPage = CameraView(
      header: header,
      cameraFrame: cameraFrame,
      title: 'Acessar',
      customPaint: customPaint,
      text: "TEXT!!!",
      controlWidget: AuthControlView(
        usecaseAuth: this,
        emergencyButtonMarginTop: emergencyButtonMarginTop,
      ),
      onImage: ({CameraImage image, InputImage inputImage}) async {
        onCameraImageUpdate(image: image, inputImage: inputImage);
      },
      initialDirection: FlutterRecognize.instance.cameraDirection.last,
      // initialDirection: CameraLensDirection.back,
      showDefaultAppBar: useCameraDefaultAppbar,
      defaultAppbarText: defaultAppbarText,
    );

    initCompleted = true;

    //Navegar para a tela da camera
    UserRecognize userAuthenticated = await Navigator.pushReplacement(
      Get.context,
      MaterialPageRoute(
        builder: (BuildContext context) => cameraPage,
      ),
    );

    return userAuthenticated;
  }

  //---------------------------------------------- REINICIAR PROCESSO ----------------------------------------------

  @override
  Future restart() async {
    _onDetectFace = 0;
    predictedData.clear();
    authComplete.value = false;
    faceDeteced.value = false;
  }

  //----------------------------------------------- AO DETECTAR FACE -----------------------------------------------

  bool authInProgress = false;
  int _onDetectFace = 0;

  @override
  Future onDetectFace() async {
    if (authInProgress == true || initCompleted == false) return;

    //Verificacao necessaria para evitar a interpretacao de imagens antigas da camera.
    // Por ex, depois de fazer o processo de cadastro e em seguida iniciar o processo de auth,
    // no processo de auth sera recebida imagem remanescente do processo de cadastro. ->
    // Ignorando a primeira imagem recebida, teremos certeza que as proximas imagens sao atualizadas
    if (_onDetectFace == 0) {
      predictedData = [];
      _onDetectFace = 1;
      return;
    }

    authInProgress = true;
    fireEmergencyCounter();
    await tryAuthenticate();
    await Future.delayed(const Duration(milliseconds: 200), () {});
    authInProgress = false;
  }

  bool authenticateInProgress = false;

  Future tryAuthenticate() async {
    if (authenticateInProgress) return;
    authenticateInProgress = true;

    if (predictedData.isEmpty) return;

    int qtdUsuariosAnalisados = 0;

    for (UserRecognize user in users) {
      if (user.prediction.isNotEmpty && await ultimaDeteccaoExpirada(user)) {
        //
        double currDist = 0.0;

        try {
          currDist = _euclideanDistance(user.prediction, predictedData);

          qtdUsuariosAnalisados++;
        } catch (e) {
          currDist = 0.0;
        }

        print("currDist >>>>>>>>>>>>>>>>>> " + currDist.toString());

        //// MELHOR VALOR ATE O MOMENTO: 0.6
        if (currDist < 0.6 && currDist > 0.0) {
          //
          //---------- ROSTO IDENTIFICADO ---------

          showEmergencyButton.value = false;

          authComplete.value = true;

          await Future.delayed(const Duration(milliseconds: 300), () {});

          await onAuthenticate(user: user);
        }
      }
    }

    print("###############################################   QUANTIDADE DE USUARIOS ANALISADOS: " + qtdUsuariosAnalisados.toString());

    authenticateInProgress = false;
  }

  double _euclideanDistance(List e1, List e2) {
    if (e1 == null || e2 == null) throw Exception("Null argument");

    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  ///Retorna TRUE se ja expirou o tempo desde a ultima deteccao, ou seja,
  /// retorna true se puder realizar uma nova deteccao
  Future<bool> ultimaDeteccaoExpirada(UserRecognize user) async {
    if (user.timestampLastDetection == 0) {
      return true;
    } else {
      int atualTs = DateTime.now().millisecondsSinceEpoch;
      int difTs = atualTs - user.timestampLastDetection;
      if (difTs > 12000) {
        return true;
      } else {
        return false;
      }
    }
  }

  //-------------------------------------------- SEM FACES DETECTADAS --------------------------------------------

  @override
  Future onNoFaces() async {
    resetEmergency();
  }

  //----------------------------------------------- EMERGENCY BUTTON -----------------------------------------------

  Timer timerEmergency;

  bool emergencyCountInProgress = false;

  @override
  RxBool showEmergencyButton = false.obs;

  Future fireEmergencyCounter() async {
    if (emergencyCountInProgress) return;
    emergencyCountInProgress = true;
    timerEmergency = Timer(Duration(seconds: 6), () {
      if (authComplete.value == false) {
        emergencyCountInProgress = false;
        showEmergencyButton.value = true;
      }
    });
  }

  Future resetEmergency() async {
    if (emergencyCountInProgress == false) return;
    Timer(Duration(milliseconds: 800), () {
      timerEmergency.cancel();
      showEmergencyButton.value = false;
      emergencyCountInProgress = false;
    });
  }

  Future onClickEmergency() async {
    Future.delayed(const Duration(milliseconds: 800), () async {
      // await cameraPage.cameraController.stopImageStream();
      await cameraPage.cameraController.pausePreview();
      // await cameraPage.cameraController.dispose();
    });
    await onClickEmergencyButton();
     showEmergencyButton.value = false;
    await cameraPage.cameraController.resumePreview();

    var p = "";
  }
}

class AuthProcessLog {
  List usersProcessed;
}

class UserProcessedDetails {
  //s
}
