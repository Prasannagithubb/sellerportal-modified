import 'package:file_picker/file_picker.dart';
import 'package:flowkit/controller/pages/inventory/itemmaster_controller.dart';
import 'package:flowkit/helpers/theme/admin_theme.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/utils/utils.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/screens/itemmaster_screen.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewOffer extends StatefulWidget {
  const NewOffer(
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
  final ItemMasterController controller;
  final double width;
  final double heigth;

  @override
  State<NewOffer> createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  bool isActive = true;
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
          key: widget.controller.formkey[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.titleMedium(
                    "New Offer",
                    fontWeight: 600,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                        widget.controller.clearGNDtls();
                      },
                      icon: Icon(
                        LucideIcons.square_x,
                        color: Colors.grey,
                      ))
                ],
              ),
              MySpacing.height(10),
              Expanded(
                child: Column(
                  children: [
                    _generalDtls(theme),
                  ],
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
              // SizedBox(
              //   width: widget.width / 2.5,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       MyText.bodyMedium('Offer Code *'),
              //       MySpacing.height(8),
              //       CommonValidationForm(
              //         hintText: "",
              //         // icon: LucideIcons.user,
              //         validator: widget.controller.basicValidator
              //             .getValidation('offercode'),
              //         controller: widget.controller.basicValidator
              //             .getController('offercode'),
              //         outlineInputBorder: widget.outlineInputBorder,
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        MyText.bodyMedium('Offer Description '),
                        MyText.bodyMedium(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
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
                    Row(
                      children: [
                        MyText.bodyMedium('From Date'),
                        MyText.bodyMedium(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    MySpacing.height(8),
                    CommonValidationForm(
                      onDateSelected: (selectedDate) {
                        // Format the date to "MM/dd/yyyy"
                        String formattedDate =
                            DateFormat('MM/dd/yyyy').format(selectedDate);
                        widget.controller.basicValidator
                            .getController('fromdate')
                            ?.text = formattedDate;
                      },
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('fromdate'),
                      controller: widget.controller.basicValidator
                          .getController('fromdate'),
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
                    Row(
                      children: [
                        MyText.bodyMedium('To Date'),
                        MyText.bodyMedium(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "Select To Date", // Hint for the user
                      validator: widget.controller.basicValidator
                          .getValidation('todate'), // Validation logic
                      controller: widget.controller.basicValidator
                          .getController('todate'), // TextEditingController
                      outlineInputBorder:
                          widget.outlineInputBorder, // Your custom border
                      isDatePicker: true, // Enable the date picker
                      onDateSelected: (selectedDate) {
                        // Handle any additional logic when a date is selected
                        print(
                            "Selected date: ${selectedDate.toLocal()}"); // Or handle it as needed
                      },
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
                    Row(
                      children: [
                        MyText.bodyMedium('Relavent Tags'),
                        MyText.bodyMedium(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('relaventtags'),
                      controller: widget.controller.basicValidator
                          .getController('relaventtags'),
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
                    Row(
                      children: [
                        MyText.bodyMedium('Offer % '),
                        MyText.bodyMedium(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    MyText.bodyMedium(
                      '*',
                      style: TextStyle(color: Colors.red),
                    ),
                    MySpacing.height(8),
                    CommonValidationForm(
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only numeric input
                      ],
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('offer'),
                      controller: widget.controller.basicValidator
                          .getController('offer'),
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
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                      activeColor: theme.colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: widget.width / 2.5,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Offer Band 1'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      readOnly: true,
                      hintText: "Choose File",
                      icon: LucideIcons.upload,
                      iconOnPressed: () async {
                        var result = await FilePicker.platform.pickFiles(
                            allowMultiple: false, type: widget.controller.type);
                        if (result?.files.isNotEmpty ?? false) {
                          setState(() {
                            var fileBytes = result?.files.first.bytes;
                            var fileName = result?.files.first.name;
                            // print(String.fromCharCodes(fileBytes!));
                            // print(result?.paths);

                            widget.controller.catelogue1 = result!.files[0];
                          });
                        }
                        TextEditingController? cat1 = widget
                            .controller.basicValidator
                            .getController('catalogue1');
                        cat1!.text = '${widget.controller.catelogue1!.name}';
                        // print(cat1!.text.toString());
                      },
                      // validator: widget.controller.basicValidator
                      //     .getValidation('colour'),
                      controller: widget.controller.basicValidator
                          .getController('catalogue1'),
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
                    MyText.bodyMedium('Offer Band 2'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      readOnly: true,
                      hintText: "Choose File",
                      icon: LucideIcons.upload,
                      iconOnPressed: () async {
                        try {
                          var result = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: widget.controller.type);
                          if (result?.files.isNotEmpty ?? false) {
                            setState(() {
                              widget.controller.catelogue2 = result!.files[0];
                            });
                          }
                          TextEditingController? cat1 = widget
                              .controller.basicValidator
                              .getController('catalogue2');
                          cat1!.text = '${widget.controller.catelogue2!.name}';
                        } catch (e) {
                          Get.dialog(AlertBox(msg: '$e'));
                        }

                        // print(cat1!.text.toString());
                      },
                      // validator: widget.controller.basicValidator
                      //     .getValidation('colour'),
                      controller: widget.controller.basicValidator
                          .getController('catalogue2'),
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
                    Row(
                      children: [
                        MyText.bodyMedium('Store'),
                        MyText.bodyMedium(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
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
                    MyText.bodyMedium('Items'),
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
          SizedBox(
            width: widget.width,
            height: widget.heigth * 0.16,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                widget.controller.catelogue1 == null
                    ? SizedBox()
                    : Row(
                        children: [
                          SizedBox(
                            width: widget.width * 0.06,
                          ),
                          MyContainer.bordered(
                            borderRadiusAll: 8,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            paddingAll: widget.heigth * 0.008,
                            child: SizedBox(
                              width: widget.heigth * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: Alignment.topRight,
                                    children: [
                                      MyContainer(
                                        height: widget.heigth * 0.08,
                                        width: widget.width * 0.08,
                                        borderRadiusAll: 8,
                                        color: Colors.grey[200],
                                        paddingAll: 0,
                                        child: Icon(LucideIcons.file, size: 20),
                                      ),
                                      MyContainer.transparent(
                                          onTap: () {
                                            setState(() {
                                              widget.controller.catelogue1 =
                                                  null;
                                              TextEditingController? cat1 =
                                                  widget
                                                      .controller.basicValidator
                                                      .getController(
                                                          'catalogue1');
                                              cat1!.clear();
                                            });
                                          },
                                          paddingAll: 4,
                                          child: Icon(LucideIcons.circle_x,
                                              color: Colors.redAccent)),
                                    ],
                                  ),
                                  MySpacing.height(8),
                                  MyText.bodySmall(
                                      widget.controller.catelogue1!.name,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: 600),
                                  MySpacing.height(4),
                                  MyText.bodySmall(
                                    Utils.getStorageStringFromByte(widget
                                            .controller
                                            .catelogue1!
                                            .bytes
                                            ?.length ??
                                        0),
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                widget.controller.catelogue2 == null
                    ? SizedBox()
                    : Row(
                        children: [
                          SizedBox(
                            width: widget.width * 0.06,
                          ),
                          MyContainer.bordered(
                            borderRadiusAll: 8,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            paddingAll: widget.heigth * 0.008,
                            child: SizedBox(
                              width: widget.heigth * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: Alignment.topRight,
                                    children: [
                                      MyContainer(
                                        height: widget.heigth * 0.08,
                                        width: widget.width * 0.08,
                                        borderRadiusAll: 8,
                                        color: Colors.grey[200],
                                        paddingAll: 0,
                                        child: Icon(LucideIcons.file, size: 20),
                                      ),
                                      MyContainer.transparent(
                                          onTap: () {
                                            setState(() {
                                              widget.controller.catelogue2 =
                                                  null;
                                              TextEditingController? cat1 =
                                                  widget
                                                      .controller.basicValidator
                                                      .getController(
                                                          'catalogue2');
                                              cat1!.clear();
                                            });
                                          },
                                          paddingAll: 4,
                                          child: Icon(LucideIcons.circle_x,
                                              color: Colors.redAccent)),
                                    ],
                                  ),
                                  MySpacing.height(8),
                                  MyText.bodySmall(
                                      widget.controller.catelogue2!.name,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: 600),
                                  MySpacing.height(4),
                                  MyText.bodySmall(
                                    Utils.getStorageStringFromByte(widget
                                            .controller
                                            .catelogue2!
                                            .bytes
                                            ?.length ??
                                        0),
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  width: widget.width * 0.02,
                ),
              ],
            ),
          ),
          MySpacing.height(widget.heigth * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                onPressed: widget.controller.clearGNDtls,
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: Colors.grey,
                borderRadiusAll: 8,
                child: MyText.bodySmall(
                  'Clear',
                  color: Colors.black,
                ),
              ),
              MySpacing.width(16),
              MyButton(
                onPressed: () {
                  setState(() {
                    // widget.controller.NewOfferValidate();
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
