import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mult_col_list.imports.dart';

class MultColList extends StatelessWidget {
  //
  late MultColListController controller;

  MultColListPreferences? preferences;

  Function? onClickItem;

  List imagesPathList = [
    "assets/images/avatar/user/user1.jpg",
    "assets/images/avatar/user/lima_1.jpeg",
  ];

  // ISourceList sourceList;

  MultColList({
    required ISourceList sourceList,
    this.preferences,
    this.onClickItem,
  }) {
    controller = Get.put(MultColListController(sourceList: sourceList));

    controller.initComponent();
  }

  late double w;
  late double h;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      body: Container(
          width: w * 100,
          height: h * 100,
          // color: Style().colors.primary,//
          color: preferences!.backgroundPageColor,
          child: GetX<MultColListController>(
            builder: (controller) {
              List<MultColListItem> listItems = controller.listItems;

              if (listItems.length == 0) {
                return Container();
              } else {
                return GridView.count(
                  // crossAxisCount is the number of columns
                  childAspectRatio: (1 / 0.8),
                  crossAxisCount: 2,
                  children: List.generate(listItems.length, (index) {
                    return Center(
                      child: imageBox(index, listItems[index]),
                    );
                  }),
                );
              }
            },
          )

          // Obx(() {
          //   List<MultColListItem> listItems = controller.listItems;

          //   if (listItems.length == 0) {
          //     return Container();
          //   } else {
          //     return GridView.count(
          //       // crossAxisCount is the number of columns
          //       crossAxisCount: 2,
          //       // This creates two columns with two items in each column
          //       children: List.generate(listItems.length, (index) {
          //         return Center(
          //           child: imageBox(index, listItems[index]),
          //         );
          //       }),
          //     );
          //   }
          // }),
          ),
    );
  }

  Widget imageBox(int index, MultColListItem item) {
    BoxDecoration? decoration;
    if (item.clicked == true) decoration = preferences!.clickedDecoration;
    if (item.clicked == false) decoration = preferences!.defaultDecoration;

    return GestureDetector(
      onTap: () {
        controller.onClickItem(index);
        onClickItem!(index);
      },
      child: Stack(
        children: [
          //----- CHILD ----
          Container(
            width: w * 32,
            height: w * 32,
            child: item.itemChild,
            decoration: BoxDecoration(
              borderRadius: decoration!.borderRadius,
              color: decoration!.color,
            ),
          ),
          //-- DECORATION --
          Container(
            width: w * 32,
            height: w * 32,
            decoration: BoxDecoration(
              borderRadius: decoration!.borderRadius,
              border: decoration!.border,
            ),
          ),
        ],
      ),
    );
  }
}
