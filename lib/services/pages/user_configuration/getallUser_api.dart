import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetAllUserListApi {
  int? stcode;
  String? message;
  List<AllUserData2>? data;
  GetAllUserListApi(
      {required this.data, required this.message, required this.stcode});

  static Future<GetAllUserListApi> call() async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    String userid = await SharedPre.getUserid();
    res = await ServiceGet.callApi(
        '${UtilsVariables.clientPortalUrl}/GetAllUsers?', UtilsVariables.token);

    return GetAllUserListApi.fromJson(res);
  }

  factory GetAllUserListApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var data2 = jsonDecode(res.responceBody!.toString()) as List;
      if (data2.isNotEmpty) {
        List<AllUserData2> datalist =
            data2.map((e) => AllUserData2.fromJson(e)).toList();
        return GetAllUserListApi(
            data: datalist, message: 'Sucess', stcode: res.resCode);
      } else {
        return GetAllUserListApi(
            data: null, message: 'No data', stcode: res.resCode);
      }
    } else {
      return GetAllUserListApi(
          data: null, message: 'No data', stcode: res.resCode);
    }
  }
}

class AllUserData2 {
  int? id;
  String? tenetid;
  int? userTypeId;
  String? usercode;
  String? username;
  String? password;
  String? deviceCode;
  String? fcmToken;
  int? storeId;
  String? currentLicenseKey;
  String? profileUrl;
  String? licenseActivatedOn;
  String? licenseValidTill;
  String? mobile;
  String? email;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn;
  int? status;
  bool? isMobileUser;
  bool? isPortalUser;
  String? reportingTo;
  String? slpCode;
  String? userBranch;
  int? restrictionType;
  AllUserData2({
    required this.id,
    required this.tenetid,
    required this.userTypeId,
    required this.usercode,
    required this.username,
    required this.password,
    required this.deviceCode,
    required this.fcmToken,
    required this.storeId,
    required this.currentLicenseKey,
    required this.profileUrl,
    required this.licenseActivatedOn,
    required this.licenseValidTill,
    required this.mobile,
    required this.email,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.status,
    required this.isMobileUser,
    required this.isPortalUser,
    required this.reportingTo,
    required this.slpCode,
    required this.userBranch,
    required this.restrictionType,
  });

  factory AllUserData2.fromJson(Map<String, dynamic> json) {
    return AllUserData2(
        id: json['id'] == null ? 0 : int.parse(json['id'].toString()),
        tenetid: json['tenantId'] ?? '',
        userTypeId: json['userTypeId'] == null
            ? 0
            : int.parse(json['userTypeId'].toString()),
        usercode: json['userCode'] ?? '',
        username: json['userName'] ?? '',
        password: json['password'] ?? '',
        deviceCode: json['deviceCode'] ?? '',
        fcmToken: json['fcmToken'] ?? '',
        storeId:
            json['storeId'] == null ? 0 : int.parse(json['storeId'].toString()),
        currentLicenseKey: json['currentLicenseKey'],
        profileUrl: json['profileUrl'] ?? '',
        licenseActivatedOn: json['licenseActivatedOn'] ?? '',
        licenseValidTill: json['licenseValidTill'] ?? '',
        mobile: json['mobile'] ?? '',
        email: json['email'] ?? '',
        createdBy: json['createdBy'] == null
            ? 0
            : int.parse(json['createdBy'].toString()),
        createdOn: json['createdOn'],
        updatedBy: json['updatedBy'] == null
            ? 0
            : int.parse(json['updatedBy'].toString()),
        updatedOn: json['updatedOn'],
        status:
            json['status'] == null ? 0 : int.parse(json['status'].toString()),
        isMobileUser: null,
        isPortalUser: null,
        reportingTo: json['reportingTo'],
        slpCode: json['slpCode'],
        userBranch: json['userBranch'],
        restrictionType: json['restrictionType'] == null
            ? 0
            : int.parse(json['restrictionType'].toString()));
  }
}
