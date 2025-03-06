import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainCnt extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var selectedDay = DateTime.now().day.obs;
  var selectedMonth = DateTime.now().month.obs;
  var selectedYear = DateTime.now().year.obs;

  var dropdownKey = UniqueKey().obs; // Reactive key for rebuilding dropdown

  void updateDropdown() {
    dropdownKey.value = UniqueKey();
    update();
  }
}
