import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/user_configuration/getattendenceDetails_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendenceDtsController extends MyController {
  @override
  void onInit() {
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
  List<GetAttendenceData>? getattendenceDtls = [];
  List<GetAttendenceData>? filterGetattendenceDtls = [];
  MyFormValidator basicValidator = MyFormValidator();

  bool isLoad = false;
  calApi() async {
    isLoad = true;
    getattendenceDtls = [];
    filterGetattendenceDtls = [];
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      update();
      await GetAttendenceDtlsApi.call(data['fromdate'], data['todate'])
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          getattendenceDtls = onValue.data;
          filterGetattendenceDtls = getattendenceDtls;
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
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.userCode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterUserNAme(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.userName!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterCustomermobile(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.mobileNo!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterDepartment(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.storeCode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterDesignation(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.userType!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterAttendenceDate(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.attDate!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterStarttime(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.sTime!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterEndTime(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) =>
              e.eTime!.toUpperCase().toString().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterWorkingHrs(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.workingHrs!
              .toUpperCase()
              .toString()
              .contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterStartLocation(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.sLoc!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }

  filterEndLocation(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterGetattendenceDtls = getattendenceDtls!
          .where((e) => e.eLoc!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterGetattendenceDtls = getattendenceDtls;
      update();
    }
  }
}
