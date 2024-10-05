import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class SetupCommonApi {
  List<SetupsCommonData>? data;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  SetupCommonApi(
      {required this.data,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<SetupCommonApi> callapi(String masterid) async {
    Responce res = Responce();
    String? token = await SharedPre.getToken();

    res = await ServiceGet.callApi(
        "${UtilsVariables.clientPortalUrl}/GetallMaster?MasterTypeId=$masterid",
        token!);
    return SetupCommonApi.fromJson(res);
  }

  factory SetupCommonApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      List<dynamic> jsons = jsonDecode(res.responceBody!.toString());

      var list = jsons as List;
      List<SetupsCommonData>? datalist = list
          .map((toElement) => SetupsCommonData.fromJson(toElement))
          .toList();

      if (jsons.isNotEmpty) {
        return SetupCommonApi(
            data: datalist,
            message: "Success",
            status: true,
            stcode: res.resCode,
            exception: null);
      } else {
        return SetupCommonApi(
            data: null,
            message: "Failure",
            status: false,
            stcode: res.resCode,
            exception: null);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var jsons = jsonDecode(res.responceBody!);

      return SetupCommonApi(
          data: null,
          message: jsons['respCode'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return SetupCommonApi(
          data: null,
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}

class SetupsCommonData {
  SetupsCommonData(
      {required this.code,
      required this.color,
      required this.createdBy,
      required this.createdOn,
      required this.description,
      required this.id,
      required this.mastertypeid,
      required this.parentMasterId,
      required this.status,
      required this.updatedBy,
      required this.updatedOn,
      required this.nextStatus,
      required this.isFixed});

  String? code;
  int? color;
  int? id;
  int? mastertypeid;
  String? description;
  int? parentMasterId;
  int? status;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn;
  int? nextStatus;
  int? isFixed;

  factory SetupsCommonData.fromJson(Map<String, dynamic> json) =>
      SetupsCommonData(
          nextStatus: json["nextStatus"],
          code: json['code'],
          color: 0,
          createdBy: json['createdBy'],
          createdOn: json['createdOn'] ?? '',
          description: json['description'],
          id: json['id'],
          mastertypeid: json['masterTypeId'],
          parentMasterId: json['parentMasterId'],
          status: json['status'],
          updatedBy: json['updatedBy'],
          updatedOn: json['updatedOn'],
          isFixed: json['isFixed']);
}
