import 'package:flutter/material.dart';

abstract class BackButtonWatcher {
  Future onBackButtonTap({@required bool returnRouteStatus});
  int index;
}
