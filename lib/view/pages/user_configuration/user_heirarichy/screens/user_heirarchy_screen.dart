import 'dart:convert';
import 'package:flowkit/controller/pages/user_configuration/userlist_controller.dart';
import 'package:flowkit/helpers/services/url_service.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/getallUsetr_byid_api.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/view/pages/user_configuration/user_heirarichy/widgets/hirarchy_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart';

class UserHeirarchy extends StatefulWidget {
  const UserHeirarchy({super.key});

  @override
  State<UserHeirarchy> createState() => _UserHeirarchyState();
}

class _UserHeirarchyState extends State<UserHeirarchy>
    with TickerProviderStateMixin, UIMixin {
  UserListController? controller;
  @override
  void initState() {
    controller = UserListController(this);
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
                          MyText.titleMedium("User Hierarichy",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(
                                  name: 'userHeirarchy', active: true)
                            ],
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(flexSpacing),
                    Padding(
                        padding: MySpacing.x(flexSpacing),
                        child: MyFlex(children: [
                          _leftbody(height, width),
                          _rightbody(height, width),
                        ])),
                  ],
                );
        },
      ),
    );
  }

  MyFlexItem _rightbody(double height, double width) {
    return MyFlexItem(
        sizes: 'lg-6 md-6 sm-6 xs-6',
        child: Container(
          padding: EdgeInsets.all(10),
          // height: height / 2,
          // width: width * 0.2,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey[200]!)],
              borderRadius: BorderRadius.circular(5)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            CommonValidationForm(
              controller: null,
              outlineInputBorder: outlineInputBorder,
              icon: LucideIcons.search,
              iconOnPressed: () {},
            ),
            SizedBox(
              height: height * 0.01,
            ),
            MenuItem(
              title: '732 - ADAM KHAN S',
              // route: '',
              isCondensed: true,
            ),
            SizedBox(
              width: width,
              child: DropdownMenuWidget(
                iconData: LucideIcons.dot,
                isCondensed: false,
                title: "1786 - NETHAJI-AV-HA",
                children: [
                  MenuItem(
                    title: '1792 - NIVETHA SA',
                    iconData: LucideIcons.dot,
                    isCondensed: false,
                    childrenDropdownMenuWidget: [
                      MenuItem(
                          title: '1492 - TAMILSELVAN',
                          // route: '/auth/register_account',
                          isCondensed: false,
                          childrenDropdownMenuWidget: [
                            MenuItem(
                              title: '632 - PRAVEEN B',

                              // route: '',
                              isCondensed: true,
                            ),
                            MenuItem(
                              title: '682 - VELMURUGAN',

                              // route: '',
                              isCondensed: true,
                            ),
                          ]),
                    ],
                  ),
                ],
              ),
            ),
          ]),

          // ],
        ));
  }

  MyFlexItem _leftbody(double height, double width) {
    return MyFlexItem(
        sizes: 'lg-6 md-6 sm-6 xs-6',
        child: Container(
          padding: EdgeInsets.all(10),
          // height: height / 2,
          // width: width * 0.2,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey[200]!)],
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyFlex(children: [
                MyFlexItem(
                    sizes: 'lg-6 md-6 sm-6 xs-6',
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium("User", fontWeight: 600),
                          MySpacing.height(12),
                          DropdownButtonFormField(
                              isExpanded: true,
                              focusColor: Colors.grey[100],
                              items: <DropdownMenuItem>[
                                DropdownMenuItem(
                                  child: Text('dataww'),
                                ),
                              ],
                              onChanged: (val) {},
                              dropdownColor: Colors.white,
                              value: null,
                              decoration: InputDecoration(
                                hintText: 'Select User..',
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: MyTextStyle.bodyMedium(xMuted: true),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      strokeAlign: 0,
                                      color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      strokeAlign: 0,
                                      color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      strokeAlign: 0,
                                      color: Colors.grey[400]!),
                                ),
                                contentPadding: MySpacing.all(16),
                                // prefixIcon: Icon(icon, size: 20),
                                // isCollapsed: true,
                              )),
                        ],
                      ),
                    )),
                MyFlexItem(
                    sizes: 'lg-6 md-6 sm-6 xs-6',
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium("Reporting", fontWeight: 600),
                          MySpacing.height(12),
                          DropdownButtonFormField(
                              isExpanded: true,
                              focusColor: Colors.grey[100],
                              items: <DropdownMenuItem>[
                                DropdownMenuItem(
                                  child: Text('dataww'),
                                ),
                              ],
                              onChanged: (val) {},
                              // itemHeight: height * 0.06,
                              dropdownColor: Colors.white,
                              value: null,
                              decoration: InputDecoration(
                                hintText: 'Select User..',
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: MyTextStyle.bodyMedium(xMuted: true),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      strokeAlign: 0,
                                      color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      strokeAlign: 0,
                                      color: Colors.grey[400]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      strokeAlign: 0,
                                      color: Colors.grey[400]!),
                                ),
                                contentPadding: MySpacing.all(16),
                                // prefixIcon: Icon(icon, size: 20),
                                // isCollapsed: true,
                              )),
                        ],
                      ),
                    )),
              ]),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(right: 11),
                width: width * 0.09,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.user_round_plus,
                          color: theme.primaryColor,
                          size: 14,
                        ),
                        MyText.bodySmall(
                          '   Update',
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
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
    sheet.getRangeByIndex(1, 1).setText("Store");
    sheet.getRangeByIndex(1, 2).setText("User Code");
    sheet.getRangeByIndex(1, 3).setText("User Name");
    sheet.getRangeByIndex(1, 4).setText("Mobile");
    sheet.getRangeByIndex(1, 5).setText("Email");
    sheet.getRangeByIndex(1, 6).setText("Profile Url");
    sheet.getRangeByIndex(1, 6).setText("Status");

    for (var i = 0; i < controller!.filterUserData!.length; i++) {
      final item = controller!.filterUserData![i];
      sheet.getRangeByIndex(i + 2, 1).setText(item.userBranch);
      sheet.getRangeByIndex(i + 2, 2).setText(item.usercode);
      sheet.getRangeByIndex(i + 2, 3).setText(item.username);
      sheet.getRangeByIndex(i + 2, 4).setText(item.mobile);
      sheet.getRangeByIndex(i + 2, 5).setText(item.email);
      sheet.getRangeByIndex(i + 2, 5).setText(item.profileUrl);
      sheet
          .getRangeByIndex(i + 2, 5)
          .setText(item.status == 1 ? 'Active' : 'In Active');

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
}

class MyData extends DataTableSource with UIMixin {
  List<AllUserData> data = [];
  UserListController cnt;

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
        DataCell(
            // onTap: () {},
            Container(
          margin: EdgeInsets.only(left: 10),
          width: 140,
          child: MyText.bodySmall(
            '  ${data[index].userBranch.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(SizedBox(
          width: 140,
          child: MyText.bodySmall(
            '${data[index].usercode!}',
            textAlign: TextAlign.justify,
            // fontWeight: 600,
          ),
        )),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: 140,
            child: MyText.bodySmall(
              data[index].username.toString(),
            ))),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: 150,
            child: MyText.bodySmall(
              data[index].mobile.toString(),
            ))),
        DataCell(SizedBox(
            width: 200, child: MyText.bodySmall(data[index].email.toString()))),
        DataCell(Container(
            width: 140,
            child: GestureDetector(
                onTap: data[index].profileUrl!.isEmpty
                    ? null
                    : () {
                        UrlService.goToUrl('${data[index].profileUrl}');
                      },
                child: data[index].profileUrl!.isEmpty
                    ? Text('')
                    : MyText.bodySmall(
                        'Show',
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      )))),
        DataCell(SizedBox(
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color:
                            data[index].status == 1 ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: data[index].status == 1
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
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.pencil,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
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
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.log_out,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.lock,
                    size: 12,
                    color: contentTheme.primary,
                  ),
                ),
                MyContainer.bordered(
                  onTap: () => {},
                  padding: MySpacing.xy(6, 6),
                  borderColor: contentTheme.primary.withAlpha(40),
                  child: Icon(
                    LucideIcons.key,
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
