import 'package:flutter/material.dart';

import '../login.imports.dart';

class LoginEmailPreferences {
  //

  /// Para app`s baseados em firebase, utilizar a classe FirebaseLoginEmail()
  /// Para app's baseados em api HTTP, utilziar a classe HttpLoginEmail()
  LoginEmailRepository repository;

  LoginEmailPreferences({
    @required this.repository,
  });
}
