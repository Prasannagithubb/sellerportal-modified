import 'dart:convert';
import 'dart:developer';

import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_post.dart';

class ItemAddApi {
  int? stcode;
  String? rescode;
  String? resDesc;

  ItemAddApi({this.resDesc, this.rescode, this.stcode});

  static Future<ItemAddApi> call(List<ItemAddPostModel> data) async {
    Responce res = Responce();
    // UtilsVariables.token = SharedPre.getToken();
    // print(data.map((toElement)=>toElement.tojson()).toList());
    List<Map<String, dynamic>> data2 =
        data.map((toElement) => toElement.tojson()).toList();
    res = await ServicePost.callApi(
        '${UtilsVariables.url}/PostItemDetails', UtilsVariables.token, {},
        listbody: data2);
    return ItemAddApi.fromJson(res);
  }

  factory ItemAddApi.fromJson(Responce res) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      Map<String, dynamic> json = jsonDecode(res.responceBody!);
      return ItemAddApi(
          rescode: json['respCode'],
          resDesc: json['respDesc'],
          stcode: res.resCode);
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      Map<String, dynamic> json = jsonDecode(res.responceBody!);
      return ItemAddApi(
          rescode: json['respCode'],
          resDesc: json['respDesc'],
          stcode: res.resCode);
    } else {
      return ItemAddApi(
          rescode: null, resDesc: res.responceBody, stcode: res.resCode);
    }
  }
}

// [{"ItemName":"New","ItemCode":"NewItemn","Brand":"AIRTEL","Category":"CL ACC","SubCategory":"APPACHETTY","ItemDescription":"erter",
// "ModelNo":null,"PartCode":null,"Skucode":null,"BrandCode":null,"ItemGroup":null,"Specification":null,"SizeCapacity":"5","Color":"res","Clasification":"20","UoM":null
// ,"TaxRate":10.0,"CatalogueUrl1":null,"CatalogueUrl2":null,"ImageUrl1":null,"ImageUrl2":null,"TextNote":null,"Status":"1"}]
class ItemAddPostModel {
  String? itemname;
  String? itemcode;
  String? brand;
  String? category;
  String? subcategory;
  String? itemDesc;
  String? modelNo;
  String? skucode;
  String? brancode;
  String? itemgroup;
  String? specification;
  String? sizecapacity;
  String? color;
  String? clasification;
  String? uom;
  double? taxrate;
  String? catalogue1;
  String? catalogue2;
  String? link1;
  String? link2;
  String? textnote;
  String? status;
  String? partCode;

  ItemAddPostModel({
    required this.itemname,
    required this.itemcode,
    required this.brand,
    required this.category,
    required this.subcategory,
    required this.itemDesc,
    required this.modelNo,
    required this.skucode,
    required this.brancode,
    required this.itemgroup,
    required this.specification,
    required this.sizecapacity,
    required this.color,
    required this.clasification,
    required this.uom,
    required this.taxrate,
    required this.catalogue1,
    required this.catalogue2,
    required this.link1,
    required this.link2,
    required this.textnote,
    required this.status,
    required this.partCode,
  });

  Map<String, dynamic> tojson() => {
        "ItemName": itemname,
        "ItemCode": itemcode,
        "Brand": brand,
        "Category": category,
        "SubCategory": subcategory,
        "ItemDescription": itemDesc,
        "ModelNo": modelNo,
        "PartCode": partCode,
        "Skucode": skucode,
        "BrandCode": brancode,
        "ItemGroup": itemgroup,
        "Specification": specification,
        "SizeCapacity": sizecapacity,
        "Color": color,
        "Clasification": clasification,
        "UoM": uom,
        "TaxRate": taxrate ?? 0.0,
        "CatalogueUrl1": catalogue1,
        "CatalogueUrl2": catalogue2,
        "ImageUrl1": link1,
        "ImageUrl2": link2,
        "TextNote": textnote,
        "Status": status
      };
}
