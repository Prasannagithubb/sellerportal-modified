import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/user_configuration/getSiteIn&Out_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiteInOutController extends MyController {
  @override
  void onInit() {
    // TODO: implement onInit
    validator();
    super.onInit();
  }

  validator() {
    basicValidator.addField('fromdate',
        required: true, controller: TextEditingController());
    basicValidator.addField('todate',
        required: true, controller: TextEditingController());
    refresh();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<GetSiteInoutData>? getSiteinoutData = [];
  List<GetSiteInoutData>? filterGetSiteinoutData = [];
  MyFormValidator basicValidator = MyFormValidator();

  bool isLoad = false;
  calApi() async {
    isLoad = true;
    getSiteinoutData = [];
    filterGetSiteinoutData = [];
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      update();
      await GetSiteinOutApi.call(data['fromdate'], data['todate'])
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          getSiteinoutData = onValue.data;
          filterGetSiteinoutData = getSiteinoutData;
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

  filterUserCode(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.userCode!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterUserNAme(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.userName!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterCustomermobile(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.mobileNo!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterMail(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.customerEmail!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterCustomerName(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.customerName!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterCheckInLoaction(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.checkinAdd!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterCheckOutLocation(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.checkoutAdd!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterCheckOutLat(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.checkOutlat!.toString().contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterCheckOutLong(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.checkoutlong.toString().contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterPurposeofVisit(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.purposeOfvisit!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterLookingfor(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.lookingFor!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterVisitoutComes(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.visitOutcome!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterCheckinDate(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.checkinDateAndTime!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }

  filterCheckOutDate(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetSiteinoutData = getSiteinoutData!
          .where((e) => e.checkoutDateTime!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterGetSiteinoutData = getSiteinoutData;
      update();
    }
  }
}
