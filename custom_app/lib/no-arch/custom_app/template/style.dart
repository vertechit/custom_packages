import 'package:flutter/material.dart';

/// [====================== INTERFACE THEMES ======================]
///
abstract class IStyleTheme {
  String name = "tema1";
  FontOptions fonts;
  ColorsPallets colors;
  BoxDecorationOptions boxDecorations;
  //
}

///[========================== DECORATION ==========================]

class BoxDecorationOptions {
  BoxDecoration op1;
  BoxDecoration op2;
  BoxDecoration op3;
  BoxDecoration op4;
  BoxDecorationOptions({
    this.op1,
    this.op2,
    this.op3,
    this.op4,
  });
}

///[========================= FONT OPTIONS =========================]

class FontOptions {
  String op1;
  String op2;
  String op3;
  String op4;
  String op5;
  String op6;
  String op7;
  String op8;
  String op9;
  String op10;
  FontOptions({
    this.op1,
    this.op2,
    this.op3,
    this.op4,
    this.op5,
    this.op6,
    this.op7,
    this.op8,
    this.op9,
    this.op10,
  });
}

///[==================== MODEL COLORS PALLETS ====================]
///
class ColorsPallets {
  //
  ///[====== PRIMARIA ======]
  Color _primary;
  set primary(Color primary) => _primary;
  Color get primary => _primary;

  ///[===== SECUNDARIA =====]
  Color _secundary;
  set secundary(Color secundary) => _secundary;
  Color get secundary => _secundary;

  ///[===== BACKGROUND 1 =====]
  Color _bg1;
  set bg1(Color bg1) => _bg1;
  Color get bg1 => _bg1;

  ColorsPallets({
    Color primary,
    Color secundary,
    Color bg1,
  }) {
    _primary = primary;
    _secundary = secundary;
    _bg1 = bg1;
  }
}
