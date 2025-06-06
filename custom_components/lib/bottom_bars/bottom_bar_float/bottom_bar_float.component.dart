import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../core.imports.dart';

import 'bottom_bar_float.controller.dart';

class BottomBarFloat extends StatelessWidget {
  //
  ///[=================== VARIAVEIS ===================]
  ///

  late BottomBarFloatController bottomBarController;

  late Future futureFunction;

  BottomBarFloatItem? btnCenter;
  BottomBarFloatItem? btnLeft;
  BottomBarFloatItem? btnRight;

  Color? itemColor;
  Color? selectedItemColor;
  Color? backgroundColor;
  Color? floatButtonBg;
  Color? floatButtonBgSelected;
  Color? floatButtonIconColor;
  Color? floatButtonIconColorSelected;

  ///[=================== CONSTRUTOR ===================]

  BottomBarFloat({
    required this.selectedItemColor,
    this.itemColor,
    this.backgroundColor,
    this.floatButtonBg,
    this.btnCenter,
    this.btnRight,
    this.btnLeft,
    this.floatButtonBgSelected,
    this.floatButtonIconColor,
    this.floatButtonIconColorSelected,
  }) {
    bottomBarController = BottomBarFloatController(
      btnCenter: btnCenter!,
      btnRight: btnRight!,
      btnLeft: btnLeft!,
      selectedItemColor: selectedItemColor!,
    );
    futureFunction = bottomBarController.mount();

    if (backgroundColor == null) backgroundColor = Colors.grey[100];
    if (itemColor == null) itemColor = Colors.grey[100];
    if (floatButtonBg == null) floatButtonBg = Colors.grey[100];
    if (floatButtonBgSelected == null) floatButtonBgSelected = Colors.grey[100];
    if (floatButtonIconColor == null) floatButtonIconColor = Colors.grey[100];
    if (floatButtonIconColorSelected == null) floatButtonIconColorSelected = Colors.grey[100];
  }

  ///[================================================== METODOS ==================================================]
  ///[=============================================================================================================]

  var h;
  var w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return GetBuilder<BottomBarFloatController>(
      init: bottomBarController,
      builder: (bottomBarController) {
        //
        Widget? childBtnCenter;
        if (btnCenter!.btnIcon != null) {
          childBtnCenter = Icon(
            btnCenter!.btnIcon,
            color: bottomBarController.selectedIndex == 1 ? floatButtonIconColorSelected : floatButtonIconColor,
          );
        }
        if (btnCenter!.btnImage != null) {
          childBtnCenter = Container(
            child: bottomBarController.selectedIndex == 1 ? btnCenter!.btnImage!.btnImageSelected : btnCenter!.btnImage!.btnImage,
          );
        }

        return Scaffold(
          ///[======================== BODY ========================]
          ///[======================================================]
          ///
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: Center(
            child: IndexedStack(
              index: bottomBarController.selectedIndex,
              children: bottomBarController.childrenList,
            ),
          ),

          ///[==================== FLOAT BUTTON ====================]
          ///[======================================================]
          ///
          floatingActionButton: Container(
            width: w * 20,
            height: w * 20,
            margin: EdgeInsets.only(bottom: h * 0.2, right: w * 0.5, left: w * 0.5),
            decoration: BoxDecoration(
              color: bottomBarController.selectedIndex == 1 ? floatButtonBgSelected : floatButtonBg,
              borderRadius: BorderRadius.all(
                Radius.circular(200),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.9),
                  spreadRadius: 0.8,
                  blurRadius: 6,
                  offset: Offset(0, -0),
                ),
              ],
            ),
            child: FloatingActionButton(
              backgroundColor: bottomBarController.selectedIndex == 1 ? floatButtonBgSelected : floatButtonBg,
              child: childBtnCenter,
              onPressed: () {
                bottomBarController.onItemTapped(1);
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          // bottomNavigationBar: bottomBarController.bottomNavigationWidget,

          ///[============================================== BOTTOM BAR ==============================================]
          ///[========================================================================================================]
          ///
          bottomNavigationBar: Stack(
            children: [
              ///-------- CAMADA DE SOMBRA -------
              Container(
                height: 70,
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: MyBorderShape(),
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.9),
                      spreadRadius: 0.1,
                      blurRadius: 10,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
              ),

              ///-------- CAMADA BOTTOM BAR -------
              Container(
                color: Colors.transparent,
                child: BottomAppBar(
                  color: backgroundColor,
                  // elevation: 10,
                  shape: CircularNotchedRectangle(),
                  notchMargin: 7,
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ///[========================= BOTTOM BAR BTN 1 ========================]

                        bottomNavBtn(btnIndex: 0, btnIcon: btnLeft!.btnIcon!, btnImage: btnLeft!.btnImage!),

                        ///[========================= BOTTOM BAR BTN 2 ========================]
                        ///
                        bottomNavBtn(btnIndex: 2, btnIcon: btnRight!.btnIcon!, btnImage: btnRight!.btnImage!),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///[=================================== WIDGET BOTAO ===================================]
  ///[====================================================================================]

  Widget bottomNavBtn({required int btnIndex, required IconData btnIcon, required BottomBarFloatImgItem btnImage}) {
    double marginRight = 0;
    double marginLeft = 0;

    if (btnIndex == 0) marginLeft = w * 12;
    if (btnIndex == 2) marginRight = w * 12;

    return GetBuilder<BottomBarFloatController>(
      builder: (bottomBarController) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: marginLeft,
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: () {
                bottomBarController.onItemTapped(btnIndex);
              },
              child: Container(
                // color: Colors.red,
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //
                    Container(
                      width: w * 8,
                      height: w * 8,
                      child: Stack(
                        children: [
                          ///[---- BADGE ----]
                          // Container(
                          //   width: w * 3,
                          //   height: w * 3,
                          //   decoration: new BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Colors.red,
                          //   ),
                          // ),
                          ///[----- ICON -----]
                          Icon(
                            btnIcon,
                            color: bottomBarController.selectedIndex == btnIndex ? selectedItemColor : itemColor,
                            size: w * 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: marginRight,
            ),
          ],
        );
      },
    );
  }
}

class MyBorderShape extends ShapeBorder {
  MyBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => null!;

  double holeSize = 90;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    print(rect.height);
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 12)))
        ..close(),
      Path()
        ..addOval(Rect.fromCenter(center: rect.center.translate(0, -rect.height / 2), height: holeSize, width: holeSize))
        ..close(),
    );

    ///========================================================================
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
