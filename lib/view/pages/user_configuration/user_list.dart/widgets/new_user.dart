import 'package:file_picker/file_picker.dart';
import 'package:flowkit/controller/pages/user_configuration/userlist_controller.dart';
import 'package:flowkit/helpers/theme/admin_theme.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/setups/setupCommon_getapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class NewUserAdd extends StatefulWidget {
  NewUserAdd(
      {Key? key,
      required this.outlineInputBorder,
      required this.colorScheme,
      required this.focusedInputBorder,
      required this.contentTheme,
      required this.controller,
      required this.heigth,
      required this.width,
      required this.usertypelist,
      required this.designationlist});

  final OutlineInputBorder outlineInputBorder;
  final ColorScheme colorScheme;
  final OutlineInputBorder focusedInputBorder;
  final ContentTheme contentTheme;
  final UserListController controller;
  final double width;
  final double heigth;
  final List<SetupsCommonData> usertypelist;
  final List<SetupsCommonData> designationlist;
  final List<String> cities = ['Prasanna', 'vankatesan', 'gokul', 'srinath'];

  @override
  State<NewUserAdd> createState() => _NewUserAddState();
}

class _NewUserAddState extends State<NewUserAdd> {
  final List<String> cities = ['Prasanna', 'vankatesan', 'gokul', 'srinath'];
  @override
  void initState() {
    super.initState();
  }

