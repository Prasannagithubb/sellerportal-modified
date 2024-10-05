import 'package:flowkit/controller/pages/setup/setup_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class SetupAddCommonScreen extends StatefulWidget {
  SetupAddCommonScreen(
      {super.key,
      required this.controller,
      required this.height,
      required this.width,
      required this.title,
      required this.mastertypeId,
      required this.type,
      this.id,
      this.code,
      this.description,
      this.status});

  SetUpController controller;
  final double width;
  final double height;
  final String title;
  final int mastertypeId;
  final int? id;
  final String type;
  final String? code;
  final String? description;
  final int? status;

  @override
  State<SetupAddCommonScreen> createState() => _SetupAddCommonScreenState();
}

class _SetupAddCommonScreenState extends State<SetupAddCommonScreen>
    with TickerProviderStateMixin, UIMixin {
  @override
  void initState() {
    initmethod();
    super.initState();
  }

  initmethod() async {
    if (widget.type == "Update") {
      setState(() {
        widget.controller.basicValidator.getController('code')!.text =
            widget.code!;
        widget.controller.basicValidator.getController('description')!.text =
            widget.description!;
        if (widget.status == 1) {
          widget.controller.status = true;
        } else {
          widget.controller.status = false;
        }
      });
    }
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MyCard(
      borderRadiusAll: 8,
      height: widget.height * 0.4,
      width: widget.width / 2,
      // paddingAll: 23,
      shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
      child: Form(
        key: widget.controller.formkey,
        child: Column(
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
            MySpacing.height(10),
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

                    outlineInputBorder: outlineInputBorder,
                    controller:
                        widget.controller.basicValidator.getController('code'),
                    validator:
                        widget.controller.basicValidator.getValidation('code'),
                  ),
                ],
              ),
            ),
            MySpacing.height(10),
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

                    outlineInputBorder: outlineInputBorder,
                    controller: widget.controller.basicValidator
                        .getController('description'),
                    validator: widget.controller.basicValidator
                        .getValidation('description'),
                  ),
                ],
              ),
            ),
            MySpacing.height(10),
            SizedBox(
              width: widget.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyText.labelLarge("Status"),
                  Switch(
                    onChanged: (bool vval) {
                      setState(() {
                        widget.controller.changestatus(vval);
                      });
                    },
                    value: widget.controller.status,
                    activeColor: theme.colorScheme.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ),
            MySpacing.height(10),
            SizedBox(
              width: widget.width / 2.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                      onPressed: widget.type == 'Add'
                          ? () {
                              setState(() {
                                widget.controller
                                    .validateAddMasters(widget.mastertypeId);
                              });
                            }
                          : () {
                              setState(() {
                                widget.controller.validateUpdateMasters(
                                    widget.mastertypeId, widget.id!);
                              });
                            },
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: theme.primaryColor,
                      borderRadiusAll: 5,
                      child: widget.type == 'Add'
                          ? (widget.controller.isLoadAdd == true)
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : MyText.bodySmall(
                                  'Add',
                                  color: Colors.white,
                                )
                          : (widget.controller.isLoadUpdated == true)
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : MyText.bodySmall(
                                  'Update',
                                  color: Colors.white,
                                )),
                ],
              ),
            ),
          ],
        ),
      ),
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
