import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignmentController extends GetxController{
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "TD".obs;
  var pageIndex = 0.obs;
  late PageController pageController;
}