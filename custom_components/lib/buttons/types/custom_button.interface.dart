import 'package:flutter/material.dart';

import '../buttons.imports.dart';

abstract class ICustomButtom extends StatelessWidget {
  //

  ButtonsPreferences preferences;

  ICustomButtom({
    this.preferences,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Press Me"),
      onPressed: () {
        //
        print("TESTE BOTAO !!!!");
      },
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }
}
