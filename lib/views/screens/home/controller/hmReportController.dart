import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../components/alertDialog/alertDialog.dart';

class HmReportController extends GetxController{
  late PageController pageController;
  late Future <dynamic> futureform;
  var wstrPageMode = "VIEW".obs;
  var g = Global();
  Rx<DateTime> docDate = DateTime.now().obs;

  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "AT".obs;

  var reportlist  = [

    {
      "CODE":"001",
      "RNAME":"Daily Sales Reports",
    },
    {
      "CODE":"002",
      "RNAME":"Collection Reports",
    },
    {
      "CODE":"003",
      "RNAME":"Assignemnt Details",
    },
    {
      "CODE":"004",
      "RNAME":"Booking Details",

    }

  ].obs;

  fnBackPage(context) {
    PageDialog().exitDialog(context, fnEnd);
  }

  fnEnd(context) {
    Get.back();
    Get.back();
  }


}