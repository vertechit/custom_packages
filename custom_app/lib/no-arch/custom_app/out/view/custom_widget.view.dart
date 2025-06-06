import 'package:flutter/material.dart';

import '../out.imports.dart';

abstract class CustomWidgetRequireds {
  CustomAppController? appController;
}

abstract class CustomWidget extends StatelessWidget implements CustomWidgetRequireds {
  //
  double? _w;
  get w => _w;
  double? _h;
  get h => _h;

  @override
  Widget build(BuildContext context) {
    //appController.navigation.currentContext = context;

    _h = MediaQuery.of(context).size.height / 100;
    _w = MediaQuery.of(context).size.width / 100;
    return viewWidget(context);
  }

  Widget viewWidget(BuildContext context) {
    return Container(width: w * 100, height: h * 100, color: Colors.orange);
  }
}
