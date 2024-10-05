import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetRestrictionApi {
  int? stcode;
  String? respDesc;
  String? respCode;
  List<RestrictionData>? data;
  GetRestrictionApi(
      {required this.data,
      required this.respDesc,
      required this.respCode,
      required this.stcode});

  static Future<GetRestrictionApi> call() async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    String userid = await SharedPre.getUserid();
    res = await ServiceGet.callApi(
        '${UtilsVariables.url}/GetAllrestriction?', UtilsVariables.token);

    return GetRestrictionApi.fromJson(res);
  }

  factory GetRestrictionApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!.toString());
      print(json['data']);
      List<dynamic> data2 = json['data'] as List;
      if (data2.isNotEmpty) {
        List<RestrictionData> datalist =
            data2.map((e) => RestrictionData.fromJson(e)).toList();
        return GetRestrictionApi(
            data: datalist,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      } else {
        return GetRestrictionApi(
            data: null,
            respDesc: json['respDesc'],
            respCode: json['respCode'],
            stcode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!.toString());

      return GetRestrictionApi(
          data: null,
          respDesc: json['respDesc'],
          respCode: json['respCode'],
          stcode: res.resCode);
    } else {
      return GetRestrictionApi(
          data: null, respDesc: 'No data', respCode: '', stcode: res.resCode);
    }
  }
}

class RestrictionData {
  int? id;
  String? code;
  int? restrictionType;
  String? restrictionData;
  String? remarks;

  RestrictionData({
    required this.id,
    required this.code,
    required this.restrictionType,
    required this.restrictionData,
    required this.remarks,
  });

  factory RestrictionData.fromJson(Map<String, dynamic> json) {
    return RestrictionData(
      id: json['id'] == null ? 0 : int.parse(json['id'].toString()),
      code: json['code'] ?? '',
      restrictionType: json['restrictionType'] == null
          ? 0
          : int.parse(json['restrictionType'].toString()),
      restrictionData: json['restrictionData'] ?? '',
      remarks: json['remarks'] ?? '',
    );
  }
}
