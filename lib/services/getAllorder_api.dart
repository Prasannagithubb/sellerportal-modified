import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class GetAllOrderApi {
  String? resType;
  String? resDesc;
  String? resCode;
  int? stCode;

  List<GetAllOrderData>? data;
  GetAllOrderApi({
    required this.resType,
    required this.resDesc,
    required this.data,
    required this.resCode,
    required this.stCode,
  });

  static Future<GetAllOrderApi> getmethod() async {
    Map<String, dynamic> body = {
      "listtype": "summary",
      "valuetype": "name",
      "fromperiod": null,
      "toperiod": null,
      "status": null
    };
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    res = await ServicePost.callApi('${UtilsVariables.url}/GetAllOrders', UtilsVariables.token, body);
    return GetAllOrderApi.fromJson(res);
  }

  factory GetAllOrderApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      Map<String, dynamic> json = jsonDecode(res.responceBody!);
      var list = jsonDecode(json['data']) as List;
      List<GetAllOrderData> datalist =
          list.map((toElement) => GetAllOrderData.fromJson(toElement)).toList();
      if (datalist.length >= 10) {
        datalist = datalist.sublist(datalist.length - 11, datalist.length - 1);
      }
      if (datalist.isEmpty) {
        return GetAllOrderApi(
            resType: json['respType'],
            resDesc: json['respDesc'],
            data: null,
            resCode: json['respCode'],
            stCode: res.resCode);
      } else {
        return GetAllOrderApi(
            resType: json['respType'],
            resDesc: json['respDesc'],
            data: datalist,
            resCode: json['respCode'],
            stCode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      Map<String, dynamic> json = jsonDecode(res.responceBody!);
      return GetAllOrderApi(
          resType: json['respType'],
          resDesc: json['respDesc'],
          data: null,
          resCode: json['respCode'],
          stCode: res.resCode);
    } else {
      return GetAllOrderApi(
          resType: 'Exception',
          resDesc: res.responceBody,
          data: null,
          resCode: '',
          stCode: res.resCode);
    }
  }
}

class GetAllOrderData {
  int? orderDocEntry; //
  int? followupEntry;
  int? orderNum;
  String? deliveryDueDate;
  String? paymentDueDate;
  String? alternateMobileNo;
  String? contactName;
  String? customerEmail;
  String? companyName;
  String? pAN;
  String? gSTNo;
  String? customerPORef;
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
  String? deliveryFrom;
  String? orderStatus;
  String? currentStatus;
  String? dealID;
  int? baseID;
  String? baseType;
  String? baseDocDate;
  double? grossTotal;
  double? discount;
  double? subTotal;
  double? taxAmount;
  double roundOff;
  String? attachURL1;
  String? attachURL2;
  String? attachURL3;

  String? mobile; //
  String? customerName; //
  String? docDate;
  // String? City;
  // String? NextFollowup;
  String? product;
  String? createdon; //
  double? value; //
  String? status; //
  String? lastUpdateMessage; //
  String? lastUpdateTime; //
  String? enqid;
  String? leadid;
  int? isDelivered;
  int? isInvoiced;
  String? orderType;
  String? customerGroup;

  GetAllOrderData({
    required this.customerGroup,
    required this.orderType,
    required this.createdon,
    required this.isDelivered,
    required this.isInvoiced,
    required this.orderDocEntry,
    required this.orderNum,
    required this.mobile,
    required this.customerName,
    required this.docDate,
    required this.assignedTo,
    required this.attachURL1,
    required this.attachURL2,
    required this.attachURL3,
    required this.baseDocDate,
    required this.baseID,
    required this.baseType,
    required this.currentStatus,
    required this.dealID,
    required this.delAddress2,
    required this.delAddress3,
    required this.delArea,
    required this.delCity,
    required this.delCountry,
    required this.delDistrict,
    required this.delPincode,
    required this.delState,
    required this.deliveryFrom,
    required this.discount,
    required this.followupEntry,
    required this.lastUpdateMessage,
    required this.grossTotal,
    required this.lastUpdateTime,
    required this.orderStatus,
    required this.product,
    required this.roundOff,
    required this.status,
    required this.storeCode,
    required this.subTotal,
    required this.taxAmount,
    required this.value,
    required this.alternateMobileNo,
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
    required this.customerEmail,
    required this.customerPORef,
    required this.delAddress1,
    required this.deliveryDueDate,
    required this.enqid,
    required this.gSTNo,
    required this.leadid,
    required this.pAN,
    required this.paymentDueDate,
    // required this.City,
    // required this.NextFollowup,
  });

