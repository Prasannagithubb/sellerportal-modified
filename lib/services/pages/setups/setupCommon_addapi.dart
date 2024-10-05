import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class SetupCommonAddApi {
  String message;
  bool? status;
  String? exception;
  int? stcode;
  SetupCommonAddApi(
      {required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<SetupCommonAddApi> callapi(
      int masterid, String code, String desrcription, int status) async {
    Responce res = Responce();
    String? token = await SharedPre.getToken();
    Map<String, dynamic> body = {
      "masterTypeId": masterid,
      "code": "$code",
      "description": "$desrcription",
      "parentMasterId": "1",
      "status": status,
      "createdBy": "1",
      "isFixed": "1",
      "nextStatus": "0"
    };
    res = await ServicePost.callApi(
        "${UtilsVariables.clientPortalUrl}/postMaster", token!, body);
    return SetupCommonAddApi.fromJson(res);
  }

  factory SetupCommonAddApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      Map<String, dynamic> jsons = jsonDecode(res.responceBody!.toString());

      if (jsons.isNotEmpty) {
        return SetupCommonAddApi(
            message: "Success",
            status: true,
            stcode: res.resCode,
            exception: null);
      } else {
        return SetupCommonAddApi(
            message: "Failure",
            status: false,
            stcode: res.resCode,
            exception: null);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);

      return SetupCommonAddApi(
          message: jsons['respCode'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return SetupCommonAddApi(
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}
