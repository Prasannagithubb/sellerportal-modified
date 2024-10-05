import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class GetAllEnquiryApi {
  String? resType;
  String? resCode;
  String? resDesc;
  int? stcode;
  List<GetAllEnqData>? data;

  GetAllEnquiryApi({
    required this.resCode,
    required this.resDesc,
    required this.resType,
    required this.stcode,
    required this.data,
  });

  static Future<GetAllEnquiryApi> getmethod() async {
    Map<String, dynamic> body = {
      "listtype": "summary",
      "valuetype": "name",
      "fromperiod": null,
      "toperiod": null,
      "status": null
    };
    Responce res = Responce();
    UtilsVariables.token=await SharedPre.getToken();
    res = await ServicePost.callApi('${UtilsVariables.url}/GetAllEnquiries', UtilsVariables.token, body);
    return GetAllEnquiryApi.fromJson(res);
  }

  factory GetAllEnquiryApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      Map<String, dynamic> json = jsonDecode(res.responceBody!);
      var list = jsonDecode(json['data']) as List;
      List<GetAllEnqData>? dataList =
          list.map((data) => GetAllEnqData.fromJson(data)).toList();

      return GetAllEnquiryApi(
          resCode: json['respCode'],
          resDesc: json['respDesc'],
          resType: json['respType'],
          stcode: res.resCode!,
          data: dataList);
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      Map<String, dynamic> json = jsonDecode(res.responceBody!);

      return GetAllEnquiryApi(
          resCode: json['respCode'],
          resDesc: json['respDesc'],
          resType: json['respType'],
          stcode: res.resCode!,
          data: null);
    } else {
      return GetAllEnquiryApi(
          resCode: null,
          resDesc: 'Exception: ${res.responceBody}',
          resType: null,
          stcode: res.resCode!,
          data: null);
    }
  }
}

class GetAllEnqData {
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
  String? addressLine1; //
  String? addressLine2; //
  String? pincode; //
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

  GetAllEnqData({
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
  factory GetAllEnqData.fromJson(Map<String, dynamic> json) => GetAllEnqData(
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
      pincode: json['PinCode'].toString(), //
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
      quantity: json['Quantity'], //
      isVisitRequired: json["IsVisitRequired"] ?? '', //
      visitTime: json['VisitTime'] ?? '', //
      remindOn: json['RemindOn'] ?? '', //
      isClosed: json['isClosed'] ?? '', //
      leadConverted: json['LeadConverted'],
      createdBy: json["CreatedBy"],
      createdDateTime: json['CreatedDateTime'],
      updatedBy: json['UpdatedBy'],
      updatedDateTime: json['UpdatedDateTime']);

  // Map<String, Object?> toMap() => {
  //       EnquiryfilterDBcolumns.enqID: EnqID,
  //       EnquiryfilterDBcolumns.enquiredOn: EnquiredOn,
  //       EnquiryfilterDBcolumns.cardCode: CardCode,
  //       EnquiryfilterDBcolumns.cardName: CardName,
  //       EnquiryfilterDBcolumns.enqDate: EnqDate,
  //       EnquiryfilterDBcolumns.followup: Followup,
  //       EnquiryfilterDBcolumns.status: Status,
  //       EnquiryfilterDBcolumns.mgrUserCode: Mgr_UserCode,
  //       EnquiryfilterDBcolumns.mgrUserName: Mgr_UserName,
  //       EnquiryfilterDBcolumns.assignedToUser: AssignedTo_User,
  //       EnquiryfilterDBcolumns.assignedToUserName: AssignedTo_UserName,
  //       EnquiryfilterDBcolumns.enqType: EnqType,
  //       EnquiryfilterDBcolumns.lookingfor: Lookingfor,
  //       EnquiryfilterDBcolumns.potentialValue: PotentialValue,
  //       EnquiryfilterDBcolumns.addressLine1: Address_Line_1,
  //       EnquiryfilterDBcolumns.addressLine2: Address_Line_2,
  //       EnquiryfilterDBcolumns.pincode: Pincode,
  //       EnquiryfilterDBcolumns.city: City,
  //       EnquiryfilterDBcolumns.state: State,
  //       EnquiryfilterDBcolumns.country: Country,
  //       EnquiryfilterDBcolumns.managerStatusTab: Manager_Status_Tab,
  //       EnquiryfilterDBcolumns.slpStatusTab: Slp_Status_Tab,
  //       EnquiryfilterDBcolumns.email: email,
  //       EnquiryfilterDBcolumns.referal: referal,
  //       EnquiryfilterDBcolumns.contactName: contactName,
  //       EnquiryfilterDBcolumns.altermobileNo: altermobileNo,
  //       EnquiryfilterDBcolumns.customerGroup: customerGroup,
  //       EnquiryfilterDBcolumns.customermobile: customermobile,
  //       EnquiryfilterDBcolumns.comapanyname: comapanyname,
  //       EnquiryfilterDBcolumns.storecode: storecode,
  //       EnquiryfilterDBcolumns.area: area,
  //       EnquiryfilterDBcolumns.district: district,
  //       EnquiryfilterDBcolumns.itemCode: itemCode,
  //       EnquiryfilterDBcolumns.itemname: itemname,
  //       EnquiryfilterDBcolumns.enquirydscription: enquirydscription,
  //       EnquiryfilterDBcolumns.quantity: quantity,
  //       EnquiryfilterDBcolumns.isVisitRequired: isVisitRequired,
  //       EnquiryfilterDBcolumns.visitTime: visitTime,
  //       EnquiryfilterDBcolumns.remindOn: remindOn,
  //       EnquiryfilterDBcolumns.isClosed: isClosed,
  //       EnquiryfilterDBcolumns.leadConverted: leadConverted,
  //       EnquiryfilterDBcolumns.createdBy: createdBy,
  //       EnquiryfilterDBcolumns.createdDateTime: createdDateTime,
  //       EnquiryfilterDBcolumns.updatedBy: updatedBy,
  //       EnquiryfilterDBcolumns.updatedDateTime: updatedDateTime,
  //       EnquiryfilterDBcolumns.interestLevel: InterestLevel,
  //       EnquiryfilterDBcolumns.orderType: OrderType,
  //     };
}
