import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bottom_bar.controller.dart';

class BottomBarDefault extends StatelessWidget {
  //
  ///[=================== VARIAVEIS ===================]
  ///

  List<BottomBarItem> itensList;
  late BottomBarController bottomBarController;
  Color selectedItemColor;

  late Future futureFunction;

  ///[=================== CONSTRUTOR ===================]

  BottomBarDefault({
    required this.itensList,
    required this.selectedItemColor,
  }) {
    bottomBarController = BottomBarController(
      itensList: itensList,
      selectedItemColor: selectedItemColor,
    );
    futureFunction = bottomBarController.mount();
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureFunction,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetBuilder<BottomBarController>(
            init: bottomBarController,
            builder: (bottomBarController) {
              return Scaffold(
                body: Center(
                  child: IndexedStack(
                    index: bottomBarController.selectedIndex,
                    children: bottomBarController.childrenList,
                  ),
                ),
                bottomNavigationBar: bottomBarController.bottomNavigationWidget,
              );
            },
          );
          // retusrn ContactListView();
        } else {
          return Container();
        }
      },
    );
  }
}
