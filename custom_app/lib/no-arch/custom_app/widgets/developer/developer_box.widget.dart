import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_app.imports.dart';

class DeveloperBox extends StatelessWidget {
  Widget child;
  DeveloperBox({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;
    return Container(
      width: w * 100,
      height: h * 100,
      child: Stack(
        children: [
          //-------- CHILD --------
          child,

          //------ BOTAO DEBUG ------
          Positioned(
            bottom: 13,
            right: 13,
            child: InkWell(
              onTap: () {
                var context = Get.context;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (ctx) {
                    return Wrap(
                      children: <Widget>[
                        Container(
                          width: w * 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                          ),
                          child: Column(
                            children: [
                              CustomAppConfig.instance.appController.debug.debugPage,
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              radius: 100,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Center(
                  child: Icon(
                    Icons.developer_mode,
                    size: 22,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
