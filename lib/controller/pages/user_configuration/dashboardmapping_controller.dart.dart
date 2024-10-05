import 'dart:collection';

import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/services/pages/user_configuration/getAllDashboardMenu-api.dart';
import 'package:flowkit/services/pages/user_configuration/getallUser_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:get/get.dart';

class DashboardMappingController extends MyController {
  @override
  void onInit() {
    _callAlluserApi();
    super.onInit();
  }

  List<AllUserData2>? getallUser = [];
  bool isLoad = false;
  bool valueEnquiry = false;
  bool valueLeads = false;
  bool valueOrder = false;
  bool valueCustomers = false;
  bool valueSalesTargets = false;

  selectAllDeselectAll(bool val) {
    valueEnquiry = val;
    valueLeads = val;
    valueOrder = val;
    valueCustomers = val;
    valueSalesTargets = val;

    update();
  }

  _callAlluserApi() async {
    getallUser = [];
    update();
    await GetAllUserListApi.call().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.data!.isNotEmpty) {
          isLoad = false;
          List<AllUserData2> getallUser2 =
              LinkedHashSet<AllUserData2>.from(onValue.data!).toList();

          // getallUser2.sort((a, b) => a.toString().compareTo(b.toString()));
          getallUser = getallUser2;
          update();
        }
      } else {
        Get.dialog(AlertBox(
          msg: 'Somethink went wrong..!!',
        ));
      }
    });
  }

  List<GetDashboardMenuData>? menuData;
  String? valueUser;
  callUserManuAuthDataApi(String val) async {
    valueUser = val;
    menuData = [];
    update();
    await GetAllDashboardMenuApi.call(int.parse(val)).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        menuData = onValue.data;
        getData(menuData);
        update();
      } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
        Get.dialog(AlertBox(msg: "Something went wrong..!!"));
      } else {
        Get.dialog(AlertBox(msg: "Something went wrong..!!"));
      }
    });
  }

  getData(List<GetDashboardMenuData>? menuData) {
    for (var e in menuData!) {
      assignvalue(e.caption!, e.isActvie == 1 ? true : false);
    }
  }

  List<GetDashboardMenuData>? posBodymenuData = [];
  bool isLoadSave = false;
  updateMenuStatus() async {
    isLoadSave = true;
    posBodymenuData = [];
    update();
    // if (valueUser != null) {
    //   for (var e in menuData!) {
    //     bool? val = setpostData(e.menuName!);
    //     posBodymenuData!.add(GetDashboardMenuData(
    //         userKey: e.userKey,
    //         menuKey: e.menuKey,
    //         authStatus: val == true ? "Y" : "N",
    //         companyCode: e.companyCode,
    //         menuName: e.menuName));
    //   }
    //   await UpdateMenuAuthApi.call(posBodymenuData).then((onValue) {
    //     if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
    //       Get.dialog(AlertBox(msg: "Sucessfulluy Saved..!!"));
    //     } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
    //       Get.dialog(AlertBox(msg: "Not Saved Something went wrong..!!"));
    //     } else {
    //       Get.dialog(AlertBox(msg: "${onValue.message}"));
    //     }
    //   });
    // } else {
    Get.dialog(AlertBox(msg: "Api..!!"));
    // }

    isLoadSave = false;
    update();
  }

  bool? setpostData(String type) {
    switch (type) {
      case 'CUSTOMER':
        return valueCustomers;
      case 'ORDERS':
        return valueOrder;
      case 'LEADS':
        return valueLeads;
      case 'SALES TARGET':
        return valueSalesTargets;
      case 'ENQUIRIES':
        return valueEnquiry;
    }
    update();
    return null;
  }

  assignvalue(String type, bool val) {
    switch (type) {
      case 'SALES TARGET':
        changeState(SwitchBoxType.salestargets, val);
        break;
      case 'CUSTOMER':
        changeState(SwitchBoxType.customers, val);
        break;
      case 'ORDERS':
        changeState(SwitchBoxType.orders, val);
        break;
      case 'LEADS':
        changeState(SwitchBoxType.leads, val);
        break;

      case 'ENQUIRIES':
        changeState(SwitchBoxType.enquiries, val);
        break;
    }
    update();
  }

  changeState(SwitchBoxType type, bool val) {
    switch (type) {
      case SwitchBoxType.enquiries:
        valueEnquiry = !valueEnquiry;
        update();
        break;
      case SwitchBoxType.leads:
        valueLeads = !valueLeads;
        update();
        break;
      case SwitchBoxType.orders:
        valueOrder = !valueOrder;
        update();
        break;
      case SwitchBoxType.customers:
        valueCustomers = !valueCustomers;
        update();
        break;
      case SwitchBoxType.salestargets:
        valueSalesTargets = !valueSalesTargets;
        update();
        break;
    }
    update();
  }
}

enum SwitchBoxType { enquiries, leads, orders, customers, salestargets }
