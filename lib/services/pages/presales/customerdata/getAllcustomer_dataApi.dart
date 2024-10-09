import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetAllCustomerApi {
  Accountsheader? itemdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetAllCustomerApi(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<GetAllCustomerApi> callapi() async {
    Responce res = Responce();
    // Map<String, dynamic> body = {
    //   "listtype": "summary",
    //   "valuetype": "name",
    //   "fromperiod": null,
    //   "toperiod": null,
    //   "status": null
    // };
    String? token = await SharedPre.getToken();

    res = await ServiceGet.callApi(
        "${UtilsVariables.clientPortalUrl}/GetAllCustomers", token!);
    return GetAllCustomerApi.fromJson(res);
  }

  factory GetAllCustomerApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var jsons = jsonDecode(res.responceBody!);
      if (jsons != null && jsons.isNotEmpty) {
        return GetAllCustomerApi(
            itemdata: Accountsheader.fromJson(jsons as List),
            message: "Success",
            status: true,
            stcode: res.resCode,
            exception: null);
      } else {
        return GetAllCustomerApi(
            itemdata: null,
            message: "Failure",
            status: false,
            stcode: res.resCode,
            exception: null);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);

      return GetAllCustomerApi(
          itemdata: null,
          message: jsons['respCode'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return GetAllCustomerApi(
          itemdata: null,
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}

class Accountsheader {
  List<AccountsNewData>? childdata;
  Accountsheader({required this.childdata});
  factory Accountsheader.fromJson(List<dynamic> jsons) {
    //  if (jsons["data"] != null) {
    if (jsons.isEmpty) {
      return Accountsheader(
        childdata: null,
      );
    } else {
      List<AccountsNewData> dataList =
          jsons.map((data) => AccountsNewData.fromJson(data)).toList();
      return Accountsheader(
        childdata: dataList,
      );
    }
  }
}

class AccountsNewData {
  AccountsNewData(
      {required this.id,
      required this.alternateMobileNo,
      required this.codeId,
      required this.bilAddress1,
      required this.bilAddress2,
      required this.bilAddress3,
      required this.bilArea,
      required this.bilCity,
      required this.bilCountry,
      required this.bilDistrict,
      required this.bilPincode,
      required this.bilState,
      required this.companyName,
      required this.contactName,
      required this.createdBy,
      required this.createdOn,
      required this.customerCode,
      required this.customerEmail,
      required this.customerGroup,
      required this.customerMobile,
      required this.customerName,
      required this.delAddress1,
      required this.delAddress2,
      required this.delAddress3,
      required this.delArea,
      required this.delCity,
      required this.delCountry,
      required this.delDistrict,
      required this.delPincode,
      required this.delState,
      required this.GSTNo,
      required this.PAN,
      required this.status,
      required this.storeCode,
      required this.updatedOn,
      required this.updatedBy,
      required this.traceid,
      required this.facebook,
      required this.cardtype});
  int? id;
  String? customerCode;
  String? customerName;
  String? customerMobile;
  String? alternateMobileNo;
  String? contactName;
  String? customerEmail;
  String? companyName;
  String? customerGroup;
  String? PAN;
  String? GSTNo;
  String? bilAddress1;
  String? bilAddress2;
  String? bilAddress3;
  String? bilArea;
  String? bilCity;
  String? bilDistrict;
  String? bilState;
  String? bilCountry;
  String? bilPincode;
  String? delAddress1;
  String? delAddress2;
  String? delAddress3;
  String? delArea;
  String? delCity;
  String? delDistrict;
  String? delState;
  String? delCountry;
  String? delPincode;
  String? storeCode;
  String? codeId;
  bool? status;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn;
  String? traceid;
  String? facebook;
  String? cardtype;

  factory AccountsNewData.fromJson(Map<String, dynamic> json) =>
      AccountsNewData(
          alternateMobileNo: json['alternateMobileNo'] ?? '',
          codeId: json['codeId'] ?? '', //
          bilAddress1: json['bilAddress1'] ?? '',
          bilAddress2: json['bilAddress2'] ?? '',
          bilAddress3: json['bilAddress3'] ?? '',
          bilArea: json['bilArea'] ?? '',
          bilCity: json['bilCity'] ?? '',
          bilCountry: json['country'] ?? '',
          bilDistrict: json['bilDistrict'] ?? '',
          bilPincode: json['bilPincode'] ?? '',
          bilState: json['bilState'] ?? '',
          companyName: json['companyName'] ?? '',
          contactName: json['contactName'] ?? '',
          createdBy: json['createdBy'] ?? 0,
          createdOn: json['createdOn'] ?? '',
          customerCode: json['customerCode'] ?? '',
          customerEmail: json['customerEmail'] ?? '',
          customerGroup: json['customerGroup'] ?? '',
          customerMobile: json['customerMobile'] ?? '',
          customerName: json['customerName'] ?? '',
          delAddress1: json['delAddress1'] ?? '',
          delAddress2: json['delAddress2'] ?? '',
          delAddress3: json['delAddress3'] ?? '',
          delArea: json['delArea'] ?? '',
          delCity: json['delCity'] ?? '',
          delCountry: json['delCountry'] ?? '',
          delDistrict: json['Del_District'] ?? '', //
          delPincode: json['delPincode'] ?? '',
          delState: json['delState'] ?? '',
          GSTNo: json['gstno'] ?? '',
          PAN: json['pan'] ?? '',
          status: json['status'] ?? false,
          storeCode: json['storeCode'] ?? '',
          updatedBy: json['updatedBy'] ?? 0,
          updatedOn: json['updatedOn'] ?? '',
          traceid: json['traceid'] ?? '',
          facebook: json['facebook'] ?? '',
          cardtype: json['cardtype'] ?? '',
          id: json['id'] ?? 0);
}
