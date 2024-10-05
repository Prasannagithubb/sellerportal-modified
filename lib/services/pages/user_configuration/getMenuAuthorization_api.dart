import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetMenuAuthorizationApi {
  int? stcode;
  String? message;
  List<GetMenuAuthData>? data;
  GetMenuAuthorizationApi(
      {required this.data, required this.message, required this.stcode});

  static Future<GetMenuAuthorizationApi> call(String userid) async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    // String userid = await SharedPre.getUserid();
    res = await ServiceGet.callApi(
        '${UtilsVariables.clientPortalUrl}/GetMenuAuth?UserId=${int.parse(userid)}',
        UtilsVariables.token);
    print(res.resCode);
    print(res.responceBody);

    return GetMenuAuthorizationApi.fromJson(res);
  }

  factory GetMenuAuthorizationApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var data2 = jsonDecode(res.responceBody!.toString()) as List;
      if (data2.isNotEmpty) {
        List<GetMenuAuthData> datalist =
            data2.map((e) => GetMenuAuthData.fromJson(e)).toList();
        return GetMenuAuthorizationApi(
            data: datalist, message: 'Sucess', stcode: res.resCode);
      } else {
        return GetMenuAuthorizationApi(
            data: null, message: 'No data', stcode: res.resCode);
      }
    } else {
      return GetMenuAuthorizationApi(
          data: null, message: 'No data', stcode: res.resCode);
    }
  }
}

class GetMenuAuthData {
  int? userKey;
  String? menuKey;
  String? authStatus;
  String? companyCode;
  String? menuName;

  GetMenuAuthData({
    required this.userKey,
    required this.menuKey,
    required this.authStatus,
    required this.companyCode,
    required this.menuName,
  });

  factory GetMenuAuthData.fromJson(Map<String, dynamic> json) {
    return GetMenuAuthData(
      userKey:
          json['userKey'] == null ? 0 : int.parse(json['userKey'].toString()),
      menuKey: json['menuKey'] ?? '',
      authStatus: json['authStatus'] ?? '',
      companyCode: json['companyCode'] ?? '',
      menuName: json['menuName'] ?? '',
    );
  }

  Map<String, dynamic> tojson() => {
        "userKey": userKey,
        "menuKey": menuKey,
        "authStatus": authStatus,
        "companyCode": companyCode,
      };
}
