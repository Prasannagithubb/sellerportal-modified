import 'dart:convert';
import 'package:flowkit/controller/pages/user_configuration/userlist_controller.dart';
import 'package:flowkit/helpers/services/url_service.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/getallUsetr_byid_api.dart';
import 'package:flowkit/services/pages/setups/setupCommon_getapi.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/view/pages/user_configuration/user_list.dart/widgets/new_user.dart';
import 'package:flowkit/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xls;
import 'package:universal_html/html.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _UserListScreenState extends State<UserListScreen>
    with TickerProviderStateMixin, UIMixin {
  UserListController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;

  @override
  void initState() {
    controller = UserListController(this);
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
                          MyText.titleMedium("User List",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(name: 'userlist', active: true)
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      controller.filterStatusBtn('Active');
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        LucideIcons.shield_check,
                                        color: theme.primaryColor,
                                        size: 20,
                                      ),
                                      MyText.bodySmall(
                                        ' Active',
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
                                    controller.filterStatusBtn('In Active');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        LucideIcons.shield_x,
                                        color: theme.primaryColor,
                                        size: 20,
                                      ),
                                      MyText.bodySmall(
                                        ' In Active',
                                        color: Colors.black,
                                      )
                                    ],
                                  )),
                              MySpacing.width(width * 0.005),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      controller.callRestrictionApi();
                                    });
                                    List<SetupsCommonData>? usertypelist =
                                        (await controller.callApi('1'))!;
                                    List<SetupsCommonData>? designationlist =
                                        (await controller.callApi('23'))!;

                                    Get.dialog(
                                      barrierDismissible: false,
                                      Dialog(
                                          clipBehavior: Clip.none,
                                          // insetPadding: EdgeInsets.all(50),
                                          child: NewUserAdd(
                                            outlineInputBorder:
                                                outlineInputBorder,
                                            colorScheme: colorScheme,
                                            focusedInputBorder:
                                                focusedInputBorder,
                                            contentTheme: contentTheme,
                                            controller: controller,
                                            heigth: height,
                                            width: width / 2,
                                            usertypelist: usertypelist,
                                            designationlist: designationlist,
                                          )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      controller.isloadDropdown
                                          ? Center(
                                              child: SizedBox(
                                                width: width * 0.003,
                                                height: height * 0.008,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: theme.primaryColor,
                                                  strokeWidth: 1,
                                                ),
                                              ),
                                            )
                                          : Icon(
                                              LucideIcons.user_plus,
                                              color: theme.primaryColor,
                                              size: 20,
                                            ),
                                      MyText.bodySmall(
                                        ' New User',
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
                                  width: width * 0.01,
                                ),
                                // Change 5 to the number of your columns
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width * 0.08,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        controller.filterStore(
                                            value, controller);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width * 0.1,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        controller.filterUserCode(
                                            value, controller);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width * 0.1,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        controller.filterUserName(
                                            value, controller);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width * 0.1,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        controller.filterMobile(
                                            value, controller);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width * 0.1,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        controller.filterEmail(
                                            value, controller);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.09, // Adjust width as necessary
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.09, // Adjust width as necessary
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
                                        0.1, // Adjust width as necessary
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
                              // header: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     SizedBox(
                              //         width: width * 0.09,
                              //         child: CommonValidationForm(
                              //           controller: null,
                              //           hintText: '',
                              //           outlineInputBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(5)),
                              //             borderSide: BorderSide(
                              //                 width: 1,
                              //                 strokeAlign: 0,
                              //                 color: colorScheme.onSurface
                              //                     .withAlpha(80)),
                              //           ),
                              //           onChanged: (aval) async {
                              //             setState(() {
                              //               controller.filterStore(
                              //                   aval, controller);
                              //             });
                              //           },
                              //         )),
                              //     // SizedBox(width: width*0.003,),
                              //     SizedBox(
                              //         width: width * 0.09,
                              //         child: CommonValidationForm(
                              //           controller: null,
                              //           outlineInputBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(5)),
                              //             borderSide: BorderSide(
                              //                 width: 1,
                              //                 strokeAlign: 0,
                              //                 color: colorScheme.onSurface
                              //                     .withAlpha(80)),
                              //           ),
                              //           onChanged: (aval) async {
                              //             setState(() {
                              //               controller.filterUserCode(
                              //                   aval, controller);
                              //             });
                              //           },
                              //         )),
                              //     SizedBox(
                              //         width: width * 0.1,
                              //         child: CommonValidationForm(
                              //           controller: null,
                              //           outlineInputBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(5)),
                              //             borderSide: BorderSide(
                              //                 width: 1,
                              //                 strokeAlign: 0,
                              //                 color: colorScheme.onSurface
                              //                     .withAlpha(80)),
                              //           ),
                              //           onChanged: (aval) async {
                              //             setState(() {
                              //               controller.filterUserName(
                              //                   aval, controller);
                              //             });
                              //           },
                              //         )),
                              //     SizedBox(
                              //         width: width * 0.09,
                              //         child: CommonValidationForm(
                              //           controller: null,
                              //           outlineInputBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(5)),
                              //             borderSide: BorderSide(
                              //                 width: 1,
                              //                 strokeAlign: 0,
                              //                 color: colorScheme.onSurface
                              //                     .withAlpha(80)),
                              //           ),
                              //           onChanged: (aval) async {
                              //             setState(() {
                              //               controller.filterMobile(
                              //                   aval, controller);
                              //             });
                              //           },
                              //         )),
                              //     SizedBox(
                              //         width: width * 0.12,
                              //         child: CommonValidationForm(
                              //           controller: null,
                              //           outlineInputBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(5)),
                              //             borderSide: BorderSide(
                              //                 width: 1,
                              //                 strokeAlign: 0,
                              //                 color: colorScheme.onSurface
                              //                     .withAlpha(80)),
                              //           ),
                              //           onChanged: (aval) async {
                              //             setState(() {
                              //               controller.filterEmail(
                              //                   aval, controller);
                              //             });
                              //           },
                              //         )),
                              //     SizedBox(
                              //         width: width * 0.09,
                              //         child: CommonValidationForm(
                              //           controller: null,
                              //           outlineInputBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(5)),
                              //             borderSide: BorderSide(
                              //                 width: 1,
                              //                 strokeAlign: 0,
                              //                 color: colorScheme.onSurface
                              //                     .withAlpha(80)),
                              //           ),
                              //           onChanged: (aval) async {},
                              //         )),
                              //     SizedBox(
                              //         width: width * 0.09,
                              //         child: CommonValidationForm(
                              //           controller: null,
                              //           outlineInputBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(5)),
                              //             borderSide: BorderSide(
                              //                 width: 1,
                              //                 strokeAlign: 0,
                              //                 color: colorScheme.onSurface
                              //                     .withAlpha(80)),
                              //           ),
                              //           onChanged: (aval) async {
                              //             // controller.filterStatus(
                              //             //     aval, controller);
                              //           },
                              //         )),
                              //     SizedBox(
                              //         width: width * 0.1,
                              //         child: CommonValidationForm(
                              //           controller: null,
                              //           outlineInputBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(5)),
                              //             borderSide: BorderSide(
                              //                 width: 1,
                              //                 strokeAlign: 0,
                              //                 color: colorScheme.onSurface
                              //                     .withAlpha(80)),
                              //           ),
                              //           onChanged: (aval) async {
                              //             // controller.filterItemName(
                              //             //     aval, controller);
                              //           },
                              //         )),
                              //   ],
                              // ),
                              // arrowHeadColor: Colors.black  ,
                              source: MyData(
                                  controller.filterUserData!.isEmpty
                                      ? [
                                          AllUserData(
                                              id: 0,
                                              tenetid: '',
                                              userTypeId: 0,
                                              usercode: '',
                                              username: '',
                                              password: '',
                                              deviceCode: '',
                                              fcmToken: '',
                                              storeId: 0,
                                              currentLicenseKey: '',
                                              profileUrl: '',
                                              licenseActivatedOn: '',
                                              licenseValidTill: '',
                                              mobile: '',
                                              email: '',
                                              createdBy: 0,
                                              createdOn: '',
                                              updatedBy: 0,
                                              updatedOn: '',
                                              status: -1,
                                              isMobileUser: false,
                                              isPortalUser: false,
                                              reportingTo: '',
                                              slpCode: '',
                                              userBranch: '',
                                              restrictionType: 0),
                                        ]
                                      : controller.filterUserData!,
                                  controller,
                                  context),
                              columns: [
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    '     Store',
                                    fontWeight: 600,
                                  ),
                                  onSort: (columnIndex, ascending) {},
                                ),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'User Code',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  '  User Name',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  '  Mobile No',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Email',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Profile',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    'Status',
                                    // textAlign: TextAlign.center,
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
    final width = MediaQuery.of(context).size.width;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
            // onTap: () {},
            Container(
          margin: EdgeInsets.only(left: 10),
          width: width * 0.08,
          child: MyText.bodySmall(
            '  ${data[index].userBranch.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(SizedBox(
          width: width * 0.11,
          child: MyText.bodySmall(
            '${data[index].usercode!}',
            textAlign: TextAlign.justify,
            // fontWeight: 600,
          ),
        )),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: width * 0.11,
            child: MyText.bodySmall(
              data[index].username.toString(),
            ))),
        DataCell(Container(
            padding: EdgeInsets.all(10),
            width: width * 0.11,
            child: MyText.bodySmall(
              data[index].mobile.toString(),
            ))),
        DataCell(SizedBox(
            width: width * 0.11,
            child: MyText.bodySmall(data[index].email.toString()))),
        DataCell(SizedBox(
            width: width * 0.08,
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
            width: width * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: data[index].status == 1
                            ? Colors.green
                            : data[index].status == 0
                                ? Colors.red
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    child: data[index].status == 1
                        ? MyText.bodySmall(
                            'Active',
                            color: Colors.white,
                          )
                        : data[index].status == 0
                            ? MyText.bodySmall(
                                'Inactive',
                                color: Colors.white,
                              )
                            : MyText('')),
              ],
            ))),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: data[index].status == -1
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
                      MySpacing.width(12),

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
                      MySpacing.width(12),

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
                      MySpacing.width(12),

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
