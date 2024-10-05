import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class GetAllStocksPriceApi {
  String? rescode;
  String? resDesc;
  List<GetAllStocksPriceData>? data;
  int? stcode;
  GetAllStocksPriceApi(
      {required this.data,
      required this.resDesc,
      required this.rescode,
      required this.stcode});
  static Future<GetAllStocksPriceApi> callapi(String storeid) async {
    Responce res = Responce();
    print(storeid);

    String? token = await SharedPre.getToken();
    // print(UtilsVariables.token);

    res = await ServiceGet.callApi(
        '${UtilsVariables.url}/Getallitemlist?StoreId=$storeid', token!);

    return GetAllStocksPriceApi.fromjson(res);
  }

  factory GetAllStocksPriceApi.fromjson(Responce res) {
    if (res.resCode! >= 200 && res.resCode! <= 210) {
      var json = jsonDecode(res.responceBody!);
      List<dynamic> list = json['data'] as List;
      List<GetAllStocksPriceData>? datalist =
          list.map((e) => GetAllStocksPriceData.fromjson(e)).toList();
      return GetAllStocksPriceApi(
          data: datalist,
          resDesc: json['respDesc'],
          rescode: json['respCode'],
          stcode: res.resCode);
    } else if (res.resCode! >= 400 && res.resCode! <= 410) {
      var json = jsonDecode(res.responceBody!);

      return GetAllStocksPriceApi(
          data: null,
          resDesc: json['respDesc'],
          rescode: json['respCode'],
          stcode: res.resCode);
    } else {
      return GetAllStocksPriceApi(
          data: null,
          resDesc: res.responceBody.toString(),
          rescode: null,
          stcode: res.resCode);
    }
  }
}

class GetAllStocksPriceData {
  int? id;
  String? itemCode;
  String? itemName;
  String? brand;
  String? category;
  String? subCategory;
  String? itemDescription;
  String? modelNo;
  String? partCode;
  String? skucode;
  String? brandCode;
  String? itemGroup;
  String? specification;
  String? sizeCapacity;
  String? color;
  String? clasification;
  String? uoM;
  int? taxRate;
  String? catalogueUrl1;
  String? catalogueUrl2;
  String? imageUrl1;
  String? imageUrl2;
  String? textNote;
  String? status;
  String? movingType;
  bool? eol;
  bool? veryFast;
  bool? fast;
  bool? slow;
  bool? verySlow;
  bool? serialNumber;
  int? priceStockId;
  String? storeCode;
  double? storeStock;
  String? whseCode;
  double? whseStock;
  double? mrp;
  double? cost;
  double? sp;
  double? ssp1;
  double? ssp2;
  double? ssp3;
  double? ssp4;
  double? ssp5;
  double? ssp1Inc;
  double? ssp2Inc;
  double? ssp3Inc;
  double? ssp4Inc;
  double? ssp5Inc;
  String? calcType;
  String? payOn;
  bool? allowNegativeStock;
  bool? allowOrderBelowCost;
  bool? isFixedPrice;
  String? validTill;
  double? storeAgeSlab1;
  double? storeAgeSlab2;
  double? storeAgeSlab3;
  double? storeAgeSlab4;
  double? storeAgeSlab5;
  double? whsAgeSlab1;
  double? whsAgeSlab2;
  double? whsAgeSlab3;
  double? whsAgeSlab4;
  double? whsAgeSlab5;
  GetAllStocksPriceData({
    required this.id,
    required this.itemCode,
    required this.itemName,
    required this.brand,
    required this.category,
    required this.subCategory,
    required this.itemDescription,
    required this.modelNo,
    required this.partCode,
    required this.skucode,
    required this.brandCode,
    required this.itemGroup,
    required this.specification,
    required this.sizeCapacity,
    required this.color,
    required this.clasification,
    required this.uoM,
    required this.taxRate,
    required this.catalogueUrl1,
    required this.catalogueUrl2,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.textNote,
    required this.status,
    required this.movingType,
    required this.eol,
    required this.veryFast,
    required this.fast,
    required this.slow,
    required this.verySlow,
    required this.serialNumber,
    required this.priceStockId,
    required this.storeCode,
    required this.storeStock,
    required this.whseCode,
    required this.whseStock,
    required this.mrp,
    required this.cost,
    required this.sp,
    required this.ssp1,
    required this.ssp2,
    required this.ssp3,
    required this.ssp4,
    required this.ssp5,
    required this.ssp1Inc,
    required this.ssp2Inc,
    required this.ssp3Inc,
    required this.ssp4Inc,
    required this.ssp5Inc,
    required this.calcType,
    required this.payOn,
    required this.allowNegativeStock,
    required this.allowOrderBelowCost,
    required this.isFixedPrice,
    required this.validTill,
    required this.storeAgeSlab1,
    required this.storeAgeSlab2,
    required this.storeAgeSlab3,
    required this.storeAgeSlab4,
    required this.storeAgeSlab5,
    required this.whsAgeSlab1,
    required this.whsAgeSlab2,
    required this.whsAgeSlab3,
    required this.whsAgeSlab4,
    required this.whsAgeSlab5,
  });

