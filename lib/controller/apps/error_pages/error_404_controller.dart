import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/view/dashboard/analytics_screen.dart';
import 'package:get/get.dart';

class Error404Controller extends MyController {
  void goToDashboardScreen() {
    Get.off(AnalyticsScreen());
  }
}
