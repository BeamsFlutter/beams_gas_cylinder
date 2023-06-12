

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../../../../global/globalValues.dart';
import '../../../components/common/common.dart';

class CustomerBalaneReportController extends GetxController {
  //**************************************************Pagevariable
  late PageController pageController;
  late Future <dynamic> futureform;
  Rx<DateTime> docDate = DateTime.now().obs;
  var wstrPageMode = "VIEW".obs;
  var g = Global();
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;
  var txtFromdate = TextEditingController();
  var txtTodate = TextEditingController();

  Future<void> wSelectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025, 8),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != fromDate.value) {
      fromDate.value = pickedDate;
      txtFromdate.text = setDate(15, fromDate.value);
      dprint(fromDate.value);
      dprint("DeliveryDate DATE:  ${DateFormat('dd-MM-yyyy').format(
          fromDate.value)}");
    }
  }

  Future<void> wSelectDateto(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025, 8),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != toDate.value) {
      toDate.value = pickedDate;
      txtTodate.text = setDate(15, toDate.value);
      dprint(toDate.value);
      dprint("DeliveryDate DATE:  ${DateFormat('dd-MM-yyyy').format(
          toDate.value)}");
    }
  }
}