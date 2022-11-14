import 'package:flutter/material.dart';

import 'register.imports.dart';

class RegisterView extends StatelessWidget {
  RegisterController controller = RegisterController();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: FutureBuilder(
        future: controller.init(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: w * 100,
              height: h * 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: w * 20,
                    height: w * 20,
                    child: const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }

          return Container();
        },
      ),
    );
  }
}
