import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class StoreAddApi {
  String message;
  bool? status;
  String? exception;
  int? stcode;
  StoreAddApi(
      {required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<StoreAddApi> callapi(PostBodyStore? postbody) async {
    Map<String, dynamic> body = {
      "tenantId": postbody!.tenantId,
      "storeCode": postbody.storeCode,
      "storeName": postbody.storeName,
      "address1": postbody.address1,
      "address2": postbody.address2,
      "address3": postbody.address3,
      "city": postbody.city,
      "state": postbody.state,
      "country": postbody.country,
      "pinCode": postbody.pinCode,
      "latitude": postbody.latitude,
      "longitude": postbody.longitude,
      "createdBy": postbody.createdBy,
      "createdOn": postbody.createdOn,
      "updatedBy": postbody.updatedBy,
      "updatedOn": postbody.updatedOn,
      "status": postbody.status,
      "gstNo": postbody.gstNo,
      "primaryContact": postbody.primaryContact,
      "primaryEmail": postbody.primaryEmail,
      "centralWhs": postbody.centralWhs,
      "restrictionType": postbody.restrictionType,
      "radius": postbody.radius,
      "storeLogoUrl": postbody.storeLogoUrl,
      "storeIplists": postbody.dataIplist.map((e) => e.toJson())
    };
    Responce res = Responce();
    String? token = await SharedPre.getToken();
    res = await ServicePost.callApi(
        "${UtilsVariables.clientPortalUrl}/postStores?", token!, body);
    return StoreAddApi.fromJson(res);
  }

  factory StoreAddApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      return StoreAddApi(
          message: "Success",
          status: true,
          stcode: res.resCode,
          exception: null);
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);

      return StoreAddApi(
          message: jsons['respCode'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return StoreAddApi(
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}

class PostBodyStore {
  int id;
  String tenantId;
  String storeCode;
  String storeName;
  String address1;
  String address2;
  String address3;
  String city;
  String state;
  String country;
  String pinCode;
  String latitude;
  String longitude;
  int createdBy;
  String createdOn;
  int updatedBy;
  String updatedOn;
  int status;
  String gstNo;
  String primaryContact;
  String primaryEmail;
  String centralWhs;
  int restrictionType;
  int radius;
  String storeLogoUrl;
  List<StoreIplists> dataIplist;
  PostBodyStore({
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
    required this.dataIplist,
  });
}

class StoreIplists {
  String ip;
  String ssid;
  StoreIplists({required this.ip, required this.ssid});

  Map<String, dynamic> toJson() {
    return {'ip': ip, 'ssid': ssid};
  }
}
