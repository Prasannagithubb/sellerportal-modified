import 'dart:convert';
import 'package:flowkit/controller/pages/inventory/itemmaster_controller.dart';
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
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/widgets/deleted_alertbox.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/widgets/new_brand.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/widgets/new_category.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/widgets/new_item.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/widgets/new_subcategory.dart';
import 'package:flowkit/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart';

class ItemMasterScren extends StatefulWidget {
  const ItemMasterScren({super.key});

  @override
  State<ItemMasterScren> createState() => _ItemMasterScrenState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _ItemMasterScrenState extends State<ItemMasterScren>
    with TickerProviderStateMixin, UIMixin {
  ItemMasterController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;

  @override
  void initState() {
    controller = ItemMasterController(this);
    _controllerTop = ScrollController();
    _controllerbottom = ScrollController();
    // test2();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      test2();
    });
    super.initState();
  }

  test2() {
    setState(() {
      print('Length::' + controller!.itemdata!.length.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final bool minimizescreen = MediaQuery.of(context).size.width < 1000;
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
                          MyText.titleMedium("Item Master",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(name: 'itemMaster', active: true)
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        controller.softTabController.index = 0;
                                      });
                                      Get.dialog(
                                        barrierDismissible: false,
                                        Dialog(
                                            clipBehavior: Clip.none,
                                            // insetPadding: EdgeInsets.all(50),
                                            child: NewItemAdd(
                                              outlineInputBorder:
                                                  outlineInputBorder,
                                              colorScheme: colorScheme,
                                              focusedInputBorder:
                                                  focusedInputBorder,
                                              contentTheme: contentTheme,
                                              controller: controller,
                                              heigth: height,
                                              width: width / 2,
                                            )),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: theme.primaryColor,
                                        ),
                                        MyText.bodySmall(
                                          ' New Item',
                                          color: Colors.black,
                                        )
                                      ],
                                    )),
                                MySpacing.width(width * 0.005),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        controller.basicValidator
                                            .getController('newbrand')!
                                            .text = '';
                                      });
                                      Get.dialog(
                                        barrierDismissible: false,
                                        Dialog(
                                            // clipBehavior: Clip.none,
                                            // insetPadding: EdgeInsets.all(50),
                                            child: NewBrand(
                                          outlineInputBorder:
                                              outlineInputBorder,
                                          colorScheme: colorScheme,
                                          focusedInputBorder:
                                              focusedInputBorder,
                                          contentTheme: contentTheme,
                                          controller: controller,
                                          heigth: height,
                                          width: width / 2,
                                        )),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: theme.primaryColor,
                                        ),
                                        MyText.bodySmall(
                                          ' New Brand',
                                          color: Colors.black,
                                        )
                                      ],
                                    )),
                                MySpacing.width(width * 0.005),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        controller.basicValidator
                                            .getController('newcategory')!
                                            .text = '';
                                      });
                                      Get.dialog(
                                        barrierDismissible: false,
                                        Dialog(
                                            // clipBehavior: Clip.none,
                                            // insetPadding: EdgeInsets.all(50),
                                            child: NewCategory(
                                          outlineInputBorder:
                                              outlineInputBorder,
                                          colorScheme: colorScheme,
                                          focusedInputBorder:
                                              focusedInputBorder,
                                          contentTheme: contentTheme,
                                          controller: controller,
                                          heigth: height,
                                          width: width / 2,
                                        )),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: theme.primaryColor,
                                        ),
                                        MyText.bodySmall(
                                          ' New Category',
                                          color: Colors.black,
                                        )
                                      ],
                                    )),
                                MySpacing.width(width * 0.005),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        controller.basicValidator
                                            .getController('newsubcategory')!
                                            .text = '';
                                      });
                                      Get.dialog(
                                        barrierDismissible: false,
                                        Dialog(
                                            // clipBehavior: Clip.none,
                                            // insetPadding: EdgeInsets.all(50),
                                            child: NewSubCategory(
                                          outlineInputBorder:
                                              outlineInputBorder,
                                          colorScheme: colorScheme,
                                          focusedInputBorder:
                                              focusedInputBorder,
                                          contentTheme: contentTheme,
                                          controller: controller,
                                          heigth: height,
                                          width: width / 2,
                                        )),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: theme.primaryColor,
                                        ),
                                        MyText.bodySmall(
                                          ' New SubCategory',
                                          color: Colors.black,
                                        )
                                      ],
                                    )),
                                MySpacing.width(width * 0.005),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: theme.primaryColor,
                                        ),
                                        MyText.bodySmall(
                                          ' Excel',
                                          color: Colors.black,
                                        )
                                      ],
                                    )),
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
                            ),
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
                              child: Row(children: [
                                // SizedBox(width: width*0.015,),
                                // Change 5 to the number of your columns
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.17, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        controller.filterItemCode(
                                            value, controller, context);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.17, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        controller.filterItemName(
                                            value, controller, context);
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
                                        controller.filterBrand(
                                            value, controller);
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
                                        controller.filterCAtegory(
                                            value, controller);
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
                                        controller.filterSubCategory(
                                            value, controller);
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
                                        controller.filterStatus(
                                            value, controller);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.07, // Adjust width as necessary
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: ' ',
                                      ),
                                      onChanged: (value) {
                                        // Handle search functionality here
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollStartNotification) {
                                if (scrollingList == ScrollingList.none) {
                                  scrollingList = ScrollingList.right;
                                }
                              } else if (notification
                                  is ScrollEndNotification) {
                                if (scrollingList == ScrollingList.right) {
                                  scrollingList = ScrollingList.none;
                                }
                              }
                              if (scrollingList == ScrollingList.right) {
                                _controllerTop.jumpTo(_controllerbottom.offset);
                              }
                              return true;
                            },
                            child: PaginatedDataTable(
                              controller: _controllerbottom,
                              showFirstLastButtons: true,

                              source: MyData(
                                  controller.filterItemdata!.isEmpty
                                      ? [
                                          ItemMasterNewData(
                                              MgrPrice: null,
                                              itemcode: '',
                                              itemName: '',
                                              Segment: '',
                                              Favorite: '',
                                              SlpPrice: null,
                                              Category: '',
                                              Brand: '',
                                              Division: '',
                                              StoreStock: null,
                                              WhsStock: null,
                                              id: null,
                                              allowNegativeStock: null,
                                              allowOrderBelowCost: null,
                                              brandCode: '',
                                              catalogueUrl1: '',
                                              catalogueUrl2: '',
                                              clasification: '',
                                              eol: null,
                                              fast: null,
                                              imageUrl1: '',
                                              imageUrl2: '',
                                              isFixedPrice: null,
                                              itemDescription: '',
                                              itemGroup: '',
                                              modelNo: '',
                                              movingType: '',
                                              partCode: '',
                                              priceStockId: null,
                                              serialNumber: null,
                                              sizeCapacity: '',
                                              skucode: '',
                                              slow: null,
                                              sp: null,
                                              specification: '',
                                              ssp1: null,
                                              ssp1Inc: null,
                                              ssp2: null,
                                              ssp2Inc: null,
                                              ssp3: null,
                                              ssp3Inc: null,
                                              ssp4: null,
                                              ssp4Inc: null,
                                              ssp5: null,
                                              ssp5Inc: null,
                                              status: '-1',
                                              storeCode: '',
                                              taxRate: null,
                                              textNote: '',
                                              uoM: '',
                                              veryFast: null,
                                              verySlow: null,
                                              whseCode: '',
                                              color: '',
                                              validTill: '',
                                              calcType: '',
                                              payOn: '')
                                        ]
                                      : controller.filterItemdata!,
                                  controller,
                                  context),

                              columns: [
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    '     Item Code',
                                    fontWeight: 600,
                                  ),
                                ),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Item Name',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  '  Brand',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Category',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'SubCategory',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    'Status',
                                    fontWeight: 600,
                                  ),
                                ),
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    'Action',
                                    fontWeight: 600,
                                  ),
                                ),
                              ],
                              columnSpacing: 10,
                              horizontalMargin: 10,
                              // rowsPerPage: 20,

                              headingRowHeight: height * 0.04,
                              // ignore: deprecated_member_use
                              dataRowHeight: height * 0.04,
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
    sheet.getRangeByIndex(1, 3).setText("Brand");
    sheet.getRangeByIndex(1, 4).setText("Category");
    sheet.getRangeByIndex(1, 5).setText("SubCategory");
    sheet.getRangeByIndex(1, 6).setText("Status");

    for (var i = 0; i < controller!.filterItemdata!.length; i++) {
      final item = controller!.filterItemdata![i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.itemcode);
      sheet.getRangeByIndex(i + 2, 2).setText(item.itemName);
      sheet.getRangeByIndex(i + 2, 3).setText(item.Brand);
      sheet.getRangeByIndex(i + 2, 4).setText(item.Category);
      sheet.getRangeByIndex(i + 2, 5).setText(item.Segment);
      sheet
          .getRangeByIndex(i + 2, 6)
          .setText(item.status == '1' ? 'Active' : 'Inactive');
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

  Widget buildVisitorByChannel() {
    return MyCard(
      width: double.infinity,
      shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
      borderRadiusAll: 8,
      paddingAll: 23,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.titleMedium("Visitors By Channel", fontWeight: 600),
          MySpacing.height(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortAscending: true,
                columnSpacing: 60,
                onSelectAll: (_) => {},
                headingRowColor:
                    WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(
                    borderRadius: BorderRadius.circular(8),
                    style: BorderStyle.solid,
                    width: .4,
                    color: Colors.grey),
                columns: [
                  DataColumn(
                      label: MyText.labelLarge(
                    'S.No',
                    color: contentTheme.primary,
                  )),
                  DataColumn(
                      label: MyText.labelLarge(
                    'Channel',
                    color: contentTheme.primary,
                  )),
                  DataColumn(
                      label: MyText.labelLarge(
                    'Session',
                    color: contentTheme.primary,
                  )),
                  DataColumn(
                      label: MyText.labelLarge(
                    'Bounce Rate',
                    color: contentTheme.primary,
                  )),
                  DataColumn(
                      label: MyText.labelLarge(
                    'Session Duration',
                    color: contentTheme.primary,
                  )),
                  DataColumn(
                      label: MyText.labelLarge(
                    'Target Reached',
                    color: contentTheme.primary,
                  )),
                  DataColumn(
                      label: MyText.labelLarge(
                    'Page Per Session',
                    color: contentTheme.primary,
                  )),
                  DataColumn(
                      label: MyText.labelLarge(
                    'Action',
                    color: contentTheme.primary,
                  )),
                ],
                rows: controller!.visitorByChannel
                    .mapIndexed((index, data) => DataRow(cells: [
                          DataCell(MyText.bodyMedium('${data.id}')),
                          DataCell(SizedBox(
                            width: 250,
                            child: MyText.labelLarge(
                              data.channel,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )),
                          DataCell(SizedBox(
                              width: 100,
                              child: MyText.bodySmall('${data.session}',
                                  fontWeight: 600))),
                          DataCell(SizedBox(
                            width: 100,
                            child: MyText.bodySmall('${data.bounceRate}%',
                                fontWeight: 600),
                          )),
                          DataCell(SizedBox(
                            width: 250,
                            child: MyText.bodySmall(
                                '${Utils.getDateTimeStringFromDateTime(data.sessionDuration)}',
                                fontWeight: 600),
                          )),
                          DataCell(
                            MyContainer(
                              borderRadiusAll: 4,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              padding: MySpacing.xy(8, 8),
                              color: contentTheme.primary.withAlpha(32),
                              child: MyText.bodySmall(
                                '${data.targetReached}',
                                fontWeight: 600,
                                color: contentTheme.primary,
                              ),
                            ),
                          ),
                          DataCell(SizedBox(
                              width: 100,
                              child:
                                  MyText.bodyMedium('${data.pagePerSession}'))),
                          DataCell(SizedBox(
                            width: 130,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyContainer(
                                  onTap: () => {},
                                  padding: MySpacing.xy(8, 8),
                                  color: contentTheme.primary.withAlpha(36),
                                  child: Icon(
                                    LucideIcons.pencil,
                                    size: 14,
                                    color: contentTheme.primary,
                                  ),
                                ),
                                MyContainer(
                                  onTap: () => {},
                                  padding: MySpacing.xy(8, 8),
                                  color: contentTheme.success.withAlpha(36),
                                  child: Icon(
                                    LucideIcons.pencil,
                                    size: 14,
                                    color: contentTheme.success,
                                  ),
                                ),
                                MyContainer(
                                  onTap: () => controller!.removeData(index),
                                  padding: MySpacing.xy(8, 8),
                                  color: contentTheme.danger.withAlpha(36),
                                  child: Icon(
                                    LucideIcons.trash_2,
                                    size: 14,
                                    color: contentTheme.danger,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ]))
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class MyData extends DataTableSource with UIMixin {
  List<ItemMasterNewData> data = [];
  ItemMasterController cnt;
  BuildContext context;
  MyData(this.data, this.cnt, this.context);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
            // onTap: () {},
            Container(
          margin: EdgeInsets.only(left: 20),
          width: width * 0.17,
          child: MyText.bodySmall(
            '${data[index].itemcode.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(SizedBox(
          width: width * 0.17,
          child: MyText.bodySmall(
            '${data[index].itemName!}',
            textAlign: TextAlign.justify,
            // fontWeight: 600,
          ),
        )),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: width * 0.1,
            child: MyText.bodySmall(
              data[index].Brand.toString(),
            ))),
        DataCell(SizedBox(
            width: width * 0.1,
            child: MyText.bodySmall(data[index].Category.toString()))),
        DataCell(SizedBox(
            width: width * 0.1,
            child: MyText.bodySmall(data[index].Segment!.toString()))),
        DataCell(SizedBox(
            width: width * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: data[index].status == '1'
                            ? Colors.green
                            : data[index].status == '0'
                                ? Colors.red
                                : Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: data[index].status == '1'
                        ? MyText.bodySmall(
                            'Active',
                            color: Colors.white,
                          )
                        : data[index].status == '0'
                            ? MyText.bodySmall(
                                'Inactive',
                                color: Colors.white,
                              )
                            : Text('')),
              ],
            ))),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: data[index].status == '-1'
                ? Row(
                    children: [SizedBox()],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // MyContainer.bordered(
                      //   onTap: () => {},
                      //   padding: MySpacing.xy(6, 6),
                      //   borderColor: contentTheme.primary.withAlpha(40),
                      //   child: Icon(
                      //     LucideIcons.pencil,
                      //     size: 12,
                      //     color: contentTheme.primary,
                      //   ),
                      // ),
                      // MySpacing.width(12),
                      MyContainer.bordered(
                        onTap: () => {
                          Get.dialog(DeleteItemAlertBox(
                              controller: cnt, deletId: data[index].id!))
                        },
                        padding: MySpacing.xy(6, 6),
                        borderColor: contentTheme.primary.withAlpha(40),
                        child: Icon(
                          LucideIcons.trash_2,
                          size: 12,
                          color: contentTheme.primary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
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
      this.readOnly = false,
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
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      readOnly: readOnly,
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
          suffixIcon: iconOnPressed == null
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
