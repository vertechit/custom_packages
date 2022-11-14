import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src.imports.dart';
import '../auth.imports.dart';

class AuthControlView extends StatelessWidget {
  IAuth usecaseAuth;
  double w;
  double h;

  double emergencyButtonMarginTop = 0;

  AuthControlView({
    @required this.usecaseAuth,
    this.emergencyButtonMarginTop,
  });

  //======================================================= WIDGET BUILD =======================================================
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width / 100;
    h = MediaQuery.of(context).size.height / 100;

    if (emergencyButtonMarginTop == null) {
      emergencyButtonMarginTop = h * 17.8;
    }

    return Container(
      width: w * 100,
      height: h * 100,
      child: Stack(
        children: [
          //
          Obx(() {
            if (usecaseAuth.faceDeteced.value == true) {
              if (usecaseAuth.authComplete.value == true) {
                return cardTrabalhadorIdentificado();
              } else {
                if (usecaseAuth.showEmergencyButton.value == false) {
                  return cardIdentificandoTrabalhador();
                }
              }
            }
            return Container();
          }),

          Obx(() {
            if (usecaseAuth.showEmergencyButton.value) {
              // return Positioned(
              //   top: emergencyButtonMarginTop,
              //   right: 19.5,
              //   child: FloatingActionButton(
              //     elevation: 0,
              //     onPressed: usecaseAuth.onClickEmergencyButton,
              //     backgroundColor: Colors.black.withOpacity(0.45),
              //     child: const Icon(
              //       Icons.warning,
              //     ),
              //   ),
              // );

              return Positioned(
                bottom: h * 4.5,
                child: FalhaIdentificacao(
                  onClickViaMatricula: usecaseAuth.onClickEmergency,
                ),
              );
            } else {
              return Container();
            }
          }),

          Positioned(
            top: emergencyButtonMarginTop + 20,
            right: 19.5,
            child: FloatingActionButton(
              onPressed: PopupAuthInstructions().show,
              elevation: 0,
              backgroundColor: Colors.black.withOpacity(0.45),
              child: const Icon(
                Icons.info_outline_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //======================================================= CARD IDENTIFICANDO =======================================================

  Widget cardIdentificandoTrabalhador() {
    return Positioned(
      bottom: h * 3.4,
      child: Container(
        width: w * 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: w * 72,
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 32, 32).withOpacity(0.65),
                borderRadius: const BorderRadius.all(Radius.circular(55)),
              ),
              child: Center(
                child: Text(
                  "Identificando trabalhador...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=================================================== CARD TRABALHADOR IDENTIFICADO ===================================================

  Widget cardTrabalhadorIdentificado() {
    return Positioned(
      bottom: h * 2.2,
      child: Container(
        width: w * 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: w * 80,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 75, 161, 78).withOpacity(0.55),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 4),
                    child: const Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const Text(
                    "Identificado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: w * 4),
                    child: SizedBox(width: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
