import 'package:flutter/material.dart';

import '../web_app.imports.dart';

class PageArea extends StatelessWidget {
  Widget child;
  PageArea({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return Container(
      width: w * 100,
      height: null,
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Colors.brown,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300].withOpacity(0.4),
            spreadRadius: 0.6,
            blurRadius: 4,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
