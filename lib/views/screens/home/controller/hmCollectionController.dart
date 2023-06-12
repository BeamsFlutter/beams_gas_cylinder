
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';

class HmCollectionController extends GetxController{

  var g  = Global();

  RxString collectionNumber = "".obs;
  //Page Variables
  Rx<DateTime> docDate = DateTime.now().obs;
  var wstrPageMode = "VIEW".obs;
  var paymentvalue="".obs;
  late Future <dynamic> futureform;
  RxString frDocno="DO25534".obs;

  var txtCollectionAmt = TextEditingController();



  var paymentList=[
    { "CODE":"001",
      "PDETAILS":"CASH",
    },
    { "CODE":"002",
      "PDETAILS":"CARD",},
    { "CODE":"003",
      "PDETAILS":"CREDIT",},
  ].obs;



  //============================================MENU
  fnAdd() {
    fnClear();
    wstrPageMode.value = 'ADD';
    print( wstrPageMode.value);
    update();
  }
  fnSave(){}
  fnPage(){}
  fnEdit() {
    wstrPageMode.value = 'EDIT';
    print( wstrPageMode.value);
  }
  fnCancel() {
    print( wstrPageMode.value);
    fnClear();
    wstrPageMode.value = "VIEW";
    print( wstrPageMode.value);
  }
  fnDelete(){

  }
  fnClear(){}
  //============================================FUNCTIONS
  void onClickChoosePyment(value) {
    dprint("paymets...........   "+value);
    if(wstrPageMode.value  == "VIEW"){
      return;
    }
    paymentvalue.value = value;
    update();
  }


  //============================================NAVIGATE

  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }



}