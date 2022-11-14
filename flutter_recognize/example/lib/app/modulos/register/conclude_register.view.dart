import 'package:flutter/material.dart';

import '../modulos.imports.dart';

class ConcludeRegisterView extends StatelessWidget {
  RegisterController controller;

  ConcludeRegisterView({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Container(
          width: w * 100,
          height: h * 100,
          padding: EdgeInsets.only(left: w * 10, right: w * 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Concluir cadastro",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: h * 18,
              ),
              TextFormField(
                // obscureText: isPassword,
                controller: controller.usernameInput,
                decoration: const InputDecoration(
                  // border: InputBorder.none,
                  hintText: "Nome do usuário",
                ),
                validator: (value) {
                  if (value == "") {
                    return "Informe o nome do usuário!";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: h * 18,
              ),
              Container(
                width: w * 100,
                height: 58,
                child: RaisedButton(
                  onPressed: controller.concludeRegister,
                  color: Colors.blue,
                  child: Text("Concluir cadastro"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
