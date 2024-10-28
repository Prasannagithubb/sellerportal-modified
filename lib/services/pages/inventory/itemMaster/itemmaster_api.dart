import 'dart:convert';

import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/api_main/service_get.dart';

class ItemMasterApi {
  List<ItemMasterNewData>? itemdata;
// List<ItemMasterNewData>? itempriceStock;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  ItemMasterApi(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});

  static Future<ItemMasterApi> call() async {
    Responce res = Responce();
    String? userid = await SharedPre.getUserid();
    String? token = await SharedPre.getToken();

    // DataBaseConfig.userId = userid;
    res = await ServiceGet.callApi(
        '${UtilsVariables.url}/GetallitembyUser?UserId=$userid', token!);
    return ItemMasterApi.fromJson(res);
  }

  factory ItemMasterApi.fromJson(
    Responce res,
  ) {
    if (res.resCode! <= 210 && res.resCode! >= 200) {
      Map<String, dynamic> jsons = jsonDecode(res.responceBody!);
      if (jsons != null && jsons.isNotEmpty) {
        // print("object::" + jsons.toString());
        var list = jsons['data'] as List;
        List<ItemMasterNewData> dataList =
            list.map((data) => ItemMasterNewData.fromJson(data)).toList();
        return ItemMasterApi(
            itemdata: dataList,
            message: "sucess",
            status: true,
            stcode: res.resCode,
            exception: null);
      } else {
        return ItemMasterApi(
            itemdata: null,
            message: jsons['respDesc'],
            status: false,
            stcode: res.resCode,
            exception: null);
      }
    } else if (res.resCode! <= 410 && res.resCode! >= 400) {
      Map<String, dynamic> jsons = jsonDecode(res.responceBody!);

      return ItemMasterApi(
          itemdata: null,
          message: jsons['respCode'],
          status: null,
          stcode: res.resCode,
          exception: jsons['respDesc']);
    } else {
      return ItemMasterApi(
          itemdata: null,
          message: 'Exception',
          status: null,
          stcode: res.resCode,
          exception: res.responceBody);
    }
  }
}

class ItemMasterNewData {
  ItemMasterNewData(
      {required this.MgrPrice,
      required this.itemcode,
      required this.itemName,
      required this.Segment,
      required this.Favorite,
      required this.SlpPrice,
      required this.Category,
      required this.Brand,
      required this.Division,
      required this.StoreStock,
      required this.WhsStock,
      required this.id,
      required this.allowNegativeStock,
      required this.allowOrderBelowCost,
      required this.brandCode,
      required this.catalogueUrl1,
      required this.catalogueUrl2,
      required this.clasification,
      required this.eol,
      required this.fast,
      required this.imageUrl1,
      required this.imageUrl2,
      required this.isFixedPrice,
      required this.itemDescription,
      required this.itemGroup,
      required this.modelNo,
      required this.movingType,
      required this.partCode,
      required this.priceStockId,
      required this.serialNumber,
      required this.sizeCapacity,
      required this.skucode,
      required this.slow,
      required this.sp,
      required this.specification,
      required this.ssp1,
      required this.ssp1Inc,
      required this.ssp2,
      required this.ssp2Inc,
      required this.ssp3,
      required this.ssp3Inc,
      required this.ssp4,
      required this.ssp4Inc,
      required this.ssp5,
      required this.ssp5Inc,
      required this.status,
      required this.storeCode,
      required this.taxRate,
      required this.textNote,
      required this.uoM,
      required this.veryFast,
      required this.verySlow,
      required this.whseCode,
      required this.color,
      required this.validTill,
      required this.calcType,
      required this.payOn});

  String? itemcode;
  String? itemName;
  String? Favorite;
  String? Category;
  String? Brand;
  String? Segment;
  String? Division;
  double? MgrPrice;
  double? SlpPrice;
  double? StoreStock;
  double? WhsStock;
  int? id;
  String? itemDescription;
  String? modelNo;
  String? partCode;
  String? skucode;
  String? brandCode;
  String? itemGroup;
  String? specification;
  String? sizeCapacity;
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
  String? whseCode;
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
  bool? allowNegativeStock;
  bool? allowOrderBelowCost;
  bool? isFixedPrice;
  String? validTill;
  String? color;
  String? calcType;
  String? payOn;

  factory ItemMasterNewData.fromJson(Map<String, dynamic> json) {
    // print("!-----------------------------2--------");
    return ItemMasterNewData(
        MgrPrice: json['mrp'] ?? 0,
        itemcode: json['itemCode'] ?? '',
        itemName: json['itemName'] ?? '',
        Segment: json['subCategory'] ?? '',
        Favorite: json['favourite'] ?? '', //
        SlpPrice: json['cost'] ?? 00,
        Category: json['category'] ?? '',
        Brand: json['brand'] ?? '',
        Division: json['division'] ?? '', //
        StoreStock: json['storeStock'] ?? 00,
        WhsStock: json['whseStock'] ?? 00,
        id: json['id'] ?? 0,
        color: json['color'] ?? '',
        allowNegativeStock: json['allowNegativeStock'] ?? false,
        allowOrderBelowCost: json['allowOrderBelowCost'] ?? false,
        brandCode: json['brandCode'] ?? '',
        catalogueUrl1: json['catalogueUrl1'] ?? '',
        catalogueUrl2: json['catalogueUrl2'] ?? '',
        clasification: json['clasification'] ?? '',
        eol: json['eol'] ?? false,
        fast: json['fast'] ?? false,
        imageUrl1: json['imageUrl1'] ?? '',
        imageUrl2: json['imageUrl2'] ?? '',
        isFixedPrice: json['isFixedPrice'] ?? false,
        itemDescription: json['itemDescription'] ?? '',
        itemGroup: json['itemGroup'] ?? '',
        modelNo: json['modelNo'] ?? '',
        movingType: json['movingType'] ?? '',
        partCode: json['partCode'] ?? '',
        priceStockId: json['priceStockId'] ?? 0,
        serialNumber: json['serialNumber'] ?? false,
        sizeCapacity: json['sizeCapacity'] ?? '',
        skucode: json['skucode'] ?? '',
        slow: json['slow'] ?? false,
        sp: json['sp'] ?? 0.0,
        specification: json['specification'] ?? '',
        ssp1: json['ssp1'] ?? 0.0,
        ssp1Inc: json['ssp1Inc'] ?? 0.0,
        ssp2: json['ssp2'] ?? 0.0,
        ssp2Inc: json['ssp2Inc'] ?? 0.0,
        ssp3: json['ssp3'] ?? 0.0,
        ssp3Inc: json['ssp3Inc'] ?? 0.0,
        ssp4: json['ssp4'] ?? 0.0,
        ssp4Inc: json['ssp4Inc'] ?? 0.0,
        ssp5: json['ssp5'] ?? 0.0,
        ssp5Inc: json['ssp5Inc'] ?? 0.0,
        status: json['status'] ?? '',
        storeCode: json['storeCode'] ?? '',
        taxRate: json['taxRate'] ?? 0,
        textNote: json['textNote'] ?? '',
        uoM: json['uoM'] ?? '',
        validTill: json['validTill'] ?? '',
        veryFast: json['veryFast'] ?? false,
        verySlow: json['verySlow'] ?? false,
        whseCode: json['whseCode'] ?? '',
        calcType: json['calcType'] ?? '',
        payOn: json['payOn'] ?? '');
  }
}
