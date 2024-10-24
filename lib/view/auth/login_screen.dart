import 'dart:convert';
import 'dart:io';

import 'package:flowkit/controller/auth/login_controller.dart';
import 'package:flowkit/helpers/utils/mixins/ui_mixin.dart';
import 'package:flowkit/helpers/widgets/my_spacing.dart';
import 'package:flowkit/helpers/widgets/my_text.dart';
import 'package:flowkit/model/reponce-model.dart';
import 'package:flowkit/services/test.dart';
import 'package:flowkit/view/layouts/auth_layout.dart';
import 'package:flowkit/widgets/flow_kit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late LoginController controller;

  @override
  void initState() {
    controller = LoginController();
    super.initState();
  }

  String? temp = '', temp2 = '', temp3 = '';
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return AuthLayout(
      child: GetBuilder(
        tag: 'flowkit_login_screen',
        init: controller,
        builder: (controller) {
          return Padding(
            padding: MySpacing.x(MediaQuery.of(context).size.width * .03),
            child: Column(
              children: [
                // MyContainer(
                //     height: 40,
                //     paddingAll: 0,
                //     clipBehavior: Clip.antiAliasWithSaveLayer,
                //     child: Image.asset(Images.logo,
                //         fit: BoxFit.cover, width: 150)),
                // MySpacing.height(44),
                MySpacing.height(height * 0.05),
                // GestureDetector(
                //   onTap: () async {
                //     final response =
                //         await dio.get('https://dev.sellerkit.in:86/Products');
                //     print(response);

                //     Responce testt = await GetTetApi.getmethod(
                //         "https://maps.googleapis.com/maps/api/geocode/json?latlng=11.585224,77.221555&key=AIzaSyAdvVumVzr7teF3UDRchglwonf_vjvXtZo");
                //     setState(() {
                //       temp = '';

                //       temp = response.data.toString();
                //     });
                //   },
                //   child: Text("test1"),
                // ),
                // Text(temp!, maxLines: 2),
                // GestureDetector(
                //   onTap: () async {
                //     try {
                //       String url =
                //           "https://app.innerwheel.co.in/api/Authenticate/AuthorizationwithMobileNo";
                //       Map<String, String> headers = {
                //         "Content-Type": "application/json",
                //         // "Access-Control-Allow-Methods":
                //         //     "POST, GET, OPTIONS, PUT, DELETE, HEAD",
                //       };
                //       Map<String, dynamic> body = {
                //         "deviceCode": "string",
                //         "mobileNo": "9944900000",
                //         "fcmcode": "uihhuiuhhh"
                //       };
                //       http.Response response = await http.post(Uri.parse(url),
                //           headers: headers, body: jsonEncode(body));
                //       setState(() {
                //         temp2 = response.body.toString();
                //       });
                //     } catch (e) {
                //       setState(() {
                //         temp2 = e.toString();
                //       });
                //     }
                //   },
                //   child: Text("test2"),
                // ),
                // Text(temp2!, maxLines: 2),

                // GestureDetector(
                //   onTap: () async {
                //     String? teee = await CustomHttpClient.getData(
                //         "https://dev.sellerkit.in:86/Products");
                //     // Responce testt = await GetTetApi.getmethod(
                //     //     "https://dev.sellerkit.in:86/Products");
                //     setState(() {
                //       temp3 = '';
                //       // if (testt.resCode! <= 210) {
                //       temp3 = teee;
                //       // } else {
                //       //   temp2 = testt.responceBody;
                //       // }
                //     });
                //   },
                //   child: Text("test3*"),
                // ),
                // Text(temp3!),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Responce testt = await GetTetApi.getmethod(
                            "http://91.203.133.224:81/api/SkClientPortal/GetallMasterType");
                        setState(() {
                          temp = '';

                          temp = testt.responceBody.toString();
                        });
                        //
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Let’s',
                                style: GoogleFonts.raleway(
                                  fontSize: 25.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                )),
                            TextSpan(
                              text: ' Sign In 👇',
                              style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                MySpacing.height(height * 0.02),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {},
                      child: MyText.bodySmall(
                        'Hey, Enter your details to get sign in \nto your account.',
                        color: Colors.grey,
                        style: GoogleFonts.raleway(),
                      ),
                    ),
                  ],
                ),
                // MyText.titleLarge("Welcome Back !", fontWeight: 600),
                // MySpacing.height(12),
                // MyText.bodyMedium(
                //     "Enter your email and choose password to setup your account.",
                //     fontWeight: 600),
                // MySpacing.height(24),
                // buildFields(),
                MySpacing.height(height * 0.05),
                buildbody(height),
                MySpacing.height(height * 0.05),
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
                          onPressed: () {
                            controller.validateLogin();
                          },
                          child: controller.isLoadBtn == true
                              ? Center(
                                  child: SizedBox(
                                    width: width * 0.008,
                                    height: height * 0.01,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1,
                                    ),
                                  ),
                                )
                              : Text('Log In')),
                    )
                  ],
                )
                // Row(
                //   children: [
                //     Theme(
                //       data:
                //           ThemeData(unselectedWidgetColor: Colors.transparent),
                //       child: Checkbox(
                //         activeColor: contentTheme.primary,
                //         value: controller.isCheckToggle,
                //         onChanged: (value) => controller.onSelectToggle(),
                //         visualDensity: getCompactDensity,
                //       ),
                //     ),
                //     MySpacing.width(12),
                //     MyText.bodyMedium("Remember Me", fontWeight: 600),
                //     Spacer(),
                //     MyButton.text(
                //         onPressed: () => controller.gotoForgotPasswordScreen(),
                //         child: MyText.bodyMedium("Forgot Password?",
                //             fontWeight: 600))
                //   ],
                // ),
                // MySpacing.height(24),
                // MyButton.block(
                //     elevation: 0,
                //     borderRadiusAll: 8,
                //     padding: MySpacing.y(20),
                //     backgroundColor: contentTheme.primary,
                //     onPressed: () => controller.onLogin(),
                //     child: MyText.bodyMedium(
                //       "Login",
                //       fontWeight: 600,
                //       color: contentTheme.onPrimary,
                //     )),
                // MySpacing.height(24),
                // Row(
                //   children: [
                //     Expanded(child: Divider()),
                //     MyContainer.roundBordered(
                //         paddingAll: 0,
                //         height: 30,
                //         width: 30,
                //         child: Center(
                //             child: MyText.bodySmall("OR", fontWeight: 700))),
                //     Expanded(child: Divider()),
                //   ],
                // ),
                // MySpacing.height(24),
                // MyContainer.bordered(
                //   borderRadiusAll: 8,
                //   paddingAll: 0,
                //   height: 44,
                //   onTap: () {},
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       MyContainer(
                //         height: 20,
                //         width: 20,
                //         paddingAll: 0,
                //         clipBehavior: Clip.antiAliasWithSaveLayer,
                //         child: Image.asset(Images.google, fit: BoxFit.cover),
                //       ),
                //       MySpacing.width(12),
                //       MyText.bodyMedium("Sign up with Google", fontWeight: 600),
                //     ],
                //   ),
                // ),
                // MySpacing.height(24),
                // InkWell(
                //     onTap: () => controller.goToRegisterScreen(),
                //     child: MyText.bodyMedium(
                //       "I haven't account",
                //       fontWeight: 600,
                //     ))
              ],
            ),
          );
        },
      ),
    );
  }

  Form buildbody(double height) => Form(
      key: controller.basicValidator.formKey,
      child: Container(
        padding: EdgeInsets.all(height * 0.02),
        child: Column(
          children: [
            TextFormField(
              controller: controller.controller[0],
              validator: controller.basicValidator.getValidation('customerid'),
              onChanged: (value) {},
              decoration: const InputDecoration(
                // hintText: 'Customer ID',
                labelText: 'Customer ID',
                prefixIcon: Icon(
                  Icons.store_outlined,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              controller: controller.controller[1],
              validator: controller.basicValidator.getValidation('usercode'),
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
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              controller: controller.controller[2],
              validator: controller.basicValidator.getValidation('password'),
              onChanged: (value) {},
              obscureText: controller.ishidePassword.value,
              decoration: InputDecoration(
                  // hintText: 'Password',
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.isVisiblity();
                      },
                      icon: controller.ishidePassword.value
                          ? Icon(Icons.visibility_off_outlined)
                          : Icon(Icons.visibility_outlined))),
            ),
          ],
        ),
      ));

  Widget buildFields() {
    return Form(
      key: controller.basicValidator.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Enter Email", fontWeight: 700),
          MySpacing.height(8),
          FlowKitTextField(
            controller: controller.basicValidator.getController('email'),
            validator: controller.basicValidator.getValidation('email'),
            hintText: "Email",
          ),
          MySpacing.height(20),
          MyText.bodyMedium("Enter Password", fontWeight: 700),
          MySpacing.height(8),
          FlowKitTextField(
            controller: controller.basicValidator.getController('password'),
            validator: controller.basicValidator.getValidation('password'),
            hintText: "Password",
            obscureText: controller.obscureText,
            suffixIcon: InkWell(
              onTap: () => controller.showPasswordToggle(),
              child: Icon(
                  controller.obscureText
                      ? LucideIcons.eye_off
                      : LucideIcons.eye,
                  size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHttpClient {
  static final HttpClient client = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
        true; // Ignore self-signed certificate errors
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static Future<String> getData(String url) async {
    try {
      final request = await client.getUrl(Uri.parse(url));

      headers.forEach((key, value) {
        request.headers.set(key, value);
      });

      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return 'Error: $e';
    }
  }
}
