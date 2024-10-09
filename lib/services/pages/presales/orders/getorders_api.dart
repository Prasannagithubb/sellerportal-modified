import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class GetOrdersDetails {
  String? respCode;
  String? respDesc;
  int? stcode;
  List<GetOrdersData>? data;
  GetOrdersDetails({
    required this.respCode,
    required this.respDesc,
    required this.stcode,
    required this.data,
  });
  static Future<GetOrdersDetails> call(String fromDate, String toDate) async {
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
        '${UtilsVariables.url}/GetAllOrders', UtilsVariables.token, body);
    return GetOrdersDetails.fromJson(res);
  }

  factory GetOrdersDetails.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!.toString());
      if (json['data'] != null) {
        var data2 = jsonDecode(json['data'].toString()) as List;
        print(json['data']);

        List<GetOrdersData> datalist =
            data2.map((e) => GetOrdersData.fromJson(e)).toList();
        return GetOrdersDetails(
            data: datalist,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      } else {
        return GetOrdersDetails(
            data: null,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!.toString());

      return GetOrdersDetails(
          data: null,
          respDesc: json['respDesc'],
          respCode: json['respCode'],
          stcode: res.resCode);
    } else {
      return GetOrdersDetails(
          data: null, respDesc: 'No data', respCode: '', stcode: res.resCode);
    }
  }
}

class GetOrdersData {
  int? docEntry;
  int? orderNumber;
  String? docDate;
  String? deliveryDueDate;
  String? paymentDueDate;
  String? customerCode;
  String? customerName;
  String? customerMobile;
  String? alternateMobileNo;
  String? contactName;
  String? customerEmail;
  String? companyName;
  String? customerGroup;
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
  String? orderType;
  String? currentStatus;
  String? itemName;
  dynamic dealID;
  int? baseID;
  String? baseType;
  String? baseDocDate;
  double? grossTotal;
  double? discount;
  double? subTotal;
  double? taxAmount;
  double? roundOff;
  double? docTotal;
  String? attachURL1;
  String? attachURL2;
  String? attachURL3;
  String? attachURL4;
  String? attachURL5;
  String? orderNote;
  int? isDelivered;
  String? deliveryDate;
  String? deliveryNo;
  String? deliveryURL1;
  String? deliveryURL2;
  int? isInvoiced;
  String? invoiceDate;
  String? invoiceNo;
  double? invoiceTotal;
  String? invoiceURL1;
  String? invoiceURL2;
  int? isCancelled;
  String? cancelledDate;
  String? cancelledReason;
  String? cancelledRemarks;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn;
  String? traceid;

  GetOrdersData({
    required this.docEntry,
    required this.orderNumber,
    required this.docDate,
    required this.deliveryDueDate,
    required this.paymentDueDate,
    required this.customerCode,
    required this.customerName,
    required this.customerMobile,
    required this.alternateMobileNo,
    required this.contactName,
    required this.customerEmail,
    required this.companyName,
    required this.customerGroup,
    required this.pAN,
    required this.gSTNo,
    required this.customerPORef,
    required this.bilAddress1,
    required this.bilAddress2,
    required this.bilAddress3,
    required this.bilArea,
    required this.bilCity,
    required this.bilDistrict,
    required this.bilState,
    required this.bilCountry,
    required this.bilPincode,
    required this.delAddress1,
    required this.delAddress2,
    required this.delAddress3,
    required this.delArea,
    required this.delCity,
    required this.delDistrict,
    required this.delState,
    required this.delCountry,
    required this.delPincode,
    required this.storeCode,
    required this.assignedTo,
    required this.deliveryFrom,
    required this.orderStatus,
    required this.orderType,
    required this.currentStatus,
    required this.itemName,
    required this.dealID,
    required this.baseID,
    required this.baseType,
    required this.baseDocDate,
    required this.grossTotal,
    required this.discount,
    required this.subTotal,
    required this.taxAmount,
    required this.roundOff,
    required this.docTotal,
    required this.attachURL1,
    required this.attachURL2,
    required this.attachURL3,
    required this.attachURL4,
    required this.attachURL5,
    required this.orderNote,
    required this.isDelivered,
    required this.deliveryDate,
    required this.deliveryNo,
    required this.deliveryURL1,
    required this.deliveryURL2,
    required this.isInvoiced,
    required this.invoiceDate,
    required this.invoiceNo,
    required this.invoiceTotal,
    required this.invoiceURL1,
    required this.invoiceURL2,
    required this.isCancelled,
    required this.cancelledDate,
    required this.cancelledReason,
    required this.cancelledRemarks,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.traceid,
  });

