//interface
import 'package:flutter/material.dart';

import '../../../v2.imports.dart';

abstract class LoginEmailRepository {
  Future login({@required LoginAttemptCredentials credentials, @required UserModel userModel});
}
