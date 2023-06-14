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

  var buildingCode  =  "".obs;
  Rx<DateTime> docDate = DateTime.now().obs;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "CB".obs;
  RxString frDocno="AS25534".obs;
  RxString frdriver="".obs;
  RxString frdriverName="".obs;
  RxString frvehiclenumber="".obs;
  RxString ctmrApartmentDescp="".obs;
  RxString ctmrBuildingDescp="".obs;
  RxBool checkAll = false.obs;

  // Text Controller
  var txtDocNo = TextEditingController();
  var txtDocDate = TextEditingController();
  var txtBookNumber = TextEditingController();
  var txtDriver = TextEditingController();
  var txtVehicleNo = TextEditingController();
  var txtRemarks = TextEditingController();
  var txtController = TextEditingController();
  var txtCustomerName = TextEditingController(text: "SHARJAH");



  RxString bookingNumber = "".obs;
  //Page Variables
  var lstrToday  =  DateTime.now();
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

  var priorityList=[
    { "CODE":"001",
      "PNAME":"EMERGENCY",
    },
    { "CODE":"002",
      "PNAME":"NORMAL",},
    { "CODE":"003",
      "PNAME":"LOW",},
  ].obs;
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
      g.wstrBuildingCode.value = "";
      g.wstrBuildingName.value = "";

    }
    else if(mode == "CRVEHICLEMASTER"){
      // frApartmentCode.value = "";
      // fnCustomerClear();
    }


    //Fill
    if(g.fnValCheck(data)){
      if(mode  ==  "CRDELIVERYMANMASTER"){

        frdriver.value = data["DEL_MAN_CODE"]??"";
        frvehiclenumber.value =data["VEHICLE_NO"]??"";
        frdriverName.value =data["NAME"]??"";

      }
      else if(mode  ==  "CRVEHICLEMASTER"){
        frvehiclenumber.value = data["VEHICLE_NO"]??"";

        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "GCYLINDEASSIGNMENT"){
        frDocno.value = data["DOCNO"]??"";

        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "CRVEHICLEMASTER"){
        frvehiclenumber.value = data["VEHICLE_NO"]??"";

        //   apiGetCustomerDetails();
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
    else if(mode == "GCYLINDEASSIGNMENT") {
      if(wstrPageMode.value  == "ADD"){
        return;
      }
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'Code'},
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
            lstrTable: 'GCYLINDEASSIGNMENT',
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
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany.value, 'JoinType': 'AND'}];

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

  }

}