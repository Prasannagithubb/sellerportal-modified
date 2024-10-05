import 'package:flowkit/controller/pages/setup/setup_controller.dart';
import 'package:flowkit/controller/pages/user_configuration/restriction_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flowkit/services/pages/user_configuration/getRestriction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class AddUpdateRestrictionBox extends StatefulWidget {
  AddUpdateRestrictionBox(
      {super.key,
      required this.controller,
      required this.height,
      required this.width,
      required this.title,
      required this.mastertypeId,
      required this.type,
      this.id,
      this.data});

  RestrictionController controller;
  final double width;
  final double height;
  final String title;
  final int mastertypeId;
  final int? id;
  final String type;
  final RestrictionData? data;

  @override
  State<AddUpdateRestrictionBox> createState() =>
      _AddUpdateRestrictionBoxState();
}

class _AddUpdateRestrictionBoxState extends State<AddUpdateRestrictionBox>
    with TickerProviderStateMixin, UIMixin {
  @override
  void initState() {
    initmethod();
    super.initState();
  }

  initmethod() async {
    if (widget.type == "Update") {
      setState(() {
        var locationData;
        if (widget.data!.restrictionType == 2) {
          locationData = widget.data!.restrictionData!.split(',');
        }
        widget.controller.basicValidator.getController('code')!.text =
            widget.data!.code!;
        widget.controller.basicValidator.getController('remarks')!.text =
            widget.data!.remarks!;
        widget.controller.valueUsertype = widget.data!.restrictionType == 1
            ? "IP"
            : widget.data!.restrictionType == 2
                ? "Location"
                : "SS Id";
        widget.controller.basicValidator.getController('ip')!.text =
            widget.data!.restrictionType == 1
                ? widget.data!.restrictionData!
                : '';
        widget.controller.basicValidator.getController('ssid')!.text =
            widget.data!.restrictionType == 3
                ? widget.data!.restrictionData!
                : '';
        widget.controller.basicValidator.getController('longitude')!.text =
            locationData != null ? locationData[0] : '';
        widget.controller.basicValidator.getController('latitude')!.text =
            locationData != null ? locationData[1] : '';
        widget.controller.basicValidator.getController('distance')!.text =
            locationData != null ? locationData[2] : '';
      });
    }
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MyCard(
      borderRadiusAll: 8,
      height: widget.height * 0.5,
      width: widget.width,
      // paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: Form(
        key: widget.controller.formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.titleMedium(
                  "${widget.title}",
                  fontWeight: 600,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                      // controller.clearGNDtls();
                    },
                    icon: Icon(
                      LucideIcons.square_x,
                      color: Colors.grey,
                    ))
              ],
            ),
            MySpacing.height(widget.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: widget.width / 2.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium('Code *'),
                      MySpacing.height(8),
                      CommonValidationForm(
                        hintText: "",
                        // icon: LucideIcons.user,
                        validator: widget.controller.basicValidator
                            .getValidation('code'),
                        controller: widget.controller.basicValidator
                            .getController('code'),
                        outlineInputBorder: outlineInputBorder,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.width / 2.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium('User Type *'),
                      MySpacing.height(8),
                      DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          // isDense: true,
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                                value: "IP", child: MyText.bodySmall('IP')),
                            DropdownMenuItem(
                                value: "SS Id",
                                child: MyText.bodySmall('SS Id')),
                            DropdownMenuItem(
                                value: "Location",
                                child: MyText.bodySmall('Location')),
                          ],
                          value: widget.controller.valueUsertype,
                          onChanged: (value) {
                            setState(() {
                              widget.controller.valueUsertype = value;
                            });
                          },
                          validator: widget.controller.basicValidator
                              .getValidation('usertype'),
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never))
                    ],
                  ),
                ),
              ],
            ),
            MySpacing.height(widget.height * 0.01),
            widget.controller.valueUsertype == "IP"
                ? ipFields()
                : widget.controller.valueUsertype == "SS Id"
                    ? ssIdFields()
                    : widget.controller.valueUsertype == "Location"
                        ? SizedBox(
                            width: widget.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: widget.width,
                                  child: MyFlex(
                                      wrapAlignment: WrapAlignment.spaceEvenly,
                                      wrapCrossAlignment:
                                          WrapCrossAlignment.start,
                                      runAlignment: WrapAlignment.start,
                                      spacing: 0,
                                      children: [
                                        MyFlexItem(
                                          sizes: 'xl-2 lg-4 md-6 sm-12',
                                          child: SizedBox(
                                            width: widget.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText.bodyMedium(
                                                    'Longitude *'),
                                                MySpacing.height(8),
                                                CommonValidationForm(
                                                  hintText: "",
                                                  // icon: LucideIcons.user,
                                                  validator: widget
                                                      .controller.basicValidator
                                                      .getValidation(
                                                          'longitude'),
                                                  controller: widget
                                                      .controller.basicValidator
                                                      .getController(
                                                          'longitude'),
                                                  outlineInputBorder:
                                                      outlineInputBorder,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        MyFlexItem(
                                          sizes: 'xl-2 lg-4 md-6 sm-12',
                                          child: SizedBox(
                                            // width: widget.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText.bodyMedium('Latitude *'),
                                                MySpacing.height(8),
                                                CommonValidationForm(
                                                  hintText: "",
                                                  // icon: LucideIcons.user,
                                                  validator: widget
                                                      .controller.basicValidator
                                                      .getValidation(
                                                          'latitude'),
                                                  controller: widget
                                                      .controller.basicValidator
                                                      .getController(
                                                          'latitude'),
                                                  outlineInputBorder:
                                                      outlineInputBorder,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        MyFlexItem(
                                          sizes: 'xl-2 lg-4 md-6 sm-12',
                                          child: SizedBox(
                                            // width: widget.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText.bodyMedium('Distance *'),
                                                MySpacing.height(8),
                                                CommonValidationForm(
                                                  hintText: "",
                                                  // icon: LucideIcons.user,
                                                  validator: widget
                                                      .controller.basicValidator
                                                      .getValidation(
                                                          'distance'),
                                                  controller: widget
                                                      .controller.basicValidator
                                                      .getController(
                                                          'distance'),
                                                  outlineInputBorder:
                                                      outlineInputBorder,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        MyFlexItem(
                                          sizes: 'xl-2 lg-4 md-6 sm-12',
                                          child: SizedBox(
                                            // width: widget.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [],
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                                MySpacing.height(widget.height * 0.01),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: widget.width / 2.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText.bodyMedium('Remarks'),
                                          MySpacing.height(8),
                                          CommonValidationForm(
                                            hintText: "",
                                            // icon: LucideIcons.user,
                                            validator: widget
                                                .controller.basicValidator
                                                .getValidation('remarks'),
                                            controller: widget
                                                .controller.basicValidator
                                                .getController('remarks'),
                                            outlineInputBorder:
                                                outlineInputBorder,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: widget.width / 2.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
            MySpacing.height(widget.height * 0.02),
            SizedBox(
              width: widget.width / 2.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                      onPressed: widget.type == 'Add'
                          ? () {
                              setState(() {
                                widget.controller.validateFianl();
                              });
                            }
                          : () {
                              setState(() {
                                widget.controller.validateUpdateFianl();
                              });
                            },
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: theme.primaryColor,
                      borderRadiusAll: 5,
                      child: widget.type == 'Add'
                          ? (widget.controller.isLoadAdd == true)
                              ? Center(
                                  child: SizedBox(
                                    width: widget.width * 0.003,
                                    height: widget.height * 0.008,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1,
                                    ),
                                  ),
                                )
                              : MyText.bodySmall(
                                  'Add',
                                  color: Colors.white,
                                )
                          : (widget.controller.isLoadUpdated == true)
                              ? Center(
                                  child: SizedBox(
                                    width: widget.width * 0.003,
                                    height: widget.height * 0.008,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1,
                                    ),
                                  ),
                                )
                              : MyText.bodySmall(
                                  'Update',
                                  color: Colors.white,
                                )),
                  SizedBox(
                    width: widget.width * 0.08,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row ipFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: widget.width / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium('IP *'),
              MySpacing.height(8),
              CommonValidationForm(
                hintText: "",
                // icon: LucideIcons.user,
                validator: widget.controller.basicValidator.getValidation('ip'),
                controller:
                    widget.controller.basicValidator.getController('ip'),
                outlineInputBorder: outlineInputBorder,
              ),
            ],
          ),
        ),
        SizedBox(
          width: widget.width / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium('Remarks'),
              MySpacing.height(8),
              CommonValidationForm(
                hintText: "",
                // icon: LucideIcons.user,
                validator:
                    widget.controller.basicValidator.getValidation('remarks'),
                controller:
                    widget.controller.basicValidator.getController('remarks'),
                outlineInputBorder: outlineInputBorder,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row ssIdFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: widget.width / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium('SS Id *'),
              MySpacing.height(8),
              CommonValidationForm(
                hintText: "",
                // icon: LucideIcons.user,
                validator:
                    widget.controller.basicValidator.getValidation('ssid'),
                controller:
                    widget.controller.basicValidator.getController('ssid'),
                outlineInputBorder: outlineInputBorder,
              ),
            ],
          ),
        ),
        SizedBox(
          width: widget.width / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium('Remarks'),
              MySpacing.height(8),
              CommonValidationForm(
                hintText: "",
                // icon: LucideIcons.user,
                validator:
                    widget.controller.basicValidator.getValidation('remarks'),
                controller:
                    widget.controller.basicValidator.getController('remarks'),
                outlineInputBorder: outlineInputBorder,
              ),
            ],
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
