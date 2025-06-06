import 'dart:convert' show json;
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorageService {
  ///[================================ VALOR ================================]
  ///
  Future<void> delete({required String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.remove(key);
  }

  Future<dynamic> get({required String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.get(key);
  }

  Future<void> put({required String key, required dynamic value}) async {
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

  Future getList({required String key}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var data = shared.get(key);

    if (data != null) {
      Iterable decoded = json.decode(data as String);
      var result = decoded;
      return result;
    } else {
      return null;
    }
  }

  //--------- SALVAR LISTA ---------

  Future putList({required String key, list}) async {
    var shared = await SharedPreferences.getInstance();
    await shared.setString(key, json.encode(list));
  }
}
