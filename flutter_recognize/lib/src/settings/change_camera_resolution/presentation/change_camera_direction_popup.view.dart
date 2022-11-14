import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../settings.imports.dart';

class PopupChangeCameraResolution {
  double w;
  double h;

  // CameraLensDirection currentDirection;

  PopupChangeCameraDirectionController controller;

  PopupChangeCameraResolution() {
    controller = PopupChangeCameraDirectionController();
  }

  //====================================================== SHOW ======================================================

  Future<CameraLensDirection> show() async {
    return await showDialog(
      barrierDismissible: true,
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
                    Navigator.pop(context);
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
              left: w * 4.4,
              right: w * 4.4,
              // top: 6,
              top: w * 4,
              bottom: w * 4,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alterar posição da câmera",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 21.sp,
                    color: Colors.grey[800],
                    fontFamily: "Nunito",
                  ),
                ),
                Text(
                  "Defina qual câmera será utilizada na batida de ponto.",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.grey,
                    fontFamily: "Nunito",
                  ),
                ),
                //
                SizedBox(height: 20),
                //
                radioRow(displayTxt: "Frontal", optionValue: SelectOptions.frontal.name),
                radioRow(displayTxt: "Traseira", optionValue: SelectOptions.traseira.name),
                //
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget radioRow({String displayTxt, String optionValue}) {
    return Obx(() {
      return Row(
        children: [
          Radio<String>(
            fillColor: MaterialStateColor.resolveWith((states) => const Color(0xFF01579B)),
            focusColor: MaterialStateColor.resolveWith((states) => const Color(0xFF01579B)),
            activeColor: Colors.grey[700],
            value: optionValue,
            groupValue: controller.selectAtualValue.value,
            onChanged: (String value) {
              controller.selectAtualValue.value = optionValue;
              controller.onSelectOption();
            },
          ),
          Text(displayTxt),
        ],
      );
    });
  }
}
