import 'package:firebase_auth/firebase_auth.dart';

import '../v2.imports.dart';

class FirebaseAuthClient extends AuthClient {
  //
  ///[** Futuramente, essa classe podera conter o firebaseRepository por exemplo, dessa forma nao vai ser ]
  ///[ necessario configurar o repository nos controllers de login e cadastro, pois ao definir o AuthClient tudo ]
  /// [ isso será configuradod e forma automatica ]

  @override
  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
