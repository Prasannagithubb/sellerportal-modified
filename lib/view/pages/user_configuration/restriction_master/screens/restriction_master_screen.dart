import 'package:flowkit/controller/pages/user_configuration/restriction_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/user_configuration/getRestriction.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/view/pages/user_configuration/restriction_master/widgets/addandUpdate_restriction.dart';
import 'package:flowkit/view/pages/user_configuration/restriction_master/widgets/deleteAlertbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class RestrictionMaster extends StatefulWidget {
  const RestrictionMaster({super.key});

  @override
  State<RestrictionMaster> createState() => _RestrictionMasterState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _RestrictionMasterState extends State<RestrictionMaster>
    with TickerProviderStateMixin, UIMixin {
  RestrictionController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;

  @override
  void initState() {
    controller = RestrictionController();
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
                          MyText.titleMedium("Restriction Master",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(
                                  name: 'restriction master', active: true)
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
                                        controller.clearData();
                                      });
                                      Get.dialog(
                                        barrierDismissible: false,
                                        Dialog(
                                            clipBehavior: Clip.none,
                                            // insetPadding: EdgeInsets.all(50),
                                            child: AddUpdateRestrictionBox(
                                              controller: controller,
                                              height: height,
                                              width: width / 2,
                                              title: 'Add Restriction',
                                              mastertypeId: 0,
                                              type: 'Add',
                                            )),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          LucideIcons.plus,
                                          color: theme.primaryColor,
                                        ),
                                        MyText.bodySmall(
                                          ' New Restriction',
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
                                // SizedBox(width: width*0.015,),
                                // Change 5 to the number of your columns
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.13, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filtercode(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.45, // Adjust width as necessary
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: ' ',
                                        // suffixIcon: Icon(
                                        //   LucideIcons.filter,
                                        //   color: Colors.grey[300],
                                        // )
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.13, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterremarks(value);
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
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: ' ',
                                      ),
                                      onChanged: (value) {},
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
                              source: MyData(
                                  controller.filterRestrictionData!.isEmpty
                                      ? [
                                          RestrictionData(
                                              id: 0,
                                              code: '',
                                              restrictionType: 0,
                                              restrictionData: '',
                                              remarks: '')
                                        ]
                                      : controller.filterRestrictionData!,
                                  controller,
                                  context),
                              columns: [
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    '     Code',
                                    fontWeight: 600,
                                  ),
                                  onSort: (columnIndex, ascending) {},
                                ),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Restriction Type',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  '  Remarks',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Action',
                                  fontWeight: 600,
                                )),
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
    // final xls.Workbook workbook = xls.Workbook();
    // //Accessing via index.
    // final xls.Worksheet sheet = workbook.worksheets[0];
    // sheet.getRangeByIndex(1, 1).setText("Item Code");
    // sheet.getRangeByIndex(1, 2).setText("Item Name");
    // sheet.getRangeByIndex(1, 3).setText("Brand");
    // sheet.getRangeByIndex(1, 4).setText("Category");
    // sheet.getRangeByIndex(1, 5).setText("SubCategory");
    // sheet.getRangeByIndex(1, 6).setText("Status");

    // for (var i = 0; i < controller!.filterRestrictionData!.length; i++) {
    //   final item = controller!.filterItemdata![i];
    //   sheet.getRangeByIndex(i + 2, 1).setText(item.itemcode);
    //   sheet.getRangeByIndex(i + 2, 2).setText(item.itemName);
    //   sheet.getRangeByIndex(i + 2, 3).setText(item.Brand);
    //   sheet.getRangeByIndex(i + 2, 4).setText(item.Category);
    //   sheet.getRangeByIndex(i + 2, 5).setText(item.Segment);
    //   sheet
    //       .getRangeByIndex(i + 2, 6)
    //       .setText(item.status == '1' ? 'Active' : 'Inactive');
    // }

    // final List<int> bytes = workbook.saveAsStream();
    // //Dispose the document.
    // AnchorElement(
    //     href:
    //         "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    //   ..setAttribute("download", "output.$exceltype")
    //   ..click();
    // workbook.dispose();
  }
}

class MyData extends DataTableSource with UIMixin {
  List<RestrictionData>? data = [];
  RestrictionController cnt;
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
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(SizedBox(
            width: width * 0.15,
            child: MyText.bodySmall('      ${data![index].code.toString()}'))),
        DataCell(SizedBox(
            width: width * 0.45,
            child: (data![index].restrictionType! == 1)
                ? MyText.bodySmall("IP")
                : data![index].restrictionType! == 3
                    ? MyText.bodySmall("SS Id")
                    : MyText.bodySmall("Location"))),
        DataCell(SizedBox(
            width: width * 0.15,
            child: MyText.bodySmall('${data![index].remarks.toString()}'))),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: data![index].code! == ""
                ? Row(
                    children: [
                      SizedBox(
                        width: 50,
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyContainer.bordered(
                        onTap: () => {
                          Get.dialog(
                            barrierDismissible: false,
                            Dialog(
                                clipBehavior: Clip.none,
                                // insetPadding: EdgeInsets.all(50),
                                child: AddUpdateRestrictionBox(
                                  controller: cnt,
                                  height: MediaQuery.of(context).size.height,
                                  width: width / 2,
                                  title: 'Update Restriction',
                                  mastertypeId: 0,
                                  type: 'Update',
                                  data: data![index],
                                )),
                          )
                        },
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
                        onTap: () => {
                          Get.dialog(DeleteAlertBoxRestrictionMaster(
                              controller: cnt, deletId: data![index].id!))
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
