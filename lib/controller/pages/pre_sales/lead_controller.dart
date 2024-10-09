import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/presales/enquiry/getenquiry_api.dart';
import 'package:flowkit/services/pages/presales/leads/getleads_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LeadController extends MyController {
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
  List<GetLeadsData>? filteddata = [];
  List<GetLeadsData>? dataList = [];

  calApi() async {
    isLoad = true;
    filteddata = [];
    dataList = [];
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      update();
      await GetLeadsDetails.call(data['fromdate'], data['todate'])
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          dataList = onValue.data;
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

  filterLeadId(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.leadDocEntry!
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

  filterLeadDate(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where(
              (e) => e.createdDate!.toLowerCase().contains(val.toLowerCase()))
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
          .where((e) => e.storecode!.toLowerCase().contains(val.toLowerCase()))
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

  filterCustomerMobile(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.mobile!.toLowerCase().contains(val.toLowerCase()))
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
          .where((e) => e.add1!.toLowerCase().contains(val.toLowerCase()))
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

  filterArea(String val) {
    if (val.isNotEmpty) {
      filteddata = dataList!
          .where((e) => e.area!.toLowerCase().contains(val.toLowerCase()))
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
          .where((e) =>
              e.pincode!.toString().toLowerCase().contains(val.toLowerCase()))
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
          .where((e) => e.city!.toLowerCase().contains(val.toLowerCase()))
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
          .where((e) => e.state!.toLowerCase().contains(val.toLowerCase()))
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
          .where((e) => e.status!.toLowerCase().contains(val.toLowerCase()))
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
