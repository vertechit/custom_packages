import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modulos.imports.dart';

class AcessoRealizadoView extends StatelessWidget {
  String nomeUsuario = "";

  AcessoRealizadoView({
    @required this.nomeUsuario,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Container(
        width: w * 100,
        height: h * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: const Text(
                "Login realizado com sucesso!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: h * 5,
            ),
            Container(
              child: Text(
                "Bem vindo(a), " + nomeUsuario,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[500],
                ),
              ),
            ),
            SizedBox(
              height: h * 20,
            ),
            Container(
              width: w * 30,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  Get.offAll(HomeView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 2),
                    Text("SAIR"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
