import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../../components/lookup/lookup.dart';

class HmAssignmentController extends GetxController{
  var pageIndex = 0.obs;
  late PageController pageController;
  late Future <dynamic> futureform;
  var wstrPageMode = "VIEW".obs;
  var g  = Global();


  Rx<DateTime> todyDate = DateTime.now().obs;
  Rx<DateTime> lastAssignedDate = DateTime.now().obs;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "CB".obs;
  RxString frDocno="AS25534".obs;
  RxString frLocation="".obs;
  var totalAssignedValue='56'.obs;
  var pendingAssignedValue='23'.obs;

  RxString frdriverName="".obs;
  RxString frdriverCode="".obs;
  RxString frvehiclenumber="".obs;
  RxString ctmrApartmentDescp="".obs;
  RxString ctmrBuildingDescp="".obs;
  var buildingCode  =  "".obs;
  RxBool checkAll = false.obs;

  // Text Controller
  var txtDocNo = TextEditingController();
  var txtDocDate = TextEditingController();
  var txtBookNumber = TextEditingController();
  var txtDriver = TextEditingController();
  var txtVehicleNo = TextEditingController();
  var txtRemarks = TextEditingController();
  var txtController = TextEditingController();
  var txtCustomerName = TextEditingController();

  var orderlist  = [

    {
      "CODE":"001",
      "CNAME":"WER",
      "PRIORITY":"EMERGENCY",
      "LOCATION":"AL NAHDA",
      "ITEMS":"CNG 35KG"
    },
    {
      "CODE":"002",
      "CNAME":"QWE ",
      "PRIORITY":"NORMAL",
      "LOCATION":"QUSAIS",
      "ITEMS":"LPG 25KG"
    },




  ].obs;

  RxString bookingNumber = "".obs;
  //Page Head
  var priorityvalue="".obs;

  //FocusNode
  var focusNode = FocusNode().obs;
  var focusNodeBuilding = FocusNode().obs;
  var focusNodeCustomer = FocusNode().obs;
  var focusNodeLocation = FocusNode().obs;
  var focusNodeDocno = FocusNode().obs;
  var focusNodeDriver = FocusNode().obs;
  var focusNodeVehicleNo = FocusNode().obs;

  var priorityList=[].obs;
  var txtContactNo = TextEditingController();
  var txtBuilding = TextEditingController();
  var txtBuildingName = TextEditingController();
  var txtBuildingCode = TextEditingController();
  var txtApartment = TextEditingController();
  var txtLocation = TextEditingController();
  var txtLandmark = TextEditingController();
  var txtAddress = TextEditingController();
  final txtCustomerCode = TextEditingController().obs;

  ////DELIVERY CONTROLLER
  var txtRemark = TextEditingController();
  //**************************************************MENU
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
    // apiViewAssignment('', 'LAST');
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

  fnClear(){
    frDocno.value ="";
    frLocation.value="";
    priorityvalue.value='NORMAL';
    priorityList.value=[];
    totalAssignedValue.value="";
    pendingAssignedValue.value="";
    orderlist.value=[];
    frdriverCode.value="";
    frdriverName.value="";
    frvehiclenumber.value="";





  }

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

  //============================================NAVIGATE

  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }
  void onClickRadioButton(value) {
    dprint(value);
    if(wstrPageMode.value  == "VIEW"){
      return;
    }
    priorityvalue.value = value;
    update();



  }

  fnDeletePage(context){
    PageDialog().deleteDialog(context, fnDel);

  }
  fnDel(context){
    dprint("Delete id");
  }

  fnFillData(data,mode){



  }
  fnFillCustomerData(data,mode){


    //Clear
    if(mode == "CRDELIVERYMANMASTER"){
      g.wstrBuildingCode = "";
      g.wstrBuildingName = "";

    }
    else if(mode == "CRVEHICLEMASTER"){
      // frApartmentCode.value = "";
      // fnCustomerClear();
    }


    //Fill
    if(g.fnValCheck(data)){
      if(mode  ==  "CRDELIVERYMANMASTER"){

        frdriverCode.value = data["DEL_MAN_CODE"]??"";
        frvehiclenumber.value =data["VEHICLE_NO"]??"";
        frdriverName.value =data["NAME"]??"";

      }
      else if(mode  ==  "CRVEHICLEMASTER"){
        frvehiclenumber.value = data["VEHICLE_NO"]??"";

        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "GCYLINDER_ASSIGNMENT"){
        frDocno.value = data["DOCNO"]??"";

        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "GPRIORITYMASTER"){
        priorityvalue.value = data["DESCP"]??"";

        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "AREAMASTER"){
        frLocation.value = data["DESCP"]??"";

        //   apiGetDriverDetails();
      }

    }

  }

  //====================Lookup====================

  fnLookup(mode){
    dprint(mode);

    if(mode == "GCYLINDER_CALL_LOGIN"){

      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'Code'},
        {'Column': 'PARTY_CODE', 'Display': 'PCode'},
        {'Column': 'PARTY_NAME', 'Display': 'Name'},
        {'Column': 'MOBILE_NO', 'Display': 'Mobile'},
        {'Column': 'DOCTYPE', 'Display': 'Doctype'},
        {'Column': 'YEARCODE', 'Display': 'Yearcode'},

      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany.value, 'JoinType': 'AND'}];

      // if(frBuildingCode.isNotEmpty){
      //   lstrFilter.add({'Column': "BUILDING_CODE", 'Operator': '=', 'Value': frBuildingCode, 'JoinType': 'AND'});
      // }
      // if(frApartmentCode.isNotEmpty){
      //   lstrFilter.add({'Column': "APARTMENT_CODE", 'Operator': '=', 'Value': frApartmentCode, 'JoinType': 'AND'});
      // }
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'GCYLINDER_CALL_LOGIN',
            title: 'Booking Details',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'DOCNO',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "CRDELIVERYMANMASTER") {
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DEL_MAN_CODE', 'Display': 'Code'},
        {'Column': 'NAME', 'Display': 'Name'},
        {'Column': 'VEHICLE_NO', 'Display': 'VEHICLE_NO'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}];

      // if(frBuildingCode.isNotEmpty){
      //   lstrFilter.add({'Column': "BUILDING_CODE", 'Operator': '=', 'Value': frBuildingCode, 'JoinType': 'AND'});
      // }
      // if(frApartmentCode.isNotEmpty){
      //   lstrFilter.add({'Column': "APARTMENT_CODE", 'Operator': '=', 'Value': frApartmentCode, 'JoinType': 'AND'});
      // }
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'CRDELIVERYMANMASTER',
            title: 'Driver Details',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'GUEST_CODE',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "GCYLINDER_ASSIGNMENT") {
      if(wstrPageMode.value  != "VIEW"){
        return;
      }
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'Code'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}];

      // if(frBuildingCode.isNotEmpty){
      //   lstrFilter.add({'Column': "BUILDING_CODE", 'Operator': '=', 'Value': frBuildingCode, 'JoinType': 'AND'});
      // }
      // if(frApartmentCode.isNotEmpty){
      //   lstrFilter.add({'Column': "APARTMENT_CODE", 'Operator': '=', 'Value': frApartmentCode, 'JoinType': 'AND'});
      // }
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'GCYLINDER_ASSIGNMENT',
            title: 'Assignment Details',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'DOCNO',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "CRVEHICLEMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'VEHICLE_NO', 'Display': 'Number'},
        {'Column': "DESCP", 'Display': 'Name'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}];

      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'CRVEHICLEMASTER',
            title: 'Building',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'VEHICLE_NO',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "GPRIORITYMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'CODE', 'Display': 'CODE'},
        {'Column': "DESCP", 'Display': 'Priority'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[];

      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'GPRIORITYMASTER',
            title: 'Building',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'DESCP',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "CRDELIVERYMANMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DEL_MAN_CODE', 'Display': 'Code'},
        {'Column': 'NAME', 'Display': 'Name'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}];

      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'CRDELIVERYMANMASTER',
            title: 'Driver Details',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'GUEST_CODE',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "CRVEHICLEMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'VEHICLE_NO', 'Display': 'Code'},
        {'Column': "DESCP", 'Display': 'Name'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}];

      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'CRVEHICLEMASTER',
            title: 'Building',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'VEHICLE_NO',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "AREAMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'CODE', 'Display': 'Code'},
        {'Column': "DESCP", 'Display': 'Name'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[];

      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'AREAMASTER',
            title: 'Building',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'VEHICLE_NO',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }

  }

  //***********************************************************************API
  apiGetDriverDetails() {}
  //   var lstrFilter = [];
  //   var columnList = 'CODE|DESCP|';
  //   futureform = ApiCall().LookupSearch("PRODUCT_TYPE", columnList, 0, 100, lstrFilter);
  //   futureform.then((value) => apiGetDriverDetailsRes(value));
  // }
  // apiGetProductTypeRes(value) {
  //   if (g.fnValCheck(value)) {
  //     dprint("xxxxxxxx  ${value}");
  //     lstrProductTypeList.value = value;
  //     update();
  //   }
  // }



}