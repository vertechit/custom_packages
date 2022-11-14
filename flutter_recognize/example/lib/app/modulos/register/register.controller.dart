import 'package:flutter/material.dart';
import 'package:flutter_recognize/src/src.imports.dart';
import '../../app.imports.dart';
import 'package:get/get.dart';

class RegisterController {
  //

  final formKey = GlobalKey<FormState>();

  TextEditingController usernameInput = TextEditingController();

  List facePrediction;

  //---------- INIT ------------

  Future init() async {
    //

    startRegisterProcess();

    return true;
  }

  //----- START REGISTER -------

  Future startRegisterProcess() async {
    await Future.delayed(const Duration(milliseconds: 1800), () {});

    facePrediction = await getFacePrediction();

    if (facePrediction.isEmpty) {
      Get.offAll(
        HomeView(),
      );
      return;
    }

    Get.offAll(
      ConcludeRegisterView(
        controller: this,
      ),
    );
  }

  //------ GET PREDICTION -------

  Future getFacePrediction() async {
    List prediction = await FlutterRecognize.instance.register();
    return prediction;
  }

  //----- CONCLUIR REGISTRO ------

  Future concludeRegister() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState.validate() == false) {
      return;
    }

    DatabaseHelper _databaseHelper = DatabaseHelper.instance;

    List<User> users = await _databaseHelper.queryAllUsers();

    for (User user in users) {
      if (user.user == usernameInput.text) {
        Get.snackbar("Erro!", "Ja tem um usuário cadastrado com esse nome.");
        return;
      }
    }

    // List predictedData = _mlService.predictedData;
    String user = usernameInput.text;
    String password = "123";

    User userToSave = User(
      user: user,
      password: password,
      prediction: facePrediction,
    );

    await _databaseHelper.insert(userToSave);

    //- SHOW LOAD -
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: Get.context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                // Some text
                Text('Carregando...')
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(milliseconds: 1800), () {});

    Get.offAll(HomeView());

    await Future.delayed(const Duration(milliseconds: 200), () {
      Get.snackbar("Sucesso", 'Cadastro realizado com sucesso!');
    });
  }
}
