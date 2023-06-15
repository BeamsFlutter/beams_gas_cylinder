import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../../components/lookup/lookup.dart';
import '../../../styles/colors.dart';

class HmBookingController extends GetxController{
  //**************************************************Pagevariable
  late PageController pageController;
  late Future <dynamic> futureform;
  Rx<DateTime> docDate = DateTime.now().obs;
  var wstrPageMode = "VIEW".obs;
  var g  = Global();
  Rx<DateTime> delivryDate = DateTime.now().obs;
  RxString frDocno="".obs;
  RxString frDocType="".obs;
  RxString frDriver="".obs;
  RxString frVehicleNumber="".obs;
  RxString frLocation="".obs;
  RxString frAssignmentStatus="".obs;
  RxList priorityList = [].obs;
  RxString priorityvalue=''.obs;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "CD".obs;

  // RxString cstmrApartmentDescp = "".obs;
  // RxString cstmrApartmentCode = "".obs;
  // RxString cstmrBuildingDescp = "".obs;
  // RxString cstmrBuildingCode = "".obs;
  // RxString cstmrAreaCode = "".obs;
  // RxString cstmrAddress = "".obs;
  // RxString cstmrLandmark = "".obs;
  // RxString cstmrRemark = "".obs;
  RxString cstmrCode = "".obs;
  RxString cstmrName = "".obs;
  // RxString cstmrMobile = "".obs;
  RxList lstrBookedList =[].obs;

  //************************Customer_CONTROLLER
  final txtCustomerCode = TextEditingController();
  var txtContactNo = TextEditingController();
  var txtRemark = TextEditingController();
  var txtLandmark = TextEditingController();
  var txtAreaCode= TextEditingController();
  var txtAddress = TextEditingController();
  var txtCustomerName = TextEditingController();
  var txtBuildingCode = TextEditingController();
  var txtBuildingName = TextEditingController();
  var txtApartmentCode = TextEditingController();
  var txtApartmentName = TextEditingController();
  //************************Delivery_CONTROLLER
  var txtdelivryDate = TextEditingController();
  var txtdriver = TextEditingController();
  var txtvehicleNumber = TextEditingController();
  //************************Lookup
  var txtController = TextEditingController();

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
    if(wstrPageMode.value  == "VIEW"){
      return;
    }
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
    apiViewBooking('', 'LAST');
  }

  fnPage(mode) {

    switch (mode) {
      case 'FIRST':
        apiViewBooking('', mode);
        break;
      case 'LAST':
        apiViewBooking('', mode);
        break;
      case 'NEXT':
        apiViewBooking(frDocno.value, mode);
        break;
      case 'PREVIOUS':
        apiViewBooking(frDocno.value, mode);
        break;
    }
  }

  fnClear(){

  }

  fnFill(data){
    dprint("Values>>>>>>>  ${data}");
    if(wstrPageMode != "VIEW"){
      return;
    }

    fnClear();

    var headerList  =g.fnValCheck(data["HEADER"])? data["HEADER"][0]:[];
    var detList  = g.fnValCheck(data["DET"])?data["DET"]:[];
    var assignmentList  = g.fnValCheck(data["ASSIGNMENTDET"])?data["ASSIGNMENTDET"]:[];
    dprint("HEADERLIST>>>>>>> ${headerList}");
    dprint("DET__LIST>>>>>>> ${detList}");
    dprint("ASSIGNMNT__LIST>>>>>>> ${assignmentList}");
    if(g.fnValCheck(headerList)){
      frDocno.value = (headerList["DOCNO"]??"").toString();
      frDocType.value = (headerList["DOCTYPE"]??"").toString();
      frLocation.value = (headerList["LOCATION"]??"").toString();
      priorityvalue.value = (headerList["PRIORITY"]??"").toString();
      txtCustomerName.text = (headerList["PARTY_NAME"]??"").toString();
      cstmrName.value = (headerList["PARTY_NAME"]??"").toString();
      txtCustomerCode.text = (headerList["PARTY_CODE"]??"").toString();
      cstmrCode.value = (headerList["PARTY_CODE"]??"").toString();
      txtContactNo.text = (headerList["MOBILE_NO"]??"").toString();
      txtBuildingCode.text = (headerList["BLDG_NO"]??"").toString();
      txtApartmentCode.text = (headerList["APARTMENT_NO"]??"").toString();
      txtRemark.text = (headerList["REMARKS"]??"").toString();
      txtAddress.text = (headerList["CUST_ADDRESS"]??"").toString();
      txtLandmark.text = (headerList["LANDMARK"]??"").toString();
      frAssignmentStatus.value = (headerList["ASSIGNMENT_STATUS"]??"").toString();
      docDate.value =headerList["DOCDATE"] != null ||headerList["DOCDATE"] != ""?DateTime.parse(headerList["DOCDATE"].toString()):DateTime.now();
      delivryDate.value =headerList["DELIVERY_DATE"] != null ||headerList["DELIVERY_DATE"] != ""?DateTime.parse(headerList["DELIVERY_DATE"].toString()):DateTime.now();
      txtdelivryDate.text=setDate(15, delivryDate.value);
    }
    if(g.fnValCheck(detList)){
      int i = 1;
      lstrBookedList.value = [];
      for (var e in detList) {
        var datas = Map<String,dynamic>.from({
          "STKCODE":e["STOCK_CODE"],
          "STKDESCP":e["STOCK_DESC"],
          "RATE":e["RATE"],
          "QTY": e["QTY1"],
          "AMT":  g.mfnDbl(e["QTY1"])*g.mfnDbl(e["RATE"]),
        });

        txtvehicleNumber.text =(e["VEHICLE_NO"]??"").toString();
        txtdriver.text =(e["DEL_MAN_CODE"]??"").toString();
        lstrBookedList.value.add(datas);
        i++;
        update();
      }
      update();

    }


  }

  fnSave(){}

  fnDelete(){}

