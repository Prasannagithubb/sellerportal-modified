import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetAllStoreApi {
  int? rescode;
  String? resDesc;
  int? stcode;
  List<GetAllStoreData> data;
  GetAllStoreApi(
      {required this.resDesc,
      required this.rescode,
      required this.stcode,
      required this.data});
  static Future<GetAllStoreApi> callapi() async {
    Responce res = Responce();
    String? token = await SharedPre.getToken();

    res = await ServiceGet.callApi(
        "${UtilsVariables.clientPortalUrl}/GetAllstores?", token!);
    return GetAllStoreApi.fromJson(res);
  }

  // "respType": "Error",
  // "respCode": "SK401",
  // "respDesc": "UnAuthorized Access Error",

  factory GetAllStoreApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      List<dynamic> data = jsonDecode(res.responceBody!) as List;
      // var list = data as List;
      List<GetAllStoreData>? datalist =
          data.map((e) => GetAllStoreData.fromJon(e)).toList();
      if (data.isNotEmpty) {
        return GetAllStoreApi(
          stcode: res.resCode,
          resDesc: 'Sucess',
          rescode: 200,
          data: datalist,
        );
      } else {
        return GetAllStoreApi(
          stcode: res.resCode,
          resDesc: '',
          rescode: null,
          data: [],
        );
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);

      return GetAllStoreApi(
        stcode: res.resCode,
        resDesc: jsons['respDesc'],
        rescode: jsons['respCode'],
        data: [],
      );
    } else {
      return GetAllStoreApi(
        stcode: res.resCode,
        resDesc: res.responceBody,
        rescode: null,
        data: [],
      );
    }
  }
}

class GetAllStoreData {
  int? id;
  String? tenantId;
  String? storeCode;
  String? storeName;
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? latitude;
  String? longitude;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn;
  int? status;
  String? gstNo;
  String? primaryContact;
  String? primaryEmail;
  String? centralWhs;
  int? restrictionType;
  int? radius;
  String? storeLogoUrl;
  // String? storeIplists;

  GetAllStoreData({
    required this.id,
    required this.tenantId,
    required this.storeCode,
    required this.storeName,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
    required this.latitude,
    required this.longitude,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.status,
    required this.gstNo,
    required this.primaryContact,
    required this.primaryEmail,
    required this.centralWhs,
    required this.restrictionType,
    required this.radius,
    required this.storeLogoUrl,
    // required this.storeIplists,
  });

  factory GetAllStoreData.fromJon(Map<String, dynamic> json) {
    return GetAllStoreData(
      id: json['id'] ?? 0,
      tenantId: json['tenantId'] ?? '',
      storeCode: json['storeCode'] ?? '',
      storeName: json['storeName'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      address3: json['address3'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      pinCode: json['pinCode'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      createdBy: json['createdBy'] ?? 0,
      createdOn: json['createdOn'] ?? '',
      updatedBy: json['updatedBy'] ?? 0,
      updatedOn: json['updatedOn'] ?? '',
      status: json['status'] ?? 0,
      gstNo: json['gstNo'] ?? '',
      primaryContact: json['primaryContact'] ?? '',
      primaryEmail: json['primaryEmail'] ?? '',
      centralWhs: json['centralWhs'] ?? '',
      restrictionType: json['restrictionType'] ?? 0,
      radius: json['radius'] ?? 0,
      storeLogoUrl: json['storeLogoUrl'] ?? '',
      // storeIplists: json['storeIplists'] ?? ''
    );
  }
}
