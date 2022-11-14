import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import '../../src.imports.dart';

class RegisterControlView extends StatelessWidget {
  Future Function() onClickRegister;
  IRegister usecaseRegister;
  RegisterControlView({
    @required this.onClickRegister,
    @required this.usecaseRegister,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;
    // return Obx(() {
    //   bool faceDetected = usecaseRegister.faceDeteced.value;

    return Container(
      width: w * 100,
      height: h * 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          //-------------------- MARKER --------------------

          // FaceMarker(
          //   // faceDetected: faceDetected,
          //   recognizeProcess: usecaseRegister,
          // ),

          // Container(
          //   padding: EdgeInsets.all(30),
          //   decoration: ShapeDecoration(
          //     shape: OverlayShape(
          //         // cutOutSize: w*
          //         ),
          //   ),
          // ),

          //----- FACE PAINTER -----

          // Obx(() {
          //   bool faceDetected = usecaseRegister.faceDeteced.value;
          //   if (faceDetected) {
          //     final painter = FaceDetectorPainter(
          //       usecaseRegister.rxFaces.value,
          //       usecaseRegister.usecaseDetectFace.inputImage.inputImageData.size,
          //       usecaseRegister.usecaseDetectFace.inputImage.inputImageData.imageRotation,
          //     );

          //     return CustomPaint(painter: painter);
          //   } else {
          //     return Container();
          //   }
          // }),

          //---------------- BOTAO REGISTRAR ----------------
          Obx(() {
            bool faceDetected = usecaseRegister.faceDeteced.value;
            var p = "";
            return Positioned(
              bottom: h * 5,
              child: Container(
                width: w * 100,
                height: 65,
                padding: EdgeInsets.only(left: w * 14, right: w * 14),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  color: const Color(0xFF01579B),
                  child: const Text(
                    "Registrar",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: faceDetected ? onClickRegister : null,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// class FaceDetectorPainter extends CustomPainter {
//   FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

//   final List<Face> faces;
//   final Size absoluteImageSize;
//   final InputImageRotation rotation;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0
//       ..color = Colors.red;

//     for (final Face face in faces) {
//       // print("####################### DESENHAR ###################");
//       canvas.drawRect(
//         Rect.fromLTRB(
//           translateX(face.boundingBox.left, rotation, size, absoluteImageSize),
//           translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
//           translateX(face.boundingBox.right, rotation, size, absoluteImageSize),
//           translateY(face.boundingBox.bottom, rotation, size, absoluteImageSize),
//         ),
//         paint,
//       );

//       // void paintContour(FaceContourType type) {
//       //   final faceContour = face.contours[type];
//       //   if (faceContour?.points != null) {
//       //     for ( Point point in faceContour.points) {
//       //       canvas.drawCircle(
//       //           Offset(
//       //             translateX(
//       //                 point.x.toDouble(), rotation, size, absoluteImageSize),
//       //             translateY(
//       //                 point.y.toDouble(), rotation, size, absoluteImageSize),
//       //           ),
//       //           1,
//       //           paint);
//       //     }
//       //   }
//       // }

//       // paintContour(FaceContourType.face);
//       // paintContour(FaceContourType.leftEyebrowTop);
//       // paintContour(FaceContourType.leftEyebrowBottom);
//       // paintContour(FaceContourType.rightEyebrowTop);
//       // paintContour(FaceContourType.rightEyebrowBottom);
//       // paintContour(FaceContourType.leftEye);
//       // paintContour(FaceContourType.rightEye);
//       // paintContour(FaceContourType.upperLipTop);
//       // paintContour(FaceContourType.upperLipBottom);
//       // paintContour(FaceContourType.lowerLipTop);
//       // paintContour(FaceContourType.lowerLipBottom);
//       // paintContour(FaceContourType.noseBridge);
//       // paintContour(FaceContourType.noseBottom);
//       // paintContour(FaceContourType.leftCheek);
//       // paintContour(FaceContourType.rightCheek);
//     }
//   }

//   @override
//   bool shouldRepaint(FaceDetectorPainter oldDelegate) {
//     return oldDelegate.absoluteImageSize != absoluteImageSize || oldDelegate.faces != faces;
//   }
// }

// double translateX(double x, InputImageRotation rotation, Size size, Size absoluteImageSize) {
//   switch (rotation) {
//     case InputImageRotation.rotation90deg:
//       return x * size.width / (Platform.isIOS ? absoluteImageSize.width : absoluteImageSize.height);
//     case InputImageRotation.rotation270deg:
//       return size.width - x * size.width / (Platform.isIOS ? absoluteImageSize.width : absoluteImageSize.height);
//     default:
//       return x * size.width / absoluteImageSize.width;
//   }
// }

// double translateY(double y, InputImageRotation rotation, Size size, Size absoluteImageSize) {
//   switch (rotation) {
//     case InputImageRotation.rotation90deg:
//     case InputImageRotation.rotation270deg:
//       return y * size.height / (Platform.isIOS ? absoluteImageSize.height : absoluteImageSize.width);
//     default:
//       return y * size.height / absoluteImageSize.height;
//   }
// }

// class OverlayShape extends ShapeBorder {
//   OverlayShape({
//     this.borderColor = Colors.red,
//     this.borderWidth = 3.0,
//     this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
//     this.borderRadius = 0,
//     this.borderLength = 40,
//     this.cutOutSize = 250,
//     this.cutOutBottomOffset = 0,
//   }) : assert(cutOutSize != null ?? cutOutSize != null ?? borderLength <= cutOutSize / 2 + borderWidth * 2, "Border can't be larger than ${cutOutSize / 2 + borderWidth * 2}");

//   final Color borderColor;
//   final double borderWidth;
//   final Color overlayColor;
//   final double borderRadius;
//   final double borderLength;
//   final double cutOutSize;
//   final double cutOutBottomOffset;

//   @override
//   EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

//   @override
//   Path getInnerPath(Rect rect, {TextDirection textDirection}) {
//     return Path()
//       ..fillType = PathFillType.evenOdd
//       ..addPath(getOuterPath(rect), Offset.zero);
//   }

//   @override
//   Path getOuterPath(Rect rect, {TextDirection textDirection}) {
//     Path _getLeftTopPath(Rect rect) {
//       return Path()
//         ..moveTo(rect.left, rect.bottom)
//         ..lineTo(rect.left, rect.top)
//         ..lineTo(rect.right, rect.top);
//     }

//     return _getLeftTopPath(rect)
//       ..lineTo(
//         rect.right,
//         rect.bottom,
//       )
//       ..lineTo(
//         rect.left,
//         rect.bottom,
//       )
//       ..lineTo(
//         rect.left,
//         rect.top,
//       );
//   }

//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
//     final width = rect.width;
//     final borderWidthSize = width / 2;
//     final height = rect.height;
//     final borderOffset = borderWidth / 2;
//     final _borderLength = borderLength > cutOutSize / 2 + borderWidth * 2 ? borderWidthSize / 2 : borderLength;
//     final _cutOutSize = cutOutSize != null && cutOutSize < width ? cutOutSize : width - borderOffset;

//     final backgroundPaint = Paint()
//       ..color = overlayColor
//       ..style = PaintingStyle.fill;

//     final borderPaint = Paint()
//       ..color = borderColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = borderWidth;

//     final boxPaint = Paint()
//       ..color = borderColor
//       ..style = PaintingStyle.fill
//       ..blendMode = BlendMode.dstOut;

//     final cutOutRect = Rect.fromLTWH(
//       rect.left + width / 2 - _cutOutSize / 2 + borderOffset,
//       -cutOutBottomOffset + rect.top + height / 2 - _cutOutSize / 2 + borderOffset,
//       _cutOutSize - borderOffset * 2,
//       _cutOutSize - borderOffset * 2,
//     );

//     canvas
//       ..saveLayer(
//         rect,
//         backgroundPaint,
//       )
//       ..drawRect(
//         rect,
//         backgroundPaint,
//       )
//       // Draw top right corner
//       ..drawRRect(
//         RRect.fromLTRBAndCorners(
//           cutOutRect.right - _borderLength,
//           cutOutRect.top,
//           cutOutRect.right,
//           cutOutRect.top + _borderLength,
//           topRight: Radius.circular(borderRadius),
//         ),
//         borderPaint,
//       )
//       // Draw top left corner
//       ..drawRRect(
//         RRect.fromLTRBAndCorners(
//           cutOutRect.left,
//           cutOutRect.top,
//           cutOutRect.left + _borderLength,
//           cutOutRect.top + _borderLength,
//           topLeft: Radius.circular(borderRadius),
//         ),
//         borderPaint,
//       )
//       // Draw bottom right corner
//       ..drawRRect(
//         RRect.fromLTRBAndCorners(
//           cutOutRect.right - _borderLength,
//           cutOutRect.bottom - _borderLength,
//           cutOutRect.right,
//           cutOutRect.bottom,
//           bottomRight: Radius.circular(borderRadius),
//         ),
//         borderPaint,
//       )
//       // Draw bottom left corner
//       ..drawRRect(
//         RRect.fromLTRBAndCorners(
//           cutOutRect.left,
//           cutOutRect.bottom - _borderLength,
//           cutOutRect.left + _borderLength,
//           cutOutRect.bottom,
//           bottomLeft: Radius.circular(borderRadius),
//         ),
//         borderPaint,
//       )
//       ..drawRRect(
//         RRect.fromRectAndRadius(
//           cutOutRect,
//           Radius.circular(borderRadius),
//         ),
//         boxPaint,
//       )
//       ..restore();
//   }

//   @override
//   ShapeBorder scale(double t) {
//     return OverlayShape(
//       borderColor: borderColor,
//       borderWidth: borderWidth,
//       overlayColor: overlayColor,
//     );
//   }
// }
