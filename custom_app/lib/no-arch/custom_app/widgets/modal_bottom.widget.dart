import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ModalBottomWidget {
  //

  Widget child = Container();

  Future showModal() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Wrap(
          children: <Widget>[
            child,
          ],
        );
      },
    );
  }
}
