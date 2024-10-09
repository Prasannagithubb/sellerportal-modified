import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class GetEnquiryDetails {
  String? respCode;
  String? respDesc;
  int? stcode;
  List<GetEnquiryData>? data;
  GetEnquiryDetails({
    required this.respCode,
    required this.respDesc,
    required this.stcode,
    required this.data,
  });
  static Future<GetEnquiryDetails> call(String fromDate, String toDate) async {
    Responce res = Responce();
    Utils utils = Utils();
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
        '${UtilsVariables.url}/GetAllEnquiries', UtilsVariables.token, body);
    print(res.responceBody);
    return GetEnquiryDetails.fromJson(res);
  }

  factory GetEnquiryDetails.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!.toString());
      if (json['data'] != null) {
        var data2 = jsonDecode(json['data'].toString()) as List;

        List<GetEnquiryData> datalist =
            data2.map((e) => GetEnquiryData.fromJson(e)).toList();
        return GetEnquiryDetails(
            data: datalist,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      } else {
        return GetEnquiryDetails(
            data: null,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!.toString());

      return GetEnquiryDetails(
          data: null,
          respDesc: json['respDesc'],
          respCode: json['respCode'],
          stcode: res.resCode);
    } else {
      return GetEnquiryDetails(
          data: null, respDesc: 'No data', respCode: '', stcode: res.resCode);
    }
  }
}

class GetEnquiryData {
  int? enqID; //
  String? enquiredOn;
  String? cardCode; //
  String? cardName; //
  String? enqDate; //
  String? followup; //
  String? status; //
  String? mgrUserCode; //
  String? mgrUserName; //
  String? assignedToUser; //
  String? assignedToUserName; //
  String? enqType;
  String? lookingfor; //
  double? potentialValue; //
  String? addressLine2; //
  String? addressLine1; //
  int? pincode; //
  String? city; //
  String? state; //
  String? country; //
  String? managerStatusTab; //
  String? slpStatusTab; //
  String? email; //
  String? referal; //
  // String? customertag;
  String? contactName;
  String? altermobileNo;
  String? customerGroup;
  String? customermobile;
  String? comapanyname;
  String? storecode;
  String? area;
  String? district;
  String? itemCode;
  String? itemname;
  String? enquirydscription;
  double? quantity;
  String? isVisitRequired;
  String? visitTime;
  String? remindOn;
  String? isClosed;
  bool? leadConverted;
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  String? interestLevel;
  String? orderType;

  GetEnquiryData({
    required this.interestLevel,
    required this.orderType,
    required this.contactName,
    required this.altermobileNo,
    required this.customerGroup,
    required this.mgrUserName,
    required this.comapanyname,
    required this.visitTime,
    required this.remindOn,
    required this.isClosed,
    required this.isVisitRequired,
    required this.storecode,
    required this.area,
    required this.district,
    required this.itemCode,
    required this.itemname,
    required this.leadConverted,
    required this.createdBy,
    required this.createdDateTime,
    required this.updatedBy,
    required this.updatedDateTime,
    required this.enquirydscription,
    required this.quantity,
    required this.enqID,
    required this.cardCode,
    required this.status,
    required this.cardName,
    required this.assignedToUser,
    required this.enqDate,
    required this.followup,
    required this.mgrUserCode,
    required this.assignedToUserName,
    required this.enqType,
    required this.lookingfor,
    required this.potentialValue,
    required this.addressLine1,
    required this.addressLine2,
    required this.pincode,
    required this.city,
    required this.state,
    required this.country,
    required this.managerStatusTab,
    required this.slpStatusTab,
    required this.email,
    required this.referal,
    required this.customermobile,
  });
  factory GetEnquiryData.fromJson(Map<String, dynamic> json) => GetEnquiryData(
      interestLevel: json['InterestLevel'] ?? '',
      orderType: json['OrderType'] ?? '',
      enqID: json['EnquiryID'] ?? 0, //
      cardCode: json['CustomerCode'] ?? '', //
      status: json['CurrentStatus'] ?? '', //
      cardName: json['CustomerName'] ?? '', //
      enqDate: json['EnquiredOn'] ?? '', //
      followup: json['FollowupOn'] ?? '', //
      mgrUserCode: json['mgr_UserCode'] ?? '',
      assignedToUserName: json['AssignedTo'] ?? '', //
      mgrUserName: json['mgr_UserName'] ?? '',
      assignedToUser: json['assignedTo_User'] ?? '',
      enqType: json['EnquiryType'] ?? '', //
      lookingfor: json['Lookingfor'] ?? '', //
      potentialValue: json['Potentialvalue'] ?? 0.00, //
      addressLine1: json['Address1'] ?? '', //
      addressLine2: json['Address2'] ?? '', //
      pincode: json['PinCode'] ?? 0, //
      city: json['City'] ?? '', //
      state: json['State'] ?? '', //
      country: json['Country'] ?? '', //
      managerStatusTab: json['manager_Status_Tab'] ?? '',
      slpStatusTab: json['EnquiryStatus'] ?? '', //
      email: json['CustomerEmail'] ?? '', //
      referal: json['Refferal'] ?? '', //
      contactName: json['ContactName'] ?? '', //
      customerGroup: json['CustomerGroup'] ?? '', //
      altermobileNo: json['AlternateMobileNo'] ?? '',
      customermobile: json["CustomerMobile"] ?? '', //
      comapanyname: json['CompanyName'] ?? '', //
      storecode: json['StoreCode'] ?? '', //
      area: json['BilArea'] ?? '', //
      district: json['District'] ?? '', //
      itemCode: json['ItemCode'] ?? '', //
      itemname: json['ItemName'] ?? '', //
      enquirydscription: json['Enquirydscription'] ?? '', //
      quantity: json['Quantity'] ?? 0.0, //
      isVisitRequired: json["IsVisitRequired"] ?? '', //
      visitTime: json['VisitTime'] ?? '', //
      remindOn: json['RemindOn'] ?? '', //
      isClosed: json['isClosed'] ?? '', //
      leadConverted: json['LeadConverted'] ?? false,
      createdBy: json["CreatedBy"] ?? 0,
      createdDateTime: json['CreatedDateTime'] ?? '',
      updatedBy: json['UpdatedBy'] ?? 0,
      updatedDateTime: json['UpdatedDateTime'] ?? '');
}
