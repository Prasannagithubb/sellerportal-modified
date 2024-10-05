import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';
import 'package:flowkit/services/api_main/service_update.dart';

class UpdaterestrictionApi {
  String message;
  bool? status;
  String? exception;
  int? stcode;
  UpdaterestrictionApi(
      {required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<UpdaterestrictionApi> callapi(int restrictionType, String code,
      String restrictionData, String remarks) async {
    Responce res = Responce();
    String? token = await SharedPre.getToken();
    Map<String, dynamic> body = {
      "code": "$code",
      "restrictionType": restrictionType,
      "restrictionData": "$restrictionData",
      "remarks": "$remarks"
    };
    print(body);
    res = await ServiceUpdate.callApi(
        "${UtilsVariables.url}/UpdateRestriction", token!, body);
    return UpdaterestrictionApi.fromJson(res);
  }

  factory UpdaterestrictionApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      Map<String, dynamic> jsons = jsonDecode(res.responceBody!.toString());

      if (jsons.isNotEmpty) {
        return UpdaterestrictionApi(
            message: "Success",
            status: true,
            stcode: res.resCode,
            exception: null);
      } else {
        return UpdaterestrictionApi(
            message: "Failure",
            status: false,
            stcode: res.resCode,
            exception: null);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);

      return UpdaterestrictionApi(
          message: jsons['respCode'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return UpdaterestrictionApi(
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}
