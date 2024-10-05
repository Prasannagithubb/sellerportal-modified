import 'package:flowkit/controller/pages/inventory/itemmaster_controller.dart';
import 'package:flowkit/controller/pages/user_configuration/uerAuthorization_controller.dart';
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

class UserAuthorizationScreen extends StatefulWidget {
  const UserAuthorizationScreen({super.key});

  @override
  State<UserAuthorizationScreen> createState() =>
      _UserAuthorizationScreenState();
}

class _UserAuthorizationScreenState extends State<UserAuthorizationScreen>
    with TickerProviderStateMixin, UIMixin {
  UserAuthorizationController? controller;

  @override
  void initState() {
    controller = UserAuthorizationController();

    // TODO: implement initState
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
            return Column(children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("User Authorization",
                        fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'sellerkit'),
                        MyBreadcrumbItem(
                            name: 'user authorization', active: true)
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
                                  dropdownColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  isExpanded: true,
                                  onTap: () {},
                                  items: controller.getallUser!
                                      .map<DropdownMenuItem<String>>(
                                    (e) {
                                      return DropdownMenuItem<String>(
                                        value: e.id.toString(),
                                        child: MyText.bodySmall(e.username!),
                                      );
                                    },
                                  ).toList(),
                                  value: controller.valueUser,
                                  onChanged: (val) {
                                    setState(() {
                                      controller.callUserManuAuthDataApi(val!);
                                    });
                                  },
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
                                          onPressed: controller.isLoadSave
                                              ? null
                                              : () {
                                                  setState(() {
                                                    controller
                                                        .updateMenuStatus();
                                                  });
                                                },
                                          child: Row(
                                            children: [
                                              controller.isLoadSave
                                                  ? Center(
                                                      child: SizedBox(
                                                        width: width * 0.003,
                                                        height: height * 0.008,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: theme
                                                              .primaryColor,
                                                          strokeWidth: 1,
                                                        ),
                                                      ),
                                                    )
                                                  : Icon(
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
                                            controller
                                                .selectAllDeselectAll(true);
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
                                        'Pre Sales',
                                        fontWeight: 600,
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      SizedBox(
                                        height: height * 0.15,
                                        child: GridView(
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 0.1,
                                                    crossAxisSpacing: 5.5,
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

                                                  // tileColor:
                                                  //     Colors.lightBlueAccent,
                                                  // fillColor: WidgetStateColor
                                                  //     .transparent,
                                                  // tileColor: Colors.blueAccent,
                                                  // hoverColor: Colors.deepOrange,

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
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value:
                                                      controller.valueFollowup,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .followup,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    "Followup",
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
                                                  value:
                                                      controller.valueWalkins,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.walkins,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Walkins",
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
                                                      .valueScanQrCode,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.scanQr,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Scan QrCode",
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
                                                  value: controller.valueQuotes,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.quotes,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Quotes",
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
                                SizedBox(
                                  height: height * 0.02,
                                ),
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
                                        'Resources',
                                        fontWeight: 600,
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      SizedBox(
                                        height: height * 0.08,
                                        child: GridView(
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 0.1,
                                                    crossAxisSpacing: 5.5,
                                                    childAspectRatio: 4.0,
                                                    crossAxisCount: 4),
                                            children: [
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value: controller.valueStocks,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.stocks,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    "Stocks",
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
                                                  value:
                                                      controller.valuePriceList,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .pricelist,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Price List",
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
                                                  value:
                                                      controller.valueOfferZone,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .offerzone,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Offer Zone",
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
                                SizedBox(
                                  height: height * 0.02,
                                ),
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
                                        'Accounts',
                                        fontWeight: 600,
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      SizedBox(
                                        height: height * 0.08,
                                        child: GridView(
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 0.1,
                                                    crossAxisSpacing: 5.5,
                                                    childAspectRatio: 4.0,
                                                    crossAxisCount: 4),
                                            children: [
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value:
                                                      controller.valueAccounts,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .accounts,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    "Accounts",
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
                                                      .valueOutstanding,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .outstanding,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Outstanding",
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
                                                      .valueCollection,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .collection,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Collection ",
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
                                                      .valueSettlement,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .settlements,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Settlement",
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
                                SizedBox(
                                  height: height * 0.02,
                                ),
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
                                        'Activities',
                                        fontWeight: 600,
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      SizedBox(
                                        height: height * 0.15,
                                        child: GridView(
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 0.1,
                                                    crossAxisSpacing: 5.5,
                                                    childAspectRatio: 4.0,
                                                    crossAxisCount: 4),
                                            children: [
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value: controller
                                                      .valueDayStartEnd,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .daystartend,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    "Day Start End",
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
                                                  value:
                                                      controller.valueVistPlan,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .visitplan,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Visit Plane",
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
                                                  value: controller.valueSitein,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.siteIn,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Site In",
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
                                                  value:
                                                      controller.valueSiteOut,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.siteout,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Site Out",
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
                                                  value:
                                                      controller.valueLeaveReq,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .leavereq,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Leave Request",
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
                                                      .valueLeaveApproval,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .leaveApprove,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Leave Approval",
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
                                SizedBox(
                                  height: height * 0.02,
                                ),
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
                                        'Performance',
                                        fontWeight: 600,
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      SizedBox(
                                        height: height * 0.15,
                                        child: GridView(
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 0.1,
                                                    crossAxisSpacing: 5.5,
                                                    childAspectRatio: 4.0,
                                                    crossAxisCount: 4),
                                            children: [
                                              SizedBox(
                                                // width: width * 0.1,
                                                child: CheckboxListTile(
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  value:
                                                      controller.valueScoreCard,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .scorecard,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    "Score Card",
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
                                                  value:
                                                      controller.valueEarnings,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .earnings,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Earnings",
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
                                                      .valuePerformance,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .performance,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Performance",
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
                                                  value:
                                                      controller.valueTargets,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType.target,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Target",
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
                                                      .valueChallenges,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      controller.changeState(
                                                          SwitchBoxType
                                                              .challenges,
                                                          value!);
                                                    });
                                                  },
                                                  title: const Text(
                                                    textAlign: TextAlign.end,
                                                    "Challenges",
                                                    style: TextStyle(
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )))
                  ])
            ]);
          }),
    );
  }
}
