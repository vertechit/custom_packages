import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PopupAuthInstructions {
  double w;
  double h;

  CameraLensDirection currentDirection;

  // PopupChangeCameraDirectionController controller;

  // PopupAuthInstructions({
  //   @required this.currentDirection,
  // }) {
  //   controller = PopupChangeCameraDirectionController(currentDirection: currentDirection);
  // }

  //====================================================== SHOW ======================================================

  Future<CameraLensDirection> show() async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (BuildContext context) {
        h = MediaQuery.of(context).size.height / 100;
        w = MediaQuery.of(context).size.width / 100;

        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // contentPadding: EdgeInsets.zero
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.5),
          child: Container(
            child: Stack(
              children: [
                ///[****************************** OUT TAP ****************************]
                ///
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      Get.context,
                      currentDirection,
                    );
                  },
                  child: Container(
                    width: w * 100,
                    height: h * 100,
                    color: Colors.transparent,
                  ),
                ),

                ///[******************************** BODY ******************************]
                ///
                body(),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      return val;
    });
  }

  Widget body() {
    return Container(
      width: w * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: w * 85,
            // height: h * 30,
            padding: EdgeInsets.only(
              left: w * 5,
              right: w * 5,
              // top: 6,
              top: w * 5,
              bottom: w * 5,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Instruções reconhecimento facial",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 23.sp,
                    color: Colors.grey[800],
                    // fontFamily: "Nunito",
                  ),
                ),
                SizedBox(
                  height: h * 3.5,
                ),
                Text(
                  "Em caso de dificuldades na leitura do rosto, siga as instruções abaixo.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey,
                    fontFamily: "Nunito",
                  ),
                ),

                SizedBox(
                  height: h * 5,
                ),

                containerInstruction(
                  "Boa iluminação",
                  "Fique em uma área com boa iluminação, de modo que o rosto fique bem destacado em relação ao fundo.",
                ),

                SizedBox(
                  height: h * 3,
                ),

                containerInstruction(
                  "Olhe direto para a câmera.",
                  "Segure o aparelho na altura dos olhos e olhe diretamente para a tela do dispositivo.",
                ),

                SizedBox(
                  height: h * 3,
                ),

                containerInstruction(
                  "Enquandre o rosto na tela.",
                  "Aproxime o rosto do aparelho, de modo que o rosto ocupe o espaço inteiro da tela.",
                ),
                //
              ],
            ),
          ),
        ],
      ),
    );
  }

  int idInstruction = 0;

  Widget containerInstruction(String titulo, String text) {
    idInstruction++;
    return Container(
      width: w * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF01579B),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  idInstruction.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: w * 2),
              Text(
                titulo,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.5),
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17.sp,
            ),
          ),
        ],
      ),
    );
  }
}
