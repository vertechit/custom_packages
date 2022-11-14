import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../modulos/camera_page/presentation/painters/face_detector_painter.widget.dart';
import '../../src.imports.dart';
import '../domain.imports.dart';

abstract class RecognizeProcess {
  IDetectFace usecaseDetectFace = DetectFace();

  ISetPrediction usecaseSetPrediction = SetPrediction();

  List predictedData = [];

  bool detectingFaces = false;

  @override
  RxBool faceDeteced = false.obs;

  RxList<Face> rxFaces = RxList<Face>();

  Face lastFaceDetected;

  // CameraPageView cameraPage;
  CameraView cameraPage;

  List<Face> faces;

  bool processFinished = false;

  RxList<CustomPaint> customPaint = List<CustomPaint>().obs;

  //------------------------------------- START PROCESS -------------------------------------

  Future startProcess() async {
    //
  }

  //------------------------------------- FINISH PROCESS -------------------------------------

  Future finishProcess() async {
    // processFinished = true;
    // await usecaseDetectFace.close();
    // predictedData = [];
  }

  //------------------------ RECEBER ATUALIZACAO DA IMAGEM DA CAMERA ------------------------

  //Disparado para receber atualizações da imagem da camera
  Future onCameraImageUpdate({@required CameraImage image, @required InputImage inputImage}) async {
    if (processFinished) return;
    // print("#################   RecognizeProcess -->  onCameraImageUpdate()");
    if (!detectingFaces) {
      detectingFaces = true;
      await detectFaceInImage(image: image, inputImage: inputImage);
      await setPrediction(image: image);

      if (faceDeteced.value) {
        onDetectFace();
      } else {
        onNoFaces();
      }
      detectingFaces = false;
    }
  }

  //------------------------------- DETECTAR ROSTOS NA IMAGEM -------------------------------

  Future detectFaceInImage({@required CameraImage image, @required InputImage inputImage}) async {
    // print("#################   RecognizeProcess -->  detectFaceInImage()");

    faces = await usecaseDetectFace(image: image, inputImage: inputImage);
    rxFaces.value = faces;
    if (faces.length > 0) {
      // print("FACE DETECTED = TRUE !!!!!!!");
      faceDeteced.value = true;
      lastFaceDetected = faces.last;

      if (inputImage.inputImageData?.size != null && inputImage.inputImageData?.imageRotation != null) {
        // print("DESENHAR FACE PAINTER !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        final painter = FaceDetectorPainter(faces, inputImage.inputImageData.size, inputImage.inputImageData.imageRotation);
        customPaint.add(CustomPaint(painter: painter));
      }
    } else {
      // print("FACE DETECTED = FALSE !!!!!!!");
      faceDeteced.value = false;
      customPaint.clear();
    }

    // print(">>>>>>>>>>>>>> FACES ENCONTRADAS: " + faces.length.toString());
  }

  //Metodo disparado quando é detectada uma face (Sobrescrito na implementação, para realizar ações personalizadas)
  Future onDetectFace() async {}

  Future onNoFaces() async {}

  //------------------------------------- SET PREDICTION -------------------------------------

  Future setPrediction({@required CameraImage image}) async {
    if (faces.length > 0) {
      // print("#################   RecognizeProcess -->  setPrediction()");

      predictedData = await usecaseSetPrediction(image, faces.last);
      var point = "";
    }
  }
}
