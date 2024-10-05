import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/widgets/my_text_utils.dart';
import 'package:flowkit/model/contact_lead_modal.dart';
import 'package:flutter/material.dart';

class DragNDropController extends MyController {
  List<ContactLeadModal> contact = [];
  final scrollController = ScrollController();
  final gridViewKey = GlobalKey();
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    ContactLeadModal.dummyList.then((value) {
      contact = value.sublist(0, 12);
      update();
    });
    super.onInit();
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    ContactLeadModal customer = contact.removeAt(oldIndex);
    contact.insert(newIndex, customer);
    update();
  }
}
