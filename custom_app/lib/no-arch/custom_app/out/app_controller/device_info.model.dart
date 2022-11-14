import '../../custom_app.imports.dart';

class DeviceInfoModel {
  PlatInfoModel platInfo = PlatInfoModel();
  ScreenInfoModel screenInfo = ScreenInfoModel();
  String _tokenPush = "1";
  get tokenPush {
    if (_tokenPush == "") _tokenPush = "token_de_teste";
    return _tokenPush;
  }

  set tokenPush(String token) {
    _tokenPush = token;
    SharedStorageService().put(key: "recover-tokenPush-", value: token);
  }

  String tokenVoip = "123";

  DevicesInfoModel() {
    recoverTokenPush();
  }

  Future recoverTokenPush() async {
    String valueRecover = await SharedStorageService().get(key: "recover-tokenPush-");
    if (valueRecover == null) valueRecover = "";
    tokenPush = valueRecover;
  }
}

class PlatInfoModel {
  String so;
  String version;
  PlatInfoModel({
    this.so,
    this.version,
  });
}

class ScreenInfoModel {
  double width;
  double height;
  ScreenInfoModel({this.width, this.height});
}
