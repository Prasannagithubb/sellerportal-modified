import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class FeedsGetApi {
  List<FeedsGetApiData>? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  FeedsGetApi(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<FeedsGetApi> callapi() async {
    Responce res = Responce();
    String? token = await SharedPre.getToken();
    String? userId = await SharedPre.getUserid();

    res = await ServiceGet.callApi(
        "${UtilsVariables.clientPortalUrl}/GetfeedbyId?UserId=$userId", token!);
    return FeedsGetApi.fromJson(res);
  }

  factory FeedsGetApi.fromJson(Responce res) {
    if (res.resCode! >= 200 && res.resCode! <= 210) {
      List<dynamic> jsons = jsonDecode(res.responceBody!);
      if (jsons != null && jsons.isNotEmpty) {
        var list = jsons as List;
        List<FeedsGetApiData> dataList =
            list.map((data) => FeedsGetApiData.fromJson(data)).toList();
        return FeedsGetApi(
            leadcheckdata: dataList,
            message: "Success",
            status: true,
            stcode: res.resCode,
            exception: null);
      } else {
        return FeedsGetApi(
            leadcheckdata: [],
            message: "Failure",
            status: false,
            stcode: res.resCode,
            exception: 'Something went wrong..!!');
      }
    } else {
      return FeedsGetApi(
          leadcheckdata: null,
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}

class FeedsGetApiData {
  FeedsGetApiData2? leadcheckdata2;
  String? reaction;
  String? profilePic;
  String? createdUserName;

  FeedsGetApiData({
    required this.createdUserName,
    required this.leadcheckdata2,
    required this.reaction,
    required this.profilePic,
  });

  factory FeedsGetApiData.fromJson(Map<String, dynamic> jsons) =>
      FeedsGetApiData(
          reaction: jsons['reaction'] ?? '',
          profilePic: jsons['profile'] ?? '',
          createdUserName: jsons['createdUserName'] ?? '',
          leadcheckdata2: FeedsGetApiData2.fromJson(jsons["feedMaster"]));
}

class FeedsGetApiData2 {
  int? feedsID;
  String? createdDate;
  String? title;
  String? description;
  String? mediaType;
  String mediaURL1;
  String mediaURL2;
  String mediaURL3;
  String? validTill;
  String? userCode;

  int? createdBy;
  int? status;

  // FijkPlayer? player;

  FeedsGetApiData2({
    required this.feedsID,
    required this.createdDate,
    required this.title,
    required this.description,
    required this.mediaType,
    required this.mediaURL1,
    required this.mediaURL2,
    required this.mediaURL3,
    required this.validTill,
    required this.userCode,
    required this.createdBy,
    required this.status,
  });

  factory FeedsGetApiData2.fromJson(Map<String, dynamic> json) =>
      FeedsGetApiData2(
          feedsID: json['id'] ?? -1,
          createdDate: json['createdOn'] ?? '',
          title: json['title'] ?? '',
          description: json['description'] ?? '',
          mediaType: json['mediaType'] ?? '',
          mediaURL1: json['media1'] ?? '',
          mediaURL2: json['media2'] ?? '',
          mediaURL3: json['media3'] ?? '',
          validTill: json['validTill'] ?? '',
          userCode: json['UserCode'] ?? '',
          createdBy: json['createdBy'] ?? '',
          status: json['status'] ?? 0);
}
