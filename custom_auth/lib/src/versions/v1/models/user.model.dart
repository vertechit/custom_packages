class UserModel {
  String _nome;
  String _id;
  String _tokenJwt;
  String _user;
  String _pass;

  UserModel({String nome, String id, String tokenJwt, String user, String pass}) {
    this._nome = nome;
    this._id = id;
    this._tokenJwt = tokenJwt;
    this._user = user;
    this._pass = pass;
  }

  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get id => _id;
  set id(String id) => _id = id;
  String get tokenJwt => _tokenJwt;
  set tokenJwt(String tokenJwt) => _tokenJwt = tokenJwt;
  String get user => _user;
  set user(String user) => _user = user;
  String get pass => _pass;
  set pass(String pass) => _pass = pass;

  UserModel.fromJson(Map<String, dynamic> json) {
    _nome = json['nome'];
    _id = json['id'];
    _tokenJwt = json['tokenJwt'];
    _user = json['user'];
    _pass = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this._nome;
    data['id'] = this._id;
    data['tokenJwt'] = this._tokenJwt;
    data['user'] = this._user;
    data['pass'] = this._pass;
    return data;
  }
}
