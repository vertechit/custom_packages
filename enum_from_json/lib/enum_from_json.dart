library enum_from_json;

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class EnumFromJson {
  static convert({@required var itemType, @required var value}) {
    var result = EnumToString.fromString(itemType, value.split(".")[1]);
    return result;
  }
}