  factory GetAllOrderData.fromJson(Map<String, dynamic> json) {
    // print("inside data class"+json.toString());
    return GetAllOrderData(
        customerGroup: json['CustomerGroup'] ?? '',
        orderType: json['OrderType'] ?? '',
        createdon: json['CreatedOn'] ?? '',
        isDelivered: json['isDelivered'],
        isInvoiced: json['isInvoiced'],
        orderDocEntry: json['DocEntry'],
        orderNum: json['OrderNumber'],
        mobile: json['CustomerCode'],
        customerName: json['CustomerName'],
        docDate: json['DocDate'],
        assignedTo: json['AssignedTo'],
        attachURL1: json['AttachURL1'],
        attachURL2: json['AttachURL2'],
        attachURL3: json['AttachURL3'],
        baseDocDate: json['BaseDocDate'],
        baseID: json['BaseID'],
        baseType: json['BaseType'],
        currentStatus: json['CurrentStatus'],
        dealID: json['DealID'],
        delAddress2: json['Del_Address2'],
        delAddress3: json['Del_Address3'],
        delArea: json['Del_Area'],
        delCity: json['Del_City'],
        delCountry: json['Del_Country'],
        delDistrict: json['Del_District'],
        delPincode: json['Del_Pincode'],
        delState: json['Del_State'],
        deliveryFrom: json['DeliveryFrom'],
        discount: json['Discount'],
        followupEntry: json['DocEntry'],
        lastUpdateMessage: json['OrderStatus'],
        grossTotal: json['GrossTotal'],
        lastUpdateTime: json['UpdatedOn'],
        orderStatus: json['OrderStatus'],
        product: json['ItemName'],
        roundOff: json['RoundOff'],
        status: json['OrderStatus'],
        storeCode: json['StoreCode'],
        subTotal: json['SubTotal'],
        taxAmount: json['TaxAmount'],
        value: json['DocTotal'],
        alternateMobileNo: json['AlternateMobileNo'],
        bilAddress1: json['Bil_Address1'],
        bilAddress2: json['Bil_Address2'],
        bilAddress3: json['Bil_Address3'],
        bilArea: json['Bil_Area'],
        bilCity: json['Bil_City'],
        bilCountry: json['Bil_Country'],
        bilDistrict: json['Bil_District'],
        bilPincode: json['Bil_Pincode'],
        bilState: json['Bil_State'],
        companyName: json['CompanyName'],
        contactName: json['ContactName'],
        customerEmail: json['CustomerEmail'],
        customerPORef: json['CustomerPORef'],
        delAddress1: json['Del_Address1'],
        deliveryDueDate: json['DeliveryDueDate'],
        enqid: json[''],
        gSTNo: json['GSTNo'],
        leadid: json[''],
        pAN: json['PAN'],
        paymentDueDate: json['PaymentDueDate']);
  }
//  Map<String, Object?> toMap() =>{
//   OrderfilterDBcolumns.orderDocEntry:OrderDocEntry,
//   OrderfilterDBcolumns.followupEntry :FollowupEntry,
//   OrderfilterDBcolumns.orderNum:OrderNum,
//   OrderfilterDBcolumns.deliveryDueDate:deliveryDueDate,
//   OrderfilterDBcolumns.paymentDueDate:paymentDueDate,
//   OrderfilterDBcolumns.alternateMobileNo:alternateMobileNo,
//   OrderfilterDBcolumns.contactName:contactName,
//   OrderfilterDBcolumns.companyName:companyName,
//   OrderfilterDBcolumns.pAN:pAN,
//   OrderfilterDBcolumns.gSTNo:gSTNo,
//   OrderfilterDBcolumns.customerPORef:customerPORef,
//   OrderfilterDBcolumns.bil_Address1 :bil_Address1,
//   OrderfilterDBcolumns.bil_Address2 :bil_Address2 ,
//   OrderfilterDBcolumns.bil_Address3:bil_Address3,
//   OrderfilterDBcolumns.bil_Area:bil_Area,
//   OrderfilterDBcolumns.bil_City:bil_City,
//   OrderfilterDBcolumns.bil_District:bil_District,
//   OrderfilterDBcolumns.bil_State:bil_State,
//   OrderfilterDBcolumns.bil_Country:bil_Country,
//   OrderfilterDBcolumns.bil_Pincode:bil_Pincode,
//   OrderfilterDBcolumns.del_Address1:del_Address1,
//   OrderfilterDBcolumns.del_Address2:Del_Address2,
//   OrderfilterDBcolumns.del_Address3:Del_Address3,
//   OrderfilterDBcolumns.Del_Area:Del_Area,
//   OrderfilterDBcolumns.del_City:Del_City,
//   OrderfilterDBcolumns.del_District:Del_District,
//   OrderfilterDBcolumns.del_State:Del_State,
//   OrderfilterDBcolumns.del_Country:Del_Country,
//   OrderfilterDBcolumns.del_Pincode:Del_Pincode,
//   OrderfilterDBcolumns.storeCode:StoreCode,
//   OrderfilterDBcolumns.assignedTo:AssignedTo,
//   OrderfilterDBcolumns.deliveryFrom:DeliveryFrom,
//   OrderfilterDBcolumns.orderStatus:OrderStatus,
//   OrderfilterDBcolumns.currentStatus:CurrentStatus,
//   OrderfilterDBcolumns.dealID:DealID,
//   OrderfilterDBcolumns.baseID:BaseID,
//   OrderfilterDBcolumns.baseType:BaseType,
//   OrderfilterDBcolumns.baseDocDate:BaseDocDate,
//   OrderfilterDBcolumns.grossTotal:GrossTotal,
//   OrderfilterDBcolumns.discount:Discount,
//   OrderfilterDBcolumns.subTotal:SubTotal,
//   OrderfilterDBcolumns.taxAmount:TaxAmount,
//   OrderfilterDBcolumns.roundOff:RoundOff,
//   OrderfilterDBcolumns.attachURL1:AttachURL1,
//   OrderfilterDBcolumns.attachURL2:AttachURL2,
//   OrderfilterDBcolumns.attachURL3:AttachURL3,
//   OrderfilterDBcolumns.mobile:Mobile,
//   OrderfilterDBcolumns.customerName:CustomerName,
//   OrderfilterDBcolumns.docDate:DocDate,
//   OrderfilterDBcolumns.product:Product,
//   OrderfilterDBcolumns.createdon:createdon,
//    OrderfilterDBcolumns.value:Value,
//     OrderfilterDBcolumns.status:Status,
//      OrderfilterDBcolumns.lastUpdateMessage:LastUpdateMessage,
//       OrderfilterDBcolumns.lastUpdateTime:LastUpdateTime,
//       OrderfilterDBcolumns.enqid:enqid,
//       OrderfilterDBcolumns.leadid:leadid,
//       OrderfilterDBcolumns.isDelivered:isDelivered,
//       OrderfilterDBcolumns.isInvoiced:isInvoiced,
//       OrderfilterDBcolumns.orderType:OrderType,
//       OrderfilterDBcolumns.customerGroup:CustomerGroup,

//  };
}
