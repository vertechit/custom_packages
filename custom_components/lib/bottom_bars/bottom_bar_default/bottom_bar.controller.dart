import 'package:flutter/material.dart';
import 'package:get/get.dart';

///[========================================================== MODELS ===========================================================]
///[=============================================================================================================================]
class BottomBarItem {
  var id;
  String btnText;
  IconData btnIcon;
  Widget pageWidget;
  BottomBarItem({
    required this.id,
    required this.btnIcon,
    required this.btnText,
    required this.pageWidget,
  });
}

///[======================================================= MASTER CLASS ========================================================]
///[=============================================================================================================================]

class BottomBarController extends GetxController {
  //
  ///[====================== VARIAVEIS ======================]
  int selectedIndex = 0;

  List<BottomBarItem> itensList;
  List<Widget> childrenList = <Widget>[];

  Color selectedItemColor;

  late BottomNavigationBar bottomNavigationWidget;

  ///[====================== CONSTRUTOR ======================]

  BottomBarController({
    required this.itensList,
    required this.selectedItemColor,
  }) {
    mount();
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  void _onItemTapped(int index) {
    selectedIndex = index;
    updateBottomBarIndex();
    update();
  }

  ///[---------------------- Update bottom bar widget ----------------------]
  ///
  Future updateBottomBarIndex() async {
    await buildBottomBarWidget();
  }

  ///[-------------------------------- MOUNT -------------------------------]
  ///
  Future mount() async {
    await buildBottomBarWidget();
    for (BottomBarItem itemBottomBar in itensList) {
      childrenList.add(itemBottomBar.pageWidget);
    }
    return "ok";
  }

  ///[---------------------- BUILD BOTTOM BAR WIDGET ----------------------]

  Future buildBottomBarWidget() async {
    List<BottomNavigationBarItem> items = await buildBottomBarButtons();
    bottomNavigationWidget = BottomNavigationBar(
      items: items,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  ///[---------------------- BUILD BOTTOM BAR BUTTONS ----------------------]

  Future<List<BottomNavigationBarItem>> buildBottomBarButtons() async {
    List<BottomNavigationBarItem> listaRetorno = <BottomNavigationBarItem>[];
    for (BottomBarItem itemBottomBar in itensList) {
      listaRetorno.add(
        BottomNavigationBarItem(
          icon: Icon(itemBottomBar.btnIcon),
          backgroundColor: Colors.green,
          label: itemBottomBar.btnText,
        ),
      );
    }
    return listaRetorno;
  }
}
