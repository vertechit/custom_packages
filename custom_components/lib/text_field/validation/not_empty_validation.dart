import 'validation.imports.dart';

class NotEmptyValidation implements ITextFieldValidation {
  @override
  Function(String validationFailTxt) onValidationFail;

  ///Texto exibido quando a validação for reprovada. ( Exemplo "Esse campo não pode ser vazio")
  ///Esse texto é recebido via metodo construtor no momento de utilização da validação
  @override
  String validationFailTxt;

  @override
  String defaultValidationFailTxt = "Esse campo deve ser preenchido";

  NotEmptyValidation({
    this.onValidationFail,
    this.validationFailTxt,
  }) {
    if (validationFailTxt == null) validationFailTxt = defaultValidationFailTxt;
  }

  @override
  String call(String fieldTxt) {
    print("metodo call() da classe NotEmptyValidation() disparado!!!! ");

    if (fieldTxt.isNotEmpty) {
      print("AAAAAAAA");
      return null;
    } else {
      print("BBBBBBBB");
      onValidationFail(validationFailTxt);
      return validationFailTxt;
    }
  }
}
