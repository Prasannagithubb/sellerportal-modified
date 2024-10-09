import 'dart:convert';
import 'package:flowkit/controller/pages/pre_sales/enquiry_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/presales/enquiry/getenquiry_api.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _EnquiryScreenState extends State<EnquiryScreen>
    with TickerProviderStateMixin, UIMixin {
  EnquiryController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;
  @override
  void initState() {
    controller = EnquiryController();
    //
    _controllerTop = ScrollController();
    _controllerbottom = ScrollController();
    //

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                          MyText.titleMedium("Enquiry",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(name: 'enquiry', active: true)
                            ],
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(flexSpacing),
                    Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: Form(
                        key: controller.formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.35,
                                      child: MyFlex(children: [
                                        MyFlexItem(
                                            sizes: 'lg-6 md-6 sm-6 xs-6',
                                            child: CommonValidationForm(
                                              controller: controller
                                                  .basicValidator
                                                  .getController('fromdate'),
                                              validator: controller
                                                  .basicValidator
                                                  .getValidation('fromdate'),
                                              readOnly: true,
                                              hintText: '  From Date',
                                              icon: LucideIcons.calendar,
                                              iconOnPressed: () async {
                                                DateTime? data =
                                                    await showDatePicker(
                                                        context: context,
                                                        firstDate:
                                                            DateTime(1990),
                                                        lastDate:
                                                            DateTime.now());
                                                print(data.toString());

                                                setState(() {
                                                  controller.basicValidator
                                                          .getController(
                                                              'fromdate')!
                                                          .text =
                                                      "${data!.year.toString()}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}";
                                                });
                                              },
                                              outlineInputBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    strokeAlign: 0,
                                                    color: colorScheme.onSurface
                                                        .withAlpha(50)),
                                              ),
                                            )),
                                        MyFlexItem(
                                            sizes: 'lg-6 md-6 sm-6 xs-6',
                                            child: CommonValidationForm(
                                              controller: controller
                                                  .basicValidator
                                                  .getController('todate'),
                                              validator: controller
                                                  .basicValidator
                                                  .getValidation('todate'),
                                              readOnly: true,
                                              hintText: '  To Date',
                                              icon: LucideIcons.calendar,
                                              iconOnPressed: () async {
                                                DateTime? data =
                                                    await showDatePicker(
                                                        context: context,
                                                        firstDate:
                                                            DateTime(1990),
                                                        lastDate:
                                                            DateTime.now());
                                                print(data.toString());

                                                setState(() {
                                                  controller.basicValidator
                                                          .getController('todate')!
                                                          .text =
                                                      "${data!.year.toString()}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}";
                                                });
                                              },
                                              outlineInputBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    strokeAlign: 0,
                                                    color: colorScheme.onSurface
                                                        .withAlpha(50)),
                                              ),
                                            )),
                                      ]),
                                    ),
                                    MyFlexItem(
                                        sizes: 'lg-6 md-6 sm-6 xs-6',
                                        child: Container(
                                          padding: EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                controller.calApi();
                                              },
                                              icon: Icon(
                                                LucideIcons.filter,
                                                size: 18,
                                                color: theme.primaryColor,
                                              )),
                                        ))
                                  ],
                                ),
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
                                  _controllerbottom
                                      .jumpTo(_controllerTop.offset);
                                }
                                return true;
                              },
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _controllerTop,
                                child: Row(children: [
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  // Change 5 to the number of your columns
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
                                        onChanged: (val) {
                                          // Handle search functionality here
                                          setState(() {
                                            controller.filterEnquiryId(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterEnquiryDate(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterStorename(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterusername(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterCustomername(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller
                                                .filterCustomerMobile(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterAddress(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterArea(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterPincode(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterCity(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterState(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width *
                                          0.115, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (val) {
                                          setState(() {
                                            controller.filterStatus(val);
                                          });
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
                                  _controllerTop
                                      .jumpTo(_controllerbottom.offset);
                                }
                                return true;
                              },
                              child: PaginatedDataTable(
                                controller: _controllerbottom,
                                source: MyData(
                                    controller.filteddata!.isEmpty
                                        ? [
                                            GetEnquiryData(
                                                interestLevel: '',
                                                orderType: '',
                                                contactName: '',
                                                altermobileNo: '',
                                                customerGroup: '',
                                                mgrUserName: '',
                                                comapanyname: '',
                                                visitTime: '',
                                                remindOn: '',
                                                isClosed: '',
                                                isVisitRequired: '',
                                                storecode: '',
                                                area: '',
                                                district: '',
                                                itemCode: '',
                                                itemname: '',
                                                leadConverted: false,
                                                createdBy: 0,
                                                createdDateTime: '',
                                                updatedBy: 0,
                                                updatedDateTime: '',
                                                enquirydscription: '',
                                                quantity: 0.0,
                                                enqID: 0,
                                                cardCode: '',
                                                status: '',
                                                cardName: '',
                                                assignedToUser: '',
                                                enqDate: '',
                                                followup: '',
                                                mgrUserCode: '',
                                                assignedToUserName: '',
                                                enqType: '',
                                                lookingfor: '',
                                                potentialValue: 0.0,
                                                addressLine1: '',
                                                addressLine2: '',
                                                pincode: 0,
                                                city: '',
                                                state: '',
                                                country: '',
                                                managerStatusTab: '',
                                                slpStatusTab: '',
                                                email: '',
                                                referal: '',
                                                customermobile: '')
                                          ]
                                        : controller.filteddata,
                                    controller,
                                    context),
                                columns: [
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      '     Enquiry #',
                                      fontWeight: 600,
                                    ),
                                    onSort: (columnIndex, ascending) {},
                                  ),
                                  DataColumn(
                                      label: MyText.bodyMedium(
                                    'Enquiry Date',
                                    fontWeight: 600,
                                  )),
                                  DataColumn(
                                      label: MyText.bodyMedium(
                                    '  Store Name',
                                    fontWeight: 600,
                                  )),
                                  DataColumn(
                                      label: MyText.bodyMedium(
                                    'User Name',
                                    fontWeight: 600,
                                  )),
                                  DataColumn(
                                      label: MyText.bodyMedium(
                                    'Customer Name',
                                    fontWeight: 600,
                                  )),
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      'Customer Mobile',
                                      fontWeight: 600,
                                    ),
                                  ),
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      'Address',
                                      fontWeight: 600,
                                    ),
                                  ),
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      'Bill Area',
                                      fontWeight: 600,
                                    ),
                                  ),
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      'PinCode',
                                      fontWeight: 600,
                                    ),
                                  ),
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      'City',
                                      fontWeight: 600,
                                    ),
                                  ),
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      'State',
                                      fontWeight: 600,
                                    ),
                                  ),
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      'Status',
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
    sheet.getRangeByIndex(1, 1).setText("Enquiry ID");
    sheet.getRangeByIndex(1, 2).setText("Enq Date");
    sheet.getRangeByIndex(1, 3).setText("Store Name");
    sheet.getRangeByIndex(1, 4).setText("User Name");
    sheet.getRangeByIndex(1, 5).setText("Customer Name");

    sheet.getRangeByIndex(1, 6).setText("Customer Mobile");
    sheet.getRangeByIndex(1, 7).setText("Address");
    sheet.getRangeByIndex(1, 8).setText("Bill Area");
    sheet.getRangeByIndex(1, 9).setText("PinCode");
    sheet.getRangeByIndex(1, 10).setText("City ");
    sheet.getRangeByIndex(1, 11).setText("State");

    sheet.getRangeByIndex(1, 12).setText("Status");

    for (var i = 0; i < controller!.filteddata!.length; i++) {
      final item = controller!.filteddata![i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.enqID.toString());
      sheet.getRangeByIndex(i + 2, 2).setText(item.enqDate);
      sheet.getRangeByIndex(i + 2, 3).setText(item.storecode);
      sheet.getRangeByIndex(i + 2, 4).setText(item.assignedToUser);
      sheet.getRangeByIndex(i + 2, 5).setText(item.cardName);

      sheet.getRangeByIndex(i + 2, 6).setText(item.customermobile);
      sheet.getRangeByIndex(i + 2, 7).setText(item.addressLine1);
      sheet.getRangeByIndex(i + 2, 8).setText(item.area.toString());

      sheet.getRangeByIndex(i + 2, 9).setText(item.pincode.toString());
      sheet.getRangeByIndex(i + 2, 10).setText(item.city);
      sheet.getRangeByIndex(i + 2, 11).setText(item.state);
      sheet.getRangeByIndex(i + 2, 12).setText(item.status);
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

  // Widget buildVisitorByChannel() {
  //   return MyCard(
  //     width: double.infinity,
  //     shadow: MyShadow(elevation: .5, position: MyShadowPosition.bottom),
  //     borderRadiusAll: 8,
  //     paddingAll: 23,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         MyText.titleMedium("Visitors By Channel", fontWeight: 600),
  //         MySpacing.height(12),
  //         SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: DataTable(
  //               sortAscending: true,
  //               columnSpacing: 60,
  //               onSelectAll: (_) => {},
  //               headingRowColor:
  //                   WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
  //               dataRowMaxHeight: 60,
  //               showBottomBorder: true,
  //               clipBehavior: Clip.antiAliasWithSaveLayer,
  //               border: TableBorder.all(
  //                   borderRadius: BorderRadius.circular(8),
  //                   style: BorderStyle.solid,
  //                   width: .4,
  //                   color: Colors.grey),
  //               columns: [
  //                 DataColumn(
  //                     label: MyText.labelLarge(
  //                   'S.No',
  //                   color: contentTheme.primary,
  //                 )),
  //                 DataColumn(
  //                     label: MyText.labelLarge(
  //                   'Channel',
  //                   color: contentTheme.primary,
  //                 )),
  //                 DataColumn(
  //                     label: MyText.labelLarge(
  //                   'Session',
  //                   color: contentTheme.primary,
  //                 )),
  //                 DataColumn(
  //                     label: MyText.labelLarge(
  //                   'Bounce Rate',
  //                   color: contentTheme.primary,
  //                 )),
  //                 DataColumn(
  //                     label: MyText.labelLarge(
  //                   'Session Duration',
  //                   color: contentTheme.primary,
  //                 )),
  //                 DataColumn(
  //                     label: MyText.labelLarge(
  //                   'Target Reached',
  //                   color: contentTheme.primary,
  //                 )),
  //                 DataColumn(
  //                     label: MyText.labelLarge(
  //                   'Page Per Session',
  //                   color: contentTheme.primary,
  //                 )),
  //                 DataColumn(
  //                     label: MyText.labelLarge(
  //                   'Action',
  //                   color: contentTheme.primary,
  //                 )),
  //               ],
  //               rows: controller!.visitorByChannel
  //                   .mapIndexed((index, data) => DataRow(cells: [
  //                         DataCell(MyText.bodyMedium('${data.id}')),
  //                         DataCell(SizedBox(
  //                           width: 250,
  //                           child: MyText.labelLarge(
  //                             data.channel,
  //                             overflow: TextOverflow.ellipsis,
  //                             maxLines: 1,
  //                           ),
  //                         )),
  //                         DataCell(SizedBox(
  //                             width: 100,
  //                             child: MyText.bodySmall('${data.session}',
  //                                 fontWeight: 600))),
  //                         DataCell(SizedBox(
  //                           width: 100,
  //                           child: MyText.bodySmall('${data.bounceRate}%',
  //                               fontWeight: 600),
  //                         )),
  //                         DataCell(SizedBox(
  //                           width: 250,
  //                           child: MyText.bodySmall(
  //                               '${Utils.getDateTimeStringFromDateTime(data.sessionDuration)}',
  //                               fontWeight: 600),
  //                         )),
  //                         DataCell(
  //                           MyContainer(
  //                             borderRadiusAll: 4,
  //                             clipBehavior: Clip.antiAliasWithSaveLayer,
  //                             padding: MySpacing.xy(8, 8),
  //                             color: contentTheme.primary.withAlpha(32),
  //                             child: MyText.bodySmall(
  //                               '${data.targetReached}',
  //                               fontWeight: 600,
  //                               color: contentTheme.primary,
  //                             ),
  //                           ),
  //                         ),
  //                         DataCell(SizedBox(
  //                             width: 100,
  //                             child:
  //                                 MyText.bodyMedium('${data.pagePerSession}'))),
  //                         DataCell(SizedBox(
  //                           width: 130,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               MyContainer(
  //                                 onTap: () => {},
  //                                 padding: MySpacing.xy(8, 8),
  //                                 color: contentTheme.primary.withAlpha(36),
  //                                 child: Icon(
  //                                   LucideIcons.pencil,
  //                                   size: 14,
  //                                   color: contentTheme.primary,
  //                                 ),
  //                               ),
  //                               MyContainer(
  //                                 onTap: () => {},
  //                                 padding: MySpacing.xy(8, 8),
  //                                 color: contentTheme.success.withAlpha(36),
  //                                 child: Icon(
  //                                   LucideIcons.pencil,
  //                                   size: 14,
  //                                   color: contentTheme.success,
  //                                 ),
  //                               ),
  //                               MyContainer(
  //                                 onTap: () => controller!.removeData(index),
  //                                 padding: MySpacing.xy(8, 8),
  //                                 color: contentTheme.danger.withAlpha(36),
  //                                 child: Icon(
  //                                   LucideIcons.trash_2,
  //                                   size: 14,
  //                                   color: contentTheme.danger,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         )),
  //                       ]))
  //                   .toList()),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class MyData extends DataTableSource with UIMixin {
  List<GetEnquiryData>? data = [];
  EnquiryController cnt;
  BuildContext context;
  MyData(this.data, this.cnt, this.context);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data!.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    final double width = MediaQuery.of(context).size.width;
    Utils utils = Utils();
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
            // onTap: () {},
            Container(
          margin: EdgeInsets.only(left: 20),
          width: width * 0.08,
          child: MyText.bodySmall(
            data![index].enqID == 0 ? '' : '${data![index].enqID.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(SizedBox(
          width: width * 0.12,
          child: MyText.bodySmall(
            data![index].enqDate!.isNotEmpty
                ? utils.currentDateFormat(data![index].enqDate!)
                : '',
            textAlign: TextAlign.justify,
            // fontWeight: 600,
          ),
        )),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: width * 0.12,
            child: MyText.bodySmall(
              data![index].storecode.toString(),
            ))),
        DataCell(SizedBox(
            width: width * 0.12,
            child:
                MyText.bodySmall(data![index].assignedToUserName.toString()))),
        DataCell(SizedBox(
            width: width * 0.12,
            child: MyText.bodySmall(data![index].cardName!.toString()))),
        DataCell(SizedBox(
            width: width * 0.12,
            child: MyText.bodySmall(data![index].customermobile!.toString()))),
        DataCell(SizedBox(
            width: width * 0.12,
            child: MyText.bodySmall(data![index].addressLine1!.toString()))),
        DataCell(SizedBox(
            width: width * 0.12,
            child: MyText.bodySmall(data![index].area.toString()))),
        DataCell(SizedBox(
            width: width * 0.12,
            child: MyText.bodySmall(data![index].pincode == 0
                ? ''
                : data![index].pincode!.toString()))),
        DataCell(SizedBox(
            width: width * 0.12,
            child: MyText.bodySmall(data![index].city!.toString()))),
        DataCell(SizedBox(
            width: width * 0.12,
            child: MyText.bodySmall(data![index].state!.toString()))),
        DataCell(SizedBox(
            width: width * 0.12,
            child: data![index].slpStatusTab!.isEmpty
                ? Row(
                    children: [SizedBox()],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: data![index].slpStatusTab == 'Open'
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: MyText.bodySmall(
                            data![index].slpStatusTab!,
                            color: Colors.white,
                          )),
                    ],
                  ))),
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
      this.readOnly = false,
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
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
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