  String? valueUsertype2;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      TextEditingController usercode = TextEditingController();
      TextEditingController basicvalidatorcontroller = TextEditingController();
      TextEditingController slpcodecontroller = TextEditingController();
      TextEditingController mobilenocontroller = TextEditingController();
      TextEditingController mailidcontroller = TextEditingController();
      TextEditingController userusername = TextEditingController();
      final List<String> items = [
        'Apple',
        'Banana',
        'Cherry',
        'Date',
        'Elderberry'
      ];
      String? valueDesignation;
      var selectedItem;
      return Container(
          width: 1000,
          // key: UniqueKey(),
          // borderRadiusAll: 8,
          // // height: 250,
          // width: widget.width,
          // // paddingAll: 23,
          // shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
          child: Form(
            key: widget.controller.formkey[0],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Add User",
                      fontWeight: 600,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                          widget.controller.clearAllFields();
                          print('close button pressed');
                        },
                        icon: Icon(
                          LucideIcons.square_x,
                          color: Colors.grey,
                        ))
                  ],
                ),
                MySpacing.height(10),
                TabBar(
                  controller: widget.controller.softTabController,
                  isScrollable: false,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).primaryColor.withAlpha(40)),
                  tabs: [
                    Tab(
                      icon: MyText.bodyMedium(
                        "General Details",
                        // fontWeight: widget.controller.softIndex == 0 ? 600 : 500,
                        color: widget.controller.softIndex == 0
                            ? Colors.black
                            : null,
                      ),
                    ),
                    Tab(
                      icon: MyText.bodyMedium(
                        "Restriction",
                        fontWeight:
                            widget.controller.softIndex == 1 ? 600 : 500,
                        color: widget.controller.softIndex == 1
                            ? Colors.black
                            : null,
                      ),
                    ),
                    Tab(
                      icon: MyText.bodyMedium(
                        "Filter",
                        fontWeight:
                            widget.controller.softIndex == 2 ? 600 : 500,
                        color: widget.controller.softIndex == 2
                            ? Colors.black
                            : null,
                      ),
                    ),
                  ],
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                MySpacing.height(10),
                Expanded(
                  child: TabBarView(
                    controller: widget.controller.softTabController,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('User Code *'),
                                      MySpacing.height(8),
                                      CommonValidationForm(
                                        hintText: "",
                                        // icon: LucideIcons.user,
                                        validator: widget
                                            .controller.basicValidator
                                            .getValidation('usercode'),
                                        controller: usercode,
                                        outlineInputBorder:
                                            widget.outlineInputBorder,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('User Name *'),
                                      MySpacing.height(8),
                                      CommonValidationForm(
                                        hintText: "",
                                        // icon: LucideIcons.user,
                                        validator: widget
                                            .controller.basicValidator
                                            .getValidation('username'),
                                        controller: userusername,
                                        // controller: widget
                                        //     .controller.basicValidator
                                        //     .getController('username'),
                                        outlineInputBorder:
                                            widget.outlineInputBorder,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            MySpacing.height(widget.heigth * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('Mobile No *'),
                                      MySpacing.height(8),
                                      CommonValidationForm(
                                        hintText: "",
                                        // icon: LucideIcons.user,
                                        validator: widget
                                            .controller.basicValidator
                                            .getValidation('mobileno'),
                                        controller: mobilenocontroller,

                                        // controller: widget
                                        //     .controller.basicValidator
                                        //     .getController('mobileno'),
                                        outlineInputBorder:
                                            widget.outlineInputBorder,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('Mail ID'),
                                      MySpacing.height(8),
                                      CommonValidationForm(
                                        hintText: "",
                                        // icon: LucideIcons.user,
                                        validator: widget
                                            .controller.basicValidator
                                            .getValidation('mailid'),
                                        controller: mailidcontroller,

                                        // controller: widget
                                        //     .controller.basicValidator
                                        //     .getController('mailid'),
                                        outlineInputBorder:
                                            widget.outlineInputBorder,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            MySpacing.height(widget.heigth * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // DropdownButtonFormField
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: 'Select a Fruit',
                                          border: OutlineInputBorder(),
                                        ),
                                        items: items.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        value: selectedItem,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedItem = value;
                                          });
                                        },
                                        hint: Text('Choose an option'),
                                        isExpanded: true,
                                      ),
                                      SizedBox(height: 20),
                                      // Display the selected item
                                      Text(
                                        selectedItem != null
                                            ? 'Selected: $selectedItem'
                                            : 'No item selected',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      MyText.bodyMedium('Reporting To *'),
                                      MySpacing.height(8),
                                      DropdownButtonFormField(
                                          dropdownColor: Colors.white,
                                          // isDense: true,
                                          items: widget.controller.getallUser!
                                              .map<DropdownMenuItem<String>>(
                                            (e) {
                                              return DropdownMenuItem<String>(
                                                value: e.usercode,
                                                child: MyText.bodySmall(
                                                    e.username!),
                                              );
                                            },
                                          ).toList(),
                                          value:
                                              // widget.controller.brand!.isNotEmpty
                                              //     ?
                                              widget.controller.reportinguser
                                          // : null
                                          ,
                                          isExpanded: true,
                                          onChanged: (value) {
                                            // setState(() {
                                            widget.controller.reportinguser =
                                                value;
                                            // });
                                          },
                                          // onTap: () {
                                          //   setState(() {

                                          //     widget.controller.brand=null;
                                          //   });
                                          // },
                                          validator: widget
                                              .controller.basicValidator
                                              .getValidation('reportingto'),
                                          decoration: InputDecoration(
                                              hintText: '',
                                              hintStyle: MyTextStyle.bodyMedium(
                                                  xMuted: true),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              // enabledBorder: OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                              contentPadding: MySpacing.all(16),
                                              // prefixIcon: Icon(icon, size: 20),
                                              // isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('User Type *'),
                                      MySpacing.height(8),
                                      DropdownButtonFormField(
                                        value: valueUsertype2,
                                        isExpanded: true,
                                        onChanged: (value) {
                                          // setState(() {
                                          valueUsertype2 = value;
                                          print(valueUsertype2.toString());

                                          // });
                                        },
                                        // validator: widget
                                        //     .controller.basicValidator
                                        //     .getValidation('usertype'),
                                        decoration: InputDecoration(
                                          hintText: '',

                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          // enabledBorder: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                          contentPadding: MySpacing.all(16),
                                          // prefixIcon: Icon(icon, size: 20),
                                          // isCollapsed: true,
                                        ),
                                        dropdownColor: Colors.white,
                                        // isDense: true,
                                        items: cities.map((city) {
                                          return DropdownMenuItem(
                                              value: city, child: Text(city));
                                        }).toList(),
                                        // widget.user typelist
                                        //     .map<DropdownMenuItem<String>>(
                                        //   (e) {
                                        //     return DropdownMenuItem<String>(
                                        //       value: e.code,
                                        //       child: MyText.bodySmall(
                                        //           e.description!),
                                        //     );
                                        //   },
                                        // ).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            MySpacing.height(widget.heigth * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('Designation *'),
                                      MySpacing.height(8),
                                      DropdownButtonFormField(
                                          dropdownColor: Colors.white,
                                          // isDense: true,
                                          items: widget.designationlist
                                              .map<DropdownMenuItem<String>>(
                                            (e) {
                                              return DropdownMenuItem<String>(
                                                value: e.id.toString(),
                                                child: MyText.bodySmall(
                                                    e.description!),
                                              );
                                            },
                                          ).toList(),
                                          value: valueDesignation,
                                          isExpanded: true,
                                          onChanged: (value) {
                                            valueDesignation = value;
                                          },
                                          validator: widget
                                              .controller.basicValidator
                                              .getValidation('designation'),
                                          decoration: InputDecoration(
                                              hintText: '',
                                              hintStyle: MyTextStyle.bodyMedium(
                                                  xMuted: true),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              // enabledBorder: OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                              contentPadding: MySpacing.all(16),
                                              // prefixIcon: Icon(icon, size: 20),
                                              // isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('Slp Code *'),
                                      MySpacing.height(8),
                                      CommonValidationForm(
                                        hintText: "",
                                        // icon: LucideIcons.user,
                                        validator: widget
                                            .controller.basicValidator
                                            .getValidation('slpcode'),
                                        controller: slpcodecontroller,

                                        // controller: widget
                                        //     .controller.basicValidator
                                        //     .getController('slpcode'),
                                        outlineInputBorder:
                                            widget.outlineInputBorder,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            MySpacing.height(widget.heigth * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('Upload Profile'),
                                      MySpacing.height(8),
                                      CommonValidationForm(
                                        icon: LucideIcons.upload,
                                        iconOnPressed: () async {
                                          var result = await FilePicker.platform
                                              .pickFiles(
                                                  allowMultiple: false,
                                                  type: FileType.any);
                                          if (result?.files.isNotEmpty ??
                                              false) {
                                            setState(() {
                                              widget.controller
                                                      .uploadfileField =
                                                  result!.files[0];
                                            });
                                          }

                                          setState(() {
                                            TextEditingController? cat1 = widget
                                                .controller.basicValidator
                                                .getController('uploadfiles');
                                            cat1!.text =
                                                '${widget.controller.uploadfileField!.name}';
                                          });
                                        },
                                        hintText: "",
                                        readOnly: true,
                                        // icon: LucideIcons.user,
                                        validator: widget
                                            .controller.basicValidator
                                            .getValidation('uploadfiles'),
                                        controller: basicvalidatorcontroller,
                                        // controller: widget
                                        //     .controller.basicValidator
                                        //     .getController('uploadfiles'),
                                        outlineInputBorder:
                                            widget.outlineInputBorder,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium('Template Type'),
                                      MySpacing.height(8),
                                      DropdownButtonFormField(
                                          dropdownColor: Colors.white,
                                          // isDense: true,
                                          items: <DropdownMenuItem<String>>[
                                            DropdownMenuItem(
                                              value: 'Retailer',
                                              child:
                                                  MyText.bodySmall('Retailer'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'B2B',
                                              child: MyText.bodySmall('B2B'),
                                            )
                                          ],
                                          value: widget.controller.templateType,
                                          onChanged: (value) {
                                            // setState(() {
                                            widget.controller.templateType =
                                                value;
                                            // });
                                          },
                                          validator: widget
                                              .controller.basicValidator
                                              .getValidation('templatetype'),
                                          decoration: InputDecoration(
                                              hintText: '',
                                              hintStyle: MyTextStyle.bodyMedium(
                                                  xMuted: true),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              // enabledBorder: OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey)),
                                              contentPadding: MySpacing.all(16),
                                              // prefixIcon: Icon(icon, size: 20),
                                              // isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            MySpacing.height(widget.heigth * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: widget.width * 0.2,
                                  child: Row(
                                    children: [
                                      MyText.labelLarge("Is Mobile User "),
                                      Switch(
                                        onChanged: (vval) {
                                          setState(() {
                                            widget.controller.ismobileUser =
                                                vval;
                                          });
                                        },
                                        value: widget.controller.ismobileUser!,
                                        activeColor: theme.colorScheme.primary,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width * 0.2,
                                  child: Row(
                                    children: [
                                      MyText.labelLarge("Is Portal User "),
                                      Switch(
                                        onChanged: (vval) {
                                          setState(() {
                                            widget.controller.isPortaluser =
                                                vval;
                                          });
                                        },
                                        value: widget.controller.isPortaluser!,
                                        activeColor: theme.colorScheme.primary,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width * 0.2,
                                  child: Row(
                                    children: [
                                      MyText.labelLarge(" Status "),
                                      Switch(
                                        onChanged: (vval) {
                                          setState(() {
                                            widget.controller.status = vval;
                                          });
                                        },
                                        value: widget.controller.status!,
                                        activeColor: theme.colorScheme.primary,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   width: widget.width / 2.5,
                                // )
                              ],
                            ),
                            MySpacing.height(widget.heigth * 0.002),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyButton(
                                  onPressed: () {
                                    setState(() {
                                      valueDesignation = null;
                                      selectedItem = null;
                                      // widget.controller.reportinguser = null;
                                      // widget.controller.basicValidator
                                      //     .getController('usercode')
                                      //     ?.clear();
                                      // valueUsertype2 =
                                      //     null; // Reset the dropdown value

                                      // widget.controller.clearAllFields();
                                      // usercode = TextEditingController();
                                      // basicvalidatorcontroller.clear();
                                      // slpcodecontroller.clear();
                                      // mobilenocontroller.clear();
                                      // mailidcontroller.clear();
                                      // userusername.clear();
                                    });
                                  },
                                  elevation: 0,
                                  padding: MySpacing.xy(20, 16),
                                  backgroundColor: Colors.grey,
                                  borderRadiusAll: 5,
                                  child: MyText.bodySmall(
                                    'Clear',
                                    color: Colors.black,
                                  ),
                                ),
                                MySpacing.width(16),
                                MyButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.controller
                                          .validateFinalAddNewUser();
                                    });
                                  },
                                  elevation: 0,
                                  padding: MySpacing.xy(20, 16),
                                  backgroundColor: theme.primaryColor,
                                  borderRadiusAll: 5,
                                  child: MyText.bodySmall(
                                    'Submit',
                                    color: Colors.white,
                                  ),
                                ),
                                MySpacing.width(widget.width * 0.04),
                              ],
                            )
                          ],
                        ),
                      ),

                      restrictionbar(theme),
                      // _attach()
                      uploadFile(),
                      // Container(
                      //   height: widget.heigth*0.2,
                      //   width: widget.width*00.3,
                      //   color: Colors.amber,
                      //   child: Row(
                      //     children: [
                      //       CommonValidationForm(
                      //         hintText: "Den Navadiya",
                      //         icon: LucideIcons.user,
                      //         validator: widget.controller.basicValidator
                      //             .getValidation('itemcode'),
                      //         controller: widget.controller.basicValidator
                      //             .getController('itemcode'),
                      //         outlineInputBorder: widget.outlineInputBorder,
                      //       ),
                      //       CommonValidationForm(
                      //         hintText: "Den Navadiya",
                      //         icon: LucideIcons.user,
                      //         validator: widget.controller.basicValidator
                      //             .getValidation('itemcode'),
                      //         controller: widget.controller.basicValidator
                      //             .getController('itemcode'),
                      //         outlineInputBorder: widget.outlineInputBorder,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   height: widget.heigth,
                      //   width: widget.width,
                      //   color: Colors.amber,
                      //   child: Row(
                      //     children: [
                      //       CommonValidationForm(
                      //         hintText: "Den Navadiya",
                      //         icon: LucideIcons.user,
                      //         validator: widget.controller.basicValidator
                      //             .getValidation('itemcode'),
                      //         controller: widget.controller.basicValidator
                      //             .getController('itemcode'),
                      //         outlineInputBorder: widget.outlineInputBorder,
                      //       ),
                      //       CommonValidationForm(
                      //         hintText: "Den Navadiya",
                      //         icon: LucideIcons.user,
                      //         validator: widget.controller.basicValidator
                      //             .getValidation('itemcode'),
                      //         controller: widget.controller.basicValidator
                      //             .getController('itemcode'),
                      //         outlineInputBorder: widget.outlineInputBorder,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Text('c')
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }

  // SingleChildScrollView _generalDtls(ThemeData theme,userty) {
  //   return  }

  SingleChildScrollView restrictionbar(ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widget.width / 2.5,
                child: Row(
                  children: [
                    MyText.labelLarge("Restriction "),
                    Switch(
                      onChanged: (vval) {
                        setState(() {
                          widget.controller.isRestriction = vval;
                          // if (vval == true) {
                          //   widget.controller.callRestrictionApi();
                          // }
                        });
                      },
                      value: widget.controller.isRestriction!,
                      activeColor: theme.colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: !widget.controller.isRestriction!
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium('Restriction *'),
                          MySpacing.height(8),
                          DropdownButtonFormField(
                              dropdownColor: Colors.white,
                              // isDense: true,
                              items:
                                  widget.controller.restrictionData!.map((e) {
                                return DropdownMenuItem(
                                    value: e.restrictionData,
                                    child: MyText.bodySmall('${e.remarks}'));
                              }).toList(),
                              value: widget.controller.restrictionType,
                              onChanged: (value) {
                                setState(() {
                                  widget.controller.restrictionType = value;
                                  widget.controller.addRestrictionMethod(value);
                                });
                              },
                              validator: widget.controller.basicValidator
                                  .getValidation('templatetype'),
                              isExpanded: true,
                              decoration: InputDecoration(
                                  hintText: '',
                                  hintStyle:
                                      MyTextStyle.bodyMedium(xMuted: true),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  // enabledBorder: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  contentPadding: MySpacing.all(16),
                                  // prefixIcon: Icon(icon, size: 20),
                                  // isCollapsed: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never))
                        ],
                      ),
              ),
            ],
          ),
          MySpacing.height(widget.heigth * 0.01),
          widget.controller.addRestrictionData!.isEmpty
              ? SizedBox()
              : Container(
                  height: widget.heigth * 0.2,
                  margin: EdgeInsets.only(left: widget.width * 0.06),
                  child: ListView.builder(
                    itemCount: widget.controller.addRestrictionData!.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: widget.width / 2.5,
                        child: Row(
                          children: [
                            widget.controller.addRestrictionData![index]
                                        .restrictionType ==
                                    1
                                ? Text(
                                    'IP: ${widget.controller.addRestrictionData![index].restrictionData}')
                                : widget.controller.addRestrictionData![index]
                                            .restrictionType ==
                                        3
                                    ? Text(
                                        'SSID: ${widget.controller.addRestrictionData![index].restrictionData}')
                                    : widget
                                                .controller
                                                .addRestrictionData![index]
                                                .restrictionType ==
                                            2
                                        ? Text(
                                            'Longitude: ${widget.controller.splitLocation(widget.controller.addRestrictionData![index].restrictionData!)[0]} | Latitude: ${widget.controller.splitLocation(widget.controller.addRestrictionData![index].restrictionData!)[1]} | Distance: ${widget.controller.splitLocation(widget.controller.addRestrictionData![index].restrictionData!)[2]}')
                                        : Text(
                                            'IP: ${widget.controller.addRestrictionData![index].restrictionData}'),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.controller.addRestrictionData!
                                        .removeAt(index);
                                  });
                                },
                                icon: Icon(
                                  LucideIcons.trash,
                                  color: Colors.grey,
                                  size: 12,
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
          MySpacing.height(widget.heigth * 0.02),
        ],
      ),
    );
  }

  SingleChildScrollView uploadFile() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MySpacing.height(widget.heigth * 0.01),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: widget.width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium('Store *'),
                      MySpacing.height(8),
                      DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          // isDense: true,
                          items: widget.controller.filterStorealldata
                              .map<DropdownMenuItem<String>>(
                            (e) {
                              return DropdownMenuItem<String>(
                                value: e.id.toString(),
                                child: MyText.bodySmall(e.storeName!),
                              );
                            },
                          ).toList(),
                          value:
                              // widget.controller.brand!.isNotEmpty
                              //     ?
                              widget.controller.valueStore
                          // : null
                          ,
                          isExpanded: true,
                          onChanged: (value) {
                            // setState(() {
                            widget.controller.valueStore = value;
                            // });
                          },
                          // onTap: () {
                          //   setState(() {

                          //     widget.controller.brand=null;
                          //   });
                          // },
                          validator: widget.controller.basicValidator
                              .getValidation('store'),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.controller.addStoreListMethod();
                                    });
                                  },
                                  icon: Icon(LucideIcons.plus)),
                              hintText: '',
                              hintStyle: MyTextStyle.bodyMedium(xMuted: true),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              // enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.grey)),
                              contentPadding: MySpacing.all(16),
                              // prefixIcon: Icon(icon, size: 20),
                              // isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never)),
                      widget.controller.addStorelist.isEmpty
                          ? SizedBox()
                          : Container(
                              height: widget.heigth * 0.25,
                              margin:
                                  EdgeInsets.only(left: widget.width * 0.02),
                              child: ListView.builder(
                                itemCount:
                                    widget.controller.addStorelist.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: widget.width * 0.22,
                                    // color: Colors.amber,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          // color: Colors.red,
                                          width: widget.width * 0.2,
                                          child: Text(
                                              '${widget.controller.addStorelist[index].storename}'),
                                        ),
                                        SizedBox(
                                          // width: widget.width * 0.1,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.controller.addStorelist
                                                      .removeAt(index);
                                                });
                                              },
                                              icon: Icon(
                                                LucideIcons.trash,
                                                color: Colors.grey,
                                                size: 12,
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium('Brand *'),
                      MySpacing.height(8),
                      DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          // isDense: true,
                          items: widget.controller.brandlist
                              .map<DropdownMenuItem<String>>(
                            (e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: MyText.bodySmall(e),
                              );
                            },
                          ).toList(),
                          value:
                              // widget.controller.brand!.isNotEmpty
                              //     ?
                              widget.controller.brand
                          // : null
                          ,
                          isExpanded: true,
                          onChanged: (value) {
                            // setState(() {
                            widget.controller.brand = value;
                            // });
                          },
                          // onTap: () {
                          //   setState(() {

                          //     widget.controller.brand=null;
                          //   });
                          // },
                          validator: widget.controller.basicValidator
                              .getValidation('brand'),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.controller.addBrandListMethod();
                                    });
                                  },
                                  icon: Icon(LucideIcons.plus)),
                              hintText: '',
                              hintStyle: MyTextStyle.bodyMedium(xMuted: true),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              // enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.grey)),
                              contentPadding: MySpacing.all(16),
                              // prefixIcon: Icon(icon, size: 20),
                              // isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never)),
                      widget.controller.addBrandlist.isEmpty
                          ? SizedBox()
                          : Container(
                              height: widget.heigth * 0.25,
                              margin:
                                  EdgeInsets.only(left: widget.width * 0.02),
                              child: ListView.builder(
                                itemCount:
                                    widget.controller.addBrandlist.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: widget.width * 0.22,
                                    // color: Colors.amber,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          // color: Colors.red,
                                          width: widget.width * 0.2,
                                          child: Text(
                                              '${widget.controller.addBrandlist[index]}'),
                                        ),
                                        SizedBox(
                                          // width: widget.width * 0.1,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.controller.addBrandlist
                                                      .removeAt(index);
                                                });
                                              },
                                              icon: Icon(
                                                LucideIcons.trash,
                                                color: Colors.grey,
                                                size: 12,
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.width * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText.bodyMedium('Category *'),
                      MySpacing.height(8),
                      DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          // isDense: true,
                          items: widget.controller.categorylist
                              .map<DropdownMenuItem<String>>(
                            (e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: MyText.bodySmall(e),
                              );
                            },
                          ).toList(),
                          value: widget.controller.category,
                          onChanged: (value) {
                            // setState(() {
                            widget.controller.category = value;
                            // });
                          },
                          validator: widget.controller.basicValidator
                              .getValidation('category'),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.controller.addCategoryListMethod();
                                    });
                                  },
                                  icon: Icon(LucideIcons.plus)),
                              hintText: '',
                              hintStyle: MyTextStyle.bodyMedium(xMuted: true),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              // enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.grey)),
                              contentPadding: MySpacing.all(16),
                              // prefixIcon: Icon(icon, size: 20),
                              // isCollapsed: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never)),
                      widget.controller.addCategorylist.isEmpty
                          ? SizedBox()
                          : Container(
                              height: widget.heigth * 0.25,
                              margin:
                                  EdgeInsets.only(left: widget.width * 0.02),
                              child: ListView.builder(
                                itemCount:
                                    widget.controller.addCategorylist.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: widget.width * 0.22,
                                    // color: Colors.amber,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          // color: Colors.red,
                                          width: widget.width * 0.2,
                                          child: Text(
                                              '${widget.controller.addCategorylist[index]}'),
                                        ),
                                        SizedBox(
                                          // width: widget.width * 0.1,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.controller
                                                      .addCategorylist
                                                      .removeAt(index);
                                                });
                                              },
                                              icon: Icon(
                                                LucideIcons.trash,
                                                color: Colors.grey,
                                                size: 12,
                                              )),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonValidationForm extends StatelessWidget {
  CommonValidationForm(
      {super.key,
      this.controller,
      required this.outlineInputBorder,
      this.validator,
      this.hintText,
      this.icon,
      this.onChanged,
      this.inputFormatters,
      this.iconOnPressed,
      this.readOnly = false});
  Function()? iconOnPressed;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? icon;
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final OutlineInputBorder outlineInputBorder;
  final void Function(String)? onChanged;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      readOnly: readOnly!,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: MyTextStyle.bodySmall(xMuted: true),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          contentPadding: MySpacing.all(16),
          suffixIcon: iconOnPressed == null
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
