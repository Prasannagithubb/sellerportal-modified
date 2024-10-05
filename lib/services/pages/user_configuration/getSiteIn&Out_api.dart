import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetSiteinOutApi {
  String? respCode;
  String? respDesc;
  int? stcode;
  List<GetSiteInoutData>? data;
  GetSiteinOutApi({
    required this.respCode,
    required this.respDesc,
    required this.stcode,
    required this.data,
  });
  static Future<GetSiteinOutApi> call(String fromDate, String toDate) async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    res = await ServiceGet.callApi(
        '${UtilsVariables.url}/GetSiteInOut?fromdate=${fromDate}&toDate=${toDate}',
        UtilsVariables.token);

    return GetSiteinOutApi.fromJson(res);
  }

  factory GetSiteinOutApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!.toString());
      if (json['data'] != null) {
        List<dynamic> data2 = json['data'] as List;

        List<GetSiteInoutData> datalist =
            data2.map((e) => GetSiteInoutData.fromJson(e)).toList();
        return GetSiteinOutApi(
            data: datalist,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      } else {
        return GetSiteinOutApi(
            data: null,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!.toString());

      return GetSiteinOutApi(
          data: null,
          respDesc: json['respDesc'],
          respCode: json['respCode'],
          stcode: res.resCode);
    } else {
      return GetSiteinOutApi(
          data: null, respDesc: 'No data', respCode: '', stcode: res.resCode);
    }
  }
}

class GetSiteInoutData {
  String? userCode;
  String? userName;
  String? mobileNo;
  String? customerName;
  String? customerMobile;
  String? customerEmail;
  String? purposeOfvisit;
  String? lookingFor;
  String? visitOutcome;
  String? checkinDateAndTime;
  String? checkoutDateTime;
  String? attachment1;
  String? attachment2;
  String? attachment3;
  String? attachment4;
  double? lat;
  double? longt;
  double? checkOutlat;
  double? checkoutlong;
  String? purPoseOfvisitCode;
  String? checkinAdd;
  String? checkoutAdd;
  GetSiteInoutData({
    required this.userCode,
    required this.userName,
    required this.mobileNo,
    required this.customerName,
    required this.customerMobile,
    required this.customerEmail,
    required this.purposeOfvisit,
    required this.lookingFor,
    required this.visitOutcome,
    required this.checkinDateAndTime,
    required this.checkoutDateTime,
    required this.attachment1,
    required this.attachment2,
    required this.attachment3,
    required this.attachment4,
    required this.lat,
    required this.longt,
    required this.checkOutlat,
    required this.checkoutlong,
    required this.purPoseOfvisitCode,
    required this.checkinAdd,
    required this.checkoutAdd,
  });

  factory GetSiteInoutData.fromJson(Map<String, dynamic> json) {
    return GetSiteInoutData(
        userCode: json['userCode'] ?? '',
        userName: json['userName'] ?? '',
        mobileNo: json['mobileNo'] ?? '',
        customerName: json['customerName'] ?? '',
        customerMobile: json['customerMobile'] ?? '',
        customerEmail: json['customerEmail'] ?? '',
        purposeOfvisit: json['purposeOfvisit'] ?? '',
        lookingFor: json['lookingFor'] ?? '',
        visitOutcome: json['visitOutcome'] ?? '',
        checkinDateAndTime: json['checkinDateAndTime'] ?? '',
        checkoutDateTime: json['checkoutDateTime'] ?? '',
        attachment1: json['attachment1'] ?? '',
        attachment2: json['attachment2'] ?? '',
        attachment3: json['attachment3'] ?? '',
        attachment4: json['attachment4'] ?? '',
        lat: json['lat'] ?? 0.0,
        longt: json['longt'] ?? 0.0,
        checkOutlat: json['checkOutlat'] ?? 0.0,
        checkoutlong: json['checkoutlong'] ?? 0.0,
        purPoseOfvisitCode: json['purPoseOfvisitCode'] ?? '',
        checkinAdd: json['checkinAdd'] ?? '',
        checkoutAdd: json['checkoutAdd'] ?? '');
  }
}
