import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_update.dart';
import 'package:flowkit/services/pages/presales/customerdata/addCustomer_api.dart';

class UpdateCustomerApi {
  String? message;
  int? stcode;
  UpdateCustomerApi({required this.message, required this.stcode});

  static Future<UpdateCustomerApi> call(
      NewCustomerPostBody postbody, int? id) async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    Utils utils = Utils();
    Map<String, dynamic> body = {
      "customerCode":
          postbody.customercode!.isEmpty ? "" : postbody.customercode,
      "customerName": "${postbody.customername}",
      "customerMobile": "${postbody.customermobile}",
      "alternateMobileNo": "${postbody.alternatemobileno}",
      "contactName": "${postbody.contactname}",
      "customerEmail": "${postbody.customeremail}",
      "companyName": "${postbody.companyname}",
      "gstno": postbody.gstno!.isEmpty ? null : postbody.gstno,
      "codeId": "${postbody.codeid}",
      "createdBy": 0,
      "createdOn": "${utils.currentDate()}",
      "updatedBy": 0,
      "updatedOn": "${utils.currentDate()}",
      "bilAddress1": "${postbody.biladdress1}",
      "bilAddress2": "${postbody.biladdress2}",
      "bilAddress3": "${postbody.biladdress3}",
      "bilArea": "",
      "bilCity": "${postbody.bilcity}",
      "bilDistrict": "",
      "bilState": "${postbody.bilstate}",
      "country": "${postbody.bilcountry}",
      "bilPincode": "${postbody.bilpincode}",
      "delAddress1": "${postbody.deladdress1}",
      "delAddress2": "${postbody.deladdress2}",
      "delAddress3": "${postbody.deladdress3}",
      "delArea": "",
      "delCity": "${postbody.delcity}",
      "delState": "${postbody.delstate}",
      "delCountry": "${postbody.delcountry}",
      "delPincode": "${postbody.delpincode}",
      "customerGroup": "${postbody.customerGroup}",
      "pan": null,
      "website": null,
      "status": false,
      "facebook": "${postbody.facebook}",
      "cardtype": "${postbody.cardtype}",
      "storeCode": "${postbody.storeCode}",
      "traceId": null
    };
    print(jsonEncode(body));
    res = await ServiceUpdate.callApi(
        '${UtilsVariables.clientPortalUrl}/PutCustomerById?Id=$id',
        UtilsVariables.token,
        body);
    return UpdateCustomerApi.fromjson(res);
  }

  factory UpdateCustomerApi.fromjson(Responce res) {
    print(res.responceBody);
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!);
      if (json["respDesc"] != null) {
        return UpdateCustomerApi(
            message: json["respDesc"], stcode: res.resCode);
      } else {
        return UpdateCustomerApi(
            message: "Customer SucessFully UpDated", stcode: res.resCode);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!);
      return UpdateCustomerApi(message: json['respDesc'], stcode: res.resCode);
    } else {
      var json = jsonDecode(res.responceBody!);

      if (json['respDesc'] == null) {
        return UpdateCustomerApi(
            message: res.responceBody, stcode: res.resCode);
      } else {
        return UpdateCustomerApi(
            message: json['respDesc'], stcode: res.resCode);
      }
    }
  }
}
