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

class NewItemAdd extends StatefulWidget {
  const NewItemAdd(
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
  State<NewItemAdd> createState() => _NewItemAddState();
}

class _NewItemAddState extends State<NewItemAdd> {
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
                    "Add Item",
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
                      fontWeight: widget.controller.softIndex == 0 ? 600 : 500,
                      color: widget.controller.softIndex == 0
                          ? Colors.black
                          : null,
                    ),
                  ),
                  Tab(
                    icon: MyText.bodyMedium(
                      "Other Details",
                      fontWeight: widget.controller.softIndex == 1 ? 600 : 500,
                      color: widget.controller.softIndex == 1
                          ? Colors.black
                          : null,
                    ),
                  ),
                  Tab(
                    icon: MyText.bodyMedium(
                      "Attachments",
                      fontWeight: widget.controller.softIndex == 2 ? 600 : 500,
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
                    _generalDtls(theme),
                    otherDetails(theme),
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
                    MyText.bodyMedium('Item Code *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('itemcode'),
                      controller: widget.controller.basicValidator
                          .getController('itemcode'),
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
                    MyText.bodyMedium('Item Name *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('itemname'),
                      controller: widget.controller.basicValidator
                          .getController('itemname'),
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
                    MyText.bodyMedium('Item Group'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('itemgroup'),
                      controller: widget.controller.basicValidator
                          .getController('itemgroup'),
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
                    MyText.bodyMedium('Item Description'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('itemdesc'),
                      controller: widget.controller.basicValidator
                          .getController('itemdesc'),
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
                    MyText.bodyMedium('Sub Category *'),
                    MySpacing.height(8),
                    DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        // isDense: true,
                        items: widget.controller.subCategorylist
                            .map<DropdownMenuItem<String>>(
                          (e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: MyText.bodySmall(e),
                            );
                          },
                        ).toList(),
                        value: widget.controller.subCategory,
                        onChanged: (value) {
                          widget.controller.subCategory = value;
                        },
                        validator: widget.controller.basicValidator
                            .getValidation('subcategory'),
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
                    MyText.bodyMedium('Brand Code'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('brandcode'),
                      controller: widget.controller.basicValidator
                          .getController('brandcode'),
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
                    MyText.bodyMedium('Specification'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('specification'),
                      controller: widget.controller.basicValidator
                          .getController('specification'),
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
                    MyText.bodyMedium('SKU Code'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('skucode'),
                      controller: widget.controller.basicValidator
                          .getController('skucode'),
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
                    MyText.bodyMedium('Model No'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('modelno'),
                      controller: widget.controller.basicValidator
                          .getController('modelno'),
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
                    MyText.bodyMedium('Part Code '),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('partcode'),
                      controller: widget.controller.basicValidator
                          .getController('partcode'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                onPressed: widget.controller.clearGNDtls,
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
                    widget.controller.newItemAddValidate();
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
    );
  }

  SingleChildScrollView otherDetails(ThemeData theme) {
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
                    MyText.bodyMedium('Size Capacity *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('sizecapacity'),
                      controller: widget.controller.basicValidator
                          .getController('sizecapacity'),
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
                    MyText.bodyMedium('Colour *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('colour'),
                      controller: widget.controller.basicValidator
                          .getController('colour'),
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
                    MyText.bodyMedium('Clasification *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('clasification'),
                      controller: widget.controller.basicValidator
                          .getController('clasification'),
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
                    MyText.bodyMedium('UoM'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('uom'),
                      controller:
                          widget.controller.basicValidator.getController('uom'),
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
                    MyText.bodyMedium('Tax Rate *'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "0.00",
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      // icon: LucideIcons.user,
                      validator: widget.controller.basicValidator
                          .getValidation('taxrate'),
                      controller: widget.controller.basicValidator
                          .getController('taxrate'),
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
                    MyText.bodyMedium('Text Note'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "",
                      // icon: LucideIcons.user,
                      // validator: widget.controller.basicValidator
                      //     .getValidation('portcode'),
                      controller: widget.controller.basicValidator
                          .getController('textnote'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                onPressed: widget.controller.clearGNDtls,
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
                    widget.controller.newItemAddValidate();
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
    );
  }

  SingleChildScrollView uploadFile() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: widget.width / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium('Catalogue 1'),
                    MySpacing.height(8),
                    CommonValidationForm(
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
                    MyText.bodyMedium('Catalogue 2'),
                    MySpacing.height(8),
                    CommonValidationForm(
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
                    MyText.bodyMedium('Link 1'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "Choose File",
                      icon: LucideIcons.upload,
                      iconOnPressed: () async {
                        try {
                          var result = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: widget.controller.type);
                          if (result?.files.isNotEmpty ?? false) {
                            setState(() {
                              widget.controller.link1 = result!.files[0];
                            });
                          }
                          TextEditingController? cat1 = widget
                              .controller.basicValidator
                              .getController('link1');
                          cat1!.text = '${widget.controller.link1!.name}';
                        } catch (e) {
                          Get.dialog(AlertBox(msg: '$e'));
                        }

                        // print(cat1!.text.toString());
                      },
                      // validator: widget.controller.basicValidator
                      //     .getValidation('colour'),
                      controller: widget.controller.basicValidator
                          .getController('link1'),
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
                    MyText.bodyMedium('Link 2'),
                    MySpacing.height(8),
                    CommonValidationForm(
                      hintText: "Choose File",
                      icon: LucideIcons.upload,
                      iconOnPressed: () async {
                        try {
                          var result = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: widget.controller.type);
                          if (result?.files.isNotEmpty ?? false) {
                            setState(() {
                              widget.controller.link2 = result!.files[0];
                            });
                          }
                          TextEditingController? cat1 = widget
                              .controller.basicValidator
                              .getController('link2');
                          cat1!.text = '${widget.controller.link2!.name}';
                        } catch (e) {
                          Get.dialog(AlertBox(msg: '$e'));
                        }

                        // print(cat1!.text.toString());
                      },
                      // validator: widget.controller.basicValidator
                      //     .getValidation('colour'),
                      controller: widget.controller.basicValidator
                          .getController('link2'),
                      outlineInputBorder: widget.outlineInputBorder,
                    ),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(widget.heigth * 0.01),

          // MyContainer.bordered(
          //   borderRadiusAll: 8,
          //   clipBehavior: Clip.antiAliasWithSaveLayer,
          //   onTap: () async {
          //     // setState(() {
          //     //   widget.controller.pickFiles();
          //     // });
          //   },
          //   paddingAll: 23,
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       var result = await FilePicker.platform.pickFiles(
          //           allowMultiple: widget.controller.selectMultipleFile,
          //           type: widget.controller.type);
          //       if (result?.files.isNotEmpty ?? false) {
          //         setState(() {
          //           widget.controller.files.addAll(result!.files);
          //         });
          //       }
          //       print(widget.controller.files.length);
          //     },
          //     child: Center(
          //       heightFactor: 1.5,
          //       child: Padding(
          //         padding: MySpacing.all(8),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Icon(LucideIcons.folder_up),
          //             MySpacing.height(12),
          //             MyContainer(
          //               width: 340,
          //               alignment: Alignment.center,
          //               paddingAll: 0,
          //               child: MyText.titleMedium(
          //                 "Drop files here or click to upload.",
          //                 fontWeight: 600,
          //                 muted: true,
          //                 fontSize: 18,
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //             MyContainer(
          //               alignment: Alignment.center,
          //               width: 610,
          //               child: MyText.titleMedium(
          //                 "(This is just a demo dropzone. Selected files are not actually uploaded.)",
          //                 muted: true,
          //                 fontWeight: 500,
          //                 fontSize: 16,
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // widget.controller.files.isNotEmpty
          //     ?
          SizedBox(
            width: widget.width,
            height: widget.heigth * 0.18,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                widget.controller.catelogue1 == null
                    ? SizedBox()
                    : Row(
                        children: [
                          SizedBox(
                            width: widget.width * 0.04,
                          ),
                          MyContainer.bordered(
                            borderRadiusAll: 8,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            paddingAll: widget.heigth * 0.008,
                            child: SizedBox(
                              width: widget.width * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: Alignment.topRight,
                                    children: [
                                      MyContainer(
                                        height: widget.heigth * 0.1,
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
                                  MyText.bodyMedium(
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
                            width: widget.width * 0.02,
                          ),
                          MyContainer.bordered(
                            borderRadiusAll: 8,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            paddingAll: widget.heigth * 0.008,
                            child: SizedBox(
                              width: widget.width * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: Alignment.topRight,
                                    children: [
                                      MyContainer(
                                        height: widget.heigth * 0.1,
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
                                  MyText.bodyMedium(
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
                widget.controller.link1 == null
                    ? SizedBox()
                    : Row(
                        children: [
                          SizedBox(
                            width: widget.width * 0.02,
                          ),
                          MyContainer.bordered(
                            borderRadiusAll: 8,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            paddingAll: widget.heigth * 0.008,
                            child: SizedBox(
                              width: widget.width * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: Alignment.topRight,
                                    children: [
                                      MyContainer(
                                        height: widget.heigth * 0.1,
                                        width: widget.width * 0.08,
                                        borderRadiusAll: 8,
                                        color: Colors.grey[200],
                                        paddingAll: 0,
                                        child: Icon(LucideIcons.file, size: 20),
                                      ),
                                      MyContainer.transparent(
                                          onTap: () {
                                            setState(() {
                                              widget.controller.link1 = null;
                                              TextEditingController? cat1 =
                                                  widget
                                                      .controller.basicValidator
                                                      .getController('link1');
                                              cat1!.clear();
                                            });
                                          },
                                          paddingAll: 4,
                                          child: Icon(LucideIcons.circle_x,
                                              color: Colors.redAccent)),
                                    ],
                                  ),
                                  MySpacing.height(8),
                                  MyText.bodyMedium(
                                      widget.controller.link1!.name,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: 600),
                                  MySpacing.height(4),
                                  MyText.bodySmall(
                                    Utils.getStorageStringFromByte(widget
                                            .controller.link1!.bytes?.length ??
                                        0),
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                widget.controller.link2 == null
                    ? SizedBox()
                    : Row(
                        children: [
                          SizedBox(
                            width: widget.width * 0.02,
                          ),
                          MyContainer.bordered(
                            borderRadiusAll: 8,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            paddingAll: widget.heigth * 0.008,
                            child: SizedBox(
                              width: widget.width * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    alignment: Alignment.topRight,
                                    children: [
                                      MyContainer(
                                        height: widget.heigth * 0.1,
                                        width: widget.width * 0.08,
                                        borderRadiusAll: 8,
                                        color: Colors.grey[200],
                                        paddingAll: 0,
                                        child: Icon(LucideIcons.file, size: 20),
                                      ),
                                      MyContainer.transparent(
                                          onTap: () {
                                            setState(() {
                                              widget.controller.link2 = null;
                                              TextEditingController? cat1 =
                                                  widget
                                                      .controller.basicValidator
                                                      .getController('link2');
                                              cat1!.clear();
                                            });
                                          },
                                          paddingAll: 4,
                                          child: Icon(LucideIcons.circle_x,
                                              color: Colors.redAccent)),
                                    ],
                                  ),
                                  MySpacing.height(8),
                                  MyText.bodyMedium(
                                      widget.controller.link2!.name,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: 600),
                                  MySpacing.height(4),
                                  MyText.bodySmall(
                                    Utils.getStorageStringFromByte(widget
                                            .controller.link2!.bytes?.length ??
                                        0),
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          )
          // : SizedBox()
        ],
      ),
    );
  }
}
