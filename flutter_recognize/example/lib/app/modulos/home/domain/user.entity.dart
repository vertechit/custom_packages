import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_recognize/src/src.imports.dart';

class User implements UserRecognize {
  @override
  int id;
  String user;
  String password;
  @override
  List prediction;

  User({
    @required this.user,
    @required this.password,
    @required this.prediction,
    this.id,
  }) {
    if (id == null) id = DateTime.now().millisecondsSinceEpoch;
  }

  static User fromMap(Map<String, dynamic> user) {
    return User(
      id: user['id'],
      user: user['user'],
      password: user['password'],
      prediction: jsonDecode(user['prediction']),
    );
  }

  toMap() {
    return {
      'id': id,
      'user': user,
      'password': password,
      'prediction': jsonEncode(prediction),
    };
  }

  @override
  int timestampLastDetection;
}
