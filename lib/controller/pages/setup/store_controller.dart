import 'dart:collection';

import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/others/state_api.dart';
import 'package:flowkit/services/pages/setups/getall_store_api.dart';
import 'package:flowkit/services/pages/setups/store/store_addapi.dart';
import 'package:flowkit/services/pages/setups/store/store_deleteapi.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreController extends MyController {
  @override
  void onInit() {
    callapi();
    callStateApi();
    setValidator();
    // TODO: implement onInit
    super.onInit();
  }

  MyFormValidator basicValidator = MyFormValidator();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<GetAllStoreData> storealldata = [];
  List<GetAllStoreData> filterStorealldata = [];
  bool isLoad = false;
  List<SateHeaderData>? statelist;
  String? stateValue;
  String? countryValue;

  List<String> restrictionList = [];
  callStateApi() async {
    await StateApi.callapi().then((onValue) {
      if (onValue.stcode! >= 200 && onValue.stcode! <= 210) {
        List<SateHeaderData>? statelist2 = onValue.itemdata!.datadetail;
        statelist = LinkedHashSet<SateHeaderData>.from(statelist2!).toList();
        update();
      }
    });
  }

  setValidator() {
    basicValidator.addField('storecode',
        required: true, controller: TextEditingController());
    basicValidator.addField('storename',
        required: true, controller: TextEditingController());
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
    basicValidator.addField('gstno',
        required: true, controller: TextEditingController());
    basicValidator.addField('primarymobileno',
        required: true, controller: TextEditingController());
    basicValidator.addField('email',
        required: true, controller: TextEditingController());
    basicValidator.addField('latitude',
        required: true, controller: TextEditingController());
    basicValidator.addField('longitude',
        required: true, controller: TextEditingController());
    basicValidator.addField('restrictiontype',
        required: true, controller: TextEditingController());
    basicValidator.addField('radius',
        required: true, controller: TextEditingController());
    basicValidator.addField('ipaddress',
        required: true, controller: TextEditingController());
  }

  validateNewStore() async {
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      String tenantid = SharedPre.getCustomerId();
      // for (int i = 0; i < restrictionList.length;i++) {
      //   dataIplist.add(StoreIplists(ip: restrictionList[i].id, ssid: ssid))
      // }
      print(data);
      PostBodyStore datalist = PostBodyStore(
          id: 0,
          tenantId: tenantid,
          storeCode: data['storeCode'],
          storeName: data['storeName'],
          address1: data['address1'],
          address2: data['address2'],
          address3: data['address3'],
          city: data['city'],
          state: data['state'],
          country: data['country'],
          pinCode: data['pinCode'],
          latitude: data['latitude'],
          longitude: data['longitude'],
          createdBy: data['createdBy'],
          createdOn: data['createdOn'],
          updatedBy: data['updatedBy'],
          updatedOn: data['updatedOn'],
          status: data['status'],
          gstNo: data['gstNo'],
          primaryContact: data['primaryContact'],
          primaryEmail: data['primaryEmail'],
          centralWhs: data['centralWhs'],
          restrictionType: data['restrictionType'],
          radius: data['radius'],
          storeLogoUrl: data['storeLogoUrl'],
          dataIplist: [StoreIplists(ip: '0', ssid: '0')]);

      await StoreAddApi.callapi(datalist).then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.back();
          Get.dialog(AlertBox(
            msg: 'Sucessfully New Store Added..!!',
          )).then((onValue) {
            callapi();
          });
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(AlertBox(
            msg: '${onValue.message} ${onValue.exception}..!!',
          ));
        } else {
          Get.dialog(AlertBox(
            msg: ' ${onValue.exception}..!!',
          ));
        }
      });
    }
  }

  callapi() async {
    isLoad = true;
    storealldata = [];
    filterStorealldata = [];
    update();
    await GetAllStoreApi.callapi().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        storealldata = onValue.data;
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
    isLoad = false;
    update();
  }

  filterStoreCode(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.storeCode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterStoreName(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.storeName!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterAddress1(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.address1!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterpincode(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.pinCode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterCity(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.city!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterState(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.state!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterCountry(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.country!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterGstno(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.gstNo!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterPrimaryContact(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) =>
              e.primaryContact!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  filterPrimaryEmail(String val) {
    if (val.isNotEmpty) {
      filterStorealldata = storealldata
          .where((e) => e.primaryEmail!.toString().contains(val.toString()))
          .toList();
      update();
    } else {
      filterStorealldata = storealldata;
      update();
    }
  }

  storeDeletebyId(int id) async {
    await StoreDeleteApi.callapi(id).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        Get.back();
        Get.dialog(AlertBox(
          msg: 'Store Sucessfully Deleted..!!',
        )).then((onValue) {
          callapi();
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
  }
}
