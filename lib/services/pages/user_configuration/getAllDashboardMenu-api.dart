import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetAllDashboardMenuApi {
  int? stcode;
  String? message;
  List<GetDashboardMenuData>? data;
  GetAllDashboardMenuApi(
      {required this.data, required this.message, required this.stcode});

  static Future<GetAllDashboardMenuApi> call(int? userId) async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    res = await ServiceGet.callApi(
        '${UtilsVariables.url}/AllDashboards?UserId=$userId',
        UtilsVariables.token);

    return GetAllDashboardMenuApi.fromJson(res);
  }

  factory GetAllDashboardMenuApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var data2 = jsonDecode(res.responceBody!.toString()) as List;
      if (data2.isNotEmpty) {
        List<GetDashboardMenuData> datalist =
            data2.map((e) => GetDashboardMenuData.fromJson(e)).toList();
        return GetAllDashboardMenuApi(
            data: datalist, message: 'Sucess', stcode: res.resCode);
      } else {
        return GetAllDashboardMenuApi(
            data: null, message: 'No data', stcode: res.resCode);
      }
    } else {
      return GetAllDashboardMenuApi(
          data: null, message: 'No data', stcode: res.resCode);
    }
  }
}

class GetDashboardMenuData {
  int? dashboardId;
  String? caption;
  int? usermapId;
  int? userId;
  int? isActvie;
  GetDashboardMenuData({
    required this.dashboardId,
    required this.caption,
    required this.usermapId,
    required this.userId,
    required this.isActvie,
  });

  factory GetDashboardMenuData.fromJson(Map<String, dynamic> json) {
    return GetDashboardMenuData(
        dashboardId: json['dashboardId'] == null
            ? 0
            : int.parse(json['dashboardId'].toString()),
        caption: json['caption'] ?? '',
        usermapId: json['usermapId'] == null
            ? 0
            : int.parse(json['usermapId'].toString()),
        userId:
            json['userId'] == null ? 0 : int.parse(json['userId'].toString()),
        isActvie: json['isActvie'] == null
            ? 0
            : int.parse(json['isActvie'].toString()));
  }
}
