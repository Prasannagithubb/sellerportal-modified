import 'package:flowkit/controller/pages/inventory/itemmaster_controller.dart';
import 'package:flowkit/controller/pages/setup/feeds_controller.dart';
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

class NewFeed extends StatefulWidget {
  const NewFeed(
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
  final FeedsController controller;
  final double width;
  final double heigth;

  @override
  State<NewFeed> createState() => _NewFeedState();
}

class _NewFeedState extends State<NewFeed> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MyCard(
        borderRadiusAll: 8,
        height: MediaQuery.of(context).size.height * 0.5,
        width: widget.width,
        // paddingAll: 23,
        shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
        child: Form(
          // key: widget.controller.formkey[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.titleMedium(
                    "New Feed",
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
                    MyText.bodyMedium('Title *'),
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
                    MyText.bodyMedium('Description *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('offerDesc'),
                      controller: widget.controller.basicValidator
                          .getController('offerDesc'),
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
                    MyText.bodyMedium('Valid Till *'),
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
          MySpacing.height(widget.heigth * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Store Code'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: null,
                        value:
                            // widget.controller.brand!.isNotEmpty
                            //     ?
                            // widget.controller.brand
                            // :
                            null,
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
                            .getValidation('brand'),
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
                    MyText.bodyMedium('Excutive'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: null,
                        value:
                            // widget.controller.brand!.isNotEmpty
                            //     ?
                            // widget.controller.brand
                            // :
                            null,
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
                            .getValidation('brand'),
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
                    MyText.bodyMedium('Media Type'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: null,
                        value:
                            // widget.controller.brand!.isNotEmpty
                            //     ?
                            // widget.controller.brand
                            // :
                            null,
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
                            .getValidation('brand'),
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
              ),
            ],
          ),
          MySpacing.height(widget.heigth * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                onPressed: null,
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
                    // widget.controller.NewFeedValidate();
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
