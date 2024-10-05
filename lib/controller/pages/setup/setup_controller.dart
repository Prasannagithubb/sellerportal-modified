import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/setups/setupCommon_addapi.dart';
import 'package:flowkit/services/pages/setups/setupCommon_deleteapi.dart';
import 'package:flowkit/services/pages/setups/setupCommon_getapi.dart';
import 'package:flowkit/services/pages/setups/setupCommon_updateapi.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetUpController extends MyController {
  @override
  void onInit() {
    createValidator();
    super.onInit();
  }

  // final String masterid;
  bool? isLoad = false;
  bool? isLoadAdd = false;
  bool? isLoadUpdated = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  MyFormValidator basicValidator = MyFormValidator();
  List<SetupsCommonData>? datalist;
  List<SetupsCommonData>? get _datalist => datalist;
  List<SetupsCommonData>? filterdatalist = [];
  // SetUpController(this.masterid);
  bool status = true;
  createValidator() {
    basicValidator.addField('code',
        label: "code", required: true, controller: TextEditingController());
    basicValidator.addField('description',
        label: "description",
        required: true,
        controller: TextEditingController());
  }

  clearvalidator() async {
    status = true;
    basicValidator.getController('code')!.clear();
    basicValidator.getController('description')!.clear();

    update();
  }

  changestatus(bool val) {
    print(val);
    status = !status;
    update();
  }

  validateAddMasters(int masterid) async {
    isLoadAdd = true;
    update();
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      await SetupCommonAddApi.callapi(masterid, data['code'],
              data['description'], status == false ? 0 : 1)
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          isLoadUpdated = false;
          update();
          Get.dialog(AlertBox(
            msg: 'Sucessfully Added..!!',
          )).then((onValue) {
            Get.back();
            callApi(masterid.toString());
          });
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(AlertBox(
            msg: '${onValue.message} ${onValue.exception}..!!',
          ));
        } else {
          Get.dialog(AlertBox(
            msg: '${onValue.message} ${onValue.exception}..!!',
          ));
        }
      });
    } else {}
    isLoadAdd = false;
    update();
  }

  validateUpdateMasters(int masterid, int id) async {
    isLoadUpdated = true;
    update();
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      await SetupCommonUpdateApi.callapi(masterid, id, data['code'],
              data['description'], status == false ? 0 : 1)
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          isLoadUpdated = false;
          update();
          Get.dialog(AlertBox(
            msg: 'Updated Sucessfully Added..!!',
          )).then((onValue) {
            Get.back();
            callApi(masterid.toString());
          });
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(AlertBox(
            msg: '${onValue.message} ${onValue.exception}..!!',
          ));
        } else {
          Get.dialog(AlertBox(
            msg: '${onValue.message} ${onValue.exception}..!!',
          ));
        }
      });
    } else {}
    isLoadUpdated = false;
    update();
  }

  deleteApi(int id, String masterid) async {
    await SetupCommonDeleteApi.callapi(id).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        Get.dialog(AlertBox(
          msg: 'Sucessfully Deleted..!!',
        )).then((onValue) {
          callApi(masterid.toString());
        });
      } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
        Get.dialog(AlertBox(
          msg: '${onValue.message} ${onValue.exception}..!!',
        ));
      } else {
        Get.dialog(AlertBox(
          msg: '${onValue.exception}..!!',
        ));
      }
    });
  }

  void callApi(String masterid) async {
    datalist = [];
    isLoad = true;
    filterdatalist = [];
    update();

    await SetupCommonApi.callapi(masterid).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.data != null) {
          datalist = onValue.data;
          filterdatalist = datalist;
          isLoad = false;
          update();
        } else {
          datalist = [];
          isLoad = false;

          update();
        }

        // Get.dialog(AlertBox(
        //   msg: 'Sucessfully Added..!!',
        // )).then((onValue){
        //   Get.back();
        // });
      } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
        isLoad = false;
        update();

        Get.dialog(AlertBox(
          msg: '${onValue.message} ${onValue.exception}..!!',
        ));
      } else {
        isLoad = false;
        update();

        Get.dialog(AlertBox(
          msg: '${onValue.exception}..!!',
        ));
      }
    });
    refresh();
  }

  filtercode(String val) {
    if (val.isNotEmpty) {
      filterdatalist = _datalist!
          .where((test) => test.code!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterdatalist = datalist;
      update();
    }
  }

  filterDescription(String val) {
    if (val.isNotEmpty) {
      filterdatalist = _datalist!
          .where((test) =>
              test.description!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterdatalist = datalist;
      update();
    }
  }

  filterStatus(String val) {
    String value = '';

    if (val.isNotEmpty) {
      if (val.contains('active')) {
        value = '1';
      } else {
        value = val;
      }
      filterdatalist = _datalist!
          .where((test) => test.status!
              .toString()
              .toUpperCase()
              .contains(value.toUpperCase()))
          .toList();
    } else {
      filterdatalist = datalist;
      update();
    }
  }
}
