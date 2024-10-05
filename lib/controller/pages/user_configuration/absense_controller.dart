import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/user_configuration/getAbsenceList_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbsenseController extends MyController {
  @override
  void onInit() {
    validator();
    super.onInit();
  }

  validator() {
    basicValidator.addField('date',
        required: true, controller: TextEditingController());

    refresh();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<GetAbsenseData>? getabsenseData = [];
  List<GetAbsenseData>? filtergetabsenseData = [];
  MyFormValidator basicValidator = MyFormValidator();

  bool isLoad = false;
  calApi() async {
    isLoad = true;
    getabsenseData = [];
    filtergetabsenseData = [];
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      update();
      await GetAbsenseListApi.call(data['date']).then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          getabsenseData = onValue.data;
          filtergetabsenseData = getabsenseData;
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
      filtergetabsenseData = getabsenseData!
          .where((e) => e.userCode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filtergetabsenseData = getabsenseData;
      update();
    }
  }

  filterUserNAme(
    String val,
  ) {
    if (val.isNotEmpty) {
      filtergetabsenseData = getabsenseData!
          .where((e) => e.userName!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filtergetabsenseData = getabsenseData;
      update();
    }
  }
}
