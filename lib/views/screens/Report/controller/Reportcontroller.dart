import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/globalValues.dart';
import '../../../components/alertDialog/alertDialog.dart';

class ReportController extends GetxController {

  late PageController pageController;
  late Future <dynamic> futureform;
  var wstrPageMode = "VIEW".obs;
  var g = Global();
  Rx<DateTime> docDate = DateTime.now().obs;

  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "AT".obs;

  fnBackPage(context) {
    PageDialog().exitDialog(context, fnEnd);
  }

  fnEnd(context) {
    Get.back();
    Get.back();
  }

}
