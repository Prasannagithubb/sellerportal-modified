import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class AddCustomerApi {
  String? message;
  int? stcode;
  AddCustomerApi({required this.message, required this.stcode});

  static Future<AddCustomerApi> call(NewCustomerPostBody postbody) async {
    Responce res = Responce();
    UtilsVariables.token = await SharedPre.getToken();
    Map<String, dynamic> body = {
      "customercode": "${postbody.customercode}",
      "customername": "${postbody.customername}",
      "customermobile": "${postbody.customermobile}",
      "alternatemobileno": "${postbody.alternatemobileno}",
      "contactname": "${postbody.contactname}",
      "customeremail":
          postbody.customeremail!.isEmpty ? null : "${postbody.customeremail}",
      "companyname": "${postbody.companyname}",
      "gstno": postbody.gstno!.isEmpty ? null : postbody.gstno,
      "codeid": "${postbody.codeid}",
      "bil_address1": "${postbody.biladdress1}",
      "bil_address2": "${postbody.biladdress2}",
      "bil_address3": "${postbody.biladdress3}",
      "bil_area": "${postbody.bilarea}",
      "bil_city": "${postbody.bilcity}",
      "bil_district": "${postbody.bildistrict}",
      "bil_state": postbody.delstate!.isEmpty ? null : postbody.delstate,
      "bil_country": postbody.bilcountry!.isEmpty ? null : postbody.bilcountry,
      "bil_pincode": "${postbody.bilpincode}",
      "del_address1": "${postbody.deladdress1}",
      "del_address2": "${postbody.deladdress2}",
      "del_address3": "${postbody.deladdress3}",
      "del_area": "${postbody.delarea}",
      "del_city": "${postbody.delarea}",
      "del_district": "${postbody.deldistrict}",
      "del_state": postbody.delstate!.isEmpty ? null : postbody.delstate,
      "del_country": postbody.delcountry!.isEmpty ? null : postbody.delcountry,
      "del_pincode": "${postbody.delpincode}",
      "customerGroup":
          postbody.customerGroup!.isEmpty ? null : postbody.customerGroup,
      "pan": null,
      "website": "",
      "facebook": "${postbody.facebook}",
      "storeCode": "${postbody.storeCode}"
    };
    print(jsonEncode(body));
    res = await ServicePost.callApi(
        '${UtilsVariables.url}/PostCustomer', UtilsVariables.token, body);
    return AddCustomerApi.fromjson(res);
  }

  factory AddCustomerApi.fromjson(Responce res) {
    print(res.responceBody);
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      var json = jsonDecode(res.responceBody!);

      return AddCustomerApi(message: json['respDesc'], stcode: res.resCode);
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      var json = jsonDecode(res.responceBody!);
      return AddCustomerApi(message: json['respDesc'], stcode: res.resCode);
    } else {
      return AddCustomerApi(message: res.responceBody, stcode: res.resCode);
    }
  }
}

class NewCustomerPostBody {
  String? customercode;
  String? customername;
  String? customermobile;
  String? alternatemobileno;
  String? contactname;
  String? customeremail;
  String? companyname;
  String? gstno;
  String? codeid;
  String? biladdress1;
  String? biladdress2;
  String? biladdress3;
  String? bilarea;
  String? bilcity;
  String? bildistrict;
  String? bilstate;
  String? bilcountry;
  String? bilpincode;
  String? deladdress1;
  String? deladdress2;
  String? deladdress3;
  String? delarea;
  String? delcity;
  String? deldistrict;
  String? delstate;
  String? delcountry;
  String? delpincode;
  String? customerGroup;
  String? pan;
  String? website;
  String? facebook;
  String? storeCode;
  bool? status;
  String cardtype;

  NewCustomerPostBody(
      {required this.customercode,
      required this.customername,
      required this.customermobile,
      required this.alternatemobileno,
      required this.contactname,
      required this.customeremail,
      required this.companyname,
      required this.gstno,
      required this.codeid,
      required this.biladdress1,
      required this.biladdress2,
      required this.biladdress3,
      required this.bilarea,
      required this.bilcity,
      required this.bildistrict,
      required this.bilstate,
      required this.bilcountry,
      required this.bilpincode,
      required this.deladdress1,
      required this.deladdress2,
      required this.deladdress3,
      required this.delarea,
      required this.delcity,
      required this.deldistrict,
      required this.delstate,
      required this.delcountry,
      required this.delpincode,
      required this.customerGroup,
      required this.pan,
      required this.website,
      required this.facebook,
      required this.storeCode,
      required this.status,
      required this.cardtype});
}
