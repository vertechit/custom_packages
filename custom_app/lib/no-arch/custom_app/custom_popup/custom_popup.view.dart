//Defini o estilo do popup

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custom_app.imports.dart';
import 'custom_popup.imports.dart';

//Model usado quando não foi passado um PopupStyle customizado
// class PopupDefaultStyle {
//   //
// }

// class NoButton {}

// class OkButton {}

// class ReplyButtons {}

// class CustomButtom {
//   String textButton1;
//   String textButton2;
//   CustomButtom({
//     this.textButton1,
//     this.textButton2,
//   });
// }

//========================================================================================= MASTER CLASS =========================================================================================
//=================================================================================================================================================================================================

class CustomPopup {
  //commit
  ///[OBS1: Transformar essa classe em single instance]
  ///[=================== VARIAVEIS ===================]
  CustomAppController appController = CustomPopupConfig.instance.appController;

  PopupStyle popupStyle = PopupStyle(
    borderRadius: 10.0,
  );

  PopupType type;

  BuildContext _dialogContext;

  bool closeDialogOnPressButton = true; //// Indica se deve fechar o popup ao clicar em um dos botões
  Widget customWidget;

  PopupDecoration decoration;

  //---- TEXTOS -----

  String txtTitle;
  String txtText;

  //---- FUNCTIONS ON CLICK ----
  String txtBtnOk;
  Function onClickOk;
  Function onClickCancel;

  var h;
  var w;

  //----- ICONE -----

  bool hasIcon = true;
  IconData icon;

  BuildContext context;

  ///[=================== CONSTRUTOR ===================]
  CustomPopup({
    @required this.type,
    this.onClickOk,
    this.onClickCancel,
    this.closeDialogOnPressButton,
    this.txtText,
    this.txtTitle,
    this.hasIcon,
    this.icon,
    this.txtBtnOk,
    this.customWidget,
  }) {
    // context = CustomPopupConfig.instance.appController.navigation.currentContext;
    if (CustomPopupConfig.instance.decoration != null) {
      decoration = CustomPopupConfig.instance.decoration;
    } else {
      decoration = PopupDecoration(backgroundColor: Colors.white, titleColor: Colors.grey[600], textColor: Colors.grey[600]);
    }
    if (closeDialogOnPressButton == null) closeDialogOnPressButton = true;
    if (hasIcon == null) hasIcon = false;
    if (icon == null) icon = FontAwesomeIcons.exclamationCircle;
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]
  Future closePopup() async {
    print("FECHAR POPUP!!!!!");
  }

  ///[------------------------------------ SHOW POUP ------------------------------------]
  Future show() async {
    if (CustomPopupConfig.instance.configured == false) {
      throw ("ERRO: Custom Popup deve ser configurado antes de ser usado");
    }

    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        h = MediaQuery.of(context).size.height / 100;
        w = MediaQuery.of(context).size.width / 100;

        _dialogContext = context;
        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // contentPadding: EdgeInsets.zero
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            child: Stack(
              children: [
                ///[****************** OUT TAP ****************]
                GestureDetector(
                  onTap: () {
                    Navigator.pop(_dialogContext);
                  },
                  child: Container(
                    width: w * 100,
                    height: h * 100,
                    color: Colors.transparent,
                  ),
                ),

                ///[*******************************************]
                Container(
                  width: w * 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //----------- POPUP WINDOW STYLE ----------
                        width: w * 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(popupStyle.borderRadius),
                          color: decoration.backgroundColor,
                          // color: Colors.green,
                        ),
                        //-----------------------------------------
                        child: Padding(
                          padding: EdgeInsets.only(top: h * 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //[------------------------------------------ CONTEUDO POPUP ------------------------------------------]

                              ///--- BOTAO FECHAR POPUP ---

                              Container(
                                width: w * 100,
                                height: 40,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: w * 4, top: w * 4),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(_dialogContext);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ///--------- ICON ---------
                              ///
                              hasIcon
                                  ? Container(
                                      margin: EdgeInsets.only(bottom: h * 3.2, top: h * 1),
                                      child: Icon(
                                        icon,
                                        size: w * 25,
                                        color: Colors.grey[200],
                                      ),
                                    )
                                  : Container(),

                              ///--------- TITULO ---------
                              txtTitle != null
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 25),
                                      child: Text(
                                        txtTitle,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600, fontSize: 25, fontFamily: CustomPopupConfig.instance.style.fonts.op1),
                                      ),
                                    )
                                  : Container(),

                              //ESPAÇAMENTO
                              SizedBox(height: h * 1.8),

                              ///--------- TEXTO ---------
                              ///
                              txtText != null
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        // "Ja existe um contato de emergencia utilizando esse número celular",
                                        txtText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.grey[600], fontSize: 20, fontFamily: CustomPopupConfig.instance.style.fonts.op1),
                                      ),
                                    )
                                  : Container(),

                              ///----- CUSTOM WIDGET -----
                              ///
                              customWidget != null ? customWidget : Container(),

                              ///-------- BUTTONS --------
                              Padding(
                                padding: EdgeInsets.only(top: 42),
                                child: makeButtonsArea(),
                              ),

                              //
                              //[----------------------------------------------------------------------------------------------------]
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      // tapClose();
    });
  }

  ///[------------------------------------ MAKE BUTTONS AREA ------------------------------------]
  Widget makeButtonsArea() {
    bool showCancel = false;
    bool showOk = false;
    MainAxisAlignment mainAlign = MainAxisAlignment.center;

    if (type == PopupType.OkButton) {
      showOk = true;
      mainAlign = MainAxisAlignment.center;
    } else if (type == PopupType.ReplyButtons) {
      mainAlign = MainAxisAlignment.spaceBetween;
      showOk = true;
      showCancel = true;
    }

    if (txtBtnOk == null) txtBtnOk = "OK";

    return Container(
      width: w * 100,
      margin: EdgeInsets.symmetric(horizontal: w * 8),
      child: Row(
        mainAxisAlignment: mainAlign,
        children: [
          /// BOTAO OK
          showOk ? popupButton(text: txtBtnOk, bgColor: CustomPopupConfig.instance.style.colors.primary, textColor: Colors.white, onClick: onClickOk) : Container(),

          showCancel ? popupButton(text: "Cancelar", bgColor: Colors.grey[200], textColor: Colors.grey[700], onClick: onClickCancel) : Container(),
        ],
      ),
    );
  }

  ///[------------------------------------ WIDGET ------------------------------------]
  ///
  Widget popupButton({String text, Color bgColor, Color textColor, Function onClick}) {
    double btnWidth = 0;
    double marginBottom = 0;

    if (type == PopupType.OkButton) {
      btnWidth = w * 38;
      marginBottom = w * 8;
    } else if (type == PopupType.ReplyButtons) {
      btnWidth = w * 35;
      marginBottom = w * 8;
    }

    return Container(
      // height: h * 8,
      height: 52,
      margin: EdgeInsets.only(bottom: marginBottom),
      width: btnWidth,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 20.5),
        ),
        color: bgColor,
        onPressed: () {
          if (closeDialogOnPressButton == true) Navigator.pop(_dialogContext);
          if (onClick != null) return onClick();
        },
      ),
    );
  }
}
