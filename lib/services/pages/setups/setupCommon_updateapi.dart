import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_update.dart';

class SetupCommonUpdateApi {
  String message;
  bool? status;
  String? exception;
  int? stcode;
  SetupCommonUpdateApi(
      {required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<SetupCommonUpdateApi> callapi(int masterid, int id, String code,
      String desrcription, int status) async {
    Responce res = Responce();
    String? token = await SharedPre.getToken();
    Map<String, dynamic> body = {
      "id": id,
      "masterTypeId": masterid,
      "code": "$code",
      "description": "$desrcription",
      "parentMasterId": "1",
      "status": status,
      "createdBy": "1",
      "isFixed": "1",
      "nextStatus": "0"
    };
    res = await ServiceUpdate.callApi(
        "${UtilsVariables.clientPortalUrl}/putMaster?Id=$id", token!, body);
    return SetupCommonUpdateApi.fromJson(res);
  }

  factory SetupCommonUpdateApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      // Map<String, dynamic> jsons = jsonDecode(res.responceBody!.toString());

      return SetupCommonUpdateApi(
          message: "Success",
          status: true,
          stcode: res.resCode,
          exception: null);
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);

      return SetupCommonUpdateApi(
          message: jsons['respCode'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return SetupCommonUpdateApi(
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}
