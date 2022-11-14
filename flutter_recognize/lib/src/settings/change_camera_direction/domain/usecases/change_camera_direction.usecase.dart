import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/core.imports.dart';
import '../../presentation/presentation.imports.dart';

abstract class IChangeCameraDirection {
  Future<CameraLensDirection> call({CameraLensDirection currentDirection});
}

class ChangeCameraDirection implements IChangeCameraDirection {
  SharedPreferencesDriver localStorageDriver = SharedPreferencesDriver();

  @override
  Future<CameraLensDirection> call({@required CameraLensDirection currentDirection}) async {
    CameraLensDirection directionSelected = await PopupChangeCameraDirection(currentDirection: currentDirection).show();

    //Persistir nova configuracao localmente
    String storageValue = "";
    if (directionSelected == CameraLensDirection.front) {
      storageValue = "front";
    } else if (directionSelected == CameraLensDirection.back) {
      storageValue = "back";
    }
    await localStorageDriver.put(key: "config_camera_direction", value: storageValue);

    return directionSelected;
  }
  //
}
