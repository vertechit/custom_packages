import 'dart:convert' show json;

import 'package:flutter/material.dart';

import '../../../src.imports.dart';
import '../v1.imports.dart';

///[Descricao: Classe responsavel por controlar a secao do usuario ]

///[========================================================== MASTER CLASSS ==========================================================]
///[===================================================================================================================================]
///
class UserSessionModel {
  UserModel _userModel = UserModel();
  UserModel get user => _userModel;
  bool _isAuthenticate = false;
  UserSessionPersistence sessionPersistence = UserSessionPersistence();

  ///[-------- AUTENTICAR USUARIO ---------]
  ///
  Future authenticateUser(UserModel userData) async {
    _userModel = userData;
    _isAuthenticate = true;
    await sessionPersistence.savePersistence(userData: userData, status: _isAuthenticate);
  }

  ///[-------- DESCONECTAR USUARIO --------]

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
  UserModel userData;
  RecoverItem({
    this.status,
    this.userData,
  });
}

class UserSessionPersistence {
  //
  String userDataStorageKey = "session_userData_";
  String sessionStatusStorageKey = "session_status_";

  ///[===== PERSISTIR DADOS =====]

  Future savePersistence({@required bool status, @required UserModel userData}) async {
    await _saveSessionStatus(status);
    await _saveUserData(userData);
  }

  ///[===== RECUPERAR DADOS =====]

  Future<RecoverItem> recoverPersistence() async {
    bool status = await _recoverSessionStatus();
    if (status == false) return RecoverItem(status: status, userData: UserModel());
    UserModel userData = await _recoverUserData();
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
  Future _saveUserData(UserModel userData) async {
    var jsonData = json.encode(userData);
    await SharedStorageService().put(key: userDataStorageKey, value: jsonData);
  }

  ///-- RECUPERAR DADOS USUARIO ---
  ///
  Future _recoverUserData() async {
    //
    var localData = await SharedStorageService().get(key: userDataStorageKey);
    var dadosJson = json.decode(localData);
    UserModel dadosUser = UserModel(
      id: dadosJson["id"],
      tokenJwt: dadosJson["tokenJwt"],
      nome: dadosJson["nome"],
      user: dadosJson["user"],
      pass: dadosJson["pass"],
    );
    return dadosUser;
  }
}
