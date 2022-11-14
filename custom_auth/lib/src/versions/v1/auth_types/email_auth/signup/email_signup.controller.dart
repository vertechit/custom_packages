import 'package:custom_auth/src/versions/v1/auth_types/email_auth/signup/models/signup_form.model.dart';

abstract class EmailSignUpRequireds {
  EmailSignUpPreferences signUpPreferences;
}

class EmailSignUpPreferences {
  bool useDefaultFormFields = true;
  List<FormFieldSignup> formFieldList;
  EmailSignUpPreferences({
    this.useDefaultFormFields,
    this.formFieldList,
  }) {
    if (useDefaultFormFields == null) useDefaultFormFields = true;
  }
}

abstract class EmailSignUp implements EmailSignUpRequireds {
  //
  SignUpForm signUpForm;

  EmailSignUp() {
    signUpForm = SignUpForm(formFieldList: signUpPreferences.formFieldList);
  }

  Future startSignUp() async {
    //

    ///[ 1. Validar formulario ]

    ///[ 2. Fazer requisicao ]
  }
}
