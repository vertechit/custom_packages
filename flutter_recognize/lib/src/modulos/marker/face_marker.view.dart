import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../src.imports.dart';

class FaceMarker extends StatefulWidget {
  RecognizeProcess recognizeProcess;

  FaceMarker({
    @required this.recognizeProcess,
  });

  @override
  State<FaceMarker> createState() => _FaceMarkerState();
}

class _FaceMarkerState extends State<FaceMarker> {
  Color markerColorOnFace = Colors.green.withOpacity(0.5);
  Color markerColorWithoutFace = Colors.red.withOpacity(0.5);

  Color markerColor;

  final GlobalKey _containerKey = GlobalKey();

  // bool buildComplete = false;

  bool faceDetected = false;

  Face face;

  List<Face> facesList = [];

  RenderBox box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());
  }

  void afterBuild() {
    // buildComplete = true;

    RenderBox box = _containerKey.currentContext.findRenderObject() as RenderBox;

    this.box = box;

    if (box.hasSize == false) {
      return;
    }

    Offset position = box?.localToGlobal(Offset.zero);
    if (position != null) {
      var x = position.dx;
    }

    if (faceDetected) {
      double faceRight = face.boundingBox.right;
      double faceLeft = face.boundingBox.left;

      var point = "";
    }
  }

  Future updateScreen() async {}

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Obx(() {
      bool faceDetected = widget.recognizeProcess.faceDeteced.value;

      facesList = widget.recognizeProcess.rxFaces.value;

      if (facesList.length > 0) face = facesList?.last;

      if (faceDetected == false) {
        markerColor = markerColorWithoutFace;
      }

      if (box?.hasSize == true) {
        Offset position = box?.localToGlobal(Offset.zero);
        if (position != null) {
          var x = position.dx;

          // print("Container MAX WIDTH: " + box.constraints.maxWidth.toString());
          // print("Container DY: " + position.dy.toString());
        }

        if (faceDetected) {
          double faceRight = face.boundingBox.right;
          double faceLeft = face.boundingBox.left;

          // print("FACE - Right: " + face.boundingBox.right.toString());
          // print("FACE - Left: " + face.boundingBox.left.toString());
          // print("FACE - Top: " + face.boundingBox.top.toString());
          // print("FACE - Bottom: " + face.boundingBox.bottom.toString());

          print("----------------------------------");

          // print("FACE - CENTER RIGHT: " + face.boundingBox.centerRight.toString());

          // print("FACE - WIDTH: " + face.boundingBox.width.toString());
          // print("MARKER - WIDTH: " + (w * 80).toString());

          print("----------------------------------");

          var finalLeft = face.boundingBox.left / position.dx;
          // var finalWidth = face.boundingBox.width / (w * 80);
          var finalRight = face.boundingBox.right / position.dx;

          print(">>>>>>> VALORES:  " + "LEFT: " + finalLeft.toString() + "  /  RIGHT:" + finalRight.toString());

          if (finalLeft > 0.10 && finalLeft < 1.9) {
            if (finalRight > 5.5 && finalRight < 6.0) {
              markerColor = markerColorOnFace;
            } else {
              markerColor = markerColorWithoutFace;
            }
          } else {
            markerColor = markerColorWithoutFace;
          }

          print("----------------------------------");

          var point = "";
        }
      }

      // if (faceDetected == true) {
      //   markerColor = markerColorOnFace;
      // } else {
      //   markerColor = markerColorWithoutFace;
      // }

      return Center(
        child: Container(
          width: w * 80,
          child: AspectRatio(
            // aspectRatio: 3 / 4.4,
            aspectRatio: 3 / 4.1,
            child: Container(
              key: _containerKey,
              // width: w * 80,
              // height: w * 95,
              width: w * 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: markerColor,
                  width: w * 2.6,
                ),
              ),
            ),
          ),
        ),
      );
    });

    // return Center(
    //   child: Container(
    //     key: _containerKey,
    //     width: w * 80,
    //     height: w * 95,
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //         color: markerColor,
    //         width: w * 4,
    //       ),
    //     ),
    //   ),
    // );
  }
}
