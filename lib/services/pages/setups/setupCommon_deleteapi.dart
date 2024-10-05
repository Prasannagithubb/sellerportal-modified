import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_noBodyDelete.dart';

class SetupCommonDeleteApi {
  String message;
  bool? status;
  String? exception;
  int? stcode;
  SetupCommonDeleteApi(
      {required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<SetupCommonDeleteApi> callapi(
      int id, ) async {
    Responce res = Responce();
    String? token = await SharedPre.getToken();
    res = await ServiceNoBodyDelete.callApi(
        "${UtilsVariables.clientPortalUrl}/deleteMaster/Id?Id=$id", token!);
    return SetupCommonDeleteApi.fromJson(res);
  }

  factory SetupCommonDeleteApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {

        return SetupCommonDeleteApi(
            message: "Success",
            status: true,
            stcode: res.resCode,
            exception: null);
      
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);

      return SetupCommonDeleteApi(
          message: jsons['respCode'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return SetupCommonDeleteApi(
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}
