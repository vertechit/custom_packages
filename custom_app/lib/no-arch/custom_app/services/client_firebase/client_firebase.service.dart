import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ClientFirebase {
  final databaseReference = FirebaseDatabase.instance.reference();

  ///[========================================== READ ==========================================]

  Future read({@required String endPoint}) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var dados = await ref.child(endPoint).once().then((DataSnapshot snapshot) async {
      return snapshot.value;
    }).timeout(Duration(seconds: 4), onTimeout: () async {
      // timeout
    }).onError((error, stackTrace) {
      // error
    });
    return dados;
  }

  ///[========================================= UPDATE ==========================================]

  Future update() async {
    //
  }

  ///[=========================================== SET ============================================]

  Future set() async {
    //
  }
}
