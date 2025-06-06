import 'package:flutter/material.dart';

import 'form.imports.dart';

class FormBuilder extends StatelessWidget {
  FormHandler form;
  Widget Function({required TextEditingController textController, required String hintText, bool isObscure}) inputWidget;
  double spaceBetweenInputs; //// Espaçamento entre cada input. O espaçamento é feito utilizando padding top, e só é aplicado no input de index 1 adiante.

  FormBuilder({
    required this.form,
    required this.inputWidget,
    this.spaceBetweenInputs = 0,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 100;
    var h = MediaQuery.of(context).size.height / 100;
    return Container(
      // width: w * 100,
      // height: h * 100,
      // color: Colors.red,
      child: Form(
        key: form.formKey,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: form.formInputs.length,
          itemBuilder: (context, index) {
            FormInput item = form.formInputs[index];
            double marginTop = 0;
            if (index != 0) marginTop = spaceBetweenInputs;
            return Padding(
              padding: EdgeInsets.only(top: marginTop),
              child: Container(
                width: w * 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    inputWidget(textController: item.controller!, hintText: item.hintText!, isObscure: item.isObscure!),
                    // Components().textFields.textField_Op1(textController: item.controller, hintText: item.hintText),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
