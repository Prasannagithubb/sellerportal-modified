import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_form_validator.dart';
import 'package:flowkit/services/pages/setups/feeds_api.dart';
import 'package:flowkit/widgets/alertdialog_box.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FeedsController extends MyController {
  @override
  void onInit() {
    callFeedApi();
    // TODO: implement onInit
    super.onInit();
  }

  MyFormValidator basicValidator = MyFormValidator();
  List<FeedsGetApiData>? feedsdata;

  List<FeedsGetApiData>? get _feedsdata => feedsdata;

  List<FeedsGetApiData>? filterFeedsData;
  bool? isLoad = false;

  callFeedApi() async {
    isLoad = true;
    await FeedsGetApi.callapi().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        feedsdata = value.leadcheckdata;
        filterFeedsData = feedsdata;
        update();
      } else {
        Get.dialog(AlertBox(
          msg: '${value.exception}..!!',
        ));
      }
    });
    isLoad = false;

    update();
  }
}
