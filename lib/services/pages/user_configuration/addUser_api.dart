import 'dart:convert';

import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class AddNewUserApi {
  String? message;
  int? stcode;
  AddNewUserApi({required this.message, required this.stcode});

  static Future<AddNewUserApi> call(NewUserPost newUserPostBody) async {
    Responce res = Responce();
    Map<String, dynamic> body = {
      "id": newUserPostBody.id ?? 0,
      "tenantId": newUserPostBody.tenantId,
      "userTypeId": newUserPostBody.userTypeId,
      "userCode": newUserPostBody.userCode,
      "userName": newUserPostBody.userName,
      "password": newUserPostBody.password,
      "deviceCode": newUserPostBody.deviceCode,
      "fcmToken": newUserPostBody.fcmToken,
      "storeId": newUserPostBody.storeId,
      "currentLicenseKey": newUserPostBody.currentLicenseKey,
      "profileUrl": newUserPostBody.profileUrl,
      "licenseActivatedOn": newUserPostBody.licenseActivatedOn,
      "licenseValidTill": newUserPostBody.licenseValidTill,
      "mobile": newUserPostBody.mobile,
      "email": newUserPostBody.email,
      "createdBy": newUserPostBody.createdBy,
      "createdOn": newUserPostBody.createdOn,
      "updatedBy": newUserPostBody.createdBy,
      "updatedOn": newUserPostBody.updatedOn,
      "status": newUserPostBody.status,
      "isMobileUser": newUserPostBody.isMobileUser,
      "isPortalUser": newUserPostBody.isPortalUser,
      "reportingTo": newUserPostBody.reportingTo,
      "slpCode": newUserPostBody.slpCode,
      "userBranch": newUserPostBody.userBranch,
      "restrictionType": newUserPostBody.restrictionType,
      "designation_Id": newUserPostBody.designationId,
      "storesListDtos":
          newUserPostBody.storeList!.map((e) => e.toJsonStoresPost()).toList(),
      "userBrandListDtos":
          newUserPostBody.brandlist!.map((e) => e.toJsonBrandPost()).toList(),
      "usercatogeryListDtos": newUserPostBody.categoryList!
          .map((e) => e.toJsonCategoryPost())
          .toList(),
      "userRestrictionMappingdtos": newUserPostBody.restrictionList!
          .map((e) => e.toJsonRestrictionPost())
          .toList(),
    };
    print(jsonEncode(body));
    res = await ServicePost.callApi(
        '${UtilsVariables.url}/PostUser', UtilsVariables.token, body);
    return AddNewUserApi.fromjson(res);
  }

  factory AddNewUserApi.fromjson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      return AddNewUserApi(message: 'Sucess', stcode: res.resCode);
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      return AddNewUserApi(message: 'Failure', stcode: res.resCode);
    } else {
      return AddNewUserApi(message: res.responceBody, stcode: res.resCode);
    }
  }
}

class NewUserPost {
  int? id;
  String? tenantId;
  int? userTypeId;
  String? userCode;
  String? userName;
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
  int? designationId;
  List<StoresPostListDt>? storeList;
  List<UserPostBrandList>? brandlist;
  List<UsercatogeryPostList>? categoryList;
  List<RestrictionPostData>? restrictionList;
  NewUserPost({
    required this.id,
    required this.tenantId,
    required this.userTypeId,
    required this.userCode,
    required this.userName,
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
    required this.designationId,
    required this.storeList,
    required this.brandlist,
    required this.categoryList,
    required this.restrictionList,
  });
}

class StoresPostListDt {
  int? storeid;
  String? storename;
  StoresPostListDt({required this.storeid, required this.storename});

  Map<String, dynamic> toJsonStoresPost() => {"storeid": storeid};
}

class UserPostBrandList {
  String? brand;
  UserPostBrandList({required this.brand});
  Map<String, dynamic> toJsonBrandPost() => {"brand": brand};
}

class UsercatogeryPostList {
  String? category;
  UsercatogeryPostList({
    required this.category,
  });
  Map<String, dynamic> toJsonCategoryPost() => {"category": category};
}

class RestrictionPostData {
  int? userid;
  int? restrictionMasterId;
  RestrictionPostData({
    required this.userid,
    required this.restrictionMasterId,
  });
  Map<String, dynamic> toJsonRestrictionPost() =>
      {"userid": userid, "restrictionMasterId": restrictionMasterId};
}
