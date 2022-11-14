import 'dart:convert';

class UserModel {
  String nome;
  String id;
  String tokenJwt;
  String user;
  String pass;

  UserModel({this.nome, this.id, this.tokenJwt, this.user, this.pass});

  // String get nome => _nome;
  // set nome(String nome) => _nome = nome;
  // String get id => _id;
  // set id(String id) => _id = id;
  // String get tokenJwt => _tokenJwt;
  // set tokenJwt(String tokenJwt) => _tokenJwt = tokenJwt;
  // String get user => _user;
  // set user(String user) => _user = user;
  // String get pass => _pass;
  // set pass(String pass) => _pass = pass;

  // UserModel.fromJson(Map<String, dynamic> json) {
  //   _nome = json['nome'];
  //   _id = json['id'];
  //   _tokenJwt = json['tokenJwt'];
  //   _user = json['user'];
  //   _pass = json['pass'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['nome'] = this._nome;
  //   data['id'] = this._id;
  //   data['tokenJwt'] = this._tokenJwt;
  //   data['user'] = this._user;
  //   data['pass'] = this._pass;
  //   return data;
  // }

  Future convertFromDatabase(var databaseData) async {
    //
  }

  Future convertFromMap(var databaseData) async {
    return UserModel(
      nome: databaseData["nome"],
      id: databaseData["id"],
      pass: databaseData["pass"],
      user: databaseData["user"],
      tokenJwt: databaseData["tokenJwt"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'id': id,
      'tokenJwt': tokenJwt,
      'user': user,
      'pass': pass,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'],
      id: map['id'],
      tokenJwt: map['tokenJwt'],
      user: map['user'],
      pass: map['pass'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
