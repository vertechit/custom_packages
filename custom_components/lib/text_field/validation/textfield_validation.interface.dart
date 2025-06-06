abstract class ITextFieldValidation {
  //
  ///Metodo que sera disparado quando a validação for reprovada. Por exemplo: funcao accountFormFail() utilizada nos sistemas web
  Function(String validationFailTxt)? onValidationFail;

  ///Texto exibido quando a validação for reprovada. ( Exemplo "Esse campo não pode ser vazio")
  ///Esse texto é recebido via metodo construtor no momento de utilização da validação
  String? validationFailTxt;

  ///Texto default que sera exibido quando a validação for reprovada.
  ///Esse texto é definido dentro da propria classe, sendo utilizado quando a variavel "validationFailTxt" for null
  String? defaultValidationFailTxt;

  // Future _onValidationFail();

  // Future<String> call(String fieldTxt) async {}

  String call(String fieldTxt);
}
