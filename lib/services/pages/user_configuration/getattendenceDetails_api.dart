import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetAttendenceDtlsApi {
  String? respCode;
  String? respDesc;
  int? stcode;
  List<GetAttendenceData>? data;
  GetAttendenceDtlsApi({
    required this.respCode,
    required this.respDesc,
    required this.stcode,
    required this.data,
  });
  static Future<GetAttendenceDtlsApi> call(
      String fromDate, String toDate) async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    res = await ServiceGet.callApi(
        '${UtilsVariables.url}/Getattendance?fromdate=${fromDate}&toDate=${toDate}',
        UtilsVariables.token);

    return GetAttendenceDtlsApi.fromJson(res);
  }

  factory GetAttendenceDtlsApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!.toString());
      if (json['data'] != null) {
        List<dynamic> data2 = json['data'] as List;

        List<GetAttendenceData> datalist =
            data2.map((e) => GetAttendenceData.fromJson(e)).toList();
        return GetAttendenceDtlsApi(
            data: datalist,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      } else {
        return GetAttendenceDtlsApi(
            data: null,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!.toString());

      return GetAttendenceDtlsApi(
          data: null,
          respDesc: json['respDesc'],
          respCode: json['respCode'],
          stcode: res.resCode);
    } else {
      return GetAttendenceDtlsApi(
          data: null, respDesc: 'No data', respCode: '', stcode: res.resCode);
    }
  }
}

class GetAttendenceData {
  String? userCode;
  String? userName;
  String? mobileNo;
  String? attDate;
  String? sTime;
  String? eTime;
  String? sLoc;
  String? eLoc;
  String? sPic;
  String? ePic;
  String? workingHrs;
  String? storeCode;
  String? userType;
  GetAttendenceData({
    required this.userCode,
    required this.userName,
    required this.mobileNo,
    required this.attDate,
    required this.sTime,
    required this.eTime,
    required this.sLoc,
    required this.eLoc,
    required this.sPic,
    required this.ePic,
    required this.workingHrs,
    required this.storeCode,
    required this.userType,
  });

  factory GetAttendenceData.fromJson(Map<String, dynamic> json) {
    return GetAttendenceData(
      userCode: json['userCode'] ?? '',
      userName: json['userName'] ?? '',
      mobileNo: json['mobile'] ?? '',
      attDate: json['attDate'] ?? '',
      sTime: json['sTime'] ?? '',
      eTime: json['eTime'] ?? '',
      sLoc: json['sLoc'] ?? '',
      eLoc: json['eLoc'] ?? '',
      sPic: json['sPic'] ?? '',
      ePic: json['ePic'] ?? '',
      workingHrs: json['workingHrs'] ?? '',
      storeCode: json['storeCode'] ?? '',
      userType: json['userType'] ?? '',
    );
  }
}
