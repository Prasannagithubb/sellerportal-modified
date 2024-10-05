import 'package:flowkit/controller/pages/setup/setup_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/inventory/itemMaster/itemmaster_api.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/view/pages/setups/widgets/setup_addcommonWidget.dart';
import 'package:flowkit/view/pages/setups/widgets/setup_listwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FollowUpStatusScreen extends StatefulWidget {
  const FollowUpStatusScreen({super.key});

  @override
  State<FollowUpStatusScreen> createState() => _FollowUpStatusScreenState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _FollowUpStatusScreenState extends State<FollowUpStatusScreen>
    with TickerProviderStateMixin, UIMixin {
  SetUpController? controller;
  var scrollingList = ScrollingList.none;

  @override
  void initState() {
    controller = Get.put(SetUpController());
    getmethod();
    super.initState();
  }

  getmethod() async {
    await Future.delayed(Duration(microseconds: 100));
    controller!.callApi('14');
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
                          MyText.titleMedium("Followup Status",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(
                                  name: 'followup status', active: true)
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
                                        controller.clearvalidator();
                                      });
                                      Get.dialog(Dialog(
                                        child: SetupAddCommonScreen(
                                          controller: controller,
                                          height: height,
                                          width: width / 2,
                                          title: 'Add Followup Status',
                                          mastertypeId: 14,
                                          type: 'Add',
                                        ),
                                      ));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          LucideIcons.plus,
                                          color: theme.primaryColor,
                                        ),
                                        MyText.bodySmall(
                                          ' Followup Status',
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
                                          LucideIcons.plus,
                                          color: theme.primaryColor,
                                        ),
                                        MyText.bodySmall(
                                          ' Excel',
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
                          // setupCommonList(width, controller),
                          MyWidget(
                            controller: controller,
                            height: height,
                            width: width,
                            filterCodeCallBack: (val) {
                              setState(() {
                                controller.filtercode(val);
                              });
                            },
                            filterDescriptionCallBack: (val) {
                              setState(() {
                                controller.filterDescription(val);
                              });
                            },
                            filterStatusCallBack: (val) {
                              setState(() {
                                controller.filterStatus(val);
                              });
                            },
                          )
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
}

class MyData extends DataTableSource with UIMixin {
  List<ItemMasterNewData> data = [];
  SetUpController cnt;

  MyData(
    this.data,
    this.cnt,
  );

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(SizedBox(
            width: 400,
            child:
                MyText.bodySmall('      ${data[index].Category.toString()}'))),
        DataCell(SizedBox(
            width: 500,
            child: MyText.bodySmall(data[index].Segment!.toString()))),
        DataCell(SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: data[index].status == '1'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: data[index].status == '1'
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