  factory GetOrdersData.fromJson(Map<String, dynamic> json) => GetOrdersData(
      docEntry: json["DocEntry"] ?? 0, //
      orderNumber: json["OrderNumber"] ?? 0, //
      docDate: json["DocDate"] ?? "",
      deliveryDueDate: json["DeliveryDueDate"] ?? "",
      paymentDueDate: json["PaymentDueDate"] ?? "",
      customerCode: json["CustomerCode"] ?? "",
      customerName: json["CustomerName"] ?? "",
      customerMobile: json["CustomerMobile"] ?? "",
      alternateMobileNo: json["AlternateMobileNo"] ?? "",
      contactName: json["ContactName"] ?? "",
      customerEmail: json["CustomerEmail"] ?? "",
      companyName: json["CompanyName"] ?? "",
      customerGroup: json["CustomerGroup"] ?? "",
      pAN: json["PAN"] ?? "",
      gSTNo: json["GSTNo"] ?? "",
      customerPORef: json["CustomerPORef"] ?? "",
      bilAddress1: json["Bil_Address1"] ?? "",
      bilAddress2: json["Bil_Address2"] ?? "",
      bilAddress3: json["Bil_Address3"] ?? "",
      bilArea: json["Bil_Area"] ?? "",
      bilCity: json["Bil_City"] ?? "",
      bilDistrict: json["Bil_District"] ?? "",
      bilState: json["Bil_State"] ?? "",
      bilCountry: json["Bil_Country"] ?? "",
      bilPincode: json["Bil_Pincode"] ?? "",
      delAddress1: json["Del_Address1"] ?? "",
      delAddress2: json["Del_Address2"] ?? "",
      delAddress3: json["Del_Address3"] ?? "",
      delArea: json["Del_Area"] ?? "",
      delCity: json["Del_City"] ?? "",
      delDistrict: json["Del_District"] ?? "",
      delState: json["Del_State"] ?? "",
      delCountry: json["Del_Country"] ?? "",
      delPincode: json["Del_Pincode"] ?? "",
      storeCode: json["StoreCode"] ?? "",
      assignedTo: json["AssignedTo"] ?? "",
      deliveryFrom: json["DeliveryFrom"] ?? "",
      orderStatus: json["OrderStatus"] ?? "",
      orderType: json["OrderType"] ?? "",
      currentStatus: json[" CurrentStatus"] ?? "",
      itemName: json["ItemName"] ?? "",
      dealID: json["DealID"] ?? 0, //
      baseID: json["BaseID"] ?? 0, //
      baseType: json["BaseType"] ?? "",
      baseDocDate: json["BaseDocDate"] ?? "",
      grossTotal: json["GrossTotal"] ?? 0.0,
      discount: json["Discount"] ?? 0.0,
      subTotal: json["SubTotal"] ?? 0.0,
      taxAmount: json["TaxAmount"] ?? 0.0,
      roundOff: json["RoundOff"] ?? 0.0,
      docTotal: json["DocTotal"] ?? 0.0,
      attachURL1: json["AttachURL1"] ?? "",
      attachURL2: json["AttachURL2"] ?? "",
      attachURL3: json["AttachURL3"] ?? "",
      attachURL4: json["AttachURL4"] ?? "",
      attachURL5: json["AttachURL5"] ?? "",
      orderNote: json["OrderNote"] ?? "",
      isDelivered: json["isDelivered"] ?? 0, //
      deliveryDate: json["DeliveryDate"] ?? "",
      deliveryNo: json["DeliveryNo"] ?? "",
      deliveryURL1: json["DeliveryURL1"] ?? "",
      deliveryURL2: json["DeliveryURL2"] ?? "",
      isInvoiced: json["isInvoiced"] ?? 0, //
      invoiceDate: json["InvoiceDate"] ?? "",
      invoiceNo: json["InvoiceNo"] ?? "",
      invoiceTotal: json["InvoiceTotal"] ?? 0.0,
      invoiceURL1: json["InvoiceURL1"] ?? "",
      invoiceURL2: json["InvoiceURL2"] ?? "",
      isCancelled: json["isCancelled"] ?? 0, //
      cancelledDate: json["CancelledDate"] ?? "",
      cancelledReason: json["CancelledReason"] ?? "",
      cancelledRemarks: json["CancelledRemarks"] ?? "",
      createdBy: json["CreatedBy"] ?? 0, //
      createdOn: json["CreatedOn"] ?? "",
      updatedBy: json["UpdatedBy"] ?? 0, //
      updatedOn: json["UpdatedOn"] ?? "",
      traceid: json["traceid"] ?? '');
}
