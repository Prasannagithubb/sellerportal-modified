import 'package:flowkit/controller/pages/pre_sales/customerdata_controller.dart';
import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAlertBoxCustomer extends StatefulWidget {
  DeleteAlertBoxCustomer({
    super.key,
    required this.controller,
    required this.deletId,
  });
  CustomerDataController controller;
  final int deletId;

  @override
  State<DeleteAlertBoxCustomer> createState() => _DeleteAlertBoxCustomerState();
}

class _DeleteAlertBoxCustomerState extends State<DeleteAlertBoxCustomer> {
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
            widget.controller.deleteApi(widget.deletId);
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
