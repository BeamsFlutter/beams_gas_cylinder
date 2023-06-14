

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../../../../global/globalValues.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';

class RepCustomerBalaneController extends GetxController {
  //**************************************************Pagevariable
  late PageController pageController;
  late Future <dynamic> futureform;
  Rx<DateTime> docDate = DateTime.now().obs;
  var wstrPageMode = "VIEW".obs;
  var g = Global();
  var isExpanded = false.obs;
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> toDate = DateTime.now().obs;

  var breportlist  = [

    {
      "CODE":"1",
      "DOCNO":"1234",
      "TNAME":"SALES",
      "DATE":"1-JUN-2023",
      "AMOUNT":"2500"
    },
    {
      "CODE":"2",
      "DOCNO":"1235",
      "TNAME":"COLLECTION",
      "DATE":"2-JUN-2023",
      "AMOUNT":"1500"
    },
    {
      "CODE":"3",
      "DOCNO":"1236",
      "TNAME":"SALES",
      "DATE":"12-JUN-2023",
      "AMOUNT":"2000"
    },
    {
      "CODE":"4",
      "DOCNO":"1237",
      "TNAME":"COLLECTION",
      "DATE":"11-JUN-2023",
      "AMOUNT":"3500"

    }

  ];
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