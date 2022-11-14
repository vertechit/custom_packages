import 'package:flutter/material.dart';

import '../../custom_app.imports.dart';
import '../web_app.imports.dart';

// import '../../../lib.imports.dart';

///INTERFACE
abstract class WebAppModulo extends AppModulo {
  int idModulo;

  // ////[***OBSOLET***]
  // MenuPreferences menuPreferences; //// V1

  MenuPiece menuPiece; //// V2

  // @override
  // WebModuloView get view;

  WebModuleView get view;
}