//============================================LOOKUP

  fnLookup(mode){

    if(wstrPageMode.value  == "VIEW"){
      return;
    }
    dprint(mode);
    dprint(g.wstrCompany);
    if(mode == "GCYLINDER_CALL_LOGIN"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'Code'},
        {'Column': 'PARTY_CODE', 'Display': 'PCode'},
        {'Column': 'PARTY_NAME', 'Display': 'Name'},
        {'Column': 'MOBILE_NO', 'Display': 'Mobile'},
        // {'Column': 'EMAIL', 'Display': 'Email'},
        // {'Column': 'BLDG_NO', 'Display': 'Building'},
        // {'Column': 'APARTMENT_NO', 'Display': 'Apartment'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany.value, 'JoinType': 'AND'}];


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
    else   if(mode == "GUESTMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'GUEST_CODE', 'Display': 'Code'},
        {'Column': 'GUEST_NAME', 'Display': 'Name'},
        {'Column': 'MOBILE', 'Display': 'Mobile'},
        {'Column': 'EMAIL', 'Display': 'Email'},
        {'Column': 'BUILDING_CODE', 'Display': 'Building'},
        {'Column': 'APARTMENT_CODE', 'Display': 'Apartment'},
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
            lstrTable: 'GUESTMASTER',
            title: 'Customer Details',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'GUEST_CODE',
            mode: "S",
            layoutName: "PARTY",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "GBUILDINGMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'BUILDING_CODE', 'Display': 'Code'},
        {'Column': 'DESCP', 'Display': 'Name'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany.value, 'JoinType': 'AND'}];
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'GBUILDINGMASTER',
            title: 'Building',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'BUILDING_CODE',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode);
            },
            searchYn: 'Y',
          )
      );
    }
    else if(mode == "GAPARTMENTMASTER" ){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'APARTMENT_CODE', 'Display': 'Code'},
        // {'Column': 'BUILDING_CODE', 'Display': 'Building'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany.value, 'JoinType': 'AND'}];
      if(txtBuildingCode.text.isNotEmpty){
        lstrFilter.add({'Column': "BUILDING_CODE", 'Operator': '=', 'Value': txtBuildingCode.text, 'JoinType': 'AND'});
      }
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'GAPARTMENTMASTER',
            title: 'Apartment',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'APARTMENT_CODE',
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

  fnCustomerClear(){
    txtBuildingCode.clear();
txtApartmentCode.clear();
txtContactNo.clear();
txtBuildingName.clear();
txtRemark.clear();
txtAddress.clear();
txtLandmark.clear();
txtCustomerCode.clear();
txtCustomerCode.clear();



  }

  fnFillCustomerData(data,mode){

    //Clear
    if(mode == "GBUILDINGMASTER"){
      g.wstrBuildingCode.value = "";
      g.wstrBuildingName.value = "";
      txtBuildingCode.text = "";
      txtBuildingName.text  = "";
      txtApartmentCode.text  = "";
      fnCustomerClear();
    }
    else if(mode == "GAPARTMENTMASTER"){
      txtApartmentCode.text = "";
      fnCustomerClear();
    }
    else if(mode == "GUESTMASTER"){
      fnCustomerClear();
    }

    //Fill
    if(g.fnValCheck(data)){
      if(mode  ==  "GBUILDINGMASTER"){
        dprint("1111111111111111111111   >> ${data["BUILDING_CODE"]}");

        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        txtBuildingName.text = data["DESCP"]??"";
        g.wstrBuildingCode.value = data["BUILDING_CODE"]??"";
        g.wstrBuildingName.value = data["DESCP"]??"";


      }
      else if(mode  ==  "GAPARTMENTMASTER"){
        txtApartmentCode.text = data["APARTMENT_CODE"]??"";
        g.wstrApartmentCode.value  = data["APARTMENT_CODE"]??"";
        txtApartmentCode.text =data["APARTMENT_CODE"]??"";
        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "GUESTMASTER"){
        txtCustomerCode.text  = data["GUEST_CODE"]??"";
        txtCustomerName.text  = data["GUEST_NAME"]??"";
        txtContactNo.text  = data["MOBILE"]??"";
        // frEmail.value  = data["EMAIL"]??"";
        txtContactNo.text  = data["MOBILE"]??"";
        txtApartmentCode.text = data["APARTMENT_CODE"]??"";
        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        g.wstrBuildingCode  = data["BUILDING_CODE"]??"";
        g.wstrApartmentCode  = data["APARTMENT_CODE"]??"";
        //    apiGetCustomerInfo();
      }
    }

  }
  fnFillData(data,mode){


    //Fill
    if(g.fnValCheck(data)){
      if(mode== "GCYLINDER_CALL_LOGIN"){
        frDocno.value = data["DOCNO"];
        update();

      }

    }

  }








  //**************************************************API

  apiViewBooking(docno,mode){
    futureform = ApiCall().apiViewBooking(docno,mode);
    futureform.then((value) => apiViewBookingRes(value));
  }
  apiViewBookingRes(value){
    if(g.fnValCheck(value)){
      fnClear();
      fnFill(value);
    }

  }

  apiGetPriority(){
    var lstrFilter= [];
    var columnList  =  'CODE|DESCP|';
    futureform = ApiCall().LookupSearch("GPRIORITYMASTER ", columnList,0, 100, lstrFilter);
    futureform.then((value) => apiGetPriorityRes(value));
  }
  apiGetPriorityRes(value){
    if(g.fnValCheck(value)){
      priorityList.value = value;
      dprint("priooooooooooooooooo  ${priorityList.value }");
      update();


    }

  }

}