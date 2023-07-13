import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../../servieces/api_params.dart';
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
  // Rx<DateTime> delivryDate = DateTime.now().obs;
  RxString frDocno="".obs;
  RxString frDocType="".obs;
  RxString frDriver="".obs;
  RxString frContractno="".obs;
  RxString frContractType="".obs;
  RxString frVehicleNumber="".obs;
  RxString frLocation="".obs;
  RxString frAssignmentStatus="".obs;
  RxList priorityList = [].obs;
  RxString priorityvalue='NORMAL'.obs;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "CD".obs;
  final customerformKey = GlobalKey<FormState>().obs;
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
  // RxList lstrContarctList =[].obs;


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
  var txtController = TextEditingController();
  var lstrProductTypeList = [].obs;
  var lstrProductItemDetailList =[].obs;
  //************************WIDGETS
  Future<void> wSelectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate:DateTime(2025, 8),
        initialDate: DateTime.now());
    if (pickedDate != null){


      txtdelivryDate.text =setDate(15, pickedDate);
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
    wstrPageMode.value = 'ADD';
      fnClear();

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
    dprint("###################### clear>>>>>>>>>>>>");
    fnCustomerClear();
    txtdelivryDate.text =setDate(15,DateTime.now());
    lstrBookedList.value =[];
    priorityvalue.value='NORMAL';
    txtdriver.clear();
    txtvehicleNumber.clear();
    frLocation.value ="";
    frDocno.value="";
    frDocType.value="";
    txtAreaCode.text ="";
    // frContractType.value="";
    frContractno.value="";
    // lstrContarctList.value=[];



  }



  fnSave(context) {
      dprint("ContractNumber ${frContractno.value}");
      dprint("ContractType ${frContractType.value}");
      dprint("frDocnumber ${frDocno.value}");
      dprint("frDocType ${frDocType.value}");
      dprint("priorityValue>>> ${priorityvalue.value}");
      dprint("txtAreaCode.text>>> ${txtAreaCode.text}");

    if (customerformKey.value.currentState!.validate()) {
      dprint("lstrBookedList.value>>>>  ${lstrBookedList.value}");
      List header =[];
      List det=[];
      List assignmnt =[];
      List assignmnt_details =[];
      header.add({
        ApiParams.company :g.wstrCompany,
        ApiParams.yearcode :g.wstrYearcode,
        ApiParams.mobileno :txtContactNo.text,
        ApiParams.partycode :txtCustomerCode.text,
        ApiParams.partyname :txtCustomerName.text,
        ApiParams.bldgno :txtBuildingCode.text,
        ApiParams.aprtmntno :txtApartmentCode.text,
        ApiParams.incomngid :"",
        "AREA_CODE":txtAreaCode.text,
        ApiParams.location :frLocation.value,
        ApiParams.landmrk :txtLandmark.text,
        ApiParams.custaddrss :txtAddress.text,
        ApiParams.remark :txtRemark.text,
        ApiParams.priorty :priorityvalue.value,
        ApiParams.delmancode :txtdriver.text??"",
        ApiParams.delivrydate : txtdelivryDate.text,
        ApiParams.delivryreqdate :txtdelivryDate.text,
        "DOCNO":frDocno.value,
        "DOCTYPE":frDocType.value,
        "CONTRACT_NO":frContractno.value,
        "CONTRACT_DOCTYPE":frContractType.value,


      });
      if(txtdriver.text.isNotEmpty){
        assignmnt.add(  {
          "COMPANY": g.wstrCompany,
          "YEARCODE": g.wstrYearcode,
          "EMP_CODE": txtdriver.text,
          "AREA_CODE":txtAreaCode.text,
           ApiParams.delivrydate : txtdelivryDate.text,

        });
      }
      int i=1;
      for(var e in lstrBookedList.value){
        dprint("assssssssssssssssssssss  ${lstrBookedList.value}");
        det.add(    {
          "COMPANY": g.wstrCompany,
          "YEARCODE": g.wstrYearcode,
          "SRNO": i,
          "CYLINDER_CAT": "",
          "STOCK_CODE": e["STKCODE"].toString(),
          "STOCK_DESC": e["STKDESCP"].toString(),
          "QTY1": e["QTY"],
          "RATE": e["RATE"].toString(),
          "AMT":  g.mfnDbl(e["QTY"])*g.mfnDbl(e["RATE"]),
          "REASSIGN": "",
          "DEL_MAN_CODE": txtdriver.text,
          "VEHICLE_NO": txtvehicleNumber.text,
          "PARTY_CODE":txtCustomerCode.text,
          "RATEFC":e["RATE"].toString(),
          "AMTFC":g.mfnDbl(e["QTY"])*g.mfnDbl(e["RATE"]),
        } );
        if(txtdriver.text.isNotEmpty){
          assignmnt_details.add({
            "COMPANY": g.wstrCompany,
            "YEARCODE": g.wstrYearcode,
            "SRNO": i,
            "EMP_CODE": txtdriver.text,
            "STATUS": frAssignmentStatus.value.toString(),
            "CYLINDER_CAT": "",
            "STOCK_CODE": e["STKCODE"].toString(),
            "STOCK_DESC": e["STKDESCP"].toString(),
            "PARTY_CODE": txtCustomerCode.text,
            "VEHICLE_NO": txtvehicleNumber.text,
            "BOOKING_SRNO": i,
            "CONTRACT_NO":frContractno.value,
            "CONTRACT_DOCTYPE":frContractType.value,
          });
        }
        i++;
      }

      dprint("ASSIGNMN>>>> ${assignmnt}");
      dprint("HEADER>>>> ${header}");
      dprint("ASSIGNMN>LIST>>> ${assignmnt_details}");

      fnProceedToSave(context,header,det,assignmnt,assignmnt_details);
    }else{
      dprint("Not validate..........................");
    }
  }

  fnDelete(){}

//============================================LOOKUP

  fnLookup(mode){

    // if(wstrPageMode.value  == "VIEW"){
    //   return;
    // }
    dprint(mode);
    dprint(g.wstrCompany);
    if(mode == "GCYLINDER_BOOKING"){
      // if(wstrPageMode.value  != "VIEW"){
      //   return;
      // }
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'Code'},
        {'Column': 'PARTY_CODE', 'Display': 'PCode'},
        {'Column': 'PARTY_NAME', 'Display': 'Name'},
        {'Column': 'MOBILE_NO', 'Display': 'Mobile'},
        {'Column': 'ASSIGNMENT_STATUS', 'Display': 'N'},
        // {'Column': 'EMAIL', 'Display': 'Email'},
        // {'Column': 'BLDG_NO', 'Display': 'Building'},
        // {'Column': 'APARTMENT_NO', 'Display': 'Apartment'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}];


      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'GCYLINDER_BOOKING',
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
    else   if(mode == "SLMAST"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'SLCODE', 'Display': 'Code'},
        {'Column': 'SLDESCP', 'Display': 'Name'},
        {'Column': 'MOBILE', 'Display': 'Mobile'},
        {'Column': 'EMAIL', 'Display': 'Email'},
        {'Column': 'BUILDING_CODE', 'Display': 'Building'},
        {'Column': 'APARTMENT_CODE', 'Display': 'Apartment'},
        {'Column': 'ADDRESS1', 'Display': 'Address'},
        {'Column': 'REMARKS', 'Display': ''},
        // {'Column': 'APARTMENT_CODE', 'Display': 'Apartment'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[
        {'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'},
        {'Column': "ACTYPE", 'Operator': '=', 'Value': 'AR', 'JoinType': 'AND'},
      ];

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
            lstrTable: 'SLMAST',
            title: 'Customer Details',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'SLCODE',
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
        {'Column': 'AREA', 'Display': 'Area'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}];
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
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'}];
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
    else if(mode == "CRDELIVERYMANMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DEL_MAN_CODE', 'Display': 'Code'},
        {'Column': 'NAME', 'Display': 'Name'},
        {'Column': 'VEHICLE_NO', 'Display': 'N'},
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
            keyColumn: 'DEL_MAN_CODE',
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
    else if(mode == "gcylinder_contract" ){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'CONTRACT_NO', 'Display': 'Contract_No'},
        {'Column': 'DOCTYPE', 'Display': 'N'},
        {'Column': 'SLCODE', 'Display': 'N'},
        {'Column': 'MOBILE1', 'Display': 'N'},
        {'Column': 'SLDESCP', 'Display': 'N'},
        {'Column': 'BUILDING_CODE', 'Display': 'N'},
        {'Column': 'APARTMENT_CODE', 'Display': 'N'},
        {'Column': 'ADD1', 'Display': 'N'},


      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[];
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'gcylinder_contract',
            title: 'ContractNumber',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'CONTRACT_NO',
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
txtCustomerName.clear();
cstmrName.value="";
cstmrCode.value="";



  }

  fnFillCustomerData(data,mode){


    // //Clear
    // if(mode == "GBUILDINGMASTER"){
    //   g.wstrBuildingCode= "";
    //   g.wstrBuildingName= "";
    //   txtBuildingCode.text = "";
    //   txtBuildingName.text  = "";
    //   txtApartmentCode.text  = "";
    //   fnCustomerClear();
    // }
    // else if(mode == "GAPARTMENTMASTER"){
    //   txtApartmentCode.text = "";
    //   fnCustomerClear();
    // }
    // else if(mode == "GUESTMASTER"){
    //   fnCustomerClear();
    // }

    //Fill
    if(g.fnValCheck(data)){
      if(mode  ==  "GBUILDINGMASTER"){
        dprint("1111111111111111111111   >> ${data["BUILDING_CODE"]}");

        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        txtBuildingName.text = data["DESCP"]??"";
        txtAreaCode.text = data["AREA"]??"";
        g.wstrBuildingCode = data["BUILDING_CODE"]??"";
        g.wstrBuildingName = data["DESCP"]??"";


      }
      else if(mode  ==  "GAPARTMENTMASTER"){
        g.wstrApartmentCode  = data["APARTMENT_CODE"]??"";
        txtApartmentCode.text =data["APARTMENT_CODE"]??"";
        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "SLMAST"){
        dprint("GUSTMSSTER DATTTS ${data}");
        txtCustomerCode.text  = data["SLCODE"]??"";
        txtCustomerName.text  = data["SLDESCP"]??"";

        txtContactNo.text  = data["MOBILE"]??"";
        txtApartmentCode.text = data["APARTMENT_CODE"]??"";

        txtAddress.text=data["ADDRESS1"]??"";
        txtRemark.text=data["REMARKS"]??"";

        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        g.wstrBuildingCode  = data["BUILDING_CODE"]??"";
        g.wstrApartmentCode  = data["APARTMENT_CODE"]??"";
        //    apiGetCustomerInfo();
      }
      else if(mode  ==  "CRDELIVERYMANMASTER"){
        dprint("1111111111111111111111");
        txtdriver.text = data["DEL_MAN_CODE"]??"";
        txtvehicleNumber.text = data["VEHICLE_NO"]??"";

      }
      else if(mode  ==  "CRVEHICLEMASTER"){
        txtvehicleNumber.text = data["VEHICLE_NO"]??"";

        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "gcylinder_contract"){
        dprint("dddddd<< DOCC >>ddddddd  ${data}");
        frContractno.value  = data["CONTRACT_NO"]??"";
        frContractType.value =data["DOCTYPE"]??"";
        txtCustomerCode.text  = data["SLCODE"]??"";
        txtCustomerName.text  = data["SLDESCP"]??"";
        txtContactNo.text  = data["MOBILE1"]??"";
        txtApartmentCode.text = data["APARTMENT_CODE"]??"";
        txtAddress.text=data["ADD1"]??"";
        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        apiViewContarctItem(frContractno.value,frContractType.value);

      }
      else if(mode  ==  "AREAMASTER"){
        txtAreaCode.text = data["DESCP"]??"";

        //   apiGetDriverDetails();
      }
      else if(mode  ==  "GPRIORITYMASTER"){
        priorityvalue.value = data["DESCP"]??"";

        //   apiGetCustomerDetails();
      }
    }

  }

  fnFillData(data,mode){
    //Fill
    if(g.fnValCheck(data)){

      if(mode== "GCYLINDER_BOOKING"){
        dprint("Booking dataaaaaaaaaaa ${data}");
        frDocno.value = data["DOCNO"];
        apiViewBooking(frDocno.value,"");
        // update();
      }

    }

  }

  fnFill(data){
    dprint("Docitemssss>>>>>>>  ${data}");




    var headerList  =g.fnValCheck(data["HEADER"])? data["HEADER"][0]:[];
    var detList  = g.fnValCheck(data["DET"])?data["DET"]:[];
    var assignmentList  = g.fnValCheck(data["ASSIGNMENTDET"])?data["ASSIGNMENTDET"]:[];
    var contract  =g.fnValCheck(data["CONTRACT"])? data["CONTRACT"][0]:[];
    var contractDet  = g.fnValCheck(data["CONTRACTDET"])?data["CONTRACTDET"]:[];
    dprint("HEADERLIST>>>>>>> ${headerList}");
    dprint("DET__LIST>>>>>>> ${detList}");
    dprint("ASSIGNMNT__LIST>>>>>>> ${assignmentList}");
    dprint("contract>>>>>>> ${contract}");
    dprint("CONTRACTDET>>>>>>> ${contractDet}");
    if(g.fnValCheck(headerList)){
      frDocno.value = (headerList["DOCNO"]??"").toString();
      frDocType.value = (headerList["DOCTYPE"]??"").toString();
      frLocation.value = (headerList["LOCATION"]??"").toString();
      priorityvalue.value = (headerList["PRIORITY"]??"NORMAL").toString();
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
      txtAreaCode.text = (headerList["AREA_CODE"]??"").toString();
      frAssignmentStatus.value = (headerList["ASSIGNMENT_STATUS"]??"").toString();
      frContractno.value = (headerList["CONTRACT_NO"]??"").toString();
      frContractType.value = (headerList["CONTRACT_DOCTYPE"]??"").toString();
      txtvehicleNumber.text =(headerList["VEHICLE_NO"]??"").toString();
      txtdriver.text =(headerList["DEL_MAN_CODE"]??"").toString();
      if(headerList["DELIVERY_REQ_DATE"] != null|| headerList["DELIVERY_REQ_DATE"] != ""){
        try{
          txtdelivryDate.text =setDate(15, DateTime.parse(headerList["DELIVERY_REQ_DATE"].toString()));

        }catch(e){
          dprint(e);
        }
      }

      if(headerList["DOCDATE"] != null|| headerList["DOCDATE"] != ""){
        try{
          docDate.value=DateTime.parse(headerList["DOCDATE"].toString());
        }catch(e){
          docDate.value =DateTime.now();
        }
      }

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
    if(g.fnValCheck(contract)){
      frContractno.value = (contract["CONTRACT_NO"]??"").toString();
      frContractType.value = (contract["DOCTYPE"]??"").toString();
     // frLocation.value = (contract["LOCATION"]??"").toString();
  //    priorityvalue.value = (contract["PRIORITY"]??"NORMAL").toString();
      txtCustomerName.text = (contract["SLDESCP"]??"").toString();
      cstmrName.value = (contract["SLDESCP"]??"").toString();
      txtCustomerCode.text = (contract["SLCODE"]??"").toString();
      cstmrCode.value = (contract["SLCODE"]??"").toString();
      txtContactNo.text = (contract["MOBILE1"]??"").toString();
      txtBuildingCode.text = (contract["BUILDING_CODE"]??"").toString();
      txtApartmentCode.text = (contract["APARTMENT_CODE"]??"").toString();
      txtRemark.text = (contract["REMARKS"]??"").toString();
      txtAddress.text = (contract["ADD1"]??"").toString();
    //  txtLandmark.text = (contract["LANDMARK"]??"").toString();
      txtAreaCode.text = (contract["AREA"]??"").toString();
    //  frAssignmentStatus.value = (contract["ASSIGNMENT_STATUS"]??"").toString();
    //   if(contract["DELIVERY_REQ_DATE"] != null|| contract["DELIVERY_REQ_DATE"] != ""){
    //     try{
    //       txtdelivryDate.text =setDate(15, DateTime.parse(contract["DELIVERY_REQ_DATE"].toString()));
    //
    //     }catch(e){
    //       dprint(e);
    //     }
    //   }
    //
    //   if(contract["DOCDATE"] != null|| contract["DOCDATE"] != ""){
    //     try{
    //       docDate.value=DateTime.parse(contract["DOCDATE"].toString());
    //     }catch(e){
    //       docDate.value =DateTime.now();
    //     }
    //   }

    }
    if(g.fnValCheck(contractDet)){
      int i = 1;
     // lstrContarctList.value = [];
      lstrBookedList.value = [];
      for (var e in contractDet) {
        var datas = Map<String,dynamic>.from({
          "STKCODE":e["STKCODE"],
          "STKDESCP":e["STKDESCP"],
           "RATE":e["PRICE1"],
           "QTY": e["PLANNED_QTY"],
          // "AMT":  g.mfnDbl(e["QTY1"])*g.mfnDbl(e["RATE"]),
        });
        lstrBookedList.value.add(datas);
      //  lstrContarctList.value.add(datas);
        i++;
        update();
      }
      update();

    }


  }

  fnProceedToSave(context,header,det,assignmnt,assignmnt_details){
    if(txtCustomerName.value.text.isEmpty){
      errorMsg(context, "Choose Customer");
      return;
    }
    // if(txtBuildingCode.text.isEmpty){
    //   errorMsg(context, "Choose Building");
    //   return;
    // }
    // //
    // if(txtApartmentCode.text.isEmpty){
    //   errorMsg(context, "Choose Apartment");
    //   return;
    // }
    // if(  g.wstrCylinderContractYN=="Y" && lstrContarctList.value.isEmpty){
    //     errorMsg(context, "Choose Items");
    //     return;
    else if(lstrBookedList.value.isEmpty &&  g.wstrCylinderContractYN=="N"){
        errorMsg(context, "Choose BookedItems");
        return;
      }





    apiSaveBooking(header,det,assignmnt,assignmnt_details,context);




  }


  fnChngeQty(itemCode,mode,rate) {
    var taxAmount = ''.obs;
    var itemMenu = lstrProductItemDetailList.value.where((element) => element["STKCODE"] == itemCode).toList();

    dprint("Item>>>>>> ${itemMenu}");
    dprint("Mode>>>>> ${mode}");
    dprint("price>>>>> ${rate}");
    
    if(mode == "A"){
      if(lstrBookedList.where((e) => e["STKCODE"] == itemCode).isEmpty){
        var datas = Map<String, Object>.from({
          "STKCODE": itemCode,
          "STKDESCP": itemMenu[0]["STKDESCP"],
          "QTY": 1,
          "HEADER_DISC": 0.0,
          "DISC_AMT": 0.0,
          "AMT": 0.0,
          "RATE":rate,
          "TAX_PER":0.0,
          "TAXABLE_AMT": 0.0,
          "TOTAL_TAX_AMOUNT": 0.0,
          "NET_AMOUNT": 0.0,
        });
        lstrBookedList.add(datas);
      }
      else{
        var item = lstrBookedList.where((element) => element["STKCODE"] == itemCode).toList();
        if(item.isNotEmpty){
          item[0]["QTY"] = g.mfnDbltoInt(item[0]["QTY"]) + 1;
        }
      }
    }else{
      var item = lstrBookedList.where((element) => element["STKCODE"] == itemCode).toList();
      if(item.isNotEmpty){
        item[0]["QTY"] = item[0]["QTY"] == 0?0: g.mfnDbltoInt(item[0]["QTY"]) - 1;
      }
    }
    lstrBookedList.removeWhere((element) => element["QTY"] <= 0);

  }
  // fnChngeQtyOnContract(itemCode,mode,rate) {
  //
  //   dprint("contracttttttttttt>>>>");
  //   var taxAmount = ''.obs;
  //   var itemMenu = lstrProductItemDetailList.value.where((element) => element["STKCODE"] == itemCode).toList();
  //
  //   dprint("Item>>>>>> ${itemMenu}");
  //   dprint("Mode>>>>> ${mode}");
  //   dprint("price>>>>> ${rate}");
  //
  //   if(mode == "A"){
  //     if(lstrContarctList.where((e) => e["STKCODE"] == itemCode).isEmpty){
  //       var datas = Map<String, Object>.from({
  //         "STKCODE": itemCode,
  //         "STKDESCP": itemMenu[0]["STKDESCP"],
  //         "QTY": 1,
  //         "HEADER_DISC": 0.0,
  //         "DISC_AMT": 0.0,
  //         "AMT": 0.0,
  //         "RATE":rate,
  //         "TAX_PER":0.0,
  //         "TAXABLE_AMT": 0.0,
  //         "TOTAL_TAX_AMOUNT": 0.0,
  //         "NET_AMOUNT": 0.0,
  //       });
  //       lstrContarctList.add(datas);
  //     }
  //     else{
  //       var item = lstrContarctList.where((element) => element["STKCODE"] == itemCode).toList();
  //       if(item.isNotEmpty){
  //         item[0]["QTY"] = g.mfnDbltoInt(item[0]["QTY"]) + 1;
  //       }
  //     }
  //   }else{
  //     var item = lstrContarctList.where((element) => element["STKCODE"] == itemCode).toList();
  //     if(item.isNotEmpty){
  //       item[0]["QTY"] = item[0]["QTY"] == 0?0: g.mfnDbltoInt(item[0]["QTY"]) - 1;
  //     }
  //   }
  //   lstrContarctList.removeWhere((element) => element["QTY"] <= 0);
  //
  // }


  var selectedproduct="".obs;

  wOpenBottomSheet(context) {
    dprint("bottomsheetvalue..........  ${lstrProductTypeList.value}");
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:Radius.circular(30) ),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        StatefulBuilder(
          builder: (context,setState){
            return Container(
              height: MediaQuery.of(context).size.height*0.7,
              padding: const EdgeInsets.symmetric(horizontal: 15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        gapHC(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Column(crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 tc("Product Type", txtColor, 15),
                                 Container(
                                   width: 80,
                                   height: 5,
                                   decoration: BoxDecoration(
                                       color: primaryColor,
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                 ),
                               ],
                             ),
                             Bounce(
                                 duration: const Duration(milliseconds: 110),
                               onPressed: (){
                                   Get.back();
                               },
                               child: Container(
                                 padding: EdgeInsets.all(4),

                                   child: Icon(Icons.close)),
                             ),
                          ],
                        ),

                        gapHC(10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: wProductItem(),
                          ),
                        ),
                        gapHC(10),
                        Expanded(child:StatefulBuilder(
                            builder: (BuildContext context, StateSetter setstate) {
                              // dprint("CylinderType :: ${selectedcylinder.value}");
                              return Obx(() => Column(
                                children: [
                                  gapHC(3),

                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: lstrProductItemDetailList.value.length,
                                        itemBuilder: (context, index) {

                                          //    {  "STKCODE": "FIVE", "STKDESCP": "5L", "NRATE": 20.0, "RRATE": 10.0,"TYPE":"R","QTY":1},
                                          var itemName = (lstrProductItemDetailList[index]["STKDESCP"] ?? "").toString();
                                          var itemCode = (lstrProductItemDetailList[index]["STKCODE"] ?? "").toString();

                                          var price1 = g.mfnDbl(lstrProductItemDetailList[index]["PRICE1"].toString());

                                          var item = lstrBookedList.where((element) => element["STKCODE"] == itemCode).toList();
                                           dprint("iteeeeeeeeeee ${item}");
                                          var vat = g.mfnDbl(lstrProductItemDetailList[index]["VAT"]
                                                  .toString());
                                          dprint("vaaattttttttttt  ${vat}");
                                          var qty = item.isNotEmpty?item[0]["QTY"]:0;


                                          return Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 5,vertical:3),
                                            padding: const EdgeInsets.all(10),
                                            decoration: boxDecorationS(white, 10),
                                            child: Column(
                                              children: [
                                                gapHC(2),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(child: tc(itemName,txtColor, 10)),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: [
                                                        qty>0?
                                                        Bounce(onPressed: () {
                                                          setstate(()
                                                          {
                                                            fnChngeQty(itemCode,"D",price1);
                                                        });
                                                          },
                                                          duration: const Duration(milliseconds: 110), child: Container(
                                                              height: 30,
                                                              width: 35,
                                                              decoration:boxDecorationS(primaryColor, 10),
                                                              // decoration:qty!=0||qty!=0?boxGradientDecoration(0, 10):null,
                                                              //        decoration:selectedcylinder=="new"&&newQty!=0?boxGradientDecoration(0, 10):null,
                                                              child: const Center(
                                                                  child: Icon(
                                                                    Icons.remove,
                                                                    color: Colors.white,
                                                                    size: 16,
                                                                  ))),
                                                        ):gapHC(0),
                                                        gapWC(5),
                                                        qty>0?
                                                        tc((qty.toString()), txtColor, 12):gapHC(0),
                                                        gapWC(5),
                                                        Bounce(
                                                          onPressed: () {
                                                            setstate(() {
                                                              fnChngeQty(itemCode,"A",price1);
                                                            });
                                                          },
                                                          duration: const Duration(
                                                              milliseconds: 110),
                                                          child: Container(
                                                              height: 30,
                                                              width:qty>0? 35:60,
                                                              decoration:boxDecoration(primaryColor, 10),
                                                              child: const Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: Colors.white,
                                                                    size: 16,
                                                                  ))),
                                                        ),
                                                      ],
                                                    ),



                                                  ],
                                                ),

                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ));
                            }))





                      ],
                    ),
                  ),

                ],
              ),
            );
          },

        )

    );
    // apiProductTypeDetails(34, callback);

  }
  wProductItem() {
    List<Widget> rtnPrdctList = [];
    int i=0;
    for (var e in lstrProductTypeList.value) {
      var productName = e["CODE"];

      rtnPrdctList.add(
          Obx(() =>  Padding(
            padding: const EdgeInsets.only(left: 8),
            child: GestureDetector(
              onTap: (){
                selectedproduct.value=productName??"";
                apiProductTypeDetails(selectedproduct.value);

                dprint("aaaaaaaaaaaaac ${productName}");
              },
              child: Container(
                decoration:BoxDecoration(
                  color: selectedproduct.value==productName?subColor: white,
                  border: Border.all(color: subColor,width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Center(
                  child: tc(productName, selectedproduct.value==productName?white:txtColor, 12),
                ),
              ),
            ),
          )));
      i++;
    }
    update();
    return rtnPrdctList;
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
    futureform = ApiCall().LookupSearch("GPRIORITYMASTER ",columnList,0, 100, lstrFilter);
    futureform.then((value) => apiGetPriorityRes(value));
  }
  apiGetPriorityRes(value){
    if(g.fnValCheck(value)){
      priorityList.value = value;
      dprint("priooooooooooooooooo  ${priorityList.value }");
      update();


    }

  }

  apiAddBuilding(code,name,context){
    futureform = ApiCall().addBuilding(code,name);
    futureform.then((value) => apiAddBuildinggRes(value,context));
  }
  apiAddBuildinggRes(value,context){
    dprint("ddvaaalaueeeeeeeeeee ${value}");
    if(g.fnValCheck(value)){
      var sts = value[0]["STATUS"];
      var msg = value[0]["MSG"];
      var buildingCode = value[0]["CODE"];
      if(sts=="1"){
        dprint(msg);
        txtBuildingCode.text = buildingCode;
        Get.back();
      }else{
        errorMsg(context, msg);
      }


    }

  }

  //
  // apiGetCustomerDetails(slcode){
  //   futureform = ApiCall().apiViewCustomerDetails(slcode);
  //   futureform.then((value) => apiGetCustomerDetailsRes(value));
  // }
  // apiGetCustomerDetailsRes(value){
  //   if(g.fnValCheck(value)){
  //  //   fnFillCustomerDetails(value);
  //   }
  //
  // }

  apiAddApartment(aprtmntcode,buildingcode,context){
    futureform = ApiCall().addAppartmnt(aprtmntcode,buildingcode);
    futureform.then((value) => apiAddApartmentRes(value,context));
  }
  apiAddApartmentRes(value,context){
    dprint("apaaaaaaaaart ${value}");
    if(g.fnValCheck(value)){
      var sts = value[0]["STATUS"];
      var msg = value[0]["MSG"];
      var buildingCode = value[0]["CODE"];
      if(sts=="1"){
        dprint(msg);
        txtApartmentCode.text = buildingCode;
        Get.back();
      }else{
          errorMsg(context, msg);
      }


    }

  }

  apiProductType() {
    var lstrFilter = [];
    var columnList = 'CODE|DESCP|';
    futureform = ApiCall().LookupSearch("PRODUCT_TYPE", columnList, 0, 100, lstrFilter);
    futureform.then((value) => apiGetProductTypeRes(value));
  }
  apiGetProductTypeRes(value) {
    if (g.fnValCheck(value)) {
      dprint("xxxxxxxx  ${value}");
      lstrProductTypeList.value = value;
      update();
    }
  }

  apiProductTypeDetails(product_type) {
    dprint("product_type..... ${product_type}");
    var lstrFilter = [
      {
        'Column': "COMPANY",
        'Operator': '=',
        'Value': g.wstrCompany,
        'JoinType': 'AND'
      },
      {
        'Column': "PRODUCT_TYPE",
        'Operator': '=',
        'Value': product_type,
        'JoinType': 'AND'
      },
    ];

    var columnList = 'STKCODE|STKDESCP|PRODUCT_TYPE|PRICE1|PRICE2|';
    futureform = ApiCall().LookupSearch("STOCKMASTER", columnList, 0, 100, lstrFilter);
    futureform.then((value) => apiProductTypeDetailsRes(value));
  }
  apiProductTypeDetailsRes(value) {
    if (g.fnValCheck(value)) {
      dprint("Producttypeppp43243ppppp  ${value}");
      lstrProductItemDetailList.value = value;
      update();
    }
  }

  apiSaveBooking(header,det,assignmnt,assignmnt_details,context){
    dprint("!!!!!!!!!!!!!apiiii");

    futureform = ApiCall().saveBooking(wstrPageMode.value,header,det,assignmnt,assignmnt_details);
    futureform.then((value) => apiSaveBookingRes(value,context));
  }
  apiSaveBookingRes(value,context){

    if(g.fnValCheck(value)){
      var sts  =  value[0]["STATUS"];
      var msg  =  value[0]["MSG"]??"";
      if(sts == "1"){
        frDocno.value = value[0]["CODE"];
        var doctype = value[0]["DOCTYPE"];
        wstrPageMode.value ="VIEW";
        apiViewBooking(frDocno.value, "LAST");
        successMsg(context, msg);

        // CustomToast.showToast(msg.toString(), ToastType.success, ToastPositionType.end);
      }else{
        errorMsg(context, msg);
      }
    }
  }

  apiViewContarctItem(contrNo,docTytpe){
    futureform = ApiCall().apiViewContractItem(contrNo,docTytpe);
    futureform.then((value) => apiViewContarctItemRes(value));
  }
  apiViewContarctItemRes(value){
    if(g.fnValCheck(value)){
      dprint("contracttttttttttt  ${value}");
      // frDocType.value="";
      // frDocno.value="";
      // docDate.value =setDate(15,DateTime.now());
      // priorityvalue.value='NORMAL';

      // fnClear();
      fnFill(value);
    }

  }
}