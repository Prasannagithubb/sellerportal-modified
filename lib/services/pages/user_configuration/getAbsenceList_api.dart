import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetAbsenseListApi {
  String? respCode;
  String? respDesc;
  int? stcode;
  List<GetAbsenseData>? data;
  GetAbsenseListApi({
    required this.respCode,
    required this.respDesc,
    required this.stcode,
    required this.data,
  });
  static Future<GetAbsenseListApi> call(String date) async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    res = await ServiceGet.callApi(
        '${UtilsVariables.url}/GetAbsentList?date=${date}',
        UtilsVariables.token);

    return GetAbsenseListApi.fromJson(res);
  }

  factory GetAbsenseListApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!.toString());
      if (json['data'] != null) {
        List<dynamic> data2 = json['data'] as List;

        List<GetAbsenseData> datalist =
            data2.map((e) => GetAbsenseData.fromJson(e)).toList();
        return GetAbsenseListApi(
            data: datalist,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      } else {
        return GetAbsenseListApi(
            data: null,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!.toString());

      return GetAbsenseListApi(
          data: null,
          respDesc: json['respDesc'],
          respCode: json['respCode'],
          stcode: res.resCode);
    } else {
      return GetAbsenseListApi(
          data: null, respDesc: 'No data', respCode: '', stcode: res.resCode);
    }
  }
}

class GetAbsenseData {
  String? userCode;
  String? userName;

  GetAbsenseData({
    required this.userCode,
    required this.userName,
  });

  factory GetAbsenseData.fromJson(Map<String, dynamic> json) {
    return GetAbsenseData(
      userCode: json['userCode'] ?? '',
      userName: json['userName'] ?? '',
    );
  }
}
