import 'package:flutter/material.dart';

class CleanListBody extends StatelessWidget {
  Widget Function(BuildContext context, int index) listBuilder;
  int listLenght;

  CleanListBody({
    required this.listBuilder,
    required this.listLenght,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return listBuilder(context, index);

          //------------------------------------------------------
          //                         CHILD
          // if (index < netList.length) {
          //   return Container(
          //     child: Column(
          //       children: [
          //         Text(netList[index].nome),
          //         Obx(() {
          //           Net netItem = netListController.netList[index];
          //           return Text(
          //             "Status proximidade: " + netItem.bleData.inRange.toString(),
          //           );
          //         }),
          //       ],
          //     ),
          //   );

          //   // return NetCardV2Widget(
          //   //   controller: null,
          //   //   listItem: netList[index],
          //   //   index: index,
          //   // );
          // } else {
          //   return Container();
          // }

          //------------------------------------------------------
        },
        childCount: listLenght,
      ),
    );
  }
}
