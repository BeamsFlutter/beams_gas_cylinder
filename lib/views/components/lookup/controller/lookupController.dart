import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../servieces/api_controller.dart';


class LookupController extends GetxController{


  late Future<dynamic> lstrFutureLookup;
  late Future<dynamic> lstrFutureLookupValidate;
  late List<Map<String, dynamic >> lookupFilterVal ;
  // var  apiCall = ApiCall();


  late Function fnCallback;
  RxString keyColumn = "".obs;
  RxString lstrOldvalue = "" .obs;
  RxString lstrSearchval = "".obs;
  RxString lstrLayoutName = "".obs;
  var txSearchControl = TextEditingController();
  var txtControl = TextEditingController();
  RxList columnList=[].obs;
  RxList lstrSelectedDataList=[].obs;
  RxList pageData = [].obs;

  late FocusNode focusNode;

  ApiCall apiCall =  ApiCall();
}