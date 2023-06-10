import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../components/common/common.dart';
import '../../../styles/colors.dart';

class HomeController extends GetxController{

  var g  = Global();

  RxString bookingNumber = "".obs;
  //Page Variables
  var lstrToday  =  DateTime.now();
  //Page Head
  var wstrPageMode = "VIEW".obs;
  var priorityvalue="".obs;
  late Future <dynamic> futureform;
  //FocusNode
  var focusNode = FocusNode().obs;
  var focusNodeBuilding = FocusNode().obs;
  var focusNodeCustomer = FocusNode().obs;
  var focusNodeLocation = FocusNode().obs;
  var focusNodeDocno = FocusNode().obs;
  var focusNodeDriver = FocusNode().obs;
  var focusNodeVehicleNo = FocusNode().obs;
  late PageController pageController;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "CD".obs;
  var pageIndex = 0.obs;
  var priorityList=[
    { "CODE":"001",
      "PNAME":"EMERGENCY",
    },
    { "CODE":"002",
      "PNAME":"NORMAL",},
    { "CODE":"003",
      "PNAME":"LOW",},
  ].obs;
  var txtCustomerName = TextEditingController();
  var txtContactNo = TextEditingController();
  var txtBuilding = TextEditingController();
  var txtBuildingName = TextEditingController();
  var txtBuildingCode = TextEditingController();
  var txtApartment = TextEditingController();
  var txtLocation = TextEditingController();
  var txtLandmark = TextEditingController();
  var txtController = TextEditingController();
  var txtAddress = TextEditingController();
  final txtCustomerCode = TextEditingController().obs;

  ////DELIVERY CONTROLLER
  var txtRemark = TextEditingController();
  //============================================MENU
  fnAdd() {
    fnClear();
    wstrPageMode.value = 'ADD';
    print( wstrPageMode.value);
    update();
  }
  fnSave(){}
  fnPage(){}
  void onClickRadioButton(value) {
    dprint(value);
    if(wstrPageMode.value  == "VIEW"){
      return;
    }
    priorityvalue.value = value;
    update();



  }

  fnEdit() {
    wstrPageMode.value = 'EDIT';
    print( wstrPageMode.value);
  }

  fnCancel() {



    fnClear();
    wstrPageMode.value = "VIEW";

    print( wstrPageMode.value);
  }





  fnDelete(){

  }

  fnAddItem(){

  }

fnClear(){}


  //**************************************************WIDGETS

}