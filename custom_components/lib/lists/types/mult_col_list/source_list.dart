import 'package:flutter/material.dart';

import 'mult_col_list.imports.dart';

///[=======================================================================================================================]
///                                                 [-- INTERFACE --]

abstract class ISourceList {
  //
  List<MultColListItem> outputList;

  Future mountList();
}

///[=======================================================================================================================]
///                                                   [-- MODELS --]
class SetSourceList implements ISourceList {
  //
  List<Widget> sourceList;

  SetSourceList({
    this.sourceList,
  });

  @override
  List<MultColListItem> outputList;

  @override
  Future mountList() async {
    for (Widget sourceItem in sourceList) {
      outputList.add(
        MultColListItem(
          clicked: false,
          itemChild: sourceItem,
        ),
      );
    }
  }
}

class AutomatedSourceList implements ISourceList {
  //
  String prefixPath;
  String suffixPath;
  int qtdItems;
  Widget Function(Widget) itemFrame;

  AutomatedSourceList({
    this.prefixPath,
    this.suffixPath,
    this.qtdItems,
    this.itemFrame,
  });

  @override
  List<MultColListItem> outputList = [];

  @override
  Future mountList() async {
    int i = 0;
    for (i = 0; i <= qtdItems;) {
      String currentPath = prefixPath + i.toString() + suffixPath;
      outputList.add(
        MultColListItem(
          clicked: false,
          // itemChild: Image.asset(currentPath),
          itemChild: itemFrame(Image.asset(currentPath)),
        ),
      );
      i++;
    }
  }
}
