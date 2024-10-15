import 'dart:convert';
import 'dart:developer';
import 'package:flowkit/helpers/constants/encripted.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/helpers/extensions/configuration.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:http/http.dart' as http;

class GetJWTtokenApi {
  String? resDesc;
  String? token;
  int? resCode;
  String? resType;
  LoginModelData? loginDtls;
  GetJWTtokenApi(
      {this.resDesc,
      this.token,
      this.resCode,
      this.resType,
      required this.loginDtls});

  static Future<Responce> callApi(
      String? customerId, String? usercode, String? password) async {
    try {
      final responce = await http.post(
        Uri.parse('${UtilsVariables.loginurl}/Login'),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        },
        body: jsonEncode({
          "customerId": "$customerId",
          "userCode": "$usercode",
          "password": "$password"
        }),
      );
      log("Req Body::${jsonEncode({
            "customerId": customerId,
            "userCode": usercode,
            "password": password
          })}");
      log("Res Body::${responce.body}");
      log("Res Body::${responce.statusCode}");

      // if (responce.statusCode <= 210 && responce.statusCode >= 200) {
      //   Utils.token = responce.body;
      return Responce.getRes(responce.statusCode, responce.body);
      // } else if (responce.statusCode <= 410 && responce.statusCode >= 400) {
      //   return Responce.getRes(responce.statusCode, responce.body);
      // } else {
      //   return Responce.getRes(responce.statusCode, 'Exception');
      // }
    } catch (e) {
      log('$e');
      return Responce.getRes(500, 'Exception: $e');
    }
  }

  static Future<GetJWTtokenApi> callApi2(
      String? customerId, String? userCode, String? password) async {
    Responce res = await GetJWTtokenApi.callApi(customerId, userCode, password);
    // Map<String, dynamic> json = jsonDecode(res.responceBody!);
    return GetJWTtokenApi.fromJson(res);
  }

  factory GetJWTtokenApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      Config config = Config();
      // String tokenNew3 = json.decode(res.responceBody!);
      Map<String, dynamic> jres =
          config.parseJwt("${res.responceBody!.toString()}");
      print(jres);
      EncryptData Encrupt = EncryptData();
      String? testData2 = Encrupt.decrypt(jres['encrypted']);

      Map<String, dynamic> jres2 = jsonDecode("${testData2}");
      if (jres2 != null) {
        return GetJWTtokenApi(
            resDesc: 'Sucess',
            token: res.responceBody,
            resCode: res.resCode,
            resType: '',
            loginDtls: LoginModelData.fromJson(jres2));
      } else {
        return GetJWTtokenApi(
            resDesc: 'Failure',
            token: null,
            resCode: res.resCode,
            resType: '',
            loginDtls: null);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      Map<String, dynamic> json = jsonDecode(res.responceBody!);

      return GetJWTtokenApi(
          resDesc: json['respDesc'],
          token: null,
          resCode: res.resCode,
          resType: json['respType'],
          loginDtls: null);
    } else {
      return GetJWTtokenApi(
          resDesc: res.responceBody!,
          token: null,
          resCode: res.resCode,
          resType: null,
          loginDtls: null);
    }
  }
}

class LoginModelData {
  String licenseKey;
  // String endPointUrl;
  // String sessionID;
  String UserID;
  // String userDB;
  // String dbUserName;
  // String dbPassword;
  String userType;
  String slpcode;
  String urlColumn;
  String tenantId;
  String devicecode;
  String userCode;
  String? storeid;
  String? storecode;

  LoginModelData(
      {required this.storeid,
      required this.licenseKey,
      required this.urlColumn,
      required this.tenantId,
      required this.UserID,
      required this.devicecode,
      required this.userCode,
      required this.storecode,
      // required this.dbPassword,
      required this.userType,
      required this.slpcode});

  factory LoginModelData.fromJson(Map<String, dynamic> json) {
    return LoginModelData(
        licenseKey: json["LicenseKey"] ?? '',
        urlColumn: json[
            "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"],
        tenantId: json["TenantId"],
        userCode: json['UserCode'],
        UserID: json['USerId'],
        devicecode: json['DeviceCode'],
        // dbPassword: json['dbPassword'],
        userType: json['UserTypeId'],
        slpcode: json['Slpcode'],
        storeid: json['StoreId'] ?? '',
        storecode: json['StoreCode']);
  }
  // {"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier":"DFG56","USerId":"3","TenantId":"cc45","DeviceCode":"","UserCode":"2233","UserTypeId":"1","LicenseKey":"","Slpcode":"EMP01"}
}

class PostLoginData {
  String? deviceCode;
  String? licenseKey;
  String? username;
  String? password;
  String? fcmToken;
  String? ipaddress;
  String? ipName;
  String? latitude;
  String? langtitude;
  String? devicename;
}
