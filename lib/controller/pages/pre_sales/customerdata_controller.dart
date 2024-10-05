import 'dart:collection';

import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/customerdata/getAllcustomer_dataApi.dart';
import 'package:flowkit/services/pages/others/state_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDataController extends MyController {
  @override
  void onInit() {
    _callApi();
    callStateApi();
    validator();
    super.onInit();
  }

  String? valueTag;
  String? valueState;
  String? valueCountry;
  String? valueShippingState;
  String? valueShippingCountry;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoad = false;
  List<AccountsNewData> dataList = [];
  List<AccountsNewData> filterDataList = [];
  MyFormValidator basicValidator = MyFormValidator();
  _callApi() async {
    isLoad = true;

    await GetAllCustomerApi.callapi().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        dataList = value.itemdata!.childdata!;
        filterDataList = LinkedHashSet<AccountsNewData>.from(dataList).toList();

        update();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        Get.dialog(AlertBox(
          msg: '${value.message} ${value.exception}',
        ));
      } else {
        Get.dialog(AlertBox(
          msg: '${value.message} ${value.exception}',
        ));
      }
    });
    isLoad = false;
    update();
  }

  List<SateHeaderData>? statelist;

  callStateApi() async {
    await StateApi.callapi().then((onValue) {
      if (onValue.stcode! >= 200 && onValue.stcode! <= 210) {
        List<SateHeaderData>? statelist2 = onValue.itemdata!.datadetail;
        statelist=LinkedHashSet<SateHeaderData>.from(statelist2!).toList();
        update();
      }
    });
  }

  validator() {
    basicValidator.addField('customercode',
        required: true, controller: TextEditingController());
    basicValidator.addField('customername',
        required: true, controller: TextEditingController());
    basicValidator.addField('mobileno',
        required: true, controller: TextEditingController());
    basicValidator.addField('alternatemobile',
        required: true, controller: TextEditingController());
    basicValidator.addField('contactname',
        required: true, controller: TextEditingController());
    basicValidator.addField('emailid',
        required: true, controller: TextEditingController());
    basicValidator.addField('gstno',
        required: true, controller: TextEditingController());
    basicValidator.addField('codeid',
        required: true, controller: TextEditingController());
    basicValidator.addField('tag',
        required: true, controller: TextEditingController());
    basicValidator.addField('facebookid',
        required: true, controller: TextEditingController());
    basicValidator.addField('alternatemobile',
        required: true, controller: TextEditingController());
    //
    basicValidator.addField('address1',
        required: true, controller: TextEditingController());
    basicValidator.addField('address2',
        required: true, controller: TextEditingController());
    basicValidator.addField('address3',
        required: true, controller: TextEditingController());
    basicValidator.addField('city',
        required: true, controller: TextEditingController());
    basicValidator.addField('state',
        required: true, controller: TextEditingController());
    basicValidator.addField('country',
        required: true, controller: TextEditingController());
    basicValidator.addField('pincode',
        required: true, controller: TextEditingController());
    //
    basicValidator.addField('shippingaddress1',
        required: true, controller: TextEditingController());
    basicValidator.addField('shippingaddress2',
        required: true, controller: TextEditingController());
    basicValidator.addField('shippingaddress3',
        required: true, controller: TextEditingController());
    basicValidator.addField('shippingcity',
        required: true, controller: TextEditingController());
    basicValidator.addField('shippingstate',
        required: true, controller: TextEditingController());
    basicValidator.addField('shippingcountry',
        required: true, controller: TextEditingController());
    basicValidator.addField('shippingpincode',
        required: true, controller: TextEditingController());
    update();
  }

  validatemethod() {
    if (formkey.currentState!.validate()) {}
  }
}
