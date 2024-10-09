import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/constants/dataBase_config.dart';
import 'package:flowkit/helpers/constants/shared_preferences.dart';
import 'package:flowkit/helpers/constants/utils.dart';
import 'package:flowkit/helpers/services/auth_service.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/helpers/widgets/my_validators.dart';
import 'package:flowkit/services/api_main/get_jwttokenapi.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends MyController {
  bool isCheckToggle = false, obscureText = false;
  MyFormValidator basicValidator = MyFormValidator();

  @override
  void onInit() {
    basicValidator.addField('customerid',
        required: true,
        label: "Customer ID",
        validators: [MyUserCodeValidator()],
        controller: TextEditingController(text: 'customerid'));
    basicValidator.addField('usercode',
        required: true,
        label: "User Code",
        validators: [MyUserCodeValidator()],
        controller: TextEditingController(text: 'usercode'));

    basicValidator.addField('password',
        required: true,
        label: "Password",
        validators: [MyLengthValidator()],
        controller: TextEditingController(text: 'password'));
    super.onInit();
  }

  void showPasswordToggle() {
    obscureText = !obscureText;
    update();
  }

  void onSelectToggle() {
    isCheckToggle = !isCheckToggle;
    update();
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        basicValidator.clearErrors();
      } else {
        String nextUrl =
            Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "")
                    .queryParameters['next'] ??
                "/dashboard/analytics";
        Get.toNamed(
          nextUrl,
        );
      }
      update();
    }
  }

  void gotoForgotPasswordScreen() {
    Get.toNamed('/auth/forgot_password');
  }

  void goToRegisterScreen() {
    Get.toNamed('/auth/register_account');
  }

  //

  RxBool ishidePassword = true.obs;
  bool isLoadBtn = false;

  List<TextEditingController> controller =
      List.generate(5, (i) => TextEditingController());

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  isVisiblity() {
    ishidePassword.value = !ishidePassword.value;
    update();
  }

  validateLogin() async {
    isLoadBtn = true;
    update();

    if (basicValidator.validateForm()) {
      await GetJWTtokenApi.callApi2(controller[0].text.toUpperCase(),
              controller[1].text, controller[2].text)
          .then((onValue) async {
        if (onValue.resCode! <= 210 && onValue.resCode! >= 200) {
          await SharedPre.setCustomerId(controller[0].text);
          await SharedPre.setUserCode(controller[1].text);
          await SharedPre.setPassword(controller[2].text);
          await SharedPre.setToken(onValue.token!);
          print(onValue.loginDtls!);
          await SharedPre.setUserid(onValue.loginDtls!.UserID);
          await SharedPre.setStoreCode(onValue.loginDtls!.storecode!);

          await SharedPre.setUserTypeid(onValue.loginDtls!.userType);

          UtilsVariables.token = onValue.token!;
          DataBaseConfig.userId = await SharedPre.getUserid();
          update();

          // print("token"+Utils.token.toString());
          // Get.snackbar(
          //     backgroundColor: Colors.green,
          //     colorText: Colors.white,
          //     'Sucessfully Login',
          //     '${onValue.resDesc}');
          await Future.delayed(Duration(seconds: 2));
          String nextUrl =
              Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "")
                      .queryParameters['next'] ??
                  "/dashboard/analytics";
          print(nextUrl);
          Get.toNamed(
            '/dashboard/analytics',
          );

          update();
        } else {
          Get.dialog(AlertBox(
            msg: '${onValue.resDesc}',
          ));
          // Get.dialog(CustomeAlertBox(
          //     title: "Alert",
          //     message: "${onValue.resDesc}",
          //     titelColor: Colors.black,
          //     messageColor: Colors.green,
          //     failure: true,
          //     success: false));
        }
      });
      // if (res.resCode! <= 210 && res.resCode! >= 200) {

      //   // update();
      // } else {

      // }
    } else {
      await Future.delayed(const Duration(seconds: 1));
    }
    isLoadBtn = false;
    update();
  }
}
