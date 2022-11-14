import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorageService {
  ///[================================ VALOR ================================]
  ///
  Future delete({String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove(key);
  }

  Future get({String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.get(key);
  }

  Future put({String key, dynamic value}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    if (value is bool) {
      shared.setBool(key, value);
    } else if (value is String) {
      shared.setString(key, value);
    } else if (value is int) {
      shared.setInt(key, value);
    } else if (value is double) {
      shared.setDouble(key, value);
    }
  }

  ///[================================ LISTA ================================]

  //----------- LER LISTA -----------

  Future getList({@required String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var data = shared.get(key);

    if (data != null) {
      Iterable decoded = json.decode(data);
      var result = decoded;
      return result;
    } else {
      return null;
    }
  }

  //--------- SALVAR LISTA ---------

  Future putList({@required String key, list}) async {
    var shared = await SharedPreferences.getInstance();
    await shared.setString(key, json.encode(list));
  }
}
