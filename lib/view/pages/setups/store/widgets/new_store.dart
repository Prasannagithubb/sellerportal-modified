import 'package:flowkit/controller/pages/setup/store_controller.dart';
import 'package:flowkit/helpers/theme/admin_theme.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/screens/itemmaster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class NewStore extends StatefulWidget {
  const NewStore(
      {Key? key,
      required this.outlineInputBorder,
      required this.colorScheme,
      required this.focusedInputBorder,
      required this.contentTheme,
      required this.controller,
      required this.heigth,
      required this.width});

  final OutlineInputBorder outlineInputBorder;
  final ColorScheme colorScheme;
  final OutlineInputBorder focusedInputBorder;
  final ContentTheme contentTheme;
  final StoreController controller;
  final double width;
  final double heigth;

  @override
  State<NewStore> createState() => _NewStoreState();
}

class _NewStoreState extends State<NewStore> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MyCard(
        borderRadiusAll: 8,
        // height: 250,
        width: widget.width,
        // paddingAll: 23,
        shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
        child: Form(
          key: widget.controller.formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.titleMedium(
                    "New Store",
                    fontWeight: 600,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                        // widget.controller.clearGNDtls();
                      },
                      icon: Icon(
                        LucideIcons.square_x,
                        color: Colors.grey,
                      ))
                ],
              ),
              MySpacing.height(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _generalDtls(theme),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  SingleChildScrollView _generalDtls(ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Store Code *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('storecode'),
                      controller: widget.controller.basicValidator
                          .getController('storecode'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Store Name *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('storename'),
                      controller: widget.controller.basicValidator
                          .getController('storename'),
                      outlineInputBorder: widget.outlineInputBorder,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Address 1 *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('address1'),
                      controller: widget.controller.basicValidator
                          .getController('address1'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Address 2 '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('address2'),
                      controller: widget.controller.basicValidator
                          .getController('address2'),
                      outlineInputBorder: widget.outlineInputBorder,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Address 3'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('contactname'),
                      controller: widget.controller.basicValidator
                          .getController('address3'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('City * '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('city'),
                      controller: widget.controller.basicValidator
                          .getController('city'),
                      outlineInputBorder: widget.outlineInputBorder,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('State'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: widget.controller.statelist!.map((toElement) {
                          return DropdownMenuItem(
                            value: toElement.statecode,
                            child: Text(toElement.stateName!),
                          );
                        }).toList(),
                        value: widget.controller.stateValue,
                        isExpanded: true,
                        onChanged: (value) {
                          // setState(() {
                          // widget.controller.brand = value;
                          // });
                        },
                        // onTap: () {
                        //   setState(() {

                        //     widget.controller.brand=null;
                        //   });
                        // },
                        validator: widget.controller.basicValidator
                            .getValidation('state'),
                        decoration: InputDecoration(
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
                            floatingLabelBehavior: FloatingLabelBehavior.never))
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Country'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(value: 'IN', child: Text('IN'))
                        ],
                        value: widget.controller.countryValue,
                        isExpanded: true,
                        onChanged: (value) {
                          // setState(() {
                          // widget.controller.brand = value;
                          // });
                        },
                        // onTap: () {
                        //   setState(() {

                        //     widget.controller.brand=null;
                        //   });
                        // },
                        validator: widget.controller.basicValidator
                            .getValidation('country'),
                        decoration: InputDecoration(
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
                            floatingLabelBehavior: FloatingLabelBehavior.never))
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('PinCode *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('pincode'),
                      controller: widget.controller.basicValidator
                          .getController('pincode'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('GST.No * '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('gstno'),
                      controller: widget.controller.basicValidator
                          .getController('gstno'),
                      outlineInputBorder: widget.outlineInputBorder,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Primary Contact Number *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('primarymobileno'),
                      controller: widget.controller.basicValidator
                          .getController('primarymobileno'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Email *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('email'),
                      controller: widget.controller.basicValidator
                          .getController('email'),
                      outlineInputBorder: widget.outlineInputBorder,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Latitude'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('latitude'),
                      controller: widget.controller.basicValidator
                          .getController('latitude'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Longitude'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('gstno'),
                      controller: widget.controller.basicValidator
                          .getController('longitude'),
                      outlineInputBorder: widget.outlineInputBorder,
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
                child: Row(
                  children: [
                    MyText.labelLarge("Active Status "),
                    Switch(
                      onChanged: (vval) {},
                      value: true,
                      activeColor: theme.colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Restriction Type *'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(
                              value: 'No Restriction',
                              child: Text('No Restriction')),
                          DropdownMenuItem(
                              value: 'Location', child: Text('Location')),
                          DropdownMenuItem(value: 'IP', child: Text('IP')),
                          DropdownMenuItem(value: 'SSID', child: Text('SSID'))
                        ],
                        value: null,
                        isExpanded: true,
                        onChanged: (value) {
                          // setState(() {
                          // widget.controller.brand = value;
                          // });
                        },
                        // onTap: () {
                        //   setState(() {

                        //     widget.controller.brand=null;
                        //   });
                        // },
                        validator: widget.controller.basicValidator
                            .getValidation('restrictiontype'),
                        decoration: InputDecoration(
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
                            floatingLabelBehavior: FloatingLabelBehavior.never))
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Radius'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('codeid'),
                      controller: widget.controller.basicValidator
                          .getController('radius'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('IP Address'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "Add Ip Address",
                      icon: LucideIcons.plus,
                      iconOnPressed: () {
                        Map<String, dynamic> data =
                            widget.controller.basicValidator.getData();
                        setState(() {
                          if (data['ipaddress'] != null) {
                            widget.controller.restrictionList
                                .add(data['ipaddress']);
                            widget.controller.basicValidator
                                .getController('ipaddress')!
                                .text = '';
                          }
                        });
                      },
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('gstno'),
                      controller: widget.controller.basicValidator
                          .getController('ipaddress'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(widget.heigth * 0.02),
          widget.controller.restrictionList.isEmpty
              ? SizedBox()
              : Container(
                  height: widget.heigth * 0.2,
                  margin: EdgeInsets.only(left: widget.width * 0.06),
                  child: ListView.builder(
                    itemCount: widget.controller.restrictionList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: widget.width / 2.5,
                        child: Row(
                          children: [
                            Text('${widget.controller.restrictionList[index]}'),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.controller.restrictionList
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                onPressed: null, //widget.controller.clearGNDtls,
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
                    widget.controller.validateNewStore();
                  });
                },
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: theme.primaryColor,
                borderRadiusAll: 5,
                child: MyText.bodySmall(
                  'Add',
                  color: Colors.white,
                ),
              ),
              MySpacing.width(widget.width * 0.04),
            ],
          )
        ],
      ),
    );
  }
}
