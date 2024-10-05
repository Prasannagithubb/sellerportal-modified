import 'package:flowkit/controller/pages/inventory/itemmaster_controller.dart';
import 'package:flowkit/controller/pages/user_configuration/dashboardmapping_controller.dart.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class DashboardMapping extends StatefulWidget {
  const DashboardMapping({super.key});

  @override
  State<DashboardMapping> createState() => _DashboardMappingState();
}

class _DashboardMappingState extends State<DashboardMapping>
    with TickerProviderStateMixin, UIMixin {
  DashboardMappingController? controller;

  @override
  void initState() {
    controller = DashboardMappingController();

    // TODO: implement initState
    super.initState();
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
            return Column(children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Dashboard Mapping",
                        fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'sellerkit'),
                        MyBreadcrumbItem(
                            name: 'dashboard mapping', active: true)
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyFlexItem(
                        sizes: 'lg-6 md-6 sm-6 xs-6',
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Container(
                              width: width / 3.5,
                              // alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                  dropdownColor: Colors.white,
                                  isExpanded: true,
                                  items: controller.getallUser!
                                      .map<DropdownMenuItem<String>>(
                                    (e) {
                                      return DropdownMenuItem<String>(
                                        value: e.id!.toString(),
                                        child: MyText.bodySmall(e.username!),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    controller.callUserManuAuthDataApi(val!);
                                  },
                                  value: controller.valueUser,
                                  focusColor: Colors.grey[100],
                                  decoration: InputDecoration(
                                    hintText: 'Select User\n',
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle:
                                        MyTextStyle.bodyMedium(xMuted: true),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            strokeAlign: 0,
                                            color: colorScheme.onSurface
                                                .withAlpha(20))),
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
                            ),
                          ],
                        )),
                    MyFlexItem(
                        sizes: 'lg-6 md-6 sm-6 xs-6',
                        child: Container(
                            width: width / 1.9,
                            decoration: BoxDecoration(
                                // color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
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
                                              controller.updateMenuStatus();
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.save,
                                                color: theme.primaryColor,
                                              ),
                                              MyText.bodySmall(
                                                ' Save',
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
                                              controller
                                                  .selectAllDeselectAll(true);
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                LucideIcons.square_check_big,
                                                color: theme.primaryColor,
                                              ),
                                              MyText.bodySmall(
                                                ' Select All',
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
                                              controller
                                                  .selectAllDeselectAll(false);
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                LucideIcons.box_select,
                                                color: theme.primaryColor,
                                              ),
                                              MyText.bodySmall(
                                                ' Deselect All',
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
                                                LucideIcons.import,
                                                color: theme.primaryColor,
                                              ),
                                              MyText.bodySmall(
                                                ' Excel Import',
                                                color: Colors.black,
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                MySpacing.height(height * 0.02),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyLarge(
                                        '',
                                        fontWeight: 600,
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      SizedBox(
                                        height: height * 0.18,
                                        child: GridView(
                                            scrollDirection: Axis.vertical,
                                            // padding: EdgeInsets.only(right: ),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 0.1,
                                                    crossAxisSpacing: 1,
                                                    childAspectRatio: 4.0,
                                                    crossAxisCount: 4),
                                            children: [
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value:
                                                      controller.valueEnquiry,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .enquiries,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    "Enquiries",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value: controller.valueLeads,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.leads,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Leads",
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value: controller.valueOrder,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.orders,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Orders",
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value:
                                                      controller.valueCustomers,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .customers,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    "Customer",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value: controller
                                                      .valueSalesTargets,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .salestargets,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Sales Target",
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )))
                  ])
            ]);
          }),
    );
  }
}
