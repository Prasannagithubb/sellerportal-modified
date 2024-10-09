import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class ItemMasterAddApi {
  String? respType;
  String? respCode;
  String? respDesc;
  int? stcode;

  ItemMasterAddApi(
      {required this.respCode,
      required this.respDesc,
      required this.respType,
      required this.stcode});

  static Future<ItemMasterAddApi> addBrand(String brand) async {
    Responce res = Responce();
    Utils config = Utils();

    Map<String, dynamic> body = {
      "id": 0,
      "brand": "$brand",
      "createdOn": "${config.currentDate()}"
    };
    UtilsVariables.token = await SharedPre.getToken();

    print(body);
    res = await ServicePost.callApi(
        '${UtilsVariables.clientPortalUrl}/PostBrand',
        UtilsVariables.token,
        body);
    return ItemMasterAddApi.fromJson(res);
  }

  static Future<ItemMasterAddApi> addCategory(String category) async {
    Responce res = Responce();
    Utils config = Utils();
    Map<String, dynamic> body = {
      "id": 0,
      "category": "$category",
      "createdOn": "${config.currentDate()}"
    };
    UtilsVariables.token = await SharedPre.getToken();

    res = await ServicePost.callApi(
        '${UtilsVariables.clientPortalUrl}/PostCategoryS',
        UtilsVariables.token,
        body);
    return ItemMasterAddApi.fromJson(res);
  }

  static Future<ItemMasterAddApi> addSubCategory(String subcategory) async {
    Responce res = Responce();
    Utils config = Utils();

    Map<String, dynamic> body = {
      "id": 0,
      "subcategory": "$subcategory",
      "createdOn": "${config.currentDate()}"
    };
    UtilsVariables.token = await SharedPre.getToken();

    res = await ServicePost.callApi(
        '${UtilsVariables.clientPortalUrl}/PostSubcategoryS',
        UtilsVariables.token,
        body);
    return ItemMasterAddApi.fromJson(res);
  }

  factory ItemMasterAddApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!);
      return ItemMasterAddApi(
          respCode: json['respCode'],
          respDesc: json['respDesc'],
          respType: json['respType'],
          stcode: res.resCode);
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!);
      return ItemMasterAddApi(
          respCode: json['respCode'],
          respDesc: json['respDesc'],
          respType: json['respType'],
          stcode: res.resCode);
    } else {
      return ItemMasterAddApi(
          respCode: null,
          respDesc: res.responceBody!,
          respType: null,
          stcode: res.resCode);
    }
  }
}
