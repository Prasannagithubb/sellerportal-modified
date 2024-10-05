import 'dart:collection';

import 'package:file_picker/file_picker.dart';
import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/constants/dataBase_config.dart';
import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/getallUsetr_byid_api.dart';
import 'package:flowkit/services/pages/inventory/itemMaster/itemmaster_api.dart';
import 'package:flowkit/services/pages/setups/getall_store_api.dart';
import 'package:flowkit/services/pages/setups/setupCommon_getapi.dart';
import 'package:flowkit/services/pages/user_configuration/addUser_api.dart';
import 'package:flowkit/services/pages/user_configuration/getRestriction.dart';
import 'package:flowkit/services/pages/user_configuration/getallUser_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UserListController extends MyController {
  @override
  void onInit() {
    callvalidator();
    callGetAllStoreapi();
    _callAlluserByIdApi();
    _callAlluserApi();
    callIemMaster();
    super.onInit();
  }

  List<AllUserData>? userData = [];
  List<AllUserData>? filterUserData = [];
  List<GlobalKey<FormState>> formkey =
      List.generate(10, (int i) => GlobalKey<FormState>());
  MyFormValidator basicValidator = MyFormValidator();
  final TickerProvider tickerProvider;
  var softIndex = 0;
  late TabController softTabController =
      TabController(length: 3, vsync: tickerProvider, initialIndex: softIndex);
  UserListController(this.tickerProvider);
  bool isLoad = false;

  List<ItemMasterNewData>? itemdata;
  List<ItemMasterNewData>? get _itemdata => itemdata;

  List<ItemMasterNewData>? filterItemdata;
  List<String> brandlist = [];
  List<String> addBrandlist = [];

  List<String> categorylist = [];
  List<String> addCategorylist = [];
  List<StoresPostListDt> addStorelist = [];

  String? category;
  String? brand;
  String? valueStore;

  String? reportinguser;
  String? valueUsertype;
  // String? valueUsertyp;
  String? valueDesignation;
  String? templateType;

  String? restrictionType;

  bool? ismobileUser = false;
  bool? isPortaluser = false;
  bool? status = true;
  bool? isRestriction = false;

  PlatformFile? uploadfileField;

  callvalidator() {
    basicValidator.addField('usercode',
        required: true, controller: TextEditingController());
    basicValidator.addField('username',
        required: true, controller: TextEditingController());
    basicValidator.addField('mobileno',
        required: true, controller: TextEditingController());
    basicValidator.addField('mailid',
        required: false, controller: TextEditingController());
    basicValidator.addField('reportingto',
        required: true, controller: TextEditingController());
    basicValidator.addField('usertype',
        required: true, controller: TextEditingController());
    basicValidator.addField('designation',
        required: true, controller: TextEditingController());
    basicValidator.addField('slpcode',
        required: true, controller: TextEditingController());
    //
    basicValidator.addField('uploadfiles',
        required: false, controller: TextEditingController());
    basicValidator.addField('templatetype',
        required: false, controller: TextEditingController());
    refresh();
  }

  addBrandListMethod() {
    if (brand!.isNotEmpty) {
      addBrandlist.add(brand!);
    }
    update();
  }

  addStoreListMethod() {
    if (valueStore!.isNotEmpty) {
      if (valueStore == '-1') {
        for (var e in storealldata) {
          if (e.id != -1) {
            addStorelist
                .add(StoresPostListDt(storeid: e.id, storename: e.storeName));
          }
        }
      } else {
        var data =
            storealldata.where((e) => e.id == int.parse(valueStore!)).toList();
        List<GetAllStoreData> data2 = data.toList();
        ;
        addStorelist.add(StoresPostListDt(
            storeid: int.parse(valueStore!), storename: data2[0].storeName));
      }
    }
    update();
  }

  addCategoryListMethod() {
    if (category!.isNotEmpty) {
      addCategorylist.add(category!);
    }
    update();
  }

  List<GetAllStoreData> storealldata = [];
  List<GetAllStoreData> filterStorealldata = [];

  callGetAllStoreapi() async {
    storealldata = [];
    filterStorealldata = [];
    update();
    await GetAllStoreApi.callapi().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        storealldata.add(GetAllStoreData(
            id: -1,
            tenantId: 'tenantId',
            storeCode: '',
            storeName: 'All Store',
            address1: 'address1',
            address2: 'address2',
            address3: 'address3',
            city: 'city',
            state: 'state',
            country: 'country',
            pinCode: 'pinCode',
            latitude: '',
            longitude: 'longitude',
            createdBy: 0,
            createdOn: 'createdOn',
            updatedBy: 0,
            updatedOn: 'updatedOn',
            status: 0,
            gstNo: 'gstNo',
            primaryContact: 'primaryContact',
            primaryEmail: 'primaryEmail',
            centralWhs: 'centralWhs',
            restrictionType: 0,
            radius: 0,
            storeLogoUrl: 'storeLogoUrl'));
        storealldata.addAll(onValue.data);
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
    update();
  }

  callIemMaster() async {
    itemdata = [];
    filterItemdata = [];
    update();
    await ItemMasterApi.call().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.itemdata!.isNotEmpty) {
          itemdata = onValue.itemdata;
          filterItemdata = itemdata;
          List<String> brandlist2 =
              filterItemdata!.map((item) => item.Brand ?? '').toList();
          brandlist = LinkedHashSet<String>.from(brandlist2).toList();
          List<String> categorylist2 =
              filterItemdata!.map((item) => item.Category ?? '').toList();
          categorylist = LinkedHashSet<String>.from(categorylist2).toList();
        }
      }
    });
  }

  _callAlluserByIdApi() async {
    isLoad = true;
    await GetAllUserDetailsApi.call().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.data!.isNotEmpty) {
          isLoad = false;
          userData = onValue.data;
          filterUserData = userData;
          update();
        }
      } else {
        isLoad = false;
        update();

        Get.dialog(AlertBox(
          msg: 'Somethink went wrong..!!',
        ));
      }
    });
    isLoad = false;
    update();
  }

  List<AllUserData2>? getallUser = [];

  _callAlluserApi() async {
    getallUser = [];
    update();
    await GetAllUserListApi.call().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.data!.isNotEmpty) {
          isLoad = false;
          List<AllUserData2> getallUser2 =
              LinkedHashSet<AllUserData2>.from(onValue.data!).toList();
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

  validateFinalAddNewUser() async {
    DataBaseConfig.userId = await SharedPre.getUserid();
    String customerId = await SharedPre.getCustomerId();
    String usertypeId = await SharedPre.getUserTypeid();

    List<UserPostBrandList>? brandlist = [];
    List<UsercatogeryPostList>? categoryList = [];
    List<RestrictionPostData>? restrictionlist = [];
    if (formkey[0].currentState!.validate()) {
      addBrandlist.forEach((e) {
        brandlist.add(UserPostBrandList(brand: e));
      });

      addCategorylist.forEach((e) {
        categoryList.add(UsercatogeryPostList(category: e));
      });
      addRestrictionData!.forEach((e) {
        restrictionlist.add(RestrictionPostData(
            userid: int.parse(DataBaseConfig.userId),
            restrictionMasterId: e.id));
      });
      Utils utils = Utils();
      Map<String, dynamic> data = basicValidator.getData();
      NewUserPost newUserPostBody = NewUserPost(
          id: 0,
          tenantId: customerId,
          userTypeId: int.parse(usertypeId),
          userCode: data["usercode"],
          userName: data["username"],
          password: '',
          deviceCode: '',
          fcmToken: '',
          storeId: 0,
          currentLicenseKey: '',
          profileUrl: '',
          licenseActivatedOn: '',
          licenseValidTill: '',
          mobile: data["mobileno"],
          email: data["mailid"],
          createdBy: 1,
          createdOn: utils.currentDate(),
          updatedBy: 1,
          updatedOn: utils.currentDate(),
          status: status == true ? 1 : 0,
          isMobileUser: ismobileUser,
          isPortalUser: isPortaluser,
          reportingTo: reportinguser,
          slpCode: data["slpcode"],
          userBranch: '',
          restrictionType: 0,
          designationId: int.parse(valueDesignation!),
          storeList: addStorelist,
          brandlist: brandlist,
          categoryList: categoryList,
          restrictionList: restrictionlist);
      await AddNewUserApi.call(newUserPostBody).then((onValue) {
        print("stcode::" + onValue.stcode.toString());
      });
    }
    update();
  }

  List<SetupsCommonData>? masterdata;
  List<SetupsCommonData>? get _masterdata => masterdata;
  List<SetupsCommonData>? masterdatalist = [];
  bool isloadDropdown = false;
  Future<List<SetupsCommonData>?> callApi(String masterid) async {
    masterdata = [];
    masterdatalist = [];
    isloadDropdown = true;
    update();

    await SetupCommonApi.callapi(masterid).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.data != null) {
          masterdata = onValue.data;
          masterdatalist = masterdata;
          update();
        } else {
          masterdata = [];
          update();
        }
      }
    });
    isloadDropdown = false;
    update();
    return masterdatalist!;
  }

  List<RestrictionData>? restrictionData = [];
  List<RestrictionData>? addRestrictionData = [];

  void callRestrictionApi() async {
    restrictionData = [];
    update();
    await GetRestrictionApi.call().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        restrictionData = onValue.data;
        update();
      } else {
        restrictionData = [];
      }
    });
  }

  addRestrictionMethod(String? val) {
    if (restrictionData!.isNotEmpty) {
      var data =
          restrictionData!.where((e) => e.restrictionData == val).toList();
      if (data.isNotEmpty) {
        List<RestrictionData>? restrictionData2 = data.toList();
        if (addRestrictionData!.isEmpty) {
          addRestrictionData!.addAll(restrictionData2);
        } else {
          var data2 = addRestrictionData!
              .where((e) =>
                  e.restrictionData == restrictionData2[0].restrictionData)
              .toList();
          if (data2.isEmpty) {
            addRestrictionData!.addAll(restrictionData2);
          }
        }
      }
    }
    update();
  }

  List<String> splitLocation(String val) {
    return val.split(',');
  }

  filterStore(String val, UserListController userCnt) {
    if (val.isNotEmpty) {
      filterUserData = userData!
          .where((e) => e.userBranch!.contains(val.toUpperCase()))
          .toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterUserData = userData;
      update();
    }
  }

  filterUserCode(String val, UserListController userCnt) {
    if (val.isNotEmpty) {
      filterUserData =
          userData!.where((e) => e.usercode!.contains(val)).toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterUserData = userData;
      update();
    }
  }

  filterUserName(String val, UserListController userCnt) {
    if (val.isNotEmpty) {
      filterUserData =
          userData!.where((e) => e.username!.contains(val)).toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterUserData = userData;
      update();
    }
  }

  filterMobile(String val, UserListController userCnt) {
    if (val.isNotEmpty) {
      filterUserData = userData!.where((e) => e.mobile!.contains(val)).toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterUserData = userData;
      update();
    }
  }

  filterEmail(String val, UserListController userCnt) {
    if (val.isNotEmpty) {
      filterUserData = userData!.where((e) => e.email!.contains(val)).toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterUserData = userData;
      update();
    }
  }

  filterStatusBtn(String type) {
    filterUserData = userData;
    if (type == 'Active') {
      filterUserData = filterUserData!.where((e) => e.status == 1).toList();
      update();
    } else {
      filterUserData = filterUserData!.where((e) => e.status != 1).toList();
      update();
    }
  }

  filterStatus(String val, UserListController userCnt) {
    if (val.isNotEmpty) {
      filterUserData =
          userData!.where((e) => e.userBranch!.contains(val)).toList();
      // if (filterUserData!.isEmpty) {
      //   filterUserData = userData;

      //   update();
      // }
      //  else {
      //   MyData(filterUserData!, userCnt);
      // }
    } else {
      filterUserData = userData;
      update();
    }
  }
}
