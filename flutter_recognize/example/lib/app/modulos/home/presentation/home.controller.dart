import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modulos.imports.dart';
import '../home.imports.dart';

import 'package:flutter_recognize/src/src.imports.dart';

class HomeController {
  //

  Future register() async {
    Get.to(RegisterView());
  }

  Future auth() async {
    showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                Text('Carregando...')
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(milliseconds: 1800), () {});

    DatabaseHelper _dbHelper = DatabaseHelper.instance;
    List<User> users = await _dbHelper.queryAllUsers();
    var p = "";
    User userResult = await FlutterRecognize.instance.auth(users: users);

    if (userResult != null) {
      Get.to(
        AcessoRealizadoView(nomeUsuario: userResult.user),
      );
    }
  }
}
