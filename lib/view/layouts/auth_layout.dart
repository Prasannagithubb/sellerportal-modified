import 'package:flowkit/controller/layout/auth_layout_controller.dart';
import 'package:flowkit/helpers/theme/app_theme.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_container.dart';
import 'package:flowkit/helpers/widgets/my_flex.dart';
import 'package:flowkit/helpers/widgets/my_flex_item.dart';
import 'package:flowkit/helpers/widgets/my_responsive.dart';
import 'package:flowkit/helpers/widgets/my_screen_media_type.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/images.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthLayout extends StatefulWidget {
  final Widget? child;

  AuthLayout({super.key, this.child});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> with UIMixin {
  final AuthLayoutController controller = AuthLayoutController();

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isMobile
                ? mobileScreen(context)
                : largeScreen(context);
          });
    });
  }

  Widget mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Container(
        padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
        height: MediaQuery.of(context).size.height,
        color: theme.cardTheme.color,
        child: SingleChildScrollView(
          key: controller.scrollKey,
          child: widget.child,
        ),
      ),
    );
  }

  Widget largeScreen(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            // Stack(
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   fit: StackFit.expand,
            //   children: [
            //     Image.asset(
            //       Images.authBackground,
            //       fit: BoxFit.cover,
            //     ),
            //     Container(color: Colors.black.withOpacity(.6))
            //   ],
            // ),
            // Positioned.fill(
            //   child: FloatingBubbles.alwaysRepeating(
            //     noOfBubbles: 100,
            //     colorsOfBubbles: [
            //       Colors.green,
            //       Colors.red,
            //       Colors.lightGreenAccent,
            //     ],
            //     sizeFactor: 0.010,
            //     paintingStyle: PaintingStyle.fill,
            //     shape: BubbleShape.roundedRectangle,
            //     speed: BubbleSpeed.slow,
            //   ),
            // ),
            Container(
              margin: MySpacing.top(height * 0.13),
              width: MediaQuery.of(context).size.width,
              child: MyFlex(
                wrapAlignment: WrapAlignment.center,
                wrapCrossAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.center,
                spacing: 0,
                runSpacing: 0,
                children: [
                  MyFlexItem(
                    sizes: "xxl-8 lg-8 md-9 sm-10",
                    child: MyContainer(
                      padding: EdgeInsets.zero,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200]!,
                            spreadRadius: 5,
                            blurRadius: 5)
                      ],
                      // borderRadiusAll: 0,
                      height: MediaQuery.of(context).size.height / 1.3,
                      clipBehavior: Clip.none,
                      child: MyFlex(
                          wrapAlignment: WrapAlignment.center,
                          wrapCrossAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.center,
                          runSpacing: 0,
                          contentPadding: false,
                          children: [
                            // MyFlexItem(
                            //   sizes: "lg-6",
                            //   child: MyResponsive(
                            //     builder: (_, __, type) {
                            //       return type == MyScreenMediaType.xxl ||
                            //               type == MyScreenMediaType.xl ||
                            //               type == MyScreenMediaType.lg
                            //           ? flexImage()
                            //           : const SizedBox();
                            //     },
                            //   ),
                            // ),
                            _leftbody(width / 2, height / 1.3, theme),
                            // _rightbody(width, height / 1.3)
                            MyFlexItem(
                                    sizes: "lg-6",

                              child: widget.child!
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  MyFlexItem _rightbody(double width, double height) {
    TextStyle ralewayStyle = GoogleFonts.raleway();
    const Color blueDarkColor = Color(0xff252B5C);
    const Color textColor = Color(0xff53587A);
    return MyFlexItem(
      sizes: "lg-6",
      child: Container(
        width: width / 2,
        height: height,
        padding: const EdgeInsets.all(50),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            color: Colors.white),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset(
                  //   'assets/images/SKLogo.png',
                  //   scale: 4,
                  // ),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Let’s',
                            style: ralewayStyle.copyWith(
                              fontSize: 25.0,
                              color: blueDarkColor,
                              fontWeight: FontWeight.normal,
                            )),
                        TextSpan(
                          text: ' Sign In 👇',
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w800,
                            color: blueDarkColor,
                            fontSize: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Hey, Enter your details to get sign in \nto your account.',
                    style: ralewayStyle.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        // hintText: 'Customer ID',
                        labelText: 'Customer ID',
                        prefixIcon: Icon(
                          Icons.store_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        // hintText: 'User Code',
                        labelText: 'User Code',
                        // suffixIcon: Icon(
                        //   Icons.mail_outline,
                        // ),
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                          // hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: Icon(Icons.visibility_outlined)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Colors.green,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.white.withOpacity(.32);
                          }
                          return Colors.grey[200]!;
                        }),
                        visualDensity: const VisualDensity(
                            horizontal: -4.0, vertical: -4.0),
                        value: true,
                        onChanged: (value) {
                          setState(() {
                            // prdlog.setTermsAConditionsValue(
                            //     value);
                            // _acceptTerms = value ?? false;
                          });
                        },
                      ),
                      const Text('I accept the '),
                      InkWell(
                        onTap: () async {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           pdfViwer()),
                          // );
                          // await showDialog<dynamic>(

                          //     context: context,
                          //     builder: (_) {
                          //       return TermsAndConditionsBox();
                          //     });
                        },
                        child: const Text(
                          'Terms and Conditions',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 4,
                              blurRadius: 5)
                        ],
                        // borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          Color(0xFF750537),
                          Color.fromARGB(255, 207, 127, 163),
                        ])),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shape: const BeveledRectangleBorder()),
                        onPressed: () {},
                        child: const Text('Log In')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  MyFlexItem _leftbody(double width, double height, ThemeData theme) {
    return MyFlexItem(
      sizes: "lg-6",
      child: MyResponsive(builder: (_, __, type) {
        return type != MyScreenMediaType.xxl &&
                type != MyScreenMediaType.xl &&
                type != MyScreenMediaType.lg
            ? SizedBox()
            : Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                    )
                  ],
                  color: Color(0xFF750537),
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo/loginBack.png'),
                      fit: BoxFit.fill,
                      opacity: 0.9),
                ),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo/Sellerkit-Logo.png',
                        scale: 3,
                      ),
                      SizedBox(
                        height: height * 0.08,
                      ),
                      SizedBox(
                        width: width,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.amberAccent,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Quick and Fre SignUp ",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                    SizedBox(
                                      width: width / 2,
                                      child: Text(
                                        "Enter your email address to create an account",
                                        style:
                                            theme.textTheme.bodySmall!.copyWith(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.amberAccent,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Automate your work",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                    SizedBox(
                                      width: width / 2,
                                      child: Text(
                                        "Focus on bringing sales while Sellerkit while manage all the test",
                                        style:
                                            theme.textTheme.bodySmall!.copyWith(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.amberAccent,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Something for everyone",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                    SizedBox(
                                      width: width / 2,
                                      child: Text(
                                        "Focus on bringing sales while Sellerkit while manage all the test",
                                        style:
                                            theme.textTheme.bodySmall!.copyWith(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  MyFlexItem flexImage() {
    return MyFlexItem(
        sizes: "lg-6",
        child: MyContainer(
          paddingAll: 0,
          borderRadiusAll: 8,
          height: MediaQuery.of(context).size.height * .7,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              Image.asset(
                Images.authBackground,
                fit: BoxFit.cover,
              ),
              animatedCarousel(),
            ],
          ),
        ));
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 100,
          child: Padding(
            padding: MySpacing.x(70),
            child: PageView(
              pageSnapping: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              scrollBehavior: AppScrollBehavior(),
              physics: ClampingScrollPhysics(),
              controller: controller.animatedPageController,
              onPageChanged: controller.onChangeAnimatedCarousel,
              children: <Widget>[
                MyText.bodySmall(
                  controller.dummyTexts[4],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: contentTheme.light,
                  fontWeight: 600,
                  letterSpacing: 1,
                ),
                MyText.bodySmall(
                  controller.dummyTexts[5],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: contentTheme.light,
                  fontWeight: 600,
                  letterSpacing: 1,
                ),
                MyText.bodySmall(
                  controller.dummyTexts[6],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: contentTheme.light,
                  fontWeight: 600,
                  letterSpacing: 1,
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildPageIndicatorStatic(),
        ),
        MySpacing.height(20),
      ],
    );
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withAlpha(140),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
