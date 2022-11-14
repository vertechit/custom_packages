import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SelectOptions {
  frontal,
  traseira,
}

class PopupChangeCameraDirectionController {
  //
  RxString selectAtualValue = "".obs;

  PopupChangeCameraDirectionController({
    @required CameraLensDirection currentDirection,
  }) {
    selectAtualValue.value = getStringByEnum(enumDirection: currentDirection);
  }

  String getStringByEnum({@required CameraLensDirection enumDirection}) {
    if (enumDirection == CameraLensDirection.front) {
      return SelectOptions.frontal.name;
    } else if (enumDirection == CameraLensDirection.back) {
      return SelectOptions.traseira.name;
    } else {
      return SelectOptions.frontal.name;
    }
  }

  CameraLensDirection getEnumByString({@required String stringDirection}) {
    if (stringDirection == SelectOptions.frontal.name) {
      return CameraLensDirection.front;
    } else if (stringDirection == SelectOptions.traseira.name) {
      return CameraLensDirection.back;
    }
    return CameraLensDirection.front;
  }

  Future onSelectOption() async {
    Navigator.pop(
      Get.context,
      getEnumByString(stringDirection: selectAtualValue.value),
    );
  }
}
///
///
///
///
///
///
  // CheckBoxOption optionFrontal = CheckBoxOption(
  //   displayText: "Frontal",
  //   selected: false,
  // );

  // CheckBoxOption optionTraseira = CheckBoxOption(
  //   displayText: "Traseira",
  //   selected: false,
  // );

// class CheckBoxOption {
//   RxString displayText;
//   RxBool selected;
//   CheckBoxOption({
//     @required String displayText,
//     @required bool selected,
//   }) {
//     this.displayText.value = displayText;
//     this.selected.value = selected;
//   }
// }
