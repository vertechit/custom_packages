import 'package:flutter/material.dart';

///[___________________________________________________________________________________________________________________________]
///[___________________________________________________________________________________________________________________________]
///                                                         [ V1 ]
///
///[MODEL:]
class MenuPreferences {
  bool? activeMenu; ///// [ ** Analisar mudar para 'inserirPaginaNoMenu']
  String? menuTitle;
  late int menuSequence;
  MenuPreferences({
    this.activeMenu,
    this.menuTitle,
  });
}

///[___________________________________________________________________________________________________________________________]
///[___________________________________________________________________________________________________________________________]
///                                                          [ V2 ]

enum MenuPieceType {
  ApartButton,
  DivButton,
  // Div, ** Desabilitado pq agora as divisoes sao configuradas de forma diferente
}

class MenuPiece {
  ///[=================== VARIAVEIS ===================]

  late MenuPieceType menuPieceType;
  late int divId; //// Id de referencia para uma divisao do menu
  // String divTitle;
  late String buttonTitle; //// Titulo do botao ( label )
  int? menuPos; //// Posicao que o item vai ficar dentro do menu
  IconData? icon;

  ///[=================== CONSTRUTOR ===================]

  ///------- APART BUTTON -------
  ///
  //Construtor para criar um item clicavel no menu
  MenuPiece.apartButton({
    required this.buttonTitle,
    this.menuPos,
    this.icon,
  }) {
    if (buttonTitle == null) throw ("ERRO: O parametro 'buttonTitle' é obrigatório");
    menuPieceType = MenuPieceType.ApartButton;
  }

  ///-------- DIV BUTTON --------
  ///
  //Construtor para criar um item clicavel que fica dentro de uma divisao do menu
  MenuPiece.divButton({
    required this.buttonTitle,
    required this.divId,
    this.icon,
  }) {
    if (buttonTitle == null) throw ("ERRO: O parametro 'buttonTitle' é obrigatório");
    if (divId == null) throw ("ERRO: O parametro 'divId' é obrigatório");
    menuPieceType = MenuPieceType.DivButton;
  }

  ///------------ DIV ------------
  ///
  ///Construtor para criar uma divisao no menu ( DESABILITADO PQ A DIVISAO AGORA Ë CONFIGURADA DE FORMA DIFERENTE)

  // MenuPiece.div({
  //   required this.divId,
  //   this.menuPos,
  //   this.divTitle,
  // }) {
  //   if (divId == null) throw ("ERRO: O parametro 'divId' é obrigatório.");
  //   if (divTitle == null) throw ("ERRO: O parametro 'divTitle' é obrigatório.");
  //   menuPieceType = MenuPieceType.Div;
  // }
}

///[___________________________________________________________________________________________________________________________]
///[___________________________________________________________________________________________________________________________]
///                                                          [ V3 ]
