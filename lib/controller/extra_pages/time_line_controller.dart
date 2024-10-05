import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_text_utils.dart';
import 'package:flowkit/model/contact_lead_modal.dart';

class TimeLineController extends MyController {
  List<ContactLeadModal> timeline = [];
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    ContactLeadModal.dummyList.then((value) {
      timeline = value.sublist(0, 6);
      update();
    });
    super.onInit();
  }
}
