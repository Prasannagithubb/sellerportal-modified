import 'dart:collection';

import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/services/pages/inventory/item_stocks&price/getall_stocks&prices_api.dart';
import 'package:flowkit/services/pages/setups/getall_store_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:get/get.dart';

class StocksandPriceController extends MyController {
  @override
  void onInit() {
    clearall();
    callstoreApi();
    // TODoreApi();
    // TODoreApi();
    super.onInit();
  }

  bool isLoad = false;
  String? valueStore;
  List<GetAllStoreData> storealldata = [];
  List<GetAllStoreData> filterStorealldata = [];
  List<GetAllStocksPriceData> datalist = [];
  List<GetAllStocksPriceData> filterDatalist = [];

  callapi(String storeid) async {
    datalist = [];
    filterDatalist = [];
    isLoad = true;
    update();
    await GetAllStocksPriceApi.callapi(storeid).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        datalist = onValue.data!;
        filterDatalist = datalist;
        update();
      } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
        Get.dialog(AlertBox(msg: '${onValue.rescode} ${onValue.resDesc}'));
      } else {
        Get.dialog(AlertBox(msg: '${onValue.resDesc}'));
      }
    });
    isLoad = false;
    update();
  }

  clearall() {
    print('clearall pressed');
    storealldata.clear();
    filterStorealldata.clear();
    datalist.clear();
    filterDatalist.clear();
    valueStore = null;
    update();
  }

  callstoreApi() async {
    storealldata = [];
    filterStorealldata = [];
    valueStore = null;
    update();
    await GetAllStoreApi.callapi().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        List<GetAllStoreData> storealldata2 = onValue.data;

        storealldata =
            LinkedHashSet<GetAllStoreData>.from(storealldata2).toList();
        filterStorealldata = storealldata;

        update();
      } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
        Get.dialog(AlertBox(
          msg: '${onValue.rescode} ${onValue.resDesc}..!!',
        ));
      } else {
        Get.dialog(AlertBox(
          msg: '${onValue.resDesc}..!!',
        ));
      }
    });
    update();
  }

  filterItemCode(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where((e) => e.itemCode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }

  filterItemName(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where((e) => e.itemName!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }

  filterStoreCode(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where((e) => e.storeCode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }

  filterStoreStock(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where((e) => e.storeStock!
              .toString()
              .toUpperCase()
              .contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }

  filterWarecode(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where((e) => e.whseCode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }

  filterWarestock(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where((e) =>
              e.whseStock!.toString().toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }

  filterMRP(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where((e) =>
              e.mrp!.toString().toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }

  filterCost(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where((e) =>
              e.cost.toString().toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }

  filterSP(String val) async {
    if (val.isNotEmpty) {
      filterDatalist = datalist
          .where(
              (e) => e.sp.toString().toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterDatalist = datalist;
      update();
    }
  }
}
