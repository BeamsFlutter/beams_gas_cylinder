import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
enum PaymentMode { cash, card,cheque }
class HmContractReciptController extends GetxController{
  RxString frDocno="".obs;
  RxString frDocType="".obs;
  var g  = Global();
  var wstrPageMode = "VIEW".obs;
  Rx<DateTime> docDate = DateTime.now().obs;

  var txtchequeNumber= TextEditingController();
  var txtchequeDate = TextEditingController();
  var txtAmount = TextEditingController();

  final paymentMode = PaymentMode.cash.obs;

  Future<void> wSelectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate:DateTime(2025, 8),
        initialDate: DateTime.now());
    if (pickedDate != null){


      txtchequeDate.text =setDate(15, pickedDate);
    }

  }
  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }
  fnAdd() {
    fnClear();
    wstrPageMode.value = 'ADD';


    print( wstrPageMode.value);

    update();

  }

  fnEdit() {
    wstrPageMode.value = 'EDIT';
    print( wstrPageMode.value);
  }

  fnCancel() {
    fnClear();
    wstrPageMode.value = "VIEW";
    // apiViewDeliveryOrder('', 'LAST');
  }

  fnPage(mode) {

    switch (mode) {
      case 'FIRST':
      //   apiViewDeliveryOrder('', mode);
        break;
      case 'LAST':
      //   apiViewDeliveryOrder('', mode);
        break;
      case 'NEXT':
      //   apiViewDeliveryOrder(frDocno.value, mode);
        break;
      case 'PREVIOUS':
      //   apiViewDeliveryOrder(frDocno.value, mode);
        break;
    }
  }

  fnClear(){





  }
  fnDelete(){}

  fnSave(context){

  }



}