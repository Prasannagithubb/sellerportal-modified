import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetOutstandingsApi {
  OutstandingData? itemdata;
  String rescode;
  String? exception;
  int? stcode;
  GetOutstandingsApi(
      {required this.itemdata,
      required this.rescode,
      this.exception,
      required this.stcode});

  static Future<GetOutstandingsApi> callapi() async {
    Responce res = Responce();

    String? token = await SharedPre.getToken();

    res = await ServiceGet.callApi(
        "${UtilsVariables.url}/GetAllOutstandings", token!);
    return GetOutstandingsApi.fromJson(res);
  }

  factory GetOutstandingsApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var jsons = jsonDecode(res.responceBody!);
      if (jsons['data'] != null && jsons.isNotEmpty) {
        // var data = jsonDecode(jsons['data']);
        // var datalist =
        //     data.map((e) => OutstandingData.fromJson(jsons)).toList();
        return GetOutstandingsApi(
            itemdata: OutstandingData.fromJson(jsons['data']),
            rescode: "Success",
            stcode: res.resCode,
            exception: null);
      } else {
        return GetOutstandingsApi(
            itemdata: null,
            rescode: jsons['respCode'],
            stcode: res.resCode,
            exception: jsons['respDesc']);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);
      return GetOutstandingsApi(
          itemdata: null,
          rescode: jsons['respCode'],
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return GetOutstandingsApi(
          itemdata: null,
          rescode: 'Exception',
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}

class OutstandingData {
  List<OutstandingMaster>? masterData;
  OutstandingData({required this.masterData});
  factory OutstandingData.fromJson(String data) {
    Map<String, dynamic> jsons = jsonDecode(data);
    //  if (jsons["data"] != null) {
    if (jsons['OutstandingMaster'] == null) {
      return OutstandingData(
        masterData: null,
      );
    } else {
      var data = jsons['OutstandingMaster'] as List;

      List<OutstandingMaster> dataList =
          data.map((data) => OutstandingMaster.fromJson(data)).toList();
      return OutstandingData(
        masterData: dataList,
      );
    }
  }
}

class OutstandingMaster {
  OutstandingMaster({
    required this.id,
    required this.customerCode,
    required this.customerName,
    required this.customerMobile,
    required this.alternateMobileNo,
    required this.contactName,
    required this.customerEmail,
    required this.companyName,
    required this.customerGroup,
    required this.transAmount,
    required this.penaltyAfterDue,
    required this.collectionInc,
    required this.amountPaid,
    required this.balancetoPay,
    required this.assigntoUsername,
    required this.storeCode,
  });
  int? id;
  String? customerCode; //
  String? customerName; //
  String? customerMobile; //
  String? alternateMobileNo; //
  String? contactName; //
  String? customerEmail; //
  String? companyName; //
  String? customerGroup; //
  double? transAmount; //
  double? penaltyAfterDue; //
  double? collectionInc; //
  double? amountPaid; //
  double? balancetoPay; //
  String? assigntoUsername; //
  String? storeCode; //

  factory OutstandingMaster.fromJson(Map<String, dynamic> json) =>
      OutstandingMaster(
        id: json[''],
        customerCode: json['CustomerCode'],
        customerName: json['CustomerName'],
        customerMobile: json['CustomerMobile'],
        alternateMobileNo: json['AlternateMobileNo'],
        contactName: json['ContactName'],
        customerEmail: json['CustomerEmail'],
        companyName: json['CompanyName'],
        customerGroup: json['CustomerGroup'],
        transAmount: json['TransAmount'],
        penaltyAfterDue: json['PenaltyAfterDue'],
        collectionInc: json['CollectionInc'],
        amountPaid: json['AmountPaid'],
        balancetoPay: json['BalanceToPay'],
        assigntoUsername: json['AssignedTo'],
        storeCode: json['StoreCode'],
      );
}
