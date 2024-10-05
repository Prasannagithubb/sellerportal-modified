import 'package:flowkit/controller/pages/pre_sales/customerdata_controller.dart';
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

class NewCustomer extends StatefulWidget {
  const NewCustomer(
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
  final CustomerDataController controller;
  final double width;
  final double heigth;

  @override
  State<NewCustomer> createState() => _NewCustomerState();
}

class _NewCustomerState extends State<NewCustomer> {
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
                    "New Customer",
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
                    MyText.bodyMedium('Customer Code *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('customercode'),
                      controller: widget.controller.basicValidator
                          .getController('customercode'),
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
                    MyText.bodyMedium('Customer Name *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('customername'),
                      controller: widget.controller.basicValidator
                          .getController('customername'),
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
                    MyText.bodyMedium('Mobile No *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('mobileno'),
                      controller: widget.controller.basicValidator
                          .getController('mobileno'),
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
                    MyText.bodyMedium('Alternate Mobile No '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('alter natemobileno'),
                      controller: widget.controller.basicValidator
                          .getController('alternatemobileno'),
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
                    MyText.bodyMedium('Contact Name '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('contactname'),
                      controller: widget.controller.basicValidator
                          .getController('contactname'),
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
                    MyText.bodyMedium('Email Id '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('emailid'),
                      controller: widget.controller.basicValidator
                          .getController('emailid'),
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
                    MyText.bodyMedium('GST.No '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('gstno'),
                      controller: widget.controller.basicValidator
                          .getController('gstno'),
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
                    MyText.bodyMedium('Code Id '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('codeid'),
                      controller: widget.controller.basicValidator
                          .getController('codeid'),
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
                    MyText.bodyMedium('Tag *'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: null,
                        value: widget.controller.valueTag,
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
                        // validator: widget.controller.basicValidator
                        //     .getValidation('tag'),
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
                    MyText.bodyMedium('Facebook Id '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('facebookid'),
                      controller: widget.controller.basicValidator
                          .getController('facebookid'),
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
                    MyText.bodyMedium('Card Type '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('cardtype'),
                      controller: widget.controller.basicValidator
                          .getController('cardtype'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
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
            ],
          ),
          MySpacing.height(widget.heigth * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: widget.width * 0.05,
              ),
              MyText.bodyLarge(
                'Billing Address',
                textAlign: TextAlign.end,
                fontWeight: 600,
              ),
            ],
          ),
          MySpacing.height(widget.heigth * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Address 1 '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('address1'),
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
                      // validator: widget.controller.basicValidator
                      //     .getValidation('address2'),
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
                    MyText.bodyMedium('Address 3 '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('address3'),
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
                    MyText.bodyMedium('City'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('city'),
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
                        items: widget.controller.statelist!
                            .map<DropdownMenuItem<String>>((toElement) {
                          return DropdownMenuItem(
                              value: toElement.statecode,
                              child: Text(toElement.stateName!));
                        }).toList(),
                        value: widget.controller.valueState,
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
                        // validator: widget.controller.basicValidator
                        //     .getValidation('state'),
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
                        value: widget.controller.valueCountry,
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
                        // validator: widget.controller.basicValidator
                        //     .getValidation('country'),
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
              // MySpacing.width(widget.width * 0.05),

              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('PinCode'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('pincode'),
                      controller: widget.controller.basicValidator
                          .getController('pincode'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
              )
              // SizedBox()
            ],
          ),
          MySpacing.height(widget.heigth * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: widget.width * 0.05,
              ),
              MyText.bodyLarge(
                'Shipping Address',
                textAlign: TextAlign.end,
                fontWeight: 600,
              ),
            ],
          ),
          MySpacing.height(widget.heigth * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Shipping Address 1 '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('shippingaddress1'),
                      controller: widget.controller.basicValidator
                          .getController('shippingaddress1'),
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
                    MyText.bodyMedium('Shipping Address 2 '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('shippingaddress2'),
                      controller: widget.controller.basicValidator
                          .getController('shippingaddress2'),
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
                    MyText.bodyMedium('Shipping Address 3 '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('shippingaddress3'),
                      controller: widget.controller.basicValidator
                          .getController('shippingaddress3'),
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
                    MyText.bodyMedium('Shipping City'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('shippingcity'),
                      controller: widget.controller.basicValidator
                          .getController('shippingcity'),
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
                    MyText.bodyMedium('Shipping State'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: widget.controller.statelist!
                            .map<DropdownMenuItem<String>>((toElement) {
                          return DropdownMenuItem(
                              value: toElement.statecode,
                              child: Text(toElement.stateName!));
                        }).toList(),
                        value: widget.controller.valueShippingState,
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
                        // validator: widget.controller.basicValidator
                        //     .getValidation('shippingstate'),
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
                    MyText.bodyMedium('Shipping Country'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: <DropdownMenuItem<String>>[
                          DropdownMenuItem(value: 'IN', child: Text('IN'))
                        ],
                        value: widget.controller.valueShippingCountry,
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
                        // validator: widget.controller.basicValidator
                        //     .getValidation('shippingcountry'),
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
              // MySpacing.width(widget.width * 0.05),

              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Shipping PinCode'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('shippingpincode'),
                      controller: widget.controller.basicValidator
                          .getController('shippingpincode'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
              )
              // SizedBox()
            ],
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
                    widget.controller.validatemethod();
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
