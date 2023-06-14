

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../../../../global/globalValues.dart';
import '../../../components/alertDialog/alertDialog.dart';


class RepCollectionController extends GetxController {
  //**************************************************Pagevariable
  late PageController pageController;
  late Future <dynamic> futureform;
  Rx<DateTime> docDate = DateTime.now().obs;
  var wstrPageMode = "VIEW".obs;
  var g = Global();
  var isExpanded = false.obs;
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  fnBackPage(context) {
    PageDialog().exitDialog(context, fnEnd);
  }

  fnEnd(context) {
    Get.back();
    Get.back();
  }

  Future<void> wSelectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025, 8),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != fromDate.value) {
      fromDate.value = pickedDate;

    }
  }

  Future<void> wSelectToDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025, 8),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != toDate.value) {
      toDate.value =pickedDate ;


    }
  }
}