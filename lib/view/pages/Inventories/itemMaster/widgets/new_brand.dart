import 'package:flowkit/controller/pages/inventory/itemmaster_controller.dart';
import 'package:flowkit/helpers/theme/admin_theme.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/view/pages/Inventories/itemMaster/screens/itemmaster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class NewBrand extends StatefulWidget {
  const NewBrand(
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
  State<NewBrand> createState() => _NewBrandState();
}

class _NewBrandState extends State<NewBrand> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MyCard(
        borderRadiusAll: 8,
        // height: widget.heigth * 0.28,
        width: widget.width / 2.4,
        // paddingAll: 23,
        shadow: MyShadow(position: MyShadowPosition.bottom, elevation: .5),
        child: Form(
          key: widget.controller.formkey[1],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Add Brand",
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
                MySpacing.height(widget.heigth * 0.01),
                SizedBox(
                  width: widget.width / 2.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.bodyMedium('Brand'),
                      MySpacing.height(8),
                      CommonValidationForm(
                        hintText: "",
                        // icon: LucideIcons.user,
                        validator: widget.controller.basicValidator
                            .getValidation('newbrand'),
                        controller: widget.controller.basicValidator
                            .getController('newbrand'),
                        outlineInputBorder: widget.outlineInputBorder,
                      ),
                    ],
                  ),
                ),
                MySpacing.height(widget.heigth * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                      onPressed: () {
                        setState(() {
                          widget.controller.newBrandAddValidate();
                        });
                      },
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: theme.primaryColor,
                      borderRadiusAll: 5,
                      child: MyText.bodySmall(
                        'Add Brand',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
