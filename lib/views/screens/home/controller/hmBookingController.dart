import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../../styles/colors.dart';

class HmBookingController extends GetxController{
  //**************************************************Pagevariable
  late PageController pageController;
  late Future <dynamic> futureform;
  Rx<DateTime> docDate = DateTime.now().obs;
  var wstrPageMode = "VIEW".obs;
  var g  = Global();
  Rx<DateTime> delivryDate = DateTime.now().obs;
  RxString frDocno="BS25534".obs;
  RxList priorityList = [
    {
      "DESCP":"EMAERGENCY",
      "PCODE":"1",
    },
    {
      "DESCP":"NORMAL",
      "PCODE":"2",
    },
    {
      "DESCP":"URGENT",
      "PCODE":"3",
    },

  ].obs;
  RxString priorityvalue=''.obs;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "CD".obs;

  RxString ctmrApartmentDescp = "".obs;
  RxString ctmrBuildingDescp = "".obs;

  //************************CONTROLLER
  final txtCustomerCode = TextEditingController();
  var txtContactNo = TextEditingController();
  var txtRemark = TextEditingController();
  var txtLandmark = TextEditingController();
  var txtAddress = TextEditingController();
  var txtCustomerName = TextEditingController();
  var txtdelivryDate = TextEditingController();
  var txtBuildingCode = TextEditingController();
  var txtBuildingName = TextEditingController();
  var txtApartmentCode = TextEditingController();
  var txtApartmentName = TextEditingController();


  //************************WIDGETS
  Future<void> wSelectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate:DateTime(2025, 8),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != delivryDate.value){
      delivryDate.value = pickedDate;
      txtdelivryDate.text =setDate(15, delivryDate.value);
      dprint(delivryDate.value);
      dprint("DeliveryDate DATE:  ${DateFormat('dd-MM-yyyy').format(delivryDate.value)}");
    }

  }


  //************************FUNCTION
  onClickRadioButton(value){
    priorityvalue.value = value;
    dprint(priorityvalue.value);
    update();
  }

  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }


  //***********************************************************MENU

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
    apiViewAssignment('', 'LAST');
  }

  fnPage(mode) {

    switch (mode) {
      case 'FIRST':
        apiViewAssignment('', mode);
        break;
      case 'LAST':
        apiViewAssignment('', mode);
        break;
      case 'NEXT':
        apiViewAssignment(frDocno.value, mode);
        break;
      case 'PREVIOUS':
        apiViewAssignment(frDocno.value, mode);
        break;
    }
  }

  fnClear(){}

  fnFill(value){}

  fnSave(){}

  fnDelete(){}






  //**************************************************API

  apiViewAssignment(docno,mode){
    futureform = ApiCall().apiViewAssignment(docno,mode);
    futureform.then((value) => apiViewAssignmentRes(value));
  }
  apiViewAssignmentRes(value){
    if(g.fnValCheck(value)){
      fnClear();
      fnFill(value);
    }

  }

}