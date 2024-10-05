import 'package:flowkit/controller/pages/setup/store_controller.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class StoreDeleteAlertBox extends StatefulWidget {
  StoreDeleteAlertBox({
    super.key,
    required this.controller,
    required this.deletId,
  });
  StoreController controller;
  final int deletId;

  @override
  State<StoreDeleteAlertBox> createState() => _StoreDeleteAlertBoxState();
}

class _StoreDeleteAlertBoxState extends State<StoreDeleteAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: MySpacing.only(bottom: 16, right: 23),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      title: MyText.labelLarge("Alert"),
      content: MyText.bodyMedium('Are you sure..!!', fontWeight: 600),
      actions: [
        MyButton(
          onPressed: () => Get.back(),
          borderRadiusAll: 8,
          elevation: 0,
          padding: MySpacing.xy(20, 16),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
          child: MyText.labelMedium(
            "Cancel",
            fontWeight: 600,
            color: Colors.black,
          ),
        ),
        MyButton(
          onPressed: () {
            widget.controller.storeDeletebyId(
              widget.deletId,
            );
            Get.back();
          },
          elevation: 0,
          borderRadiusAll: 8,
          padding: MySpacing.xy(20, 16),
          backgroundColor: Theme.of(context).primaryColor,
          child: MyText.labelMedium(
            "Delete",
            fontWeight: 600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
