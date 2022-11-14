import 'package:custom_app/lib.imports.dart';
import 'package:custom_auth/src/versions/v2/email_auth/login/login_email.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart' as btn;
import 'login.imports.dart';

class CustomLoginView extends StatefulWidget {
  CustomAppController appController;
  CustomLoginController loginController;
  Decoration pageDecoration = BoxDecoration();
  Widget title = Container();
  Widget get btnAcessar => null;
  @override
  _CustomLoginViewState createState() => _CustomLoginViewState();
}

class _CustomLoginViewState extends State<CustomLoginView> {
  CustomAppController appController;
  CustomLoginController loginController;
  CustomLoginController get _loginController => loginController;
  Decoration pageDecoration = BoxDecoration();
  double spaceBetweenInputs = 20;
  Widget title = Container();

  Widget _btnAcessar;

  set btnAcessar(Widget btn) {
    _btnAcessar = btn;
  }

  Widget get btnAcessar => widget.btnAcessar;

  Future init;

  get formFrame {
    return FormBuilder(
      spaceBetweenInputs: spaceBetweenInputs,
      form: loginController.formHandler,
      inputWidget: appController.components.textFields.primary,
    );
  }

  // CustomLoginView() {
  //   init = _loginController.init();
  //   if (btnAcessar == null) {
  //     btnAcessar = appController.components.buttons.primary(text: "Acessar", onClick: loginController.onClickLogin);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController = widget.loginController;
    appController = widget.appController;
    pageDecoration = widget.pageDecoration;
    title = widget.title;
    // btnAcessar = widget.btnAcessar;
    init = _loginController.init();
    if (btnAcessar == null) {
      btnAcessar = appController.components.buttons.primary(text: "Acessar", onClick: loginController.onClickLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    // appController.navigation.currentContext = context;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: w * 100,
        height: h * 100,
        decoration: pageDecoration,
        child: Stack(
          children: [
            //------- MARCADOR MODO DEBUG -------
            _loginController.loginDebug.debugActive
                ? Positioned(
                    top: 55,
                    right: 20,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red[900],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "DEBUG \n MODE",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : Container(),
            //
            //FUTURE BUILDER
            FutureBuilder(
              future: init,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: h * 100,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //=========================================== BOTAO VOLTAR ===========================================

                          Container(
                            width: w * 100,
                            height: h * 15,
                            // color: Colors.grey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 60, left: 24),
                                  child: Container(
                                    width: w * 100,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // loginController.appController.navigation.back();
                                          },
                                          child: Icon(
                                            Icons.arrow_back_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //=============================================== PAGINA ===============================================

                          Container(
                            width: w * 100,
                            // height: h * 85,
                            // color: Colors.deepOrange,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //
                                //------ ESPACAMENTO ( *** NAO REMOVER ) ------

                                SizedBox(
                                  height: h * 6,
                                ),
                                //-------------- TITLE -------------

                                title,

                                //-------------- FORM -------------
                                // FormBuilder(
                                //   spaceBetweenInputs: spaceBetweenInputs,
                                //   form: loginController.formHandler,
                                //   inputWidget: appController.components.textFields.primary,
                                // ),

                                formFrame,

                                //-------------- BTN ACESSAR -------------

                                Padding(
                                  padding: EdgeInsets.only(top: 42),
                                  child: btnAcessar,
                                ),

                                //----------------- BTNS CADASTRAR ----------------

                                SizedBox(height: h * 6),

                                //---- Cadastrar com email ----
                                Container(
                                  width: w * 100,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // mainAxisAlignment: ,
                                    children: [
                                      Text(
                                        "Não tem uma conta?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.toNamed('/signup');
                                          loginController.onClickSignup();
                                          // AppNavigation.instance.toRoute(AppRoutes.SIGNUP);
                                        },
                                        child: Text(
                                          " Cadastre-se",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h * 6),

                                //---- Cadastrar com redes sociais ----

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: w * 12,
                                      height: h * 5.6,
                                      child: btn.SignInButton(
                                        btn.Buttons.Facebook,
                                        onPressed: () {},
                                        mini: true,
                                      ),
                                    ),
                                    SizedBox(width: w * 4.2),
                                    Container(
                                      width: w * 12,
                                      height: h * 5.6,
                                      child: btn.SignInButton(
                                        btn.Buttons.Twitter,
                                        onPressed: () {},
                                        mini: true,
                                      ),
                                    ),
                                    SizedBox(width: w * 4.2),
                                    Container(
                                      width: w * 12,
                                      height: h * 5.6,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(4.8),
                                        child: Image.asset("assets/images/google.jpg"),
                                      ),
                                    ),
                                  ],
                                ),

                                //------ ESPACAMENTO ( *** NAO REMOVER ) ------

                                SizedBox(
                                  height: h * 6,
                                ),
                                //
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// abstract class CustomLoginView extends CustomWidget {
//   CustomLoginController loginController;
//   CustomLoginController get _loginController => loginController;
//   Decoration pageDecoration = BoxDecoration();
//   double spaceBetweenInputs = 20;
//   Widget title = Container();

//   Widget _btnAcessar;

//   set btnAcessar(Widget btn) {
//     _btnAcessar = btn;
//   }

//   Widget get btnAcessar => null;

//   Future init;

//   get formFrame {
//     return FormBuilder(
//       spaceBetweenInputs: spaceBetweenInputs,
//       form: loginController.formHandler,
//       inputWidget: appController.components.textFields.primary,
//     );
//   }

//   CustomLoginView() {
//     init = _loginController.init();
//     if (btnAcessar == null) {
//       btnAcessar = appController.components.buttons.primary(text: "Acessar", onClick: loginController.onClickLogin);
//     }
//   }

//   @override
//   Widget viewWidget(BuildContext cosntext) {
//     return Container(
//       decoration: pageDecoration,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             //------- MARCADOR MODO DEBUG -------
//             _loginController.loginDebug.debugActive
//                 ? Positioned(
//                     top: 55,
//                     right: 20,
//                     child: Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.red[900],
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           "DEBUG \n MODE",
//                           style: TextStyle(color: Colors.white),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(),
//             //
//             //FUTURE BUILDER
//             FutureBuilder(
//               future: init,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         //=========================================== BOTAO VOLTAR ===========================================

//                         Container(
//                           width: w * 100,
//                           height: h * 15,
//                           // color: Colors.grey,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(top: 50, left: 14),
//                                 child: Container(
//                                   width: w * 100,
//                                   child: Row(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           loginController.appController.navigation.back();
//                                         },
//                                         child: Icon(
//                                           Icons.arrow_back_outlined,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         //=============================================== PAGINA ===============================================

//                         Container(
//                           width: w * 100,
//                           height: h * 85,
//                           // color: Colors.deepOrange,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               //
//                               //-------------- TITLE -------------

//                               title,

//                               //-------------- FORM -------------
//                               // FormBuilder(
//                               //   spaceBetweenInputs: spaceBetweenInputs,
//                               //   form: loginController.formHandler,
//                               //   inputWidget: appController.components.textFields.primary,
//                               // ),

//                               formFrame,

//                               //-------------- BTN ACESSAR -------------

//                               Padding(
//                                 padding: EdgeInsets.only(top: 42),
//                                 child: btnAcessar,
//                               ),

//                               //                         //----------------- BTNS CADASTRAR ----------------

//                               SizedBox(height: h * 6),

//                               //---- Cadastrar com email ----
//                               Container(
//                                 width: w * 100,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   // mainAxisAlignment: ,
//                                   children: [
//                                     Text(
//                                       "Não tem uma conta?",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         // Get.toNamed('/signup');
//                                         loginController.onClickSignup();
//                                         // AppNavigation.instance.toRoute(AppRoutes.SIGNUP);
//                                       },
//                                       child: Text(
//                                         " Cadastre-se",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: h * 6),

//                               //---- Cadastrar com redes sociais ----

//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: w * 12,
//                                     height: h * 5.6,
//                                     child: btn.SignInButton(
//                                       btn.Buttons.Facebook,
//                                       onPressed: () {},
//                                       mini: true,
//                                     ),
//                                   ),
//                                   SizedBox(width: w * 4.2),
//                                   Container(
//                                     width: w * 12,
//                                     height: h * 5.6,
//                                     child: btn.SignInButton(
//                                       btn.Buttons.Twitter,
//                                       onPressed: () {},
//                                       mini: true,
//                                     ),
//                                   ),
//                                   SizedBox(width: w * 4.2),
//                                   Container(
//                                     width: w * 12,
//                                     height: h * 5.6,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(4),
//                                       color: Colors.white,
//                                     ),
//                                     child: Container(
//                                       margin: EdgeInsets.all(4.8),
//                                       child: Image.asset("assets/images/google.jpg"),
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               //------ ESPACAMENTO ( *** NAO REMOVER ) ------

//                               SizedBox(
//                                 height: h * 10,
//                               ),
//                               //
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
