import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/view/dashboard/analytics_screen.dart';
import 'package:get/get.dart';

class Error500Controller extends MyController {
  void goToDashboardScreen() {
    Get.off(AnalyticsScreen());
  }
}
