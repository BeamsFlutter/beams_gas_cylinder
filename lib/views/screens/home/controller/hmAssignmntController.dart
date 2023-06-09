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
  RxString frDocno="".obs;
  var frDocType="GCA".obs;
  var salesOrderDocNO="".obs;
  var salesOrderDocType="".obs;

  RxString frLocation="".obs;
  var totalAssignedValue='56'.obs;
  var pendingAssignedValue='23'.obs;

  RxString frdriverName="".obs;
  RxString frEmpCode="".obs;
  RxString frdriverCode="".obs;
  RxString frvehiclenumber="".obs;
  RxString ctmrApartmentDescp="".obs;
  RxString ctmrBuildingDescp="".obs;
  RxString partyCode="".obs;
  RxString frbookingDocType="".obs;
  RxString frBookingYearCode="".obs;
  RxString ctmrphoneNumber="".obs;
  RxList lstrBookedItemList =[].obs;
  RxList lstrBookedHeaderList =[].obs;


  RxString bookingNumber = "".obs;
  RxBool checkAll = false.obs;

  var hmButtonsList =[
    {
      "ButtonName":"Contract",
      "ButtonCode":"C",

    },
    {
      "ButtonName":"Contract\n Receipt",
      "ButtonCode":"CR",
    },
    {
      "ButtonName":"Customer\n Balance",
      "ButtonCode":"CB",
    },
    {
      "ButtonName":"Booking",
      "ButtonCode":"B",
    },
    {
      "ButtonName":"SalesOrder",
      "ButtonCode":"SO",
    },

    {
      "ButtonName":"Assignment",
      "ButtonCode":"A",
    },
    {
      "ButtonName":"DeliveryOrder",
      "ButtonCode":"DO",
    },
    {
      "ButtonName":"Sales",
      "ButtonCode":"S",
    },
    {
      "ButtonName":"Collections",
      "ButtonCode":"CN",
    },







  ];
  var repButtonsList =[
    {
      "ButtonName":"Daily Sales",
      "ButtonCode":"DS",

    },
    {
      "ButtonName":"Collections",
      "ButtonCode":"CN",
    },
    {
      "ButtonName":"Assignment",
      "ButtonCode":"A",
    },
    {
      "ButtonName":"Booking",
      "ButtonCode":"B",
    },
    {
      "ButtonName":"Customer\n Balance",
      "ButtonCode":"CB",
    },
    {
      "ButtonName":"Others",
      "ButtonCode":"O",
    },



  ];



  var txtController = TextEditingController();


  //Page Head
  var priorityvalue="NORMAL".obs;

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
  var txtLandmark = TextEditingController();
  var txtAddress = TextEditingController();

  var txtdelivryDate = TextEditingController();
  var txtdocDate = TextEditingController();


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

  fnClear(){
    dprint("*********************************************** CLEAR function");
    frDocno.value ="";
    frLocation.value="";
    priorityvalue.value='NORMAL';
    priorityList.value=[];
    lstrBookedHeaderList.value=[];
    lstrBookedItemList.value=[];
    totalAssignedValue.value="";
    pendingAssignedValue.value="";
    frdriverCode.value="";
    frdriverName.value="";
    frvehiclenumber.value="";
    txtdelivryDate.text="";
    txtdocDate.text=setDate(15,DateTime.now());
    bookingNumber.value="";
    salesOrderDocNO.value="";
    salesOrderDocType.value="";





  }

  fnFillBookedDatas(data){
    dprint("Values>>>>ff>>>  ${data}");

    // fnClear();
     var headerList  =g.fnValCheck(data["HEADER"])? data["HEADER"]:[];
     var detList  = g.fnValCheck(data["DET"])?data["DET"]:[];

//    var assignmentList  = g.fnValCheck(data["ASSIGNMENTDET"])?data["ASSIGNMENTDET"]:[];
     dprint("HEADERLIST>>>>>>> ${headerList}");
     dprint("DET__LIST>>>>>>> ${detList.toList()}");
     dprint("bookingNumber.value>>>>>> ${bookingNumber.value}");



    if(g.fnValCheck(detList)){
      int i = 1;

      for (var e in detList) {
        var datas = Map<String,dynamic>.from({
          "STKCODE":e["STOCK_CODE"],
          "STKDESCP":e["STOCK_DESC"],
          "RATE":e["RATE"],
          "QTY": e["QTY1"],
          "BOOKINGNUMB": e["DOCNO"],
          "BOOKING_DOCTYPE": e["DOCTYPE"],
          "BOOKING_YEARCODE":e["YEARCODE"],
          "AMT":  g.mfnDbl(e["QTY1"])*g.mfnDbl(e["RATE"]),
          "STATUS":e["ASSIGN"],


        });


        lstrBookedItemList.value.add(datas);
        i++;
        update();
      }
      update();

    }

    if(g.fnValCheck(headerList)){
      int i = 1;

      for (var e in headerList) {
        var datas = Map<String,dynamic>.from({
          "BOOKINGNUMB":e["DOCNO"],
          "DOCNO":e["DOCNO"],
          "DOCTYPE":e["DOCTYPE"],
          "YEARCODE":e["YEARCODE"],
          "MOBILE_NO":e["MOBILE_NO"],
          "PARTY_NAME":e["PARTY_NAME"],
          "PARTY_CODE":e["PARTY_CODE"],
          "AREA_CODE": e["AREA_CODE"],
          "LOCATION": e["LOCATION"],
          "APARTMENT_NO": e["APARTMENT_NO"],
          "BLDG_NO": e["BLDG_NO"],
          "BOOKING_YEARCODE": e["YEARCODE"],
          "BOOKING_DOCTYPE": e["DOCTYPE"],
        });
        lstrBookedHeaderList.value.add(datas);
        i++;
        update();
      }
      update();

    }



  }

  fnFillSalesOrderDatas(data){
    dprint("Values>>>>ff>>>  ${data}");

    // fnClear();
    var headerList  =g.fnValCheck(data["HEADER"])? data["HEADER"]:[];
    var detList  = g.fnValCheck(data["DET"])?data["DET"]:[];

//    var assignmentList  = g.fnValCheck(data["ASSIGNMENTDET"])?data["ASSIGNMENTDET"]:[];
    dprint("HEADERLIST>>>>>>> ${headerList}");
    dprint("DET__LISTXXXXXXXXX>>>>>>> ${detList.toList()}");
    bookingNumber.value=detList[0]["PRVDOCNO"]??"";
    dprint("bookingNumber.value>>>>>> ${bookingNumber.value}");



    if(g.fnValCheck(detList)){
      int i = 1;

      for (var e in detList) {
        var datas = Map<String,dynamic>.from({
          "STKCODE":e["STKCODE"],
          "STKDESCP":e["STKDESCP"],
          "RATE":e["RATE"],
          "QTY": e["QTY1"],
          "BOOKINGNUMB": e["PRVDOCNO"],
          "DOCTYPE": e["DOCTYPE"],
          "DOCNO": e["DOCNO"],
          "YEARCODE":e["YEARCODE"],
          "BOOKING_DOCTYPE":e["PRVDOCTYPE"],
          "BOOKING_YEARCODE":e["PRVYEARCODE"],
           "CONTRACT_NO":e["CONTRACT_NO"],
          "CONTRACT_DOCTYPE":e["CONTRACT_DOCTYPE"]
          // "AMT":  g.mfnDbl(e["QTY1"])*g.mfnDbl(e["RATE"]),
          // "STATUS":e["ASSIGN"]


        });




        lstrBookedItemList.value.add(datas);
        i++;
        update();
      }
      update();

    }

    if(g.fnValCheck(headerList)){
      int i = 1;

      for (var e in headerList) {
        var datas = Map<String,dynamic>.from({
          // "BOOKINGNUMB":e["PRVDOCNO"],
          // "BOOKING_DOCTYPE":e["PRVDOCTYPE"],
          "MOBILE_NO":e["MOBILE"],
          "PARTY_NAME":e["PARTYNAME"],
          "PARTY_CODE":e["PARTYCODE"],
          "AREA_CODE": e["AREA_CODE"],
          "LOCATION": e["LOC"],
          "APARTMENT_NO": e["PROPERTY_CODE"],
          "BLDG_NO": e["BUILDING_CODE"],
        });
        lstrBookedHeaderList.value.add(datas);
        i++;
        update();
      }
      update();

    }



  }

  fnSave(context) {
  dprint("vehiclenu,ber>>>>>>>>>>>>>>>> ${frvehiclenumber.value}");
  dprint("priorityvalue,ber>>>>>>>>>>>>>>>> ${priorityvalue.value}");
  dprint("frdriverCode.value.,ber>>>>>>>>>>>>>>>> ${frdriverCode.value}");
  dprint("partyCode.value.value.,ber>>>>>>>>>>>>>>>> ${partyCode.value}");
  dprint("partyCode.value.value.,ber>>>>>>>>>>>>>>>> ${lstrBookedHeaderList[0]["PARTYCODE"]}");
  partyCode.value = lstrBookedHeaderList[0]["PARTY_CODE"];


    List tableAssignmnt=[];
    List tableAssignmntDetails=[];
    tableAssignmnt.add({

      "COMPANY": g.wstrCompany,
      "YEARCODE": g.wstrYearcode,
      "EMP_CODE": frdriverCode.value,
      "EMP_NAME": frdriverName.value,
      "CREATE_BY":g.wstrUsername,
      "AREA_CODE":frLocation.value,
      "DELIVERY_DATE":txtdelivryDate.text,
      "PRIORITY":priorityvalue.value,
      "VEHICLE_NO":frvehiclenumber.value


    });
    int i=1;
    for(var e in lstrBookedItemList.value){
      dprint("****dd*********NNN ${e}");

      if(frdriverCode.value.isNotEmpty){
        tableAssignmntDetails.add({
          "COMPANY": g.wstrCompany,
          "YEARCODE": g.wstrYearcode,
          "SRNO": i,
          "EMP_CODE":frdriverCode.value,
          "STATUS": "",
          "CYLINDER_CAT": "",
          "STOCK_CODE": e["STKCODE"].toString(),
          "STOCK_DESC": e["STKDESCP"].toString(),
          "PARTY_CODE": partyCode.value,
          "VEHICLE_NO": frvehiclenumber.value,
          "BOOKING_SRNO": i,
          "BOOKING_NO":e["BOOKINGNUMB"],
          "BOOKING_DOCTYPE": e["BOOKING_DOCTYPE"].toString(),
          "BOOKING_YEARCODE": e["BOOKING_YEARCODE"].toString(),
          "PRV_DOCNO":e["DOCNO"],
          "PRV_DOCTYPE": e["DOCTYPE"].toString(),
          "PRV_YEARCODE":e["YEARCODE"].toString(),
          "CONTRACT_DOCTYPE":e["CONTRACT_DOCTYPE"],
          "CONTRACT_NO":e["CONTRACT_NO"]

        });
      }
      i++;
    }

    if(frdriverName.value.isEmpty ){
      errorMsg(context, "Choose Driver");
      return;
    }
    else if(frvehiclenumber.value.isEmpty){
      errorMsg(context, "Choose VehicleNumber");

    }
    else if(txtdelivryDate.text.isEmpty){
      errorMsg(context, "Select DeliveryDate");

    }
    else if(priorityvalue.value.isEmpty){
      priorityvalue.value ="NORMAL";

    }
    else{
      apiSaveAssignmnet(tableAssignmnt,tableAssignmntDetails,context);
    }











  }

  fnDelete(){}




  //============================================NAVIGATE

  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();
    fnClear();

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
    if(mode=="GCYLINDER_BOOKING"){
      lstrBookedHeaderList.value=[];
      lstrBookedItemList.value=[];
      dprint("FILLL DATAS>>>>>  "+data.toString());
      dprint("FILLLssssssss>>>>>  "+lstrBookedHeaderList.toString());
      // dprint(data["DOCNO"]==);
      bookingNumber.value = data["DOCNO"].toString();
      dprint("BOOKING_NUMBERR>>>>>>>>>>>> ${bookingNumber.value}");

     if(lstrBookedHeaderList.where((p0) => p0["BOOKINGNUMB"] == data["DOCNO"]).isEmpty){
        apiViewBooking(bookingNumber.value,"");
      }
      update();
    }



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
        dprint(data);
        frdriverCode.value = data["DEL_MAN_CODE"];
        frvehiclenumber.value =data["VEHICLE_NO"]??"";
        frdriverName.value =data["NAME"]??"";
        frEmpCode.value =data["EMPCODE"]??"";

      }
      else if(mode  ==  "CRVEHICLEMASTER"){
        dprint(data);
        frvehiclenumber.value = data["VEHICLE_NO"]??"";

        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "GCYLINDER_ASSIGNMENT"){
        dprint("GCYLINDER_ASSIGNMENT>>>>>>>>>>> ${data.toString()}");
        frDocno.value = data["DOCNO"]??"";
        frDocType.value = data["DOCTYPE"]??"";

        apiViewAssignment(frDocno.value , "");
      }
      else if(mode  ==  "GPRIORITYMASTER"){
        priorityvalue.value = data["DESCP"]??"";

        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "AREAMASTER"){
        frLocation.value = data["DESCP"]??"";

        //   apiGetDriverDetails();
      }

      else if(mode  ==  "SO"){
        dprint("11111111111SDAaaS11111111111>> ${data}" );
        salesOrderDocNO.value = data["DOCNO"]??"";
        salesOrderDocType.value = data["DOCTYPE"]??"";
        apiViewSalesOrder( salesOrderDocNO.value,"",salesOrderDocType.value);


        //   apiGetCustomerDetails();
      }

    }

  }

  fnFillAssignmntData(data) {
    fnClear();
    dprint(data);

    List assignmntList  =g.fnValCheck(data["ASSIGNMENT"])? data["ASSIGNMENT"]:[];
    List assignmntDetailList  = g.fnValCheck(data["ASSIGNMENTDET"])?data["ASSIGNMENTDET"]:[];
    List bookingList  = g.fnValCheck(data["BOOKING"])?data["BOOKING"]:[];
    List bookingDetailList  = g.fnValCheck(data["BOOKINGDET"])?data["BOOKINGDET"]:[];
    frDocno.value = assignmntList[0]["DOCNO"]??"";
    frDocType.value = assignmntList[0]["DOCTYPE"]??"";
   // frvehiclenumber.value = assignmntList[0]["VEHICLE_NO"]??"";
    frdriverName.value = assignmntList[0]["EMP_NAME"]??"";
    frLocation.value= assignmntList[0]["AREA_CODE"]??"";
    priorityvalue.value= assignmntList[0]["PRIORITY"]??"";

    frvehiclenumber.value = assignmntDetailList[0]["VEHICLE_NO"]??"";
    partyCode.value = assignmntDetailList[0]["PARTY_CODE"]??"";
    if(assignmntList[0]["DOCDATE"] != null|| assignmntList[0]["DOCDATE"] != ""){
      try{
        dprint("dooooooooo  ${assignmntList[0]["DOCDATE"]}sdada ${assignmntList[0]["DOCDATE"].runtimeType}" );

        txtdocDate.text =setDate(15, DateTime.parse(assignmntList[0]["DOCDATE"].toString()));

      }catch(e){
        dprint(e);
      }
    }
    if(assignmntList[0]["DELIVERY_DATE"] != null|| assignmntList[0]["DELIVERY_DATE"] != ""){
      try{
        dprint("dooooooooo  ${assignmntList[0]["DELIVERY_DATE"]}sdada ${assignmntList[0]["DELIVERY_DATE"].runtimeType}" );

        txtdelivryDate.text =setDate(15, DateTime.parse(assignmntList[0]["DELIVERY_DATE"].toString()));

      }catch(e){
        dprint(e);
      }
    }
    //bookingNumber.value =bookingList[0]["DOCNO"];



    // var itemList,headerList;
    // if(bookingDetailList.isEmpty){
    //   dprint("trrrrr");
    //   itemList =assignmntDetailList;
    // }else{
    //   dprint("fffffff");
    //   itemList = bookingDetailList;
    //
    // }
    //
    // if(bookingList.isEmpty){
    //   dprint("trrrrr");
    //   headerList =assignmntList;
    // }else{
    //   dprint("fffffff");
    //   headerList = bookingList;
    //
    // }


    // List itemList = bookingDetailList==[]?assignmntDetailList:bookingDetailList;
    // dprint("<<<<<<<<<<headerList>>>>>>>>>> ${headerList.toList()}");






    if(g.fnValCheck(bookingDetailList)) {
      int i = 1;
      lstrBookedItemList.value = [];

      for (var e in bookingDetailList) {


        var datas = Map<String,dynamic>.from({
          "STKCODE":e["STOCK_CODE"],
          "STKDESCP":e["STOCK_DESC"],
          "RATE":e["RATE"],
          "QTY":g.mfnDbl(e["QTY1"]),
          "AMT":g.mfnDbl(e["QTY1"])*g.mfnDbl(e["RATE"]),
          "BOOKINGNUMB":e["DOCNO"],
          "BOOKINGDOCTYPE":e["DOCTYPE"]


        });
        //
        // frvehiclenumber.value =(e["VEHICLE_NO"]??"").toString();
        // frdriverCode.value =(e["DEL_MAN_CODE"]??"").toString();
        lstrBookedItemList.value.add(datas);
        i++;
        update();
      }
      update();

    }
    if(g.fnValCheck(bookingList)) {
      int i = 1;
      lstrBookedHeaderList.value = [];

      for (var e in bookingList) {
        dprint("bbbbbbbbbbbboooooooooooooo${e}");
        bookingNumber.value = e["DOCNO"];


        var datas = Map<String,dynamic>.from({
          "LOCATION":e["LOCATION"],
          "APARTMENT_NO":e["APARTMENT_NO"],
          "BLDG_NO":e["BLDG_NO"],
          "MOBILE_NO":e["MOBILE_NO"],
          "PARTY_NAME":e["PARTY_NAME"],
          "BOOKINGNUMB":e["DOCNO"],
           "CONTRACT_NO":e["CONTRACT_NO"],
          "CONTRACT_DOCTYPE":e["CONTRACT_DOCTYPE"]


        });
        //
        // frvehiclenumber.value =(e["VEHICLE_NO"]??"").toString();
        // frdriverCode.value =(e["DEL_MAN_CODE"]??"").toString();
        lstrBookedHeaderList.value.add(datas);
        i++;
        update();
      }
      update();

    }

  }

  //====================Lookup====================

  fnLookup(mode){
    dprint(mode);


    if(mode == "CRDELIVERYMANMASTER") {
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DEL_MAN_CODE', 'Display': 'Code'},
        {'Column': 'NAME', 'Display': 'Name'},
        {'Column': 'VEHICLE_NO', 'Display': 'N'},
        {'Column': 'EMPCODE', 'Display': 'N'},
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
    else if(mode == "GCYLINDER_ASSIGNMENT") {
      // if(wstrPageMode.value  != "VIEW"){
      //   return;
      // }
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'Code'},
        {'Column': 'DOCTYPE', 'Display': 'N'},
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
    else if(mode == "GCYLINDER_BOOKING"){
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
      var lstrFilter =[{'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'},
                      {'Column': "ASSIGNMENT_STATUS", 'Operator': '=', 'Value': "P", 'JoinType': 'AND'}
      ];
      if(frLocation.isNotEmpty){
        lstrFilter.add({'Column': "AREA_CODE", 'Operator': '=', 'Value': frLocation.value, 'JoinType': 'AND'});
      }


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
    else if(mode == "SO" ){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'DOCNO'},
        {'Column': "DOCTYPE", 'Display': 'N'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [

      ];
      var lstrFilter =[
        {'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'},
        {'Column': "ASSIGNMENT_STATUS", 'Operator': '=', 'Value': "P", 'JoinType': 'AND'},
      ];
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'SO',
            title: 'salesOrder doc',
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
  }

  //***********************************************************************API
  apiGetDriverDetails() {}


  apiViewBooking(docno,mode){
    futureform = ApiCall().apiViewBooking(docno,mode);
    futureform.then((value) => apiViewBookingRes(value));
  }
  apiViewBookingRes(value){
    if(g.fnValCheck(value)){
      fnFillBookedDatas(value);
    }

  }

  apiViewSalesOrder(docno,mode,doctype){
    futureform = ApiCall().apiViewSalesOrder(docno,mode,doctype);
    futureform.then((value) => apiViewSalesOrderRes(value));
  }
  apiViewSalesOrderRes(value){
    if(g.fnValCheck(value)){
     // fnClear();
      lstrBookedHeaderList.value=[];
      lstrBookedItemList.value=[];

      fnFillSalesOrderDatas(value);
    }

  }

  apiViewAssignment(docno,mode){
    dprint("vv ${frDocType.value} vv");
    futureform = ApiCall().apiViewAssignment(docno,mode,frDocType.value);
    futureform.then((value) => apiViewAssignmentRes(value));
  }
  apiViewAssignmentRes(value){
    if(g.fnValCheck(value)){
      fnClear();
      fnFillAssignmntData(value);
    }

  }


  apiSaveAssignmnet(tableassignmnt,tableassignmntDetails,context)
  {
    dprint("!!apiSaveAssignmnetapiiii");
    futureform = ApiCall().saveAssignment(wstrPageMode.value,tableassignmnt,tableassignmntDetails);
    futureform.then((value) => apiSaveAssignmnetRes(value,context));
  }
  apiSaveAssignmnetRes(value,context){

    if(g.fnValCheck(value)){
      var sts  =  value[0]["STATUS"];
      var msg  =  value[0]["MSG"]??"";
      if(sts == "1"){
        frDocno.value = value[0]["CODE"];
        var doctype = value[0]["DOCTYPE"];
        wstrPageMode.value ="VIEW";
        successMsg(context, msg);
        apiViewAssignment('',"LAST");

      }else{
        errorMsg(context, msg);

      }



    }else{




    }
  }




}