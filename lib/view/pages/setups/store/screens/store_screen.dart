import 'package:flowkit/controller/pages/setup/store_controller.dart';
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
import 'package:flowkit/services/pages/setups/getall_store_api.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flowkit/view/pages/setups/store/widgets/deleted_alertbox.dart';
import 'package:flowkit/view/pages/setups/store/widgets/new_store.dart';
import 'package:flowkit/view/pages/setups/widgets/setup_delete_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

enum ScrollingList {
  none,
  left,
  right,
}

class _StoreScreenState extends State<StoreScreen>
    with TickerProviderStateMixin, UIMixin {
  StoreController? controller;
  late final ScrollController _controllerTop;
  late final ScrollController _controllerbottom;
  var scrollingList = ScrollingList.none;

  @override
  void initState() {
    controller = StoreController();
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
                          MyText.titleMedium("Store",
                              fontSize: 18, fontWeight: 600),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: 'sellerkit'),
                              MyBreadcrumbItem(name: 'store', active: true)
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
                                            child: NewStore(
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
                                          ' New Store',
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
                                // SizedBox(
                                //   width: width * 0.015,
                                // ),
                                // Change 5 to the number of your columns
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.112, // Adjust width as necessary
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
                                        0.112, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterStoreName(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.112, // Adjust width as necessary
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterAddress1(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.112, // Adjust width as necessary
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterpincode(value);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width *
                                        0.112, // Adjust width as necessary
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          labelText: ' ',
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterCity(value);
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
                                          suffixIcon: Icon(
                                            LucideIcons.filter,
                                            color: Colors.grey[300],
                                          )),
                                      onChanged: (value) {
                                        setState(() {
                                          controller.filterState(value);
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
                                          controller.filterCountry(value);
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
                                          controller.filterGstno(value);
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
                                          controller
                                              .filterPrimaryContact(value);
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
                                          controller.filterPrimaryEmail(value);
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
                                        0.06, // Adjust width as necessary
                                    child: TextField(
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
                                        0.06, // Adjust width as necessary
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
                              source: MyData(
                                  controller.filterStorealldata.isEmpty
                                      ? [
                                          GetAllStoreData(
                                              id: 0,
                                              tenantId: '',
                                              storeCode: '',
                                              storeName: '',
                                              address1: '',
                                              address2: '',
                                              address3: '',
                                              city: '',
                                              state: '',
                                              country: '',
                                              pinCode: '',
                                              latitude: '',
                                              longitude: '',
                                              createdBy: 0,
                                              createdOn: '',
                                              updatedBy: 0,
                                              updatedOn: '',
                                              status: null,
                                              gstNo: '',
                                              primaryContact: '',
                                              primaryEmail: '',
                                              centralWhs: '',
                                              restrictionType: 0,
                                              radius: 0,
                                              storeLogoUrl: '')
                                        ]
                                      : controller.filterStorealldata,
                                  controller,
                                  context),
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
                                    'Store Name',
                                    fontWeight: 600,
                                  ),
                                  onSort: (columnIndex, ascending) {},
                                ),
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    'Address 1',
                                    fontWeight: 600,
                                  ),
                                  onSort: (columnIndex, ascending) {},
                                ),
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    'Pincode',
                                    fontWeight: 600,
                                  ),
                                  onSort: (columnIndex, ascending) {},
                                ),
                                DataColumn(
                                  label: MyText.bodyMedium(
                                    'City',
                                    fontWeight: 600,
                                  ),
                                  onSort: (columnIndex, ascending) {},
                                ),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'State',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Country',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'GST NO',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Primary Contact',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Primary Email',
                                  fontWeight: 600,
                                )),
                                DataColumn(
                                    label: MyText.bodyMedium(
                                  'Store Logo',
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
}

class MyData extends DataTableSource with UIMixin {
  List<GetAllStoreData> data = [];
  StoreController cnt;
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
          width: width * 0.12,
          child: MyText.bodySmall(
            '${data[index].storeCode.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            Container(
          width: width * 0.12,
          child: MyText.bodySmall(
            '${data[index].storeName.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            Container(
          width: width * 0.12,
          child: MyText.bodySmall(
            '${data[index].address1.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            Container(
          width: width * 0.12,
          child: MyText.bodySmall(
            '${data[index].pinCode.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            Container(
          width: width * 0.12,
          child: MyText.bodySmall(
            '${data[index].city.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
          // ,
          width: width * 0.1,
          child: MyText.bodySmall(
            '${data[index].state.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
          // ,
          width: width * 0.1,
          child: MyText.bodySmall(
            '${data[index].country.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
          // ,
          width: width * 0.1,
          child: MyText.bodySmall(
            '${data[index].gstNo.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
          // ,
          width: width * 0.1,
          child: MyText.bodySmall(
            '${data[index].primaryContact.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
          // ,
          width: width * 0.1,
          child: MyText.bodySmall(
            '${data[index].primaryEmail.toString()}',
            textAlign: TextAlign.left,

            // fontWeight: 600,
          ),
        )),
        DataCell(
            // onTap: () {},
            SizedBox(
                // ,
                width: width * 0.08,
                child: GestureDetector(
                    onTap: data[index].storeLogoUrl!.isEmpty
                        ? null
                        : () {
                            UrlService.goToUrl('${data[index].storeLogoUrl}');
                          },
                    child: data[index].storeLogoUrl!.isEmpty
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
                data[index].status == null
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: data[index].status == 1
                                ? Colors.green
                                : Colors.red,
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
            child: data[index].status == null
                ? Row(
                    children: [
                      SizedBox(),
                    ],
                  )
                : Row(
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
                        onTap: () => {
                          Get.dialog(StoreDeleteAlertBox(
                            controller: cnt,
                            deletId: data[index].id!,
                          ))
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
