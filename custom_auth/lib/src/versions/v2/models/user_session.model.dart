import 'dart:convert' show json;

import '../../../src.imports.dart';
import '../v2.imports.dart';

///[Descricao: Classe responsavel por controlar a secao do usuario ]

///[========================================================== MASTER CLASSS ==========================================================]
///[===================================================================================================================================]
///
class UserSessionModel {
  ///[=================== VARIAVEIS ===================]
  ///
  var _userModel = UserModel();
  get user => _userModel;
  bool _isAuthenticate = false;
  late UserSessionPersistence sessionPersistence;
  AuthPreferences authPreferences;

  ///[=================== CONSTRUTOR ===================]

  UserSessionModel({
    required this.authPreferences,
  }) {
    sessionPersistence = UserSessionPersistence(authPreferences: authPreferences);
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  ///[-------- AUTENTICAR USUARIO ---------]
  ///
  Future authenticateUser(var userData) async {
    _userModel = userData;
    _isAuthenticate = true;
    await sessionPersistence.savePersistence(userData: userData, status: _isAuthenticate);
  }

  ///[-------- DESCONECTAR USUARIO --------]

  Future disconnectUser() async {
    await authPreferences.authClient.logout();
    _userModel = UserModel();
    _isAuthenticate = false;
    await sessionPersistence.savePersistence(userData: authPreferences.userModel, status: _isAuthenticate);
  }

  ///[--------- RECUPERAR SESSAO ----------]

  Future recoverSession() async {
    RecoverItem recoverItem = await sessionPersistence.recoverPersistence();
    _isAuthenticate = recoverItem.status;
    _userModel = recoverItem.userData;
  }

  ///[----------- SALVAR SESSAO -----------]

  Future saveSession() async {
    await sessionPersistence.savePersistence(userData: user, status: _isAuthenticate);
  }

  ///[--- VERIFICAR STATUS AUTENTICACAO ---]

  Future checkAuthStatus() async {
    if (_isAuthenticate == true) return AuthStatus.logged;
    if (_isAuthenticate == false) return AuthStatus.unLogged;
  }
}

///[======================================================= SESSION PERSISTENCE =======================================================]
///[===================================================================================================================================]

//Item retornado ao recuperar dados da sessao
class RecoverItem {
  bool status;
  var userData;
  RecoverItem({
    required this.status,
    this.userData,
  });
}

class UserSessionPersistence {
  //
  String userDataStorageKey = "session_userData_";
  String sessionStatusStorageKey = "session_status_";
  AuthPreferences authPreferences;

  UserSessionPersistence({
    required this.authPreferences,
  });

  ///[===== PERSISTIR DADOS =====]

  Future savePersistence({required bool status, required var userData}) async {
    await _saveSessionStatus(status);
    await _saveUserData(userData);
  }

  ///[===== RECUPERAR DADOS =====]

  Future<RecoverItem> recoverPersistence() async {
    bool status = await _recoverSessionStatus();
    if (status == false) return RecoverItem(status: status, userData: UserModel());
    var userData = await _recoverUserData();
    return RecoverItem(status: status, userData: userData);
  }

  ///==================== STATUS SESSAO =====================

  Future _saveSessionStatus(bool status) async {
    await SharedStorageService().put(key: sessionStatusStorageKey, value: status);
  }

  Future _recoverSessionStatus() async {
    bool status = await SharedStorageService().get(key: sessionStatusStorageKey);
    if (status == null) status = false;
    return status;
  }

  ///=================== DADOS DO USUARIO ===================

  ///--- SALVAR DADOS USUARIO ----
  ///
  // Future _saveUserData(var userData) async {
  //   var jsonData = jsonEncode(userData);
  //   await SharedStorageService().put(key: userDataStorageKey, value: jsonData);
  // }

  Future _saveUserData(var userData) async {
    // var jsonData = jsonEncode(userData);
    Map<String, dynamic> data = userData.toMap();
    var jsonData = json.encode(data);
    await SharedStorageService().put(key: userDataStorageKey, value: jsonData);
  }

  ///-- RECUPERAR DADOS USUARIO ---
  ///
  Future _recoverUserData() async {
    //

    var localData = await SharedStorageService().get(key: userDataStorageKey);
    var dados = json.decode(localData);
    // UserModel dadosUser = UserModel(
    //   id: dadosJson["id"],
    //   tokenJwt: dadosJson["tokenJwt"],
    //   nome: dadosJson["nome"],
    //   user: dadosJson["user"],
    //   pass: dadosJson["pass"],
    // );
    var dadosUser = await authPreferences.userModel.convertFromMap(dados);
    return dadosUser;

    //____________________________________//

    // var localData = await SharedStorageService().get(key: userDataStorageKey);
    // var dadosJson = jsonDecode(localData);
    // // var dadosJson = await authPreferences.userModel.toMap();

    // // UserModel dadosUser2 = UserModel(
    // //   id: dadosJson["id"],
    // //   tokenJwt: dadosJson["tokenJwt"],
    // //   nome: dadosJson["nome"],
    // //   user: dadosJson["user"],
    // //   pass: dadosJson["pass"],
    // // );

    // var dadosUser = await authPreferences.userModel.convertFromMap(dadosJson);
    // return dadosUser;
  }
}
