import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/user_configuration/addRestriction_api.dart';
import 'package:flowkit/services/pages/user_configuration/getRestriction.dart';
import 'package:flowkit/services/pages/user_configuration/updateRestriction_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestrictionController extends MyController {
  @override
  void onInit() {
    // TODO: implement onInit
    callRestrictionApi();
    validator();
    super.onInit();
  }

  validator() {
    basicValidator.addField("code",
        required: true, controller: TextEditingController());
    basicValidator.addField("usertype",
        required: true, controller: TextEditingController());
    basicValidator.addField("ip",
        required: true, controller: TextEditingController());
    basicValidator.addField("ssid",
        required: true, controller: TextEditingController());
    basicValidator.addField("longitude",
        required: true, controller: TextEditingController());
    basicValidator.addField("latitude",
        required: true, controller: TextEditingController());
    basicValidator.addField("distance",
        required: true, controller: TextEditingController());
    basicValidator.addField("remarks",
        required: true, controller: TextEditingController());
    update();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoad = false;
  bool isLoadAdd = false;
  bool isLoadUpdated = false;
  String? valueUsertype;
  List<RestrictionData>? restrictionData = [];
  List<RestrictionData>? filterRestrictionData = [];
  MyFormValidator basicValidator = MyFormValidator();
  void callRestrictionApi() async {
    restrictionData = [];
    filterRestrictionData = [];
    update();
    await GetRestrictionApi.call().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        restrictionData = onValue.data;
        filterRestrictionData = restrictionData;
        update();
      } else {
        restrictionData = [];
      }
    });
  }

  filtercode(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterRestrictionData = restrictionData!
          .where((e) => e.code!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterRestrictionData = restrictionData;
      update();
    }
  }

  filterremarks(
    String val,
  ) {
    if (val.isNotEmpty) {
      filterRestrictionData = restrictionData!
          .where((e) => e.remarks!.toUpperCase().contains(val.toUpperCase()))
          .toList();
    } else {
      filterRestrictionData = restrictionData;
      update();
    }
  }

  bool isSave = false;
  validateFianl() async {
    isLoadAdd = true;
    update();
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      int restrictionType = valueUsertype!.contains('IP')
          ? 1
          : valueUsertype!.contains('Location')
              ? 2
              : 3;
      String code = data["code"];
      String restrictionData = valueUsertype!.contains('IP')
          ? "${data["ip"]}"
          : valueUsertype!.contains('Location')
              ? "${data["longitude"]},${data["latitude"]}${data["distance"]}"
              : data["ssid"];
      String remarks = data["remarks"];
      await AddrestrictionApi.callapi(
              restrictionType, code, restrictionData, remarks)
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.dialog(AlertBox(msg: "New Restriction Saved Sucessfully..!!"))
              .then((onValue) {
            Get.back();
            callRestrictionApi();
          });
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(
              AlertBox(msg: "${onValue.message} ${onValue.exception}..!!"));
        } else {
          Get.dialog(AlertBox(msg: "${onValue.exception}..!!"));
        }
      });
    }
    isLoadAdd = false;
    update();
  }

  validateUpdateFianl() async {
    isLoadUpdated = true;
    update();
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      int restrictionType = valueUsertype!.contains('IP')
          ? 1
          : valueUsertype!.contains('Location')
              ? 2
              : 3;
      String code = data["code"];
      String restrictionData = valueUsertype!.contains('IP')
          ? "${data["ip"]}"
          : valueUsertype!.contains('Location')
              ? "${data["longitude"]},${data["latitude"]}${data["distance"]}"
              : data["ssid"];
      String remarks = data["remarks"];
      await UpdaterestrictionApi.callapi(
              restrictionType, code, restrictionData, remarks)
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.dialog(
                  AlertBox(msg: "Updated Restrictions Saved Sucessfully..!!"))
              .then((onValue) {
            Get.back();
            callRestrictionApi();
          });
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(
              AlertBox(msg: "${onValue.message} ${onValue.exception}..!!"));
        } else {
          Get.dialog(AlertBox(msg: "${onValue.exception}..!!"));
        }
      });
    }
    isLoadUpdated = false;
    update();
  }
}
