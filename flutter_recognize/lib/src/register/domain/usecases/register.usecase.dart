import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../src.imports.dart';
import '../../../domain/usecases/usecases.imports.dart';
import '../../register.imports.dart';

abstract class IRegister extends RecognizeProcess {
  bool registerComplete = false;
  Future<List> call();
}

class Register extends IRegister {
  //

  List predictedData = [];

  //----------------------------------------- CALL  -----------------------------------------

  Future<List> call() async {
    //Inicializar usecase prediction
    await usecaseSetPrediction.initialize();

    cameraPage = CameraView(
      title: 'Cadastro',
      customPaint: customPaint,
      text: "TEXT!!!",
      controlWidget: RegisterControlView(
        onClickRegister: onClickRegister,
        usecaseRegister: this,
      ),
      onImage: ({CameraImage image, InputImage inputImage}) async {
        onCameraImageUpdate(image: image, inputImage: inputImage);
      },
      showDefaultAppBar: true,
      initialDirection: CameraLensDirection.front,
      // initialDirection: CameraLensDirection.front,
    );

    // Close the dialog programmatically
    // Navigator.of(Get.context).pop();

    //Navegar para a tela da camera
    await Get.to(cameraPage);

    String strPredictedData = "";

    for (double data in predictedData) {
      strPredictedData = strPredictedData + data.toString() + ",";
    }

    print(">>>>>>>>>>>>>> FINAL STRING PREDICTED DATA: " + strPredictedData);

    //Retornar mapeamento da face
    return predictedData;
  }

  //-------------------------- AO CLICAR NO BOTAO REGISTRAR -------------------------------

  Future onClickRegister() async {
    // print("#################   Usecase Register -->  onClickRegister() 11111111");

    // await cameraPage.cameraController.stopImageStream();
    await cameraPage.cameraController.pausePreview();
    // await cameraPage.cameraController.dispose();

    // predictedData = [];

    // await finishProcess();

    registerComplete = true;

    ///Sai da tela da camera (retorna para tela anterior)
    Get.back();
  }

  //------------------------ RECEBER ATUALIZACAO DA IMAGEM DA CAMERA ------------------------

  // @override
  //Disparado para receber atualizações da imagem da camera
  // Future onCameraImageUpdate({CameraImage image}) async {
  //   if (!detectingFaces) {
  //     detectingFaces = true;
  //     await detectFaceInImage(image: image);
  //     await setPrediction(image: image);

  //     //****** DEBUG *****/
  //     await Future.delayed(const Duration(milliseconds: 700), () {
  //       print("DELAY DE DEBUG - LEMBRAR DE RETIRAR !!!!!!");
  //     });

  //     detectingFaces = false;
  //   }
  // }

  //------------------------------- DETECTAR ROSTOS NA IMAGEM -------------------------------

  Future onDetectFace() async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
  }
  // Future detectFaceInImage({@required CameraImage image}) async {
  //   faces = await usecaseDetectFace(image: image);
  //   if (faces.length > 0) {
  //     lastFaceDetected = faces.last;
  //     faceDeteced.value = true;
  //   } else {
  //     faceDeteced.value = false;
  //   }

  //   // print(">>>>>>>>>>>>>> FACES ENCONTRADAS: " + faces.length.toString());
  // }

  //------------------------------------- SET PREDICTION -------------------------------------

  Future setPrediction({@required CameraImage image}) async {
    if (faces.length > 0) {
      predictedData = await usecaseSetPrediction(image, faces.last);
      var point = "";
    }
  }
}