  factory GetAllStocksPriceData.fromjson(Map<String, dynamic> json) {
    // print(json);
    return GetAllStocksPriceData(
        id: json['id'] ?? 0,
        itemCode: json['itemCode'] ?? '',
        itemName: json['itemName'] ?? '',
        brand: json['brand'] ?? '',
        category: json['category'] ?? '',
        subCategory: json['subCategory'] ?? '',
        itemDescription: json['itemDescription'] ?? '',
        modelNo: json['modelNo'] ?? '',
        partCode: json['partCode'] ?? '',
        skucode: json['skucode'] ?? '',
        brandCode: json['brandCode'] ?? '',
        itemGroup: json['itemGroup'] ?? '',
        specification: json['specification'] ?? '',
        sizeCapacity: json['sizeCapacity'] ?? '',
        color: json['color'] ?? '',
        clasification: json['clasification'] ?? '',
        uoM: json['uoM'] ?? '',
        taxRate: json['taxRate'] ?? 0,
        catalogueUrl1: json['catalogueUrl1'] ?? '',
        catalogueUrl2: json['catalogueUrl2'] ?? '',
        imageUrl1: json['imageUrl1'] ?? '',
        imageUrl2: json['imageUrl2'] ?? '',
        textNote: json['textNote'] ?? '',
        status: json['status'] ?? '',
        movingType: json['movingType'] ?? '',
        eol: json['eol'] ?? false,
        veryFast: json['veryFast'] ?? false,
        fast: json['fast'] ?? false,
        slow: json['slow'] ?? false,
        verySlow: json['verySlow'] ?? false,
        serialNumber: json['serialNumber'] ?? false,
        priceStockId: json['priceStockId'] ?? 0,
        storeCode: json['storeCode'] ?? '',
        storeStock: json['storeStock'] ?? 0.0,
        whseCode: json['whseCode'] ?? '',
        whseStock: json['whseStock'] ?? 0.0,
        mrp: json['mrp'] ?? 0.0,
        cost: json['cost'] ?? 0.0,
        sp: json['sp'] ?? 0.0,
        ssp1: json['ssp1'] ?? 0.0,
        ssp2: json['ssp2'] ?? 0.0,
        ssp3: json['ssp3'] ?? 0.0,
        ssp4: json['ssp4'] ?? 0.0,
        ssp5: json['ssp5'] ?? 0.0,
        ssp1Inc: json['ssp1Inc'] ?? 0.0,
        ssp2Inc: json['ssp2Inc'] ?? 0.0,
        ssp3Inc: json['ssp3Inc'] ?? 0.0,
        ssp4Inc: json['ssp4Inc'] ?? 0.0,
        ssp5Inc: json['ssp5Inc'] ?? 0.0,
        calcType: json['calcType'] ?? '',
        payOn: json['payOn'] ?? '',
        allowNegativeStock: json['allowNegativeStock'] ?? false,
        allowOrderBelowCost: json['allowOrderBelowCost'] ?? false,
        isFixedPrice: json['isFixedPrice'] ?? false,
        validTill: json['validTill'] ?? '',
        storeAgeSlab1: json['storeAgeSlab1'] ?? 0.0,
        storeAgeSlab2: json['storeAgeSlab2'] ?? 0.0,
        storeAgeSlab3: json['storeAgeSlab3'] ?? 0.0,
        storeAgeSlab4: json['storeAgeSlab4'] ?? 0.0,
        storeAgeSlab5: json['storeAgeSlab5'] ?? 0.0,
        whsAgeSlab1: json['whsAgeSlab1'] ?? 0.0,
        whsAgeSlab2: json['whsAgeSlab2'] ?? 0.0,
        whsAgeSlab3: json['whsAgeSlab3'] ?? 0.0,
        whsAgeSlab4: json['whsAgeSlab4'] ?? 0.0,
        whsAgeSlab5: json['whsAgeSlab5'] ?? 0.0);
  }
}
