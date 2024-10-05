import 'package:flowkit/helpers/widgets/my_button.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AlertBox extends StatefulWidget {
  const AlertBox({super.key,required this.msg});
final msg;
  @override
  State<AlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
            actionsPadding: MySpacing.only(bottom: 16, right: 23),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            title: MyText.labelLarge("Alert"),
            content: MyText.bodyMedium(
                '${widget.msg}',
                fontWeight: 600),
            actions: [
              MyButton(
                onPressed: () => Get.back(),
                borderRadiusAll: 8,
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                child: MyText.labelLarge(
                  "Close",
                  fontWeight: 600,
                  color: Colors.black,
                ),
              ),
              // MyButton(
              //   onPressed: () => Get.back(),
              //   elevation: 0,
              //   borderRadiusAll: 8,
              //   padding: MySpacing.xy(20, 16),
              //   backgroundColor: colorScheme.primary,
              //   child: MyText.labelMedium(
              //     "Save",
              //     fontWeight: 600,
              //     color: colorScheme.onPrimary,
              //   ),
              // ),
            ],
          );
        
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actionsPadding: MySpacing.only(bottom: 16, right: 23),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            title: MyText.labelLarge("confirmation?"),
            content: MyText.bodySmall(
                "Are you sure, you want to delete history?",
                fontWeight: 600),
            actions: [
              MyButton(
                onPressed: () => Get.back(),
                borderRadiusAll: 8,
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.5),
                child: MyText.labelMedium(
                  "Close",
                  fontWeight: 600,
                  color: Colors.black,
                ),
              ),
              // MyButton(
              //   onPressed: () => Get.back(),
              //   elevation: 0,
              //   borderRadiusAll: 8,
              //   padding: MySpacing.xy(20, 16),
              //   backgroundColor: colorScheme.primary,
              //   child: MyText.labelMedium(
              //     "Save",
              //     fontWeight: 600,
              //     color: colorScheme.onPrimary,
              //   ),
              // ),
            ],
          );
        });
  }
}
