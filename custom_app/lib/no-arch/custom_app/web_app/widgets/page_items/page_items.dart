class PageItem {
  String? nome;
  IPageItem? type;
  bool? dropLine;
}

abstract class IPageItem {
  //
}

/// Segregacao de interface, criando uma interface mais especifica para items de formulario ( possui parametro largura, etc ).
abstract class IFormPageItem {
  //
}

/*========================================= TEXT FIELD ========================================= */
