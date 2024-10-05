import 'dart:convert';
import 'package:flowkit/controller/pages/pre_sales/customerdata_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/customerdata/getAllcustomer_dataApi.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/view/pages/presales/customer_data/widgets/new_customer.dart';
import 'package:flowkit/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart';

class CustomerData extends StatefulWidget {
  const CustomerData({super.key});

  @override
  State<CustomerData> createState() => _CustomerDataState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _CustomerDataState extends State<CustomerData>
    with TickerProviderStateMixin, UIMixin {
  CustomerDataController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;

  @override
  void initState() {
    controller = CustomerDataController();
    _controllerTop = ScrollController();
    _controllerbottom = ScrollController();
    super.initState();
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
                          MyText.titleMedium("Customer Data",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(
                                  name: 'customer data', active: true)
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
                                      Get.dialog(
                                        barrierDismissible: false,
                                        Dialog(
                                            clipBehavior: Clip.none,
                                            // insetPadding: EdgeInsets.all(50),
                                            child: NewCustomer(
                                              outlineInputBorder:
                                                  outlineInputBorder,
                                              colorScheme: colorScheme,
                                              focusedInputBorder:
                                                  focusedInputBorder,
                                              contentTheme: contentTheme,
                                              controller: controller,
                                              heigth: height,
                                              width: height,
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
                                          ' New Customer',
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
                                // SizedBox(
                                //   width: width * 0.015,
                                // ),
                                // Change 5 to the number of your columns
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        // Handle search functionality here
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        // Handle search functionality here
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        // Handle search functionality here
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.075, // Adjust width as necessary
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

                              // sortColumnIndex: 5,
                              // header: minimizescreen
                              //     ? Container()
                              //     : SingleChildScrollView(
                              //         scrollDirection: Axis.horizontal,
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             SizedBox(
                              //                 width: width * 0.19,
                              //                 child: CommonValidationForm(
                              //                   controller: null,
                              //                   hintText: '',
                              //                   outlineInputBorder:
                              //                       OutlineInputBorder(
                              //                     borderRadius: BorderRadius.all(
                              //                         Radius.circular(5)),
                              //                     borderSide: BorderSide(
                              //                         width: 1,
                              //                         strokeAlign: 0,
                              //                         color: colorScheme.onSurface
                              //                             .withAlpha(80)),
                              //                   ),
                              //                   onChanged: (aval) async {
                              //                     controller.filterItemCode(
                              //                         aval, controller);
                              //                   },
                              //                 )),
                              //             SizedBox(
                              //               width: width * 0.003,
                              //             ),
                              //             SizedBox(
                              //                 width: width * 0.19,
                              //                 child: CommonValidationForm(
                              //                   controller: null,
                              //                   outlineInputBorder:
                              //                       OutlineInputBorder(
                              //                     borderRadius: BorderRadius.all(
                              //                         Radius.circular(5)),
                              //                     borderSide: BorderSide(
                              //                         width: 1,
                              //                         strokeAlign: 0,
                              //                         color: colorScheme.onSurface
                              //                             .withAlpha(80)),
                              //                   ),
                              //                   onChanged: (aval) async {
                              //                     controller.filterItemName(
                              //                         aval, controller);
                              //                   },
                              //                 )),
                              //             SizedBox(
                              //               width: width * 0.003,
                              //             ),
                              //             SizedBox(
                              //                 width: width * 0.09,
                              //                 child: CommonValidationForm(
                              //                   controller: null,
                              //                   outlineInputBorder:
                              //                       OutlineInputBorder(
                              //                     borderRadius: BorderRadius.all(
                              //                         Radius.circular(5)),
                              //                     borderSide: BorderSide(
                              //                         width: 1,
                              //                         strokeAlign: 0,
                              //                         color: colorScheme.onSurface
                              //                             .withAlpha(80)),
                              //                   ),
                              //                   onChanged: (aval) async {
                              //                     controller.filterBrand(
                              //                         aval, controller);
                              //                   },
                              //                 )),
                              //             SizedBox(
                              //               width: width * 0.003,
                              //             ),
                              //             SizedBox(
                              //                 width: width * 0.09,
                              //                 child: CommonValidationForm(
                              //                   controller: null,
                              //                   outlineInputBorder:
                              //                       OutlineInputBorder(
                              //                     borderRadius: BorderRadius.all(
                              //                         Radius.circular(5)),
                              //                     borderSide: BorderSide(
                              //                         width: 1,
                              //                         strokeAlign: 0,
                              //                         color: colorScheme.onSurface
                              //                             .withAlpha(80)),
                              //                   ),
                              //                   onChanged: (aval) async {
                              //                     controller.filterCAtegory(
                              //                         aval, controller);
                              //                   },
                              //                 )),
                              //             SizedBox(
                              //               width: width * 0.003,
                              //             ),
                              //             SizedBox(
                              //                 width: width * 0.09,
                              //                 child: CommonValidationForm(
                              //                   controller: null,
                              //                   outlineInputBorder:
                              //                       OutlineInputBorder(
                              //                     borderRadius: BorderRadius.all(
                              //                         Radius.circular(5)),
                              //                     borderSide: BorderSide(
                              //                         width: 1,
                              //                         strokeAlign: 0,
                              //                         color: colorScheme.onSurface
                              //                             .withAlpha(80)),
                              //                   ),
                              //                   onChanged: (aval) async {
                              //                     controller.filterSubCategory(
                              //                         aval, controller);
                              //                   },
                              //                 )),
                              //             SizedBox(
                              //               width: width * 0.003,
                              //             ),
                              //             SizedBox(
                              //                 width: width * 0.07,
                              //                 child: CommonValidationForm(
                              //                   controller: null,
                              //                   outlineInputBorder:
                              //                       OutlineInputBorder(
                              //                     borderRadius: BorderRadius.all(
                              //                         Radius.circular(5)),
                              //                     borderSide: BorderSide(
                              //                         width: 1,
                              //                         strokeAlign: 0,
                              //                         color: colorScheme.onSurface
                              //                             .withAlpha(80)),
                              //                   ),
                              //                   onChanged: (aval) async {
                              //                     controller.filterStatus(
                              //                         aval, controller);
                              //                   },
                              //                 )),
                              //             SizedBox(
                              //               width: width * 0.003,
                              //             ),
                              //             SizedBox(
                              //                 width: width * 0.03,
                              //                 child: CommonValidationForm(
                              //                   controller: null,
                              //                   outlineInputBorder:
                              //                       OutlineInputBorder(
                              //                     borderRadius: BorderRadius.all(
                              //                         Radius.circular(5)),
                              //                     borderSide: BorderSide(
                              //                         width: 1,
                              //                         strokeAlign: 0,
                              //                         color: colorScheme.onSurface
                              //                             .withAlpha(80)),
                              //                   ),
                              //                   onChanged: (aval) async {
                              //                     // controller.filterItemName(
                              //                     //     aval, controller);
                              //                   },
                              //                 )),
                              //           ],
                              //         ),
                              //       ),
                              // arrowHeadColor: Colors.black  ,
                              source: MyData(controller.filterDataList,
                                  controller, context),
                              columns: [
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    '     Store Code',
                                    fontWeight: 600,
                                  ),
                                  onSort: (columnIndex, ascending) {},
                                ),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Customer Code',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  '  Customer Name',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Mobile No',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Contact Name',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Email',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Created Date',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Last Modified',
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
    sheet.getRangeByIndex(1, 1).setText("Store Code");
    sheet.getRangeByIndex(1, 2).setText("Customer code");
    sheet.getRangeByIndex(1, 3).setText("Customer Name");
    sheet.getRangeByIndex(1, 4).setText("Mobile");
    sheet.getRangeByIndex(1, 5).setText("Contact Name");
    sheet.getRangeByIndex(1, 6).setText("Customer Name");

    sheet.getRangeByIndex(1, 7).setText("Email");
    sheet.getRangeByIndex(1, 8).setText("Created Date");
    sheet.getRangeByIndex(1, 9).setText("Last Modified");
    sheet.getRangeByIndex(1, 10).setText("Status");

    for (var i = 0; i < controller!.filterDataList.length; i++) {
      final item = controller!.filterDataList[i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.storeCode);
      sheet.getRangeByIndex(i + 2, 2).setText(item.customerCode);
      sheet.getRangeByIndex(i + 2, 3).setText(item.customerName);
      sheet.getRangeByIndex(i + 2, 4).setText(item.customerMobile);
      sheet.getRangeByIndex(i + 2, 6).setText(item.contactName);
      sheet.getRangeByIndex(i + 2, 7).setText(item.customerEmail);
      sheet.getRangeByIndex(i + 2, 8).setText(item.createdOn);
      sheet.getRangeByIndex(i + 2, 9).setText(item.updatedOn);

      sheet
          .getRangeByIndex(i + 2, 10)
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
}

class MyData extends DataTableSource with UIMixin {
  List<AccountsNewData> data = [];
  CustomerDataController cnt;
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
    final double width = MediaQuery.of(context).size.width;
    Utils config = Utils();
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
            // onTap: () {},
            Container(
          margin: EdgeInsets.only(left: 20),
          width: width * 0.08,
          child: MyText.bodySmall(
            '${data[index].storeCode.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
          // margin: EdgeInsets.only(left: 20),
          width: width * 0.08,
          child: MyText.bodySmall(
            '${data[index].customerCode.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
          // margin: EdgeInsets.only(left: 20),
          width: width * 0.08,
          child: MyText.bodySmall(
            '${data[index].customerName.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
          // margin: EdgeInsets.only(left: 20),
          width: width * 0.08,
          child: MyText.bodySmall(
            '${data[index].customerMobile.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(SizedBox(
          width: width * 0.08,
          child: MyText.bodySmall(
            '${data[index].contactName!}',
            textAlign: TextAlign.justify,
            // fontWeight: 600,
          ),
        )),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: width * 0.08,
            child: MyText.bodySmall(
              data[index].customerEmail.toString(),
            ))),
        DataCell(SizedBox(
            width: width * 0.08,
            child: MyText.bodySmall(
                config.currentDateFormat(data[index].createdOn.toString())))),
        DataCell(SizedBox(
            width: width * 0.08,
            child: MyText.bodySmall(
                config.currentDateFormat(data[index].updatedOn!.toString())))),
        DataCell(SizedBox(
            width: width * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: data[index].status == 'Active'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: MyText.bodySmall(
                      data[index].status!,
                      color: Colors.white,
                    )),
              ],
            ))),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.pencil,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
                MySpacing.width(12),
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.list,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
                MySpacing.width(12),
                MyContainer.bordered(
                  onTap: () => {},
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
