import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class StateApi {
  SateHeader? itemdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  StateApi(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  // Sellerkit_Flexi/v2/Statelist

  static Future<StateApi> callapi() async {
    Responce res = Responce();
    String token = await SharedPre.getToken();

    res = await ServiceGet.callApi('${UtilsVariables.url}/Statelist', token);
    return StateApi.fromJson(res);
  }

  factory StateApi.fromJson(Responce res) {
    if (res.resCode! >= 200 && res.resCode! <= 210) {
      var jsons = jsonDecode(res.responceBody!);

      if (jsons != null && jsons.isNotEmpty) {
        // var list = jsons as List;
        // List<EnquiriesData> dataList =
        //     list.map((data) => EnquiriesData.fromJson(data)).toList();
        return StateApi(
            itemdata: SateHeader.fromJson(jsons),
            message: "Success",
            status: true,
            stcode: res.resCode,
            exception: null);
      } else {
        return StateApi(
            itemdata: null,
            message: "Failure",
            status: false,
            stcode: res.resCode,
            exception: null);
      }
    } else if (res.resCode! >= 400 && res.resCode! <= 410) {
      var jsons = jsonDecode(res.responceBody!);

      return StateApi(
          itemdata: null,
          message: jsons['respType'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return StateApi(
          itemdata: null,
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}

class SateHeader {
  SateHeader(
      {required this.respCode,
      required this.datadetail,
      required this.respDesc,
      required this.respType

      // required this.customertag
      });

  String? respType;
  String? respCode;
  String? respDesc;
  List<SateHeaderData>? datadetail;

  factory SateHeader.fromJson(Map<String, dynamic> jsons) {
    //  if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as List;
    if (list.isEmpty) {
      return SateHeader(
          respCode: jsons['respCode'],
          datadetail: null,
          respDesc: jsons['respDesc'],
          respType: jsons['respType']);
    } else {
      List<SateHeaderData> dataList =
          list.map((data) => SateHeaderData.fromJson(data)).toList();
      return SateHeader(
          respCode: jsons['respCode'],
          datadetail: dataList,
          respDesc: jsons['respDesc'],
          respType: jsons['respType']);
    }
  }
}

class SateHeaderData {
  String? statecode;
  String? stateName; //
  String? countrycode; //
  String? countryname; //

  SateHeaderData({
    required this.statecode,
    required this.stateName,
    required this.countrycode,
    required this.countryname,
  });
  factory SateHeaderData.fromJson(Map<String, dynamic> json) => SateHeaderData(
        statecode: json['StateCode'] ?? 0, //
        stateName: json['StateName'] ?? '', //
        countrycode: json['CountryCode'] ?? '', //
        countryname: json['CountryName'] ?? '', //
      );
}
