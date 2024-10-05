import 'dart:convert';
import 'package:flowkit/controller/pages/inventory/itemmaster_controller.dart';
import 'package:flowkit/controller/pages/inventory/itemstocksPrice_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_list_extension.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/inventory/itemMaster/itemmaster_api.dart';
import 'package:flowkit/services/pages/inventory/item_stocks&price/getall_stocks&prices_api.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart';

class ItemStocksPriceScreen extends StatefulWidget {
  const ItemStocksPriceScreen({super.key});

  @override
  State<ItemStocksPriceScreen> createState() => _ItemStocksPriceScreenState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _ItemStocksPriceScreenState extends State<ItemStocksPriceScreen>
    with TickerProviderStateMixin, UIMixin {
  StocksandPriceController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;
  @override
  void initState() {
    controller = StocksandPriceController();
    _controllerTop = ScrollController();
    _controllerbottom = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return controller.isLoad
              ? SizedBox(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText.titleMedium("Item Stocks and Price",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(
                                  name: 'item Stocks&Price', active: true)
                            ],
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(flexSpacing),
                    Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: height * 0.01,
                                ),
                                width: width / 3,
                                child: DropdownButtonFormField(
                                    dropdownColor: Colors.white,
                                    // isDense: true,
                                    items: controller.filterStorealldata
                                        .map<DropdownMenuItem<String>>(
                                      (e) {
                                        return DropdownMenuItem<String>(
                                          value: e.id.toString(),
                                          child: MyText.bodySmall(e.storeName!),
                                        );
                                      },
                                    ).toList(),
                                    value: controller.valueStore
                                    // widget.controller.brand!.isNotEmpty
                                    //     ?
                                    // widget.controller.brand
                                    // : null
                                    ,
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        controller.callapi(value!);
                                      });
                                    },
                                    onTap: () {},
                                    // validator: widget.controller.basicValidator
                                    //     .getValidation('brand'),
                                    focusColor: Colors.grey[100],
                                    decoration: InputDecoration(
                                      hintText: 'Select Store\n',
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle:
                                          MyTextStyle.bodyMedium(xMuted: true),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              strokeAlign: 0,
                                              color: colorScheme.onSurface
                                                  .withAlpha(20))),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            strokeAlign: 0,
                                            color: Colors.grey[400]!),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            strokeAlign: 0,
                                            color: Colors.grey[400]!),
                                      ),
                                      contentPadding: MySpacing.all(16),
                                      // prefixIcon: Icon(icon, size: 20),
                                      // isCollapsed: true,
                                    )),
                              ),
                              Row(
                                children: [
                                  MySpacing.width(width * 0.005),
                                  CustomPopupMenu(
                                    backdrop: true,
                                    onChange: (_) {},
                                    offsetX: -20,
                                    offsetY: 0,
                                    menu: Stack(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            onPressed: () {},
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.outbox_outlined,
                                                  color: theme.primaryColor,
                                                ),
                                                MyText.bodySmall(
                                                  ' Export',
                                                  color: Colors.black,
                                                )
                                              ],
                                            )),
                                        Container(
                                          color: Colors.transparent,
                                          width: width * 0.06,
                                          height: height * 0.02,
                                        ),
                                      ],
                                    ),
                                    menuBuilder: (_) => buildAccountMenu(),
                                    // hideFn: (hide) => languageHideFn = hide,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollStartNotification) {
                                if (scrollingList == ScrollingList.none) {
                                  scrollingList = ScrollingList.left;
                                }
                              } else if (notification
                                  is ScrollEndNotification) {
                                if (scrollingList == ScrollingList.left) {
                                  scrollingList = ScrollingList.none;
                                }
                              }
                              if (scrollingList == ScrollingList.left) {
                                _controllerbottom.jumpTo(_controllerTop.offset);
                              }
                              return true;
                            },
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _controllerTop,
                              // dragStartBehavior: DragStartBehavior.start,
                              child: Row(children: [
                                // SizedBox(width: width*0.015,),
                                // Change 5 to the number of your columns
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.173, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterItemCode(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.173, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterItemName(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.08, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterStoreCode(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.08, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterStoreStock(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.08, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterWarecode(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.08, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterWarestock(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.1, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterMRP(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.1, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterCost(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.1, // Adjust width as necessary
                                    child: TextField(
                                      // readOnly: true,
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterSP(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          controller.isLoad
                              ? CircularProgressIndicator()
                              : NotificationListener<ScrollNotification>(
                                  onNotification: (notification) {
                                    if (notification
                                        is ScrollStartNotification) {
                                      if (scrollingList == ScrollingList.none) {
                                        scrollingList = ScrollingList.right;
                                      }
                                    } else if (notification
                                        is ScrollEndNotification) {
                                      if (scrollingList ==
                                          ScrollingList.right) {
                                        scrollingList = ScrollingList.none;
                                      }
                                    }
                                    if (scrollingList == ScrollingList.right) {
                                      _controllerTop
                                          .jumpTo(_controllerbottom.offset);
                                    }
                                    return true;
                                  },
                                  child: PaginatedDataTable(
                                    controller: _controllerbottom,
                                    source: MyData(
                                        controller.filterDatalist.isEmpty
                                            ? [
                                                GetAllStocksPriceData(
                                                    id: 0,
                                                    itemCode: '',
                                                    itemName: '',
                                                    brand: '',
                                                    category: '',
                                                    subCategory: '',
                                                    itemDescription: '',
                                                    modelNo: '',
                                                    partCode: '',
                                                    skucode: '',
                                                    brandCode: '',
                                                    itemGroup: '',
                                                    specification: '',
                                                    sizeCapacity: '',
                                                    color: '',
                                                    clasification: '',
                                                    uoM: '',
                                                    taxRate: 0,
                                                    catalogueUrl1: '',
                                                    catalogueUrl2: '',
                                                    imageUrl1: '',
                                                    imageUrl2: '',
                                                    textNote: '',
                                                    status: '',
                                                    movingType: '',
                                                    eol: false,
                                                    veryFast: false,
                                                    fast: false,
                                                    slow: false,
                                                    verySlow: false,
                                                    serialNumber: false,
                                                    priceStockId: 0,
                                                    storeCode: '',
                                                    storeStock: 0.0,
                                                    whseCode: '',
                                                    whseStock: 0.0,
                                                    mrp: 0.0,
                                                    cost: 0.0,
                                                    sp: 0.0,
                                                    ssp1: 0.0,
                                                    ssp2: 0.0,
                                                    ssp3: 0.0,
                                                    ssp4: 0.0,
                                                    ssp5: 0.0,
                                                    ssp1Inc: 0.0,
                                                    ssp2Inc: 0.0,
                                                    ssp3Inc: 0.0,
                                                    ssp4Inc: 0.0,
                                                    ssp5Inc: 0.0,
                                                    calcType: '',
                                                    payOn: '',
                                                    allowNegativeStock: false,
                                                    allowOrderBelowCost: false,
                                                    isFixedPrice: false,
                                                    validTill: '',
                                                    storeAgeSlab1: 0.0,
                                                    storeAgeSlab2: 0.0,
                                                    storeAgeSlab3: 0.0,
                                                    storeAgeSlab4: 0.0,
                                                    storeAgeSlab5: 0.0,
                                                    whsAgeSlab1: 0.0,
                                                    whsAgeSlab2: 0.0,
                                                    whsAgeSlab3: 0.0,
                                                    whsAgeSlab4: 0.0,
                                                    whsAgeSlab5: 0.0)
                                              ]
                                            : controller.filterDatalist,
                                        controller,
                                        context),
                                    columns: [
                                      DataColumn(
                                        label: MyText.bodyMedium(
                                          '   Item Code',
                                          fontWeight: 600,
                                        ),
                                        onSort: (columnIndex, ascending) {},
                                      ),
                                      DataColumn(
                                          label: MyText.bodyMedium(
                                        'Item Name',
                                        fontWeight: 600,
                                      )),
                                      DataColumn(
                                          label: MyText.bodyMedium(
                                        'Store Code',
                                        fontWeight: 600,
                                      )),
                                      DataColumn(
                                          label: MyText.bodyMedium(
                                        'Store Stock',
                                        fontWeight: 600,
                                      )),
                                      DataColumn(
                                          label: MyText.bodyMedium(
                                        'Warehouse Code',
                                        fontWeight: 600,
                                      )),
                                      DataColumn(
                                        label: MyText.bodyMedium(
                                          'Warehouse Stock',
                                          // textAlign: TextAlign.center,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.bodyMedium(
                                          'MRP',
                                          fontWeight: 600,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.bodyMedium(
                                          'Cost',
                                          fontWeight: 600,
                                        ),
                                      ),
                                      DataColumn(
                                        label: MyText.bodyMedium(
                                          'SP',
                                          fontWeight: 600,
                                        ),
                                      ),
                                    ],
                                    columnSpacing: 10,
                                    horizontalMargin: 10,
                                    rowsPerPage: 10,
                                  ),
                                ),
                          // MySpacing.height(12),
                          // buildVisitorByChannel()
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget buildAccountMenu() {
    return MyContainer(
      borderRadiusAll: 8,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyButton(
            onPressed: () => {_createExcel('xlsx')},
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            borderRadiusAll: AppStyle.buttonRadius.medium,
            padding: MySpacing.xy(8, 4),
            splashColor: colorScheme.onSurface.withAlpha(20),
            backgroundColor: Colors.transparent,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/brand/xlsx.png',
                  scale: 20,
                ),
                MySpacing.width(8),
                MyText.labelMedium(
                  "XLSX",
                  fontWeight: 600,
                )
              ],
            ),
          ),
          MySpacing.height(8),
          MyButton(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () => {_createExcel('xls')},
            borderRadiusAll: AppStyle.buttonRadius.medium,
            padding: MySpacing.xy(8, 4),
            splashColor: colorScheme.onSurface.withAlpha(20),
            backgroundColor: Colors.transparent,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/brand/xls.png',
                  scale: 20,
                ),
                MySpacing.width(8),
                MyText.labelMedium("XLS", fontWeight: 600)
              ],
            ),
          ),
          MySpacing.height(8),
          MyButton(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              // languageHideFn?.call();
              // Get.offAll(LoginScreen());
            },
            borderRadiusAll: AppStyle.buttonRadius.medium,
            padding: MySpacing.xy(8, 4),
            splashColor: contentTheme.danger.withAlpha(28),
            backgroundColor: Colors.transparent,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/brand/docx.png',
                  scale: 20,
                ),
                MySpacing.width(8),
                MyText.labelMedium("DOCX",
                    fontWeight: 600, color: contentTheme.danger)
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _createExcel(String exceltype) async {
    //Create a Excel document.
    //Creating a workbook
    final xls.Workbook workbook = xls.Workbook();
    //Accessing via index.
    final xls.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByIndex(1, 1).setText("Item Code");
    sheet.getRangeByIndex(1, 2).setText("Item Name");
    sheet.getRangeByIndex(1, 3).setText("Store Code");
    sheet.getRangeByIndex(1, 4).setText("Store Stock");
    sheet.getRangeByIndex(1, 5).setText("WareHouse Code");
    sheet.getRangeByIndex(1, 6).setText("Warehouse Stock");
    sheet.getRangeByIndex(1, 7).setText("MRP");
    sheet.getRangeByIndex(1, 8).setText("Cost");
    sheet.getRangeByIndex(1, 9).setText("SP");

    for (var i = 0; i < controller!.filterDatalist.length; i++) {
      final item = controller!.filterDatalist[i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.itemCode);
      sheet.getRangeByIndex(i + 2, 2).setText(item.itemName);
      sheet.getRangeByIndex(i + 2, 3).setText(item.storeCode);
      sheet.getRangeByIndex(i + 2, 4).setText(item.storeStock.toString());
      sheet.getRangeByIndex(i + 2, 5).setText(item.whseCode);
      sheet.getRangeByIndex(i + 2, 6).setText(item.whseStock.toString());
      sheet.getRangeByIndex(i + 2, 7).setText(item.mrp.toString());
      sheet.getRangeByIndex(i + 2, 8).setText(item.cost.toString());
      sheet.getRangeByIndex(i + 2, 9).setText(item.sp.toString());

      // sheet
      //     .getRangeByIndex(i + 2, 6)
      //     .setText(item.status == '1' ? 'Active' : 'Deactive');
    }

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "output.$exceltype")
      ..click();
    workbook.dispose();
  }
}

class MyData extends DataTableSource with UIMixin {
  List<GetAllStocksPriceData> data = [];
  StocksandPriceController cnt;
  BuildContext context;
  MyData(this.data, this.cnt, this.context);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.isEmpty ? 1 : data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    final double width = MediaQuery.of(context).size.width;
    return DataRow(
      cells: [
        DataCell(
            // onTap: () {},
            Container(
          margin: EdgeInsets.only(left: 10),
          width: width * 0.18,
          child: MyText.bodySmall(
            data[index].itemCode.toString(),
            // fontWeight: 600,
          ),
        )),
        DataCell(SizedBox(
          width: width * 0.18,
          child: MyText.bodySmall(
            '${data[index].itemName!}',
            textAlign: TextAlign.justify,
            // fontWeight: 600,
          ),
        )),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: width * 0.08,
            child: MyText.bodySmall(
              data[index].storeCode.toString(),
            ))),
        DataCell(SizedBox(
            width: width * 0.08,
            child: MyText.bodySmall(data[index].storeStock == 0.0
                ? ''
                : data[index].storeStock.toString()))),
        DataCell(SizedBox(
            width: width * 0.08,
            child: MyText.bodySmall(data[index].whseCode!.toString()))),
        DataCell(SizedBox(
            width: width * 0.08,
            child: MyText.bodySmall(data[index].whseStock == 0.0
                ? ''
                : data[index].whseStock.toString()))),
        DataCell(SizedBox(
            width: width * 0.1,
            child: MyText.bodySmall(
                data[index].mrp == 0.0 ? '' : data[index].mrp!.toString()))),
        DataCell(SizedBox(
            width: width * 0.1,
            child: MyText.bodySmall(
                data[index].cost == 0.0 ? '' : data[index].cost!.toString()))),
        DataCell(SizedBox(
            width: width * 0.1,
            child: MyText.bodySmall(
                data[index].sp == 0.0 ? '' : data[index].sp!.toString()))),
      ],
    );
  }
}

/* Common Text Field For Validation */
class CommonValidationForm extends StatelessWidget {
  CommonValidationForm(
      {super.key,
      required this.controller,
      required this.outlineInputBorder,
      this.validator,
      this.hintText,
      this.icon,
      this.onChanged,
      this.inputFormatters,
      this.iconOnPressed});
  Function()? iconOnPressed;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? icon;
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final OutlineInputBorder outlineInputBorder;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          contentPadding: MySpacing.all(16),
          prefixIcon: iconOnPressed == null
              ? null
              : IconButton(
                  icon: Icon(
                    icon,
                    size: 20,
                    color: theme.primaryColor,
                  ),
                  onPressed: iconOnPressed ?? () {},
                ),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never),
    );
  }
}
