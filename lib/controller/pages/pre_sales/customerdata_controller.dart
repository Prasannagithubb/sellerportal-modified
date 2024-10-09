import 'dart:collection';

import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/presales/customerdata/addCustomer_api.dart';
import 'package:flowkit/services/pages/presales/customerdata/deleteCustomer_api.dart';
import 'package:flowkit/services/pages/presales/customerdata/getAllcustomer_dataApi.dart';
import 'package:flowkit/services/pages/presales/customerdata/updateCustomer_api.dart';
import 'package:flowkit/services/pages/others/state_api.dart';
import 'package:flowkit/services/pages/setups/setupCommon_getapi.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDataController extends MyController {
  @override
  void onInit() {
    _callApi();
    callCustomerTagApi();
    callStateApi();
    validator();
    super.onInit();
  }

  String? valueTag;
  String? valueState;
  String? valueCountry;
  String? valueShippingState;
  String? valueShippingCountry;
  bool addBilltoShip = false;
  bool activeStatus = false;
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
        statelist = LinkedHashSet<SateHeaderData>.from(statelist2!).toList();
        update();
      }
    });
  }

  List<SetupsCommonData>? customerTagList = [];

  void callCustomerTagApi() async {
    customerTagList = [];
    isLoad = true;
    update();

    await SetupCommonApi.callapi("4").then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.data != null) {
          List<SetupsCommonData>? customerTagList2 = onValue.data;
          customerTagList =
              LinkedHashSet<SetupsCommonData>.from(customerTagList2!).toList();
          // filterdatalist = datalist;
          isLoad = false;
          update();
        }
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
    refresh();
  }

  validator() {
    basicValidator.addField('customercode',
        required: true, controller: TextEditingController());
    basicValidator.addField('customername',
        required: true, controller: TextEditingController());
    basicValidator.addField('mobileno',
        required: true, controller: TextEditingController());
    basicValidator.addField('alternatemobile',
        required: false, controller: TextEditingController());
    basicValidator.addField('contactname',
        required: false, controller: TextEditingController());
    basicValidator.addField('emailid',
        required: false, controller: TextEditingController());
    basicValidator.addField('gstno',
        required: false, controller: TextEditingController());
    basicValidator.addField('codeid',
        required: false, controller: TextEditingController());
    basicValidator.addField('tag',
        required: true, controller: TextEditingController());
    basicValidator.addField('facebookid',
        required: true, controller: TextEditingController());
    basicValidator.addField('alternatemobileno',
        required: false, controller: TextEditingController());
    basicValidator.addField('cardtype',
        required: false, controller: TextEditingController());
    //
    basicValidator.addField('address1',
        required: false, controller: TextEditingController());
    basicValidator.addField('address2',
        required: false, controller: TextEditingController());
    basicValidator.addField('address3',
        required: false, controller: TextEditingController());
    basicValidator.addField('city',
        required: false, controller: TextEditingController());
    basicValidator.addField('state',
        required: false, controller: TextEditingController());
    basicValidator.addField('country',
        required: false, controller: TextEditingController());
    basicValidator.addField('pincode',
        required: false, controller: TextEditingController());
    //
    basicValidator.addField('shippingaddress1',
        required: false, controller: TextEditingController());
    basicValidator.addField('shippingaddress2',
        required: false, controller: TextEditingController());
    basicValidator.addField('shippingaddress3',
        required: false, controller: TextEditingController());
    basicValidator.addField('shippingcity',
        required: false, controller: TextEditingController());
    basicValidator.addField('shippingstate',
        required: false, controller: TextEditingController());
    basicValidator.addField('shippingcountry',
        required: false, controller: TextEditingController());
    basicValidator.addField('shippingpincode',
        required: false, controller: TextEditingController());
    update();
  }

  changebillAddresstoShipAdd(bool val) {
    if (val) {
      print(valueState);

      String? dvar = statelist!
          .where((e) => e.statecode == valueState)
          .map((e) => e.stateName)
          .first;
      print(dvar);
      Map<String, dynamic> data = basicValidator.getData();
      basicValidator.getController('shippingaddress1')!.text =
          data['address1'] ?? '';
      basicValidator.getController('shippingaddress2')!.text =
          data['address2'] ?? '';
      basicValidator.getController('shippingaddress3')!.text =
          data['address3'] ?? '';

      basicValidator.getController('shippingcity')!.text = data['city'] ?? '';
      valueShippingState = statelist!
              .where((e) => e.statecode == valueState)
              .map((e) => e.statecode)
              .first ??
          '';
      valueShippingCountry = statelist!
              .where((e) => e.countrycode == valueCountry)
              .map((e) => e.countrycode)
              .first ??
          '';
      basicValidator.getController('shippingpincode')!.text =
          data['pincode'] ?? '';
    }
  }

  bool isSave = false;
  validatemethod() async {
    isSave = true;
    update();
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      String company = await SharedPre.getCustomerId();
      String storecode = await SharedPre.getStoreCode();
      print('1');
      // NewCustomerPostBody? postbody;
      NewCustomerPostBody postbody = NewCustomerPostBody(
          customercode: data['customercode'] ?? '',
          customername: data['customername'] ?? '',
          customermobile: data['mobileno'] ?? '',
          alternatemobileno: data['alternatemobile'] ?? '',
          contactname: data['contactname'] ?? '',
          customeremail: data['emailid'] ?? '',
          companyname: '${company}',
          gstno: data['gstno'] ?? '',
          codeid: data['codeid'] ?? '',
          biladdress1: data['address1'] ?? '',
          biladdress2: data['address2'] ?? '',
          biladdress3: data['address3'] ?? '',
          bilarea: '',
          bilcity: data['city'] ?? '',
          bildistrict: '',
          bilstate: data['state'] ?? '',
          bilcountry: data['country'] ?? '',
          bilpincode: data['pincode'] ?? '',
          deladdress1: data['shippingaddress1'] ?? '',
          deladdress2: data['shippingaddress2'] ?? '',
          deladdress3: data['shippingaddress3'] ?? '',
          delarea: '',
          delcity: data['shippingcity'] ?? '',
          deldistrict: '',
          delstate: data['shippingstate'] ?? '',
          delcountry: data['shippingcountry'] ?? '',
          delpincode: data['shippingpincode'] ?? '',
          customerGroup: valueTag ?? '',
          pan: '',
          website: '',
          facebook: data['facebookid'] ?? '',
          storeCode: '${storecode}',
          status: activeStatus,
          cardtype: data['cardtype'] ?? '');
      await AddCustomerApi.call(postbody).then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          if (onValue.message!.contains('sucessfu')) {
            Get.back();
            Get.dialog(AlertBox(msg: "${onValue.message}")).then((onValue) {
              _callApi();
            });
          } else {
            Get.dialog(AlertBox(msg: "${onValue.message}")).then((onValue) {
              _callApi();
            });
          }
        } else if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.dialog(AlertBox(msg: "${onValue.message}..!!"));
        } else {
          Get.dialog(AlertBox(msg: "${onValue.message}..!!"));
        }
      });
      isSave = false;
      update();
    }
  }

  filterStoreCode(String val) {
    if (val.isNotEmpty) {
      filterDataList = dataList
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
      filterDataList = dataList;
      update();
    }
  }

  filterCutomerCode(String val) {
    if (val.isNotEmpty) {
      filterDataList = dataList
          .where(
              (e) => e.customerCode!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterDataList = dataList;
      update();
    }
  }

  filterCustomerName(String val) {
    if (val.isNotEmpty) {
      filterDataList = dataList
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
      filterDataList = dataList;
      update();
    }
  }

  filterMobileNo(String val) {
    if (val.isNotEmpty) {
      filterDataList = dataList
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
      filterDataList = dataList;
      update();
    }
  }

  filterContactName(String val) {
    if (val.isNotEmpty) {
      filterDataList = dataList
          .where(
              (e) => e.contactName!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterDataList = dataList;
      update();
    }
  }

  filterEmail(String val) {
    if (val.isNotEmpty) {
      filterDataList = dataList
          .where(
              (e) => e.customerEmail!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterDataList = dataList;
      update();
    }
  }

  filterCreateDate(String val) {
    if (val.isNotEmpty) {
      filterDataList = dataList
          .where((e) => e.createdOn!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterDataList = dataList;
      update();
    }
  }

  filterLastModifi(String val) {
    if (val.isNotEmpty) {
      filterDataList = dataList
          .where((e) => e.updatedOn!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterDataList = dataList;
      update();
    }
  }

  void deleteApi(int deletId) async {
    await DeleteCustomerbyId.callapi(deletId).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        Get.dialog(AlertBox(
          msg: 'Sucessfully Deleted..!!',
        )).then((onValue) {
          _callApi();
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

  updateValuehange(AccountsNewData? datalist) async {
    // valueTag = customerTagList!
    //         .where((e) => e.description == datalist!.customerGroup!)
    //         .map((e) => e.code)
    //         .first ??
    //     '';
    // valueState = statelist!
    //         .where((e) => e.statecode == datalist!.bilState!)
    //         .map((e) => e.statecode)
    //         .first ??
    //     '';
    // valueCountry = statelist!
    //         .where((e) => e.countrycode == datalist!.bilCountry!)
    //         .map((e) => e.countrycode)
    //         .first ??
    //     '';
    // valueShippingState = statelist!
    //         .where((e) => e.statecode == datalist!.delState)
    //         .map((e) => e.statecode)
    //         .first ??
    //     '';
    // valueShippingCountry = statelist!
    //         .where((e) => e.countrycode == datalist!.delCountry)
    //         .map((e) => e.countrycode)
    //         .first ??
    //     '';
    print(datalist.toString());
    basicValidator.getController('customercode')!.text =
        datalist!.customerCode == null ? '' : datalist.customerCode!;
    basicValidator.getController('customername')!.text =
        datalist.customerName == null ? '' : datalist.customerName!;
    basicValidator.getController('mobileno')!.text =
        datalist.customerMobile == null ? '' : datalist.customerMobile!;
    basicValidator.getController('alternatemobileno')!.text =
        datalist.alternateMobileNo == "null"
            ? ''
            : "${datalist.alternateMobileNo!}";

    basicValidator.getController('contactname')!.text =
        datalist.contactName == "null" ? '' : datalist.contactName!;
    basicValidator.getController('emailid')!.text =
        datalist.customerEmail == "null" ? '' : datalist.customerEmail!;
    basicValidator.getController('gstno')!.text =
        datalist.GSTNo == "null" ? '' : datalist.GSTNo!;
    basicValidator.getController('codeid')!.text =
        datalist.codeId == null ? '' : datalist.codeId!;
    basicValidator.getController('facebookid')!.text =
        datalist.facebook == null ? '' : datalist.facebook!;
    basicValidator.getController('cardtype')!.text =
        datalist.cardtype == null ? '' : datalist.cardtype!;
    update();

    basicValidator.getController('address1')!.text =
        datalist.bilAddress1 == null ? '' : datalist.bilAddress1!;
    basicValidator.getController('address2')!.text =
        datalist.bilAddress2 == null ? '' : datalist.bilAddress2!;
    basicValidator.getController('address3')!.text =
        datalist.bilAddress3 == null ? '' : datalist.bilAddress3!;
    basicValidator.getController('city')!.text =
        datalist.bilCity == null ? '' : datalist.bilCity!;
    basicValidator.getController('pincode')!.text =
        datalist.bilPincode == null ? '' : datalist.bilPincode!;
    update();

    basicValidator.getController('shippingaddress1')!.text =
        datalist.delAddress1 == null ? '' : datalist.delAddress1!;
    basicValidator.getController('shippingaddress2')!.text =
        datalist.delAddress2 == null ? '' : datalist.delAddress2!;
    basicValidator.getController('shippingaddress3')!.text =
        datalist.delAddress3 == null ? '' : datalist.delAddress3!;
    basicValidator.getController('shippingcity')!.text =
        datalist.delCity == null ? '' : datalist.delCity!;
    basicValidator.getController('shippingpincode')!.text =
        datalist.delPincode == null ? '' : datalist.delPincode!;
    update();
  }

  bool isUpdateSave = false;
  validateUpdatemethod(int? id) async {
    isUpdateSave = true;
    update();
    if (formkey.currentState!.validate()) {
      Map<String, dynamic> data = basicValidator.getData();
      String company = await SharedPre.getCustomerId();
      String storecode = await SharedPre.getStoreCode();
      print('1');
      // NewCustomerPostBody? postbody;
      NewCustomerPostBody postbody = NewCustomerPostBody(
          customercode: data['customercode'] ?? '',
          customername: data['customername'] ?? '',
          customermobile: data['mobileno'] ?? '',
          alternatemobileno: data['alternatemobile'] ?? '',
          contactname: data['contactname'] ?? '',
          customeremail: data['emailid'] ?? '',
          companyname: '${company}',
          gstno: data['gstno'] ?? '',
          codeid: data['codeid'] ?? '',
          biladdress1: data['address1'] ?? '',
          biladdress2: data['address2'] ?? '',
          biladdress3: data['address3'] ?? '',
          bilarea: '',
          bilcity: data['city'] ?? '',
          bildistrict: '',
          bilstate: valueState ?? '',
          bilcountry: valueCountry ?? '',
          bilpincode: data['pincode'] ?? '',
          deladdress1: data['shippingaddress1'] ?? '',
          deladdress2: data['shippingaddress2'] ?? '',
          deladdress3: data['shippingaddress3'] ?? '',
          delarea: '',
          delcity: data['shippingcity'] ?? '',
          deldistrict: '',
          delstate: valueShippingState ?? '',
          delcountry: valueShippingCountry ?? '',
          delpincode: data['shippingpincode'] ?? '',
          customerGroup: valueTag ?? '',
          pan: '',
          website: '',
          facebook: data['facebookid'],
          storeCode: '${storecode}',
          cardtype: data['cardype'],
          status: activeStatus);
      await UpdateCustomerApi.call(postbody, id).then((onValue) {
        print('2:' + onValue.stcode.toString());

        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          if (onValue.message!.contains('sucessfu')) {
            Get.back();
            Get.dialog(AlertBox(msg: "${onValue.message}")).then((onValue) {
              _callApi();
            });
          } else {
            Get.dialog(AlertBox(msg: "${onValue.message}")).then((onValue) {
              _callApi();
            });
          }
        } else if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.dialog(AlertBox(msg: "${onValue.message}..!!"));
        } else {
          Get.dialog(AlertBox(msg: "${onValue.message}..!!"));
        }
      });
      isUpdateSave = false;
      update();
    }
  }
}
