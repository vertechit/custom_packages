import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home.imports.dart';
import 'home.controller.dart';

class HomeView extends StatelessWidget {
  HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("POC Reconhecimento Facial"),
      ),
      body: Container(
        width: w * 100,
        height: h * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            Container(
              width: w * 80,
              child: Image.asset("assets/images/logo.png"),
            ),

            const SizedBox(
              height: 45,
            ),

            //
            Container(
              width: w * 80,
              height: 60,
              child: RaisedButton(
                onPressed: () {
                  // Get.to(LoginView());
                  controller.auth();
                },
                color: Colors.blue,
                // color: Colors.grey[50],
                child: const Text(
                  "Acessar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: w * 80,
              height: 60,
              child: RaisedButton(
                onPressed: () {
                  // FlutterRecognize().register();
                  controller.register();
                },
                // color: Colors.grey[50],
                color: Colors.blue,
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(
              width: w * 80,
              height: 60,
              child: RaisedButton(
                onLongPress: () {
                  DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
                  _dataBaseHelper.deleteAll();
                  Get.snackbar("Todos os usuários foram excluídos!", "");
                },
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("Limpar usuários cadastrados"),
                        SizedBox(height: 2),
                        Text(
                          "(Pressione e segure p/ limpar)",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            //

            const SizedBox(
              height: 32,
            ),

            //--------------------------------------------------------

            Container(
              width: w * 100,
              // height: h * 20,
              margin: EdgeInsets.only(left: w * 9.8, right: w * 9.8),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[200]),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200].withOpacity(0.8),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(1.8, 1.8), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Esse aplicativo é uma POC (prova de conceito), com o especifico objetivo de testar o funcionamento do reconhecimento facial nos diversos aparelhos existentes no mercado.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      // color: Colors.grey[400],
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Para testar, realize os seguintes passos: \n 1. Pressione o botão 'Cadastrar' para realizar o cadastro de um usuário. Ao detectar um rosto, o botão 'Registrar' será habilitado; pressione esse botão para concluir o cadastro. \n 2. Pressione 'acessar' para fazer o login; após fazer o login, é exibido o nome do usuário que acessou.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.2,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            //

            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
