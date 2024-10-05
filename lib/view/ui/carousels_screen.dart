import 'package:carousel_slider/carousel_slider.dart';
import 'package:flowkit/controller/ui/carousels_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/utils/my_shadow.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb.dart';
import 'package:flowkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flowkit/helpers/widgets/my_card.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/images.dart';
import 'package:flowkit/view/layouts/layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class CarouselsScreen extends StatefulWidget {
  const CarouselsScreen({super.key});

  @override
  State<CarouselsScreen> createState() => _CarouselsScreenState();
}

class _CarouselsScreenState extends State<CarouselsScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late CarouselsController controller;

  @override
  void initState() {
    controller = CarouselsController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Carousal",
                        fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Widgets'),
                        MyBreadcrumbItem(name: 'Carousal', active: true)
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    MyFlexItem(
                        sizes: "lg-6 md-12",
                        child: MyCard(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadiusAll: 8,
                          paddingAll: 23,
                          shadow: MyShadow(
                              elevation: .5, position: MyShadowPosition.bottom),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.titleMedium('Simple', fontWeight: 600),
                              MySpacing.height(20),
                              simpleCarousel()
                            ],
                          ),
                        )),
                    MyFlexItem(
                        sizes: "lg-6 md-12",
                        child: MyCard(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadiusAll: 8,
                          paddingAll: 23,
                          shadow: MyShadow(
                              elevation: .5, position: MyShadowPosition.bottom),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.titleMedium('Animated', fontWeight: 600),
                              MySpacing.height(20),
                              animatedCarousel()
                            ],
                          ),
                        )),
                    MyFlexItem(
                        sizes: "lg-6 md-12",
                        child: MyCard(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadiusAll: 8,
                          paddingAll: 23,
                          shadow: MyShadow(
                              elevation: .5, position: MyShadowPosition.bottom),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    'Animated With Arrow',
                                    fontWeight: 600,
                                    letterSpacing: 0,
                                  ),
                                  Spacer(),
                                  MyContainer(
                                    color: contentTheme.primary.withAlpha(32),
                                    padding: MySpacing.xy(20, 8),
                                    onTap: () => controller.onChangePreview(),
                                    child: Icon(
                                      LucideIcons.arrow_left,
                                      color: contentTheme.primary,
                                    ),
                                  ),
                                  MySpacing.width(12),
                                  MyContainer(
                                    color: contentTheme.primary.withAlpha(32),
                                    padding: MySpacing.xy(20, 8),
                                    onTap: () => controller.onChangeNext(),
                                    child: Icon(
                                      LucideIcons.arrow_right,
                                      color: contentTheme.primary,
                                    ),
                                  )
                                ],
                              ),
                              MySpacing.height(16),
                              carouselSlider(),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withAlpha(140),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }

  Widget simpleCarousel() {
    List<Widget> buildPageIndicatorStatic() {
      List<Widget> list = [];
      for (int i = 0; i < controller.simpleCarouselSize; i++) {
        list.add(i == controller.selectedSimpleCarousel
            ? indicator(true)
            : indicator(false));
      }
      return list;
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          height: 300,
          child: PageView(
            pageSnapping: true,
            scrollBehavior: AppScrollBehavior(),
            physics: ClampingScrollPhysics(),
            controller: controller.simplePageController,
            onPageChanged: controller.onChangeSimpleCarousel,
            children: <Widget>[
              MyContainer(
                borderRadiusAll: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                paddingAll: 0,
                child: Image.asset(
                  Images.authBackground,
                  fit: BoxFit.fill,
                ),
              ),
              MyContainer(
                borderRadiusAll: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                paddingAll: 0,
                child: Image.asset(
                  Images.authBackground,
                  fit: BoxFit.fill,
                ),
              ),
              MyContainer(
                borderRadiusAll: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                paddingAll: 0,
                child: Image.asset(
                  Images.authBackground,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildPageIndicatorStatic(),
          ),
        ),
      ],
    );
  }

  Widget animatedCarousel() {
    List<Widget> buildPageIndicatorStatic() {
      List<Widget> list = [];
      for (int i = 0; i < controller.animatedCarouselSize; i++) {
        list.add(i == controller.selectedAnimatedCarousel
            ? indicator(true)
            : indicator(false));
      }
      return list;
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          height: 300,
          child: PageView(
            pageSnapping: true,
            scrollBehavior: AppScrollBehavior(),
            physics: ClampingScrollPhysics(),
            controller: controller.animatedPageController,
            onPageChanged: controller.onChangeAnimatedCarousel,
            children: <Widget>[
              MyContainer(
                borderRadiusAll: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                paddingAll: 0,
                child: Image.asset(
                  Images.authBackground,
                  fit: BoxFit.fill,
                ),
              ),
              MyContainer(
                borderRadiusAll: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                paddingAll: 0,
                child: Image.asset(
                  Images.authBackground,
                  fit: BoxFit.fill,
                ),
              ),
              MyContainer(
                borderRadiusAll: 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                paddingAll: 0,
                child: Image.asset(
                  Images.authBackground,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildPageIndicatorStatic(),
          ),
        ),
      ],
    );
  }

  Widget carouselSlider() {
    Widget carouselImage(String image) {
      return MyContainer(
          borderRadiusAll: 8,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: double.infinity,
          paddingAll: 0,
          child: Image.asset(image, fit: BoxFit.cover));
    }

    return CarouselSlider(
        items: [
          carouselImage(Images.landscape[4]),
          carouselImage(Images.landscape[5]),
          carouselImage(Images.landscape[6]),
          carouselImage(Images.landscape[7]),
          carouselImage(Images.landscape[8]),
        ],
        carouselController: controller.carouselController,
        options: CarouselOptions(
          height: 300,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayCurve: Curves.decelerate,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 1200),
        ));
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
