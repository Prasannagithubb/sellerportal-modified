import 'package:flowkit/controller/pages/setup/feeds_controller.dart';
import 'package:flowkit/helpers/services/url_service.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/setups/feeds_api.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/view/pages/setups/feeds/widgets/new_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _FeedsScreenState extends State<FeedsScreen>
    with TickerProviderStateMixin, UIMixin {
  FeedsController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;

  @override
  void initState() {
    controller = FeedsController();
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
          return controller.isLoad!
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
                          MyText.titleMedium("Feeds",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(name: 'feeds', active: true)
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
                                            child: NewFeed(
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
                                          ' New Feed',
                                          color: Colors.black,
                                        )
                                      ],
                                    )),
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
                                SizedBox(
                                  width: width * 0.015,
                                ),
                                // Change 5 to the number of your columns
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
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.28, // Adjust width as necessary
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
                                        0.1, // Adjust width as necessary
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
                                        0.08, // Adjust width as necessary
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: ' ',
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.08, // Adjust width as necessary
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: ' ',
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.08, // Adjust width as necessary
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: ' ',
                                      ),
                                      onChanged: (value) {},
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
                                        // Handle search functionality here
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
                                        // Handle search functionality here
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.05, // Adjust width as necessary
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
                              source: MyData(
                                  controller.filterFeedsData == null
                                      ? []
                                      : controller.filterFeedsData!,
                                  controller,
                                  context),
                              columns: [
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    '     Title',
                                    fontWeight: 600,
                                  ),
                                  onSort: (columnIndex, ascending) {},
                                ),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Description',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Media Type',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Media 1',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Media 2',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Media 3',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Valid Til',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Status',
                                  fontWeight: 600,
                                )),
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

  // Widget buildAccountMenu() {
  //   return MyContainer(
  //     borderRadiusAll: 8,
  //     width: 150,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         MyButton(
  //           onPressed: () => {_createExcel('xlsx')},
  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           borderRadiusAll: AppStyle.buttonRadius.medium,
  //           padding: MySpacing.xy(8, 4),
  //           splashColor: colorScheme.onSurface.withAlpha(20),
  //           backgroundColor: Colors.transparent,
  //           child: Row(
  //             children: [
  //               Image.asset(
  //                 'assets/images/brand/xlsx.png',
  //                 scale: 20,
  //               ),
  //               MySpacing.width(8),
  //               MyText.labelMedium(
  //                 "XLSX",
  //                 fontWeight: 600,
  //               )
  //             ],
  //           ),
  //         ),
  //         MySpacing.height(8),
  //         MyButton(
  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           onPressed: () => {_createExcel('xls')},
  //           borderRadiusAll: AppStyle.buttonRadius.medium,
  //           padding: MySpacing.xy(8, 4),
  //           splashColor: colorScheme.onSurface.withAlpha(20),
  //           backgroundColor: Colors.transparent,
  //           child: Row(
  //             children: [
  //               Image.asset(
  //                 'assets/images/brand/xls.png',
  //                 scale: 20,
  //               ),
  //               MySpacing.width(8),
  //               MyText.labelMedium("XLS", fontWeight: 600)
  //             ],
  //           ),
  //         ),
  //         MySpacing.height(8),
  //         MyButton(
  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           onPressed: () {
  //             // languageHideFn?.call();
  //             // Get.offAll(LoginScreen());
  //           },
  //           borderRadiusAll: AppStyle.buttonRadius.medium,
  //           padding: MySpacing.xy(8, 4),
  //           splashColor: contentTheme.danger.withAlpha(28),
  //           backgroundColor: Colors.transparent,
  //           child: Row(
  //             children: [
  //               Image.asset(
  //                 'assets/images/brand/docx.png',
  //                 scale: 20,
  //               ),
  //               MySpacing.width(8),
  //               MyText.labelMedium("DOCX",
  //                   fontWeight: 600, color: contentTheme.danger)
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Future<void> _createExcel(String exceltype) async {
  //   //Create a Excel document.
  //   //Creating a workbook
  //   final xls.Workbook workbook = xls.Workbook();
  //   //Accessing via index.
  //   final xls.Worksheet sheet = workbook.worksheets[0];
  //   sheet.getRangeByIndex(1, 1).setText("Item Code");
  //   sheet.getRangeByIndex(1, 2).setText("Item Name");
  //   sheet.getRangeByIndex(1, 3).setText("Brand");
  //   sheet.getRangeByIndex(1, 4).setText("Category");
  //   sheet.getRangeByIndex(1, 5).setText("SubCategory");
  //   sheet.getRangeByIndex(1, 6).setText("Status");

  //   for (var i = 0; i < controller!.filterItemdata!.length; i++) {
  //     final item = controller!.filterItemdata![i];
  //     sheet.getRangeByIndex(i + 2, 1).setText(item.itemcode);
  //     sheet.getRangeByIndex(i + 2, 2).setText(item.itemName);
  //     sheet.getRangeByIndex(i + 2, 3).setText(item.Brand);
  //     sheet.getRangeByIndex(i + 2, 4).setText(item.Category);
  //     sheet.getRangeByIndex(i + 2, 5).setText(item.Segment);
  //     sheet
  //         .getRangeByIndex(i + 2, 6)
  //         .setText(item.status == '1' ? 'Active' : 'Inactive');
  //   }

  //   final List<int> bytes = workbook.saveAsStream();
  //   //Dispose the document.
  //   AnchorElement(
  //       href:
  //           "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
  //     ..setAttribute("download", "output.$exceltype")
  //     ..click();
  //   workbook.dispose();
  // }

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
  List<FeedsGetApiData> data = [];
  FeedsController cnt;
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
    Utils config = Utils();
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
            // onTap: () {},
            Container(
          margin: EdgeInsets.only(left: 20),
          width: width * 0.1,
          child: MyText.bodySmall(
            '${data[index].leadcheckdata2!.title.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            Container(
          // margin: EdgeInsets.only(left: 20),
          width: width * 0.3,
          child: MyText.bodySmall(
            '${data[index].leadcheckdata2!.description.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            Container(
          // margin: EdgeInsets.only(left: 20),
          width: width * 0.1,
          child: MyText.bodySmall(
            '${data[index].leadcheckdata2!.mediaType.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            Container(
                // margin: EdgeInsets.only(left: 20),
                width: width * 0.08,
                child: GestureDetector(
                    onTap: data[index].leadcheckdata2!.mediaURL1.isEmpty
                        ? null
                        : () {
                            UrlService.goToUrl(
                                '${data[index].leadcheckdata2!.mediaURL1}');
                          },
                    child: data[index].leadcheckdata2!.mediaURL1.isEmpty
                        ? Text('')
                        : MyText.bodySmall(
                            'Show',
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          )))),
        DataCell(SizedBox(
            width: width * 0.08,
            child: GestureDetector(
                onTap: data[index].leadcheckdata2!.mediaURL2.isEmpty
                    ? null
                    : () {
                        UrlService.goToUrl(
                            '${data[index].leadcheckdata2!.mediaURL2}');
                      },
                child: data[index].leadcheckdata2!.mediaURL2.isEmpty
                    ? Text('')
                    : MyText.bodySmall(
                        'Show',
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      )))),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: width * 0.08,
            child: GestureDetector(
                onTap: data[index].leadcheckdata2!.mediaURL3.isEmpty
                    ? null
                    : () {
                        UrlService.goToUrl(
                            '${data[index].leadcheckdata2!.mediaURL3}');
                      },
                child: data[index].leadcheckdata2!.mediaURL3.isEmpty
                    ? Text('')
                    : MyText.bodySmall(
                        'Show',
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      )))),
        DataCell(SizedBox(
            width: width * 0.1,
            child: MyText.bodySmall(config.currentDateFormat(
                data[index].leadcheckdata2!.validTill!.toString())))),
        DataCell(SizedBox(
            width: width * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: data[index].leadcheckdata2!.status == 1
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: data[index].leadcheckdata2!.status == 1
                        ? MyText.bodySmall(
                            'Active',
                            color: Colors.white,
                          )
                        : MyText.bodySmall(
                            'Inactive',
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
