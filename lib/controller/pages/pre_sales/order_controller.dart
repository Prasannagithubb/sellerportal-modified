import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/presales/leads/getleads_api.dart';
import 'package:flowkit/services/pages/presales/orders/getorders_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrdersController extends MyController {
  @override
  void onInit() {
    validator();

    // TODO: implement onInit
    super.onInit();
  }

  MyFormValidator basicValidator = MyFormValidator();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  validator() {
    basicValidator.addField('fromdate',
        required: true, controller: TextEditingController());
    basicValidator.addField('todate',
        required: true, controller: TextEditingController());
    refresh();
  }

  bool isLoad = false;
  List<GetOrdersData>? filteddata = [];
  List<GetOrdersData>? dataList = [];

  calApi() async {
    isLoad = true;
    filteddata = [];
    dataList = [];
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      update();
      await GetOrdersDetails.call(data['fromdate'], data['todate'])
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          dataList = onValue.data!;
          filteddata = dataList;
          update();
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(AlertBox(msg: "${onValue.respCode} ${onValue.respDesc}"));
        } else {
          Get.dialog(AlertBox(msg: " ${onValue.respDesc}"));
        }
      });
    }

    isLoad = false;
    update();
  }

  filterOrderId(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) =>
              e.docEntry!.toString().toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterOrderDate(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.docDate!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterStorename(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.storeCode!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterusername(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.assignedTo!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterCustomername(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where(
              (e) => e.customerName!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterItemName(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.itemName!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterCustomerMobile(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) =>
              e.customerMobile!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterAddress(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where(
              (e) => e.bilAddress1!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterPincode(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.bilPincode!
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
      filteddata = dataList;
      update();
    }
  }

  filterCity(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.bilCity!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterState(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.bilState!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }

  filterStatus(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where(
              (e) => e.orderStatus!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filteddata = dataList;
      update();
    }
  }
}
