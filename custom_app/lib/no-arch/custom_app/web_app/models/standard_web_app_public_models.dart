import 'package:flutter/material.dart';

import '../../custom_app.imports.dart';

class WebModuloView {
  PageType type;
  Widget widget;
  var viewConfig;
  WebModuloView({
    this.type,
    this.widget,
  });
}

enum PageType {
  basic,
  modal,
}

class WebModuleView {
  //

  ///[=================== VARIAVEIS ===================]
  ///
  ///
  final Widget widget;

  double width;
  double height;

  final PageType type;

  ///[=================== CONSTRUTOR ===================]

  ///---------- BASIC ----------

  WebModuleView.basic({
    @required this.widget,
  })  : width = 0,
        height = 0,
        type = PageType.basic;

  ///----------- MODAL -----------

  WebModuleView.modal({
    @required this.widget,
    this.width,
    this.height,
  }) : type = PageType.modal {
    if (width == null) width = WebAppConfig.instance.appController.deviceInfo.screenInfo.width * 90;
    if (height == null) height = WebAppConfig.instance.appController.deviceInfo.screenInfo.height * 90;
  }
}
