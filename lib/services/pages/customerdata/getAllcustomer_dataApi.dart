import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_noBodyPost.dart';
import 'package:flowkit/services/api_main/service_post.dart';

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
    Map<String, dynamic> body = {
      "listtype": "summary",
      "valuetype": "name",
      "fromperiod": null,
      "toperiod": null,
      "status": null
    };
    String? token = await SharedPre.getToken();

    res = await ServicePost.callApi(
        "${UtilsVariables.url}/AllCustomers", token!, body);
    return GetAllCustomerApi.fromJson(res);
  }

  factory GetAllCustomerApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var jsons = jsonDecode(res.responceBody!);
      if (jsons != null && jsons.isNotEmpty) {
        return GetAllCustomerApi(
            itemdata: Accountsheader.fromJson(jsons),
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
  factory Accountsheader.fromJson(Map<String, dynamic> jsons) {
    //  if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as List;
    if (list.isEmpty) {
      return Accountsheader(
        childdata: null,
      );
    } else {
      List<AccountsNewData> dataList =
          list.map((data) => AccountsNewData.fromJson(data)).toList();
      return Accountsheader(
        childdata: dataList,
      );
    }
  }
}

class AccountsNewData {
  AccountsNewData(
      {required this.alternateMobileNo,
      required this.assignedTo,
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
      required this.traceid});

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
  String? assignedTo;
  String? status;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn;
  String? traceid;

  factory AccountsNewData.fromJson(Map<String, dynamic> json) =>
      AccountsNewData(
          alternateMobileNo: json['AlternateMobileNo'] ?? '',
          assignedTo: json['AssignedTo'] ?? '',
          bilAddress1: json['Bil_Address1'] ?? '',
          bilAddress2: json['Bil_Address2'] ?? '',
          bilAddress3: json['Bil_Address3'] ?? '',
          bilArea: json['Bil_Area'] ?? '',
          bilCity: json['Bil_City'] ?? '',
          bilCountry: json['Bil_Country'] ?? '',
          bilDistrict: json['Bil_District'] ?? '',
          bilPincode: json['Bil_Pincode'] ?? '',
          bilState: json['Bil_State'] ?? '',
          companyName: json['CompanyName'] ?? '',
          contactName: json['ContactName'] ?? '',
          createdBy: json['CreatedBy'] ?? 0,
          createdOn: json['CreatedOn'] ?? '',
          customerCode: json['CustomerCode'] ?? '',
          customerEmail: json['CustomerEmail'] ?? '',
          customerGroup: json['CustomerGroup'] ?? '',
          customerMobile: json['CustomerMobile'] ?? '',
          customerName: json['CustomerName'] ?? '',
          delAddress1: json['Del_Address1'] ?? '',
          delAddress2: json['Del_Address2'] ?? '',
          delAddress3: json['Del_Address3'] ?? '',
          delArea: json['Del_Area'] ?? '',
          delCity: json['Del_City'] ?? '',
          delCountry: json['Del_Country'] ?? '',
          delDistrict: json['Del_District'] ?? '',
          delPincode: json['Del_Pincode'] ?? '',
          delState: json['Del_State'] ?? '',
          GSTNo: json['GSTNo'] ?? '',
          PAN: json['PAN'] ?? '',
          status: json['Status'] ?? '',
          storeCode: json['StoreCode'] ?? '',
          updatedBy: json['UpdatedBy'] ?? 0,
          updatedOn: json['UpdatedOn'] ?? '',
          traceid: json['traceid'] ?? '');
}
