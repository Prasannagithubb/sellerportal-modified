import 'dart:convert';
import 'package:flowkit/controller/pages/inventory/itemmaster_controller.dart';
import 'package:flowkit/controller/pages/user_configuration/absense_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_list_extension.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/inventory/itemMaster/itemmaster_api.dart';
import 'package:flowkit/services/pages/user_configuration/getAbsenceList_api.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart';

class AbsenseList extends StatefulWidget {
  const AbsenseList({super.key});

  @override
  State<AbsenseList> createState() => _AbsenseListState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _AbsenseListState extends State<AbsenseList>
    with TickerProviderStateMixin, UIMixin {
  AbsenseController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;
  @override
  void initState() {
    controller = AbsenseController();
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
    // final bool minimizescreen = MediaQuery.of(context).size.width < 1000;
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
                          MyText.titleMedium("Absense List",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(
                                  name: 'absense list', active: true)
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
                                SizedBox(
                                  width: width * 0.35,
                                  child: MyFlex(children: [
                                    MyFlexItem(
                                        sizes: 'lg-6 md-6 sm-6 xs-6',
                                        child: CommonValidationForm(
                                          controller: controller.basicValidator
                                              .getController('date'),
                                          validator: controller.basicValidator
                                              .getValidation('date'),
                                          readOnly: true,
                                          hintText: '  Absence Date',
                                          icon: LucideIcons.calendar,
                                          iconOnPressed: () async {
                                            DateTime? data =
                                                await showDatePicker(
                                                    context: context,
                                                    firstDate: DateTime(1990),
                                                    lastDate: DateTime.now());
                                            print(data.toString());

                                            setState(() {
                                              controller.basicValidator
                                                      .getController('date')!
                                                      .text =
                                                  "${data!.year.toString()}-${data.month.toString()}-${data.day.toString()}";
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
                                        child: Container(
                                          padding: EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(1),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
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
                                              ),
                                            ],
                                          ),
                                        ))
                                  ]),
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
                                      width: width /
                                          2.1, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (value) {
                                          setState(() {
                                            controller.filterUserCode(value);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width /
                                          2.3, // Adjust width as necessary
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText: ' ',
                                            suffixIcon: Icon(
                                              LucideIcons.filter,
                                              color: Colors.grey[300],
                                            )),
                                        onChanged: (value) {
                                          setState(() {
                                            controller.filterUserNAme(value);
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
                                    controller.filtergetabsenseData!.isEmpty
                                        ? [
                                            GetAbsenseData(
                                                userCode: '', userName: '')
                                          ]
                                        : controller.filtergetabsenseData,
                                    controller,
                                    context),
                                columns: [
                                  DataColumn(
                                    label: MyText.bodyMedium(
                                      '     User Code',
                                      fontWeight: 600,
                                    ),
                                    onSort: (columnIndex, ascending) {},
                                  ),
                                  DataColumn(
                                      label: MyText.bodyMedium(
                                    'Department',
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
    sheet.getRangeByIndex(1, 1).setText("User Code");
    sheet.getRangeByIndex(1, 2).setText("User Name");

    for (var i = 0; i < controller!.filtergetabsenseData!.length; i++) {
      final item = controller!.filtergetabsenseData![i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.userCode);
      sheet.getRangeByIndex(i + 2, 2).setText(item.userName);
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
  List<GetAbsenseData>? data = [];
  AbsenseController cnt;
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
        DataCell(
            // onTap: () {},
            Container(
          margin: EdgeInsets.only(left: 20),
          width: width * 0.5,
          child: MyText.bodySmall(
            '${data![index].userCode.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(SizedBox(
          width: width * 0.5,
          child: MyText.bodySmall(
            '${data![index].userName!}',
            textAlign: TextAlign.justify,
            // fontWeight: 600,
          ),
        )),
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
