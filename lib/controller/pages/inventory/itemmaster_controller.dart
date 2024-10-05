import 'dart:collection';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/extensions/string.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/helpers/widgets/my_text_utils.dart';
import 'package:flowkit/model/visitor_by_channels_model.dart';
import 'package:flowkit/services/api_main/fileupload_api.dart';
import 'package:flowkit/services/pages/inventory/itemMaster/addbrand_api.dart';
import 'package:flowkit/services/pages/inventory/itemMaster/delete_item_api.dart';
import 'package:flowkit/services/pages/inventory/itemMaster/itemadd_api.dart';
import 'package:flowkit/services/pages/inventory/itemMaster/itemmaster_api.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/screens/itemmaster_screen.dart';
// import 'package:flowkit/view/forms/validation_screen.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemMasterController extends MyController {
  // List<ItemMasterNewData> datas = Data.factory();
  DataTableSource? data;
  List<VisitorByChannelsModel> visitorByChannel = [];
  List<ItemMasterNewData>? itemdata;
  List<ItemMasterNewData>? get _itemdata => itemdata;

  List<ItemMasterNewData>? filterItemdata;
  MyFormValidator basicValidator = MyFormValidator();
  List<GlobalKey<FormState>> formkey =
      List.generate(5, (i) => GlobalKey<FormState>());
  List<TextEditingController> controller =
      List.generate(20, (i) => TextEditingController());

  final TickerProvider tickerProvider;
  var softIndex = 0;

  late TabController softTabController =
      TabController(length: 3, vsync: tickerProvider, initialIndex: softIndex);
  ItemMasterController(this.tickerProvider);

  bool isLoad = false;
  String? brand;
  String? category;
  String? subCategory;

  @override
  void onInit() {
    super.onInit();
    // VisitorByChannelsModel.dummyList.then((value) {
    //   visitorByChannel = value;
    //   update();
    // });

    validator();
    callIemMaster();
    cleardata();
    softTabController.addListener(() {
      if (softIndex != softTabController.index) {
        softIndex = softTabController.index;
        update();
      }
    });
  }

  cleardata() {
    brand = null;
    category = null;
    subCategory = null;
    refresh();
  }

  newItemAddValidate() async {
    bool isValid = false;
    isValid = formkey[0].currentState!.validate();
    if (isValid == true) {
      subValidate();
    } else {
      Get.dialog(AlertBox(
        msg: 'Please Fill all required fields..!!',
      ));
    }
    update();
  }

  newBrandAddValidate() async {
    bool isValid = false;
    isValid = formkey[1].currentState!.validate();
    Map<String, dynamic> data = basicValidator.getData();
    if (isValid == true) {
      await ItemMasterAddApi.addBrand(data['newbrand']).then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.dialog(AlertBox(
            msg: 'Sucessfully Added..!!',
          )).then((onValue) {
            Get.back();
          });
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(AlertBox(
            msg: '${onValue.respCode} ${onValue.respDesc}..!!',
          ));
        } else {
          Get.dialog(AlertBox(
            msg: '${onValue.respDesc}..!!',
          ));
        }
      });
    }
    update();
  }

  newCategoryAddValidate() async {
    bool isValid = false;
    isValid = formkey[2].currentState!.validate();
    Map<String, dynamic> data = basicValidator.getData();
    if (isValid == true) {
      await ItemMasterAddApi.addCategory(data['newcategory']).then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.dialog(AlertBox(
            msg: 'Sucessfully Added..!!',
          )).then((onValue) {
            Get.back();
          });
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(AlertBox(
            msg: '${onValue.respCode} ${onValue.respDesc}..!!',
          ));
        } else {
          Get.dialog(AlertBox(
            msg: '${onValue.respDesc}..!!',
          ));
        }
      });
    }
    update();
  }

  newSubCategroyAddValidate() async {
    bool isValid = false;
    isValid = formkey[3].currentState!.validate();
    Map<String, dynamic> data = basicValidator.getData();
    if (isValid == true) {
      await ItemMasterAddApi.addSubCategory(data['newsubcategory'])
          .then((onValue) {
        if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
          Get.dialog(AlertBox(
            msg: 'Sucessfully Added..!!',
          )).then((onValue) {
            Get.back();
          });
        } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
          Get.dialog(AlertBox(
            msg: '${onValue.respCode} ${onValue.respDesc}..!!',
          ));
        } else {
          Get.dialog(AlertBox(
            msg: '${onValue.respDesc}..!!',
          ));
        }
      });
    }
    update();
  }

  subValidate() async {
    String filecatalogue1 = '';
    String filecatalogue2 = '';
    String filelink1 = '';
    String filelink2 = '';

    if (catelogue1 != null) {
      await FileUploadApi.uploadImage(catelogue1!).then((value) {
        if (value.stcode! <= 210) {
          filecatalogue1 = value.imgUrl!;
          update();
        }
      });
    }
    if (catelogue2 != null) {
      await FileUploadApi.uploadImage(catelogue2!).then((value) {
        if (value.stcode! <= 210) {
          filecatalogue2 = value.imgUrl!;
          update();
        }
      });
    }
    if (link1 != null) {
      await FileUploadApi.uploadImage(link1!).then((value) {
        if (value.stcode! <= 210) {
          filelink1 = value.imgUrl!;
          update();
        }
      });
    }
    if (link2 != null) {
      await FileUploadApi.uploadImage(link2!).then((value) {
        if (value.stcode! <= 210) {
          filelink2 = value.imgUrl!;
          update();
        }
      });
    }

    Map<String, dynamic> json = basicValidator.getData();
    List<ItemAddPostModel> data = [];
    data.add(ItemAddPostModel(
        itemname: json['itemname'],
        itemcode: json['itemcode'],
        brand: json['brand'],
        category: json['category'],
        subcategory: json['subcategory'],
        itemDesc: json['itemdesc'],
        modelNo: json['modelno'],
        skucode: json['skucode'],
        brancode: json['brandcode'],
        itemgroup: json['itemgroup'],
        specification: json['specification'],
        sizecapacity: json['sizecapacity'],
        color: json['colour'],
        clasification: json['clasification'],
        uom: json['uom'],
        taxrate: json['taxrate'] != null
            ? double.parse(json['taxrate'].toString())
            : 0.0,
        catalogue1: filecatalogue1.isEmpty ? null : filecatalogue1,
        catalogue2: filecatalogue2.isEmpty ? null : filecatalogue2,
        link1: filelink1.isEmpty ? null : filelink1,
        link2: filelink2.isEmpty ? null : filelink2,
        textnote: json['textnote'],
        status: "1",
        partCode: json['partcode']));

    ItemAddApi.call(data).then((onValue) {
      if (onValue.stcode! >= 200 && onValue.stcode! <= 210) {
        Get.dialog(AlertBox(
          msg: 'Sucessfully Saved',
        ));
      } else {
        Get.dialog(AlertBox(
          msg: '${onValue.rescode ?? ''} ${onValue.resDesc}',
        ));
      }
    });
  }

  validator() async {
    basicValidator.addField('itemcode',
        required: true,
        label: "Item Code",
        // validators: [MyUserCodeValidator()],
        controller: TextEditingController());

    basicValidator.addField('itemname',
        required: true,
        label: "Item Name",
        // validators: [MyEmailValidator()],
        controller: TextEditingController());
    basicValidator.addField('itemgroup',
        required: false,
        label: "Item Group",
        // validators: [MyEmailValidator()],
        controller: TextEditingController());
    basicValidator.addField('itemdesc',
        required: false,
        label: "Item Description",
        // validators: [MyEmailValidator()],
        controller: TextEditingController());
    basicValidator.addField('brand',
        required: true,
        label: "Brand",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('category',
        required: true,
        label: "Category",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('subcategory',
        required: true,
        label: "Sub Category",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('brandcode',
        required: false,
        label: "Brand Code",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('specification',
        required: false,
        label: "Specification",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('skucode',
        required: false,
        label: "SKU Code",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('modelno',
        required: false,
        label: "Model No",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('partcode',
        required: false,
        label: "Part Code",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());

    //otherDtls
    basicValidator.addField('sizecapacity',
        required: true,
        label: "Size Capacity",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('clasification',
        required: true,
        label: "Clasification",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('colour',
        required: true,
        label: "Colour",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('uom',
        required: false,
        label: "UoM",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('taxrate',
        required: true,
        label: "Tax Rate",

        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('textnote',
        required: false,
        label: "Text Note",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());

    //attachments
    basicValidator.addField('catalogue1',
        required: false,
        label: "Catelogue 1",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('catalogue2',
        required: false,
        label: "Catelogue 2",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('link1',
        required: false,
        label: "Link 1",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
    basicValidator.addField('link2',
        required: false,
        label: "Link 2",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());

    //New Brand
    basicValidator.addField('newbrand',
        required: true,
        label: "New Brand",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());

    //New Category
    basicValidator.addField('newcategory',
        required: true,
        label: "New Category",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());

    //New Sub Category
    basicValidator.addField('newsubcategory',
        required: true,
        label: "New Sub Category",
        // validators: [MyLengthValidator(min: 6, max: 10)],
        controller: TextEditingController());
  }

  List<String> brandlist = [];
  List<String> categorylist = [];

  List<String> subCategorylist = [];

  filterItemName(String? val, ItemMasterController cnt, BuildContext context) {
    if (val!.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.itemName!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterItemdata = itemdata!;
      update();
    }
  }

  filterItemCode(String? val, ItemMasterController cnt, context) {
    if (val!.isNotEmpty) {
      // List<ItemMasterNewData>? itemdata2 = _itemdata;
      filterItemdata = itemdata!
          .where((e) => e.itemcode!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      // MyData(filterItemdata!, cnt, context);
      update();
      print(itemdata!.length);
    } else {
      filterItemdata = itemdata!;
      update();
    }
  }

  filterBrand(String? val, ItemMasterController cnt) {
    if (val!.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.Brand!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterItemdata = itemdata!;
      update();
    }
  }

  filterCAtegory(String? val, ItemMasterController cnt) {
    if (val!.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.Category!.toUpperCase().contains(val.toUpperCase()))
          .toList();
      update();
    } else {
      filterItemdata = itemdata!;
      update();
    }
  }

  filterSubCategory(String? val, ItemMasterController cnt) {
    if (val!.isNotEmpty) {
      filterItemdata = itemdata!
          .where((e) => e.Segment!.toLowerCase().contains(val.toLowerCase()))
          .toList();
      update();
    } else {
      filterItemdata = itemdata!;
      update();
    }
  }

  filterStatus(String? val, ItemMasterController cnt) {
    if (val!.isNotEmpty) {
      String value = '';
      if (val.contains('active')) {
        value = '1';
      } else {
        value = val;
      }
      filterItemdata = itemdata!
          .where((e) => e.status!.toLowerCase().contains(value))
          .toList();
      update();
    } else {
      filterItemdata = itemdata!;
      update();
    }
  }

  callIemMaster() async {
    isLoad = true;
    itemdata = [];
    filterItemdata = [];
    update();
    await ItemMasterApi.call().then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        if (onValue.itemdata!.isNotEmpty) {
          itemdata = onValue.itemdata;
          filterItemdata = itemdata;
          List<String> brandlist2 =
              filterItemdata!.map((item) => item.Brand ?? '').toList();
          brandlist = LinkedHashSet<String>.from(brandlist2).toList();
          List<String> categorylist2 =
              filterItemdata!.map((item) => item.Category ?? '').toList();
          categorylist = LinkedHashSet<String>.from(categorylist2).toList();

          List<String> subCategorylist2 =
              filterItemdata!.map((item) => item.Segment ?? '').toList();
          subCategorylist =
              LinkedHashSet<String>.from(subCategorylist2).toList();
          // data = MyData(filterItemdata!);
          isLoad = false;
          update();
        }
      } else {
        isLoad = false;
        update();
        Get.dialog(AlertBox(
          msg: '${onValue.message}',
        ));
      }
    });
  }

  void removeData(index) {
    visitorByChannel.removeAt(index);
    update();
  }

  void clearGNDtls() {
    brand = null;
    category = null;
    subCategory = null;
    refresh();
    formkey[0].currentState!.reset();
    refresh();
  }

  List<PlatformFile> files = [];
  PlatformFile? catelogue1;
  PlatformFile? catelogue2;
  PlatformFile? link1;
  PlatformFile? link2;

  List<PlatformFile> multipleFiles = [];
  bool selectMultipleFile = false;
  FileType type = FileType.any;

  Future<void> pickFiles() async {
    var result = await FilePicker.platform
        .pickFiles(allowMultiple: selectMultipleFile, type: type);
    if (result?.files.isNotEmpty ?? false) {
      files.addAll(result!.files);
      update();
    }
    update();
  }

  onSelectMultipleFile(value) {
    selectMultipleFile = value ?? selectMultipleFile;
    update();
  }

  void removeFile(PlatformFile file) {
    files.remove(file);
    refresh();
    update();
  }

  void storeDeletebyId(int deletId) async {
    await ItemDeleteApi.callapi(deletId).then((onValue) {
      if (onValue.stcode! <= 210 && onValue.stcode! >= 200) {
        Get.back();
        Get.dialog(AlertBox(
          msg: 'Store Sucessfully Deleted..!!',
        )).then((onValue) {
          callIemMaster();
        });
      } else if (onValue.stcode! <= 410 && onValue.stcode! >= 400) {
        Get.dialog(AlertBox(
          msg: '${onValue.message} ${onValue.exception}..!!',
        ));
      } else {
        Get.dialog(AlertBox(
          msg: '${onValue.message} ${onValue.exception}..!!',
        ));
      }
    });
  }
}

class Data {
  final int id, qty;
  final String name;
  final String code;
  final double amount;

  Data(this.id, this.qty, this.name, this.code, this.amount);

  static factory([int seeds = 30]) {
    return List.generate(
        seeds,
        (index) => Data(
            index + 1,
            Random().nextInt(100),
            MyTextUtils.getDummyText(2, withStop: false),
            MyTextUtils.getDummyText(1, withStop: false).toLowerCase(),
            (Random().nextDouble() * 100).toStringAsPrecision(2).toDouble()));
  }
}

class _DataSource extends DataTableSource {
  _DataSource();

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(SizedBox(
          width: 100,
          child: CommonValidationForm(
              controller: null,
              outlineInputBorder: OutlineInputBorder(),
              icon: Icons.abc))),
      DataCell(CommonValidationForm(
          controller: null,
          outlineInputBorder: OutlineInputBorder(),
          icon: Icons.abc)),
      DataCell(CommonValidationForm(
          controller: null,
          outlineInputBorder: OutlineInputBorder(),
          icon: Icons.abc)),
      DataCell(CommonValidationForm(
          controller: null,
          outlineInputBorder: OutlineInputBorder(),
          icon: Icons.abc)),
      DataCell(CommonValidationForm(
          controller: null,
          outlineInputBorder: OutlineInputBorder(),
          icon: Icons.abc)),
      DataCell(CommonValidationForm(
          controller: null,
          outlineInputBorder: OutlineInputBorder(),
          icon: Icons.abc)),
      DataCell(CommonValidationForm(
          controller: null,
          outlineInputBorder: OutlineInputBorder(),
          icon: Icons.abc))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 1;

  @override
  int get selectedRowCount => 0;
}
