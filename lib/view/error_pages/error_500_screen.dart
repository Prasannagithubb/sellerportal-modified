import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flowkit/controller/apps/error_pages/error_500_controller.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Error500Screen extends StatefulWidget {
  const Error500Screen({super.key});

  @override
  State<Error500Screen> createState() => _Error500ScreenState();
}

class _Error500ScreenState extends State<Error500Screen>
    with SingleTickerProviderStateMixin, UIMixin {
  late Error500Controller controller;

  @override
  void initState() {
    controller = Error500Controller();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      tag: 'error_500_controller',
      builder: (controller) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                fit: StackFit.expand,
                children: [
                  Image.asset(Images.authBackground, fit: BoxFit.cover),
                  Container(color: Colors.black.withOpacity(.6))
                ],
              ),
              Positioned.fill(
                child: FloatingBubbles.alwaysRepeating(
                  noOfBubbles: 100,
                  colorsOfBubbles: [
                    Colors.green,
                    Colors.red,
                    Colors.lightGreenAccent,
                  ],
                  sizeFactor: 0.010,
                  paintingStyle: PaintingStyle.fill,
                  shape: BubbleShape.roundedRectangle,
                  speed: BubbleSpeed.slow,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText.displayMedium("500",
                      fontWeight: 600,
                      fontSize: 200,
                      color: contentTheme.onPrimary,
                      textAlign: TextAlign.center),
                  MyText.displayMedium("Internal server error!",
                      fontWeight: 600,
                      color: contentTheme.onPrimary,
                      textAlign: TextAlign.center),
                  MySpacing.height(40),
                  MyText.headlineMedium(
                      "The Server has been deserted for a while. Please be patient or try again",
                      fontWeight: 600,
                      color: contentTheme.onPrimary,
                      textAlign: TextAlign.center),
                  MySpacing.height(40),
                  MyContainer(
                    onTap: () => controller.goToDashboardScreen(),
                    borderRadiusAll: 8,
                    color: contentTheme.primary,
                    height: 44,
                    width: 200,
                    paddingAll: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Center(
                        child: MyText.bodyLarge(
                      "Come back later",
                      color: contentTheme.onPrimary,
                    )),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}