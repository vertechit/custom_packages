// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// // import '../../../core.imports.dart';

// import '../../../core.imports.dart';
// import 'bottom_bar_float.controller.dart';

// class BottomBarFloat extends StatelessWidget {
//   //
//   ///[=================== VARIAVEIS ===================]
//   ///

//   BottomBarFloatController bottomBarController;
//   Color selectedItemColor;

//   Future futureFunction;

//   BottomBarFloatItem btnCenter;
//   BottomBarFloatItem btnLeft;
//   BottomBarFloatItem btnRight;

//   ///[=================== CONSTRUTOR ===================]

//   BottomBarFloat({
//     @required this.selectedItemColor,
//     this.btnCenter,
//     this.btnRight,
//     this.btnLeft,
//   }) {
//     bottomBarController = BottomBarFloatController(
//       btnCenter: btnCenter,
//       btnRight: btnRight,
//       btnLeft: btnLeft,
//       selectedItemColor: selectedItemColor,
//     );
//     futureFunction = bottomBarController.mount();
//   }

//   ///[================================================== METODOS ==================================================]
//   ///[=============================================================================================================]

//   var h;
//   var w;

//   @override
//   Widget build(BuildContext context) {
//     h = MediaQuery.of(context).size.height / 100;
//     w = MediaQuery.of(context).size.width / 100;

//     return GetBuilder<BottomBarFloatController>(
//       init: bottomBarController,
//       builder: (bottomBarController) {
//         return Scaffold(
//           ///[======================== BODY ========================]
//           ///[======================================================]
//           ///
//           body: Center(
//             child: IndexedStack(
//               index: bottomBarController.selectedIndex,
//               children: bottomBarController.childrenList,
//             ),
//           ),

//           ///[==================== FLOAT BUTTON ====================]
//           ///[======================================================]
//           ///
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: bottomBarController.selectedIndex == 1 ? Style().colors.secundary : Colors.white,
//             child: Icon(
//               btnCenter.btnIcon,
//               color: bottomBarController.selectedIndex == 1 ? Colors.white : Colors.grey,
//             ),
//             onPressed: () {
//               bottomBarController.onItemTapped(1);
//             },
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//           // bottomNavigationBar: bottomBarController.bottomNavigationWidget,

//           ///[============================================== BOTTOM BAR ==============================================]
//           ///[========================================================================================================]
//           ///
//           bottomNavigationBar: BottomAppBar(
//             shape: CircularNotchedRectangle(),
//             notchMargin: 10,
//             child: Container(
//               height: h * 8,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   //

//                   Padding(
//                     padding: EdgeInsets.only(left: w * 3),
//                     child: Container(
//                       // color: Colors.red,
//                       width: w * 28,
//                       height: w * 10,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // bottomNavBtn2(btnIndex: 0, btnIcon: btnLeft.btnIcon),
//                           // bottomNavBtn2(btnIndex: 2, btnIcon: btnLeft.btnIcon),
//                           bottomNavBtn3(btnIndex: 0, btnIcon: btnLeft.btnIcon),
//                           bottomNavBtn3(btnIndex: 0, btnIcon: btnLeft.btnIcon),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: w * 3),
//                     child: Container(
//                       // color: Colors.red,
//                       width: w * 28,
//                       height: w * 10,
//                     ),
//                   ),

//                   ///[========================= BOTTOM BAR BTN 1 ========================]

//                   // bottomNavBtn(btnIndex: 0, btnIcon: btnLeft.btnIcon),

//                   ///[========================= BOTTOM BAR BTN 2 ========================]
//                   ///
//                   // bottomNavBtn(btnIndex: 2, btnIcon: btnRight.btnIcon),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   ///[=================================== WIDGET BOTAO ===================================]
//   ///[====================================================================================]

//   Widget bottomNavBtn3({@required int btnIndex, @required IconData btnIcon}) {
//     return GetBuilder<BottomBarFloatController>(
//       builder: (bottomBarController) {
//         return GestureDetector(
//           onTap: () {
//             bottomBarController.onItemTapped(btnIndex);
//           },
//           child: Container(
//             width: w * 8,
//             height: w * 8,
//             child: Stack(
//               children: [
//                 Icon(
//                   FontAwesomeIcons.clinicMedical,
//                   color: bottomBarController.selectedIndex == btnIndex ? Style().colors.secundary : Colors.grey,
//                   size: w * 8,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget bottomNavBtn2({@required int btnIndex, @required IconData btnIcon}) {
//     double marginRight = 0;
//     double marginLeft = 0;

//     if (btnIndex == 0) marginLeft = w * 1;
//     if (btnIndex == 2) marginRight = w * 1;

//     return GetBuilder<BottomBarFloatController>(
//       builder: (bottomBarController) {
//         return MaterialButton(
//           // minWidth: 40,
//           onPressed: () {
//             bottomBarController.onItemTapped(btnIndex);
//           },
//           child: Container(
//             width: w * 8,
//             height: w * 8,
//             child: Stack(
//               children: [
//                 ///[---- BADGE ----]
//                 // Container(
//                 //   width: w * 3,
//                 //   height: w * 3,
//                 //   decoration: new BoxDecoration(
//                 //     shape: BoxShape.circle,
//                 //     color: Colors.red,
//                 //   ),
//                 // ),
//                 ///[----- ICON -----]
//                 Icon(
//                   btnIcon,
//                   color: bottomBarController.selectedIndex == btnIndex ? Style().colors.secundary : Colors.grey,
//                   size: w * 8,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget bottomNavBtn({@required int btnIndex, @required IconData btnIcon}) {
//     double marginRight = 0;
//     double marginLeft = 0;

//     if (btnIndex == 0) marginLeft = w * 1;
//     if (btnIndex == 2) marginRight = w * 1;

//     return GetBuilder<BottomBarFloatController>(
//       builder: (bottomBarController) {
//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // SizedBox(
//             //   width: marginLeft,
//             // ),
//             MaterialButton(
//               // minWidth: 40,
//               onPressed: () {
//                 bottomBarController.onItemTapped(btnIndex);
//               },
//               child: Container(
//                 // color: Colors.red,
//                 // height: h * 7,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     //
//                     Container(
//                       width: w * 8,
//                       height: w * 8,
//                       child: Stack(
//                         children: [
//                           ///[---- BADGE ----]
//                           // Container(
//                           //   width: w * 3,
//                           //   height: w * 3,
//                           //   decoration: new BoxDecoration(
//                           //     shape: BoxShape.circle,
//                           //     color: Colors.red,
//                           //   ),
//                           // ),
//                           ///[----- ICON -----]
//                           Icon(
//                             btnIcon,
//                             color: bottomBarController.selectedIndex == btnIndex ? Style().colors.secundary : Colors.grey,
//                             size: w * 8,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // SizedBox(
//             //   width: marginRight,
//             // ),
//           ],
//         );
//       },
//     );
//   }
// }
