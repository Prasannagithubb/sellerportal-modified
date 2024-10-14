import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/services/pages/presales/outstandings/getoutstanding_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:get/get.dart';

class OutstandingsController extends MyController {
  @override
  void onInit() {
    callApi();
    // TODO: implement onInit
    super.onInit();
  }

  List<OutstandingMaster>? itemdata = [];
  List<OutstandingMaster>? filterItemdata = [];
  bool isLoad = false;
  callApi() async {
    isLoad = true;
    update();
    await GetOutstandingsApi.callapi().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        filterItemdata = onValue.itemdata!.masterData;
        update();
      } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
        Get.dialog(AlertBox(msg: "${onValue.rescode} ${onValue.exception}"));
      } else {
        Get.dialog(AlertBox(msg: "${onValue.rescode} ${onValue.exception}"));
      }
    });
    isLoad = false;
    update();
  }

  filterCustomerCode(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.customerCode!
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }

  filterCustomerName(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.customerName!
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }

  filterStoreName(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) =>
              e.storeCode!.toString().toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }

  filterUserName(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.assigntoUsername!
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }

  filterTransAmount(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.transAmount!
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }

  filterPenaltyDue(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.penaltyAfterDue!
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }

  filterCollectionInc(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.collectionInc!
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }

  filterAmountPaid(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.amountPaid!
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }

  filterBalance(String val) {
    if (val.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.balancetoPay!
              .toString()
              .toLowerCase()
              .contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterItemdata = itemdata;
      update();
    }
  }
}
