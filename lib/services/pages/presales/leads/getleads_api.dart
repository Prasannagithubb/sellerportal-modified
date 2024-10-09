import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class GetLeadsDetails {
  String? respCode;
  String? respDesc;
  int? stcode;
  List<GetLeadsData>? data;
  GetLeadsDetails({
    required this.respCode,
    required this.respDesc,
    required this.stcode,
    required this.data,
  });
  static Future<GetLeadsDetails> call(String fromDate, String toDate) async {
    Responce res = Responce();
    print(fromDate);
    print(toDate);

    UtilsVariables.token = await SharedPre.getToken();
    Map<String, dynamic> body = {
      "listtype": "all",
      "valuetype": "name",
      "fromperiod": "${fromDate}",
      "toperiod": "${toDate}",
      "status": null
    };
    res = await ServicePost.callApi(
        '${UtilsVariables.url}/GetAllLeads', UtilsVariables.token, body);
    return GetLeadsDetails.fromJson(res);
  }

  factory GetLeadsDetails.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!.toString());
      if (json['data'] != null) {
        var data2 = jsonDecode(json['data'].toString()) as List;
        print(json['data']);

        List<GetLeadsData> datalist =
            data2.map((e) => GetLeadsData.fromJson(e)).toList();
        return GetLeadsDetails(
            data: datalist,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      } else {
        return GetLeadsDetails(
            data: null,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!.toString());

      return GetLeadsDetails(
          data: null,
          respDesc: json['respDesc'],
          respCode: json['respCode'],
          stcode: res.resCode);
    } else {
      return GetLeadsDetails(
          data: null, respDesc: 'No data', respCode: '', stcode: res.resCode);
    }
  }
}

class GetLeadsData {
  int? leadDocEntry;
  int? followupEntry;
  int? leadNum;
  String? mobile;
  String? customerName;
  String? docDate;
  String? city;
  String? nextFollowup;
  String? product;
  double? value;
  String? status;
  String? lastUpdateMessage;
  String? lastUpdateTime;
  String? customermob;
  String? cusEmail;
  String? companyname;
  String? cusgroup;
  String? storecode;
  String? add1;
  String? add2;
  String? area;

  String? district;
  String? state;
  String? country;
  int? pincode;
  String? gender;
  String? agegroup;
  String? cameAs;
  int? headcount;
  double? maxbudget;
  String? assignedTo;
  String? refferal;
  String? purchasePlan;
  String? dealDescription;
  String? lastFollowupDate;

  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  String? traceId;
  int? isselected;
  String? interestLevel;
  String? orderType;
  GetLeadsData({
    required this.interestLevel,
    required this.orderType,
    this.isselected,
    required this.leadDocEntry,
    required this.leadNum,
    required this.mobile,
    required this.customerName,
    required this.docDate,
    required this.city,
    required this.nextFollowup,
    required this.product,
    required this.value,
    required this.status,
    required this.lastUpdateMessage,
    required this.lastUpdateTime,
    required this.followupEntry,
    required this.customermob,
    required this.cusEmail,
    required this.companyname,
    required this.cusgroup,
    required this.storecode,
    required this.add1,
    required this.add2,
    required this.area,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.gender,
    required this.agegroup,
    required this.cameAs,
    required this.headcount,
    required this.maxbudget,
    required this.assignedTo,
    required this.refferal,
    required this.purchasePlan,
    required this.dealDescription,
    required this.lastFollowupDate,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.traceId,
  });

  factory GetLeadsData.fromJson(Map<String, dynamic> json) => GetLeadsData(
        interestLevel: json['InterestLevel'] ?? '',
        orderType: json['OrderType'] ?? '',
        leadDocEntry: json['LeadId'] ?? -1,
        leadNum: json['LeadId'] ?? -1, //
        mobile: json['CustomerCode'] ?? '', //
        customerName: json['CustomerName'] ?? '', //
        docDate: json['docDate'] ?? '',
        city: json['City'] ?? '', //
        nextFollowup: json['NextFollowupDate'] ?? '', //
        product: json['ItemName'] ?? '', //
        value: json['LeadValue'] ?? 0.0, //
        status: json['Status'] ?? '', //
        lastUpdateMessage: json['LastFollowupStatus'] ?? '', //
        lastUpdateTime: json['CreatedDate'] ?? '', //
        followupEntry: 0,
        customermob: json['CustomerMobile'],
        cusEmail: json['CustomerEmail'] ?? '',
        companyname: json['CompanyName'],
        cusgroup: json['CustomerGroup'],
        storecode: json['StoreCode'],
        add1: json['Address1'] ?? '',
        add2: json['Address2'] ?? '',
        area: json['Area'] ?? '',
        district: json['District'] ?? '',
        state: json['State'] ?? '',
        country: json['Country'] ?? '',
        pincode: json['Pincode'] ?? 0,
        gender: json['Gender'] ?? '',
        agegroup: json['AgeGroup'] ?? '',
        cameAs: json['CameAs'] ?? '',
        headcount: json['Headcount'] ?? 0,
        maxbudget: json['Maxbudget'] ?? 0.0,
        assignedTo: json['AssignedTo'] ?? '',
        refferal: json['Refferal'] ?? '',
        purchasePlan: json['PurchasePlan'] ?? '',
        dealDescription: json['DealDescription'] ?? '',
        lastFollowupDate: json['LastFollowupDate'] ?? '',
        createdBy: json['CreatedBy'] ?? 0,
        createdDate: json['CreatedDate'] ?? '',
        updatedBy: json['UpdatedBy'] ?? 0,
        updatedDate: json['UpdatedDate'] ?? '',
        traceId: json['TraceId'] ?? '',
      );
}
