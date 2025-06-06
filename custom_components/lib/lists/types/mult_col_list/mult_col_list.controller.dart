
import 'package:get/get.dart';
// import 'package:seg_list/seg_list.dart';

import 'mult_col_list.imports.dart';

class MultColListController extends GetxController {
  //
  // List<MultColListItem> listItems = List<MultColListItem>().obs;
  var listItems = <MultColListItem>[].obs;

  @override
  get getList => listItems;

  ISourceList sourceList;

  @override
  // ListPreferences listPreferences = ListPreferences(
  //   persistenceKey: "mult_col_list_",
  //   // tipoItemLista: NetItem(),
  //   // jsonToDartMethod: JsonToDartNet().convert,
  //   persistLocalData: false,
  // );

  ///[=================== CONSTRUTOR ===================]

  MultColListController({
    required this.sourceList,
  }) {
    // super.listUtils.listRef = getList;
    // super.listUtils.listPreferences = listPreferences;
    // super.listUtils.resetList = resetList;
  }

  ///[=========================================== METODOS ===========================================]

  ///[---------------------------- INIT COMPONENT ----------------------------]
  ///
  Future initComponent() async {
    await _mountList();
  }

  ///[----------------------------- MONTAR LISTA -----------------------------]

  Future _mountList() async {
    List<MultColListItem> tempList = [];
    // for (Widget sourceItem in sourceList) {
    //   tempList.add(
    //     MultColListItem(
    //       clicked: false,
    //       itemChild: sourceItem,
    //     ),
    //   );
    // }

    await sourceList.mountList();
    tempList = sourceList.outputList!;

    listItems.value = tempList;

    // for (MultColListItem tempItem in tempList) listItems.add(tempItem);
  }

  ///[---------------------------- ON CLICK ITEM -----------------------------]

  Future onClickItem(int index) async {
    for (MultColListItem item in listItems) {
      item.clicked = false;
    }
    listItems[index].clicked = true;
    //-----------
    var tempList = [];
    for (var itemOficialList in listItems) {
      tempList.add(itemOficialList);
    }
    listItems.clear();
    for (var itemNew in tempList) listItems.add(itemNew);

    // UpdateListComplete updateList = await listUtils.updateGetXV2(listItems);
  }

  ///[------------------------ GERADOR DE LISTA FONTE ------------------------]

  Future _automatedGenerateSourceList() async {
    //
  }
}
