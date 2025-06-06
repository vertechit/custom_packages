import 'package:flutter/material.dart';

///[============================== ITEMS ==============================]
class ISession {
  String? sessionId;
  String? sessionDate;
  ISession({
    this.sessionId,
    this.sessionDate,
  });
}

//-- Lista de sessions padroes ---
class DefaultSessions {
  static const NEW_SESSION = 'new_session';
}

///[========================= SESSION MANAGER =========================]
class AppSession {
  static final AppSession instance = AppSession._();

  AppSession._() {}

  late ISession atualSession;

  //--------------- MANUSEAR SESSAO ----------------

  //---- ATUALIZAR SESSAO ATUAL ----

  Future updateSession(ISession session) async {
    atualSession = session;
  }

  //--- RECUPERAR ULTIMA SESSAO ---

  Future recoverLastSession() async {
    // return ISession(
    //   sessionId: "layer.lobby",
    //   sessionDate: "27/02/2021",
    // );
    return ISession(
      sessionId: "layer.game",
      sessionDate: "27/02/2021",
    );
  }

  //------------------- CONTEXT --------------------

  BuildContext? _currentContext;
  set currentContext(BuildContext context) {
    _currentContext = context;
  }

  BuildContext get currentContext {
    if (_currentContext == null) throw ("ERRO: currentIndex = null / DETALHES: todos os widgets devem passar o seu context para o app session");
    return _currentContext!;
  }
}
