import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../../components/lookup/lookup.dart';
import '../../../styles/colors.dart';
import 'package:badges/badges.dart' as badges;

class HmSalesController extends GetxController{

  Rx<DateTime> docDate = DateTime.now().obs;
  RxString frDocno="".obs;
  var g  = Global();
  var wstrPageMode = "VIEW".obs;
  late Future <dynamic> futureform;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "IT".obs;
  var cstmrName = "".obs;
  var cstmrCode = "".obs;
  var pageIndex = 0.obs;
  late PageController pageController;

  RxInt rqty = 0.obs;
  RxInt nqty = 0.obs;
  RxInt eqty = 0.obs;
  var selectedproduct="".obs;
  var selectedItem=''.obs;
  var selectedItemType=''.obs;
  var selectedRate=''.obs;
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
  var txtAreacode = TextEditingController();
  var txtDriver = TextEditingController();
  var txtVehiclenumber= TextEditingController();
  var txtController= TextEditingController();
  var txtlocation= TextEditingController();

  //************************PAYMENT__CONTROLLER
  var txtDiscountAmt = TextEditingController();
  var txtTotalAmt = TextEditingController();
  var txtTaxAmt = TextEditingController();
  var txtNetAmt = TextEditingController();
  var txtRoundAmt = TextEditingController();
  var txtPaidAmt = TextEditingController();
  var txtBalanceAmt = TextEditingController();
  var txtAddlAmt = TextEditingController();
  RxList lstrSalesList = [].obs;
  var lstrProductTypeList = [].obs;

  var lstrProductItemDetailList =[].obs;
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
    apiViewSales('', 'LAST');
  }

  fnPage(mode) {

    switch (mode) {
      case 'FIRST':
        apiViewSales('', mode);
        break;
      case 'LAST':
        apiViewSales('', mode);
        break;
      case 'NEXT':
        apiViewSales(frDocno.value, mode);
        break;
      case 'PREVIOUS':
        apiViewSales(frDocno.value, mode);
        break;
    }
  }

  fnClear(){}

  fnFill(data){}

  fnSave(context){}

  fnDelete(){}
  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }


  //**************************************************LOOKUP

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
      if(wstrPageMode.value  == "VIEW"){
        return;
      }
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'Code'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[];


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
    else   if(mode == "GUESTMASTER"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'GUEST_CODE', 'Display': 'Code'},
        {'Column': 'GUEST_NAME', 'Display': 'Name'},
        {'Column': 'MOBILE', 'Display': 'Mobile'},
        {'Column': 'EMAIL', 'Display': 'Email'},
        {'Column': 'BUILDING_CODE', 'Display': 'Building'},
        {'Column': 'APARTMENT_CODE', 'Display': 'Apartment'},
        // {'Column': 'LANDMARK', 'Display': ''},
        // {'Column': 'REMARKS', 'Display': ''},
        // {'Column': 'AREA_CODE', 'Display': ''},
        {'Column': 'ADD1', 'Display': ''},
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
    else if(mode == "LOCMAST" ){
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
            lstrTable: 'LOCMAST',
            title: 'Location',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'CODE',
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

  //**************************************************FUNCTION
  void fnFillData(data, mode) {}

  void fnFillCustomerData(data, mode) {
    if (g.fnValCheck(data)) {
      if (mode == "LOCMAST") {
        txtlocation.text = data["DESCP"] ?? "";

        //   apiGetCustomerDetails();
      }
      else if (mode == "GUESTMASTER") {
        dprint("RRRRRRRRRR ${data}");
        txtCustomerCode.text = data["GUEST_CODE"] ?? "";
        txtCustomerName.text = data["GUEST_NAME"] ?? "";
        txtContactNo.text = data["MOBILE"] ?? "";
        // frEmail.value  = data["EMAIL"]??"";
        cstmrCode.value = data["GUEST_CODE"] ?? "";
        cstmrName.value = data["GUEST_NAME"] ?? "";
        txtContactNo.text = data["MOBILE"] ?? "";
        txtApartmentCode.text = data["APARTMENT_CODE"] ?? "";
        txtAreacode.text = data["AREA_CODE"] ?? "";
        txtLandmark.text = data["LANDMARK"] ?? "";
        txtAddress.text = data["CUST_ADDRESS"] ?? "";
        txtRemark.text = data["REMARKS"] ?? "";
        txtBuildingCode.text = data["BUILDING_CODE"] ?? "";
        g.wstrBuildingCode = data["BUILDING_CODE"] ?? "";
        g.wstrApartmentCode = data["APARTMENT_CODE"] ?? "";
        //    apiGetCustomerInfo();
      }
      else if (mode == "CRDELIVERYMANMASTER") {
        dprint("fdfd ${data}");
        txtDriver.text = data["NAME"];
        txtVehiclenumber.text = data["VEHICLE_NO"]??txtVehiclenumber.text;
        //    apiGetCustomerInfo();
      }
      else if (mode == "CRVEHICLEMASTER") {
        dprint("RRRRRRRRRR ${data}");
        txtVehiclenumber.text = data["VEHICLE_NO"];

        //    apiGetCustomerInfo();
      }
    }
  }



  //**************************************************WIDGETS
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
  wOpenBottomSheet(context) {
    return Get.bottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:Radius.circular(30) ),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        StatefulBuilder(
          builder: (context,setState){
            return Container(
              height: MediaQuery.of(context).size.height*0.7,
              padding: const EdgeInsets.symmetric(horizontal: 10),


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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding: const EdgeInsets.all(4),

                                  child: const Icon(Icons.close)),
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

                                          var nrate = g.mfnDbl(lstrProductItemDetailList[index]["PRICE1"].toString());
                                          var rrate = g.mfnDbl(lstrProductItemDetailList[index]["PRICE2"].toString());
                                          var erate = g.mfnDbl("200");

                                          var item = lstrSalesList.value.where((element) => element["STKCODE"] == itemCode).toList();
                                          var itemR = item.where((element) => element["TYPE"] == "R").toList();
                                          var itemN = item.where((element) => element["TYPE"] == "N").toList();
                                          var itemE = item.where((element) => element["TYPE"] == "E").toList();
                                          // dprint("itemRrrr ${itemR}");
                                          rqty.value = itemR.length > 0
                                              ? g.mfnDbltoInt(itemR[0]["QTY"])
                                              : 0;
                                          nqty.value = itemN.length > 0
                                              ?  g.mfnDbltoInt(itemN[0]["QTY"])
                                              : 0;
                                          eqty.value = itemE.length > 0
                                              ?  g.mfnDbltoInt(itemE[0]["QTY"])
                                              : 0;

                                          return Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 5,vertical:3),
                                            padding: const EdgeInsets.all(10),
                                            decoration: boxDecorationS(white, 10),
                                            child: Column(
                                              children: [
                                                gapHC(2),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [

                                                    tc(itemName,txtColor, 10),
                                                  ],
                                                ),
                                                const Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    badges.Badge(
                                                      badgeContent: tcn(
                                                          nqty.value.toString() ?? "",
                                                          white,
                                                          10),
                                                      showBadge: nqty.value == 0.0
                                                          ? false
                                                          : true,
                                                      badgeStyle: badges.BadgeStyle(
                                                        shape: badges.BadgeShape.circle,
                                                        padding: const EdgeInsets.all(7),
                                                        borderRadius:
                                                        BorderRadius.circular(1),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setstate(() {
                                                            selectedItem.value = itemCode;
                                                            selectedItemType.value = "N";
                                                          });
                                                        },
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 3),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                              border: Border.all(
                                                                color: ((selectedItem.value ==
                                                                    itemCode &&
                                                                    selectedItemType.value ==
                                                                        "N")
                                                                    ? subColor
                                                                    : AppTheme
                                                                    .background),
                                                                width: 2,
                                                              )),
                                                          child: Column(
                                                            children: [
                                                              tc("New", txtColor, 10),
                                                              gapHC(3),
                                                              tc("${nrate} AED", txtColor,
                                                                  10)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    badges.Badge(
                                                      badgeContent: tcn(
                                                          rqty.value.toString() ?? "",
                                                          white,
                                                          10),
                                                      showBadge: rqty.value == 0.0
                                                          ? false
                                                          : true,
                                                      badgeStyle: badges.BadgeStyle(
                                                        shape: badges.BadgeShape.circle,
                                                        padding: const EdgeInsets.all(7),
                                                        borderRadius:
                                                        BorderRadius.circular(1),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setstate(() {
                                                            selectedItem.value = itemCode;
                                                            selectedItemType.value = "R";
                                                          });
                                                        },
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 3),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                              border: Border.all(
                                                                color: ((selectedItem.value ==
                                                                    itemCode &&
                                                                    selectedItemType.value ==
                                                                        "R")
                                                                    ? subColor
                                                                    : AppTheme
                                                                    .background),
                                                                width: 2,
                                                              )),
                                                          child: Column(
                                                            children: [
                                                              tc("Refill", txtColor, 10),
                                                              gapHC(3),
                                                              tc("${rrate} AED", txtColor,
                                                                  10),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    badges.Badge(
                                                      badgeContent: tcn(
                                                          eqty.value.toString() ?? "",
                                                          white,
                                                          10),
                                                      showBadge: eqty.value == 0.0
                                                          ? false
                                                          : true,
                                                      badgeStyle: badges.BadgeStyle(
                                                        shape: badges.BadgeShape.circle,
                                                        padding: const EdgeInsets.all(7),
                                                        borderRadius:
                                                        BorderRadius.circular(1),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setstate(() {
                                                            selectedItem.value = itemCode;
                                                            selectedItemType.value = "E";
                                                          });
                                                        },
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 3),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                              border: Border.all(
                                                                color: ((selectedItem.value == itemCode && selectedItemType.value == "E")
                                                                    ? subColor
                                                                    : AppTheme
                                                                    .background),
                                                                width: 2,
                                                              )),
                                                          child: Column(
                                                            children: [
                                                              tc("Empty", txtColor, 10),
                                                              gapHC(3),
                                                              tc("${erate} AED", txtColor,
                                                                  10),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                gapHC(5),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    rqty.value != 0 && selectedItemType.value == "R" || nqty.value != 0 && selectedItemType.value == "N"||eqty.value != 0 && selectedItemType.value == "E"
                                                        ? Bounce(
                                                      onPressed: () {
                                                        setstate(() {
                                                          if (selectedItem.value ==
                                                              null ||
                                                              selectedItem.value !=
                                                                  itemCode) {
                                                            wShowitemSelectedornot();
                                                          } else {
                                                            fnChngeQty(itemCode, selectedItemType.value, "D",nrate,erate,rrate);
                                                          }
                                                        });
                                                      },
                                                      duration: const Duration(
                                                          milliseconds: 110),
                                                      child: Container(
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
                                                    )
                                                        : gapHC(0),
                                                    gapWC(5),
                                                    Bounce(
                                                      onPressed: () {
                                                        setstate(() {
                                                          if (selectedItem.value == null ||
                                                              selectedItem.value != itemCode) {
                                                            wShowitemSelectedornot();
                                                          } else {
                                                            fnChngeQty(itemCode, selectedItemType.value,"A",nrate,erate,rrate);
                                                          }
                                                        });
                                                      },
                                                      duration: const Duration(
                                                          milliseconds: 110),
                                                      child: Container(
                                                          height: 30,
                                                          width: 55,
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

    ).whenComplete((){
      // fnPaymntCalc();


    });



    // apiProductTypeDetails(product["CODE"], callback);
  }

  SnackbarController wShowitemSelectedornot() {
    return Get.showSnackbar(
      const GetSnackBar(
        message: 'Please Select a Type',
        duration: Duration(seconds: 3),
      ),
    );
  }

  List<Widget> wSalesItemList(context){
    List<Widget> rtnList =[];
    var ftotal  = 0.0;
    var ftaxamount  = 0.0;



    // Get.find<SalesController>().txtTotalAmt.value.text="" ;
    for(var e  in lstrSalesList.value){
      dprint(">>>>>>MMMMMMMMM ${e}");


      var itemName  = (e["STKDESCP"]??"").toString();
      var itemCode  = (e["STKCODE"]??"").toString();
      var rate  = g.mfnDbl(e["RATE"].toString());
      var type  = (e["TYPE"]??"").toString();
      var qty  = g.mfnDbl(e["QTY"].toString());
      var total = qty*rate;
      var taxAmount =g.mfnDbl(e["TAX_AMT"].toString());
      var amt =total;
      ftotal += amt;
      ftaxamount+=taxAmount;
      // salesController.fnCalc();
      //  salesController.fnPaymntCalc();
      // salesController.fnTotal(ftotal);





      rtnList.add( Padding(
        padding: const EdgeInsets.only(left: 5,bottom: 2),
        child: badges.Badge(
          badgeContent: tcn((type=="E")?"Empty":(type=="N")?"New":(type=="R")?"Refill":"",white, 8),
          showBadge: true,
          position: BadgePosition.topStart(top: 5,start: 2),
          stackFit: StackFit.passthrough,
          badgeStyle: badges.BadgeStyle(
            badgeColor: (type=="E")?Colors.redAccent:(type=="N")?Colors.green:(type=="R")?Colors.blueAccent:Colors.redAccent,

            padding: EdgeInsets.symmetric(horizontal: 16,),
            shape: badges.BadgeShape.square,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),
                topRight: Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: InkWell(
              onLongPress: (){
                wDeletItemSelect(context,itemCode,type);
                dprint(">>>>>looooooooo>>>>>> ${itemCode}");
              },


              onTap: (){
                dprint(">>>>>fff>>>>>> ${itemCode}");
                wItemSelect(context,itemCode,type,qty);
              },
              child: Container(
                decoration: boxBaseDecoration(
                    bGreyLight, 0),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: tcn(itemName.toString(),
                                    Colors.black, 10),
                              )
                            ],
                          ),
                        )),
                    // Flexible(
                    //     flex: 1,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment
                    //           .end,
                    //       children: [
                    //         tcn((type=="E")?"Empty":(type=="N")?"New":(type=="R")?"Refill":"", Colors.black, 10),
                    //         gapWC(10)
                    //       ],
                    //     )),
                    Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end,
                          children: [
                            tcn(rate.toString(), Colors.black, 10)
                          ],
                        )),
                    Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end,
                          children: [
                            tcn(qty.toString(),
                                Colors.black, 10)
                          ],
                        )),
                    Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end,
                          children: [
                            tcn(total.toString(), Colors.black, 10)
                          ],
                        )),
                  ],
                ),

              ),
            ),
          ),
        ),
      ));

    }

    return rtnList;
  }

  wItemSelect(context,itemCodee,type,itemqty){

    selectedItemType.value = type;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 45),
          child: StatefulBuilder(
            builder:(context,setstate){

              var item = lstrSalesList.where((el) => el["STKCODE"]==itemCodee).toList()??[];
              if(item.isEmpty){
                Get.back();
                return Container();
              }
              var itemName  = (item[0]["STKDESCP"]??"").toString();
              var itemCode  = (item[0]["STKCODE"]??"").toString();
              var rate  = g.mfnDbl(item[0]["RATE"].toString());
              var type  = (item[0]["TYPE"]??"").toString();
              var qty  = itemqty;
              //  var qty  = g.mfnDbl(item[0]["QTY"].toString());
              var total = qty*rate;
              var taxAmount =g.mfnDbl(item[0]["TAX_AMT"].toString());
              var amt =total;

              var nrate=(item[0]["NRATE"]??"").toString();
              var erate=(item[0]["ERATE"]??"").toString();
              var rrate=(item[0]["RRATE"]??"").toString();;
              var itemR = item.where((element) => element["TYPE"] == "R").toList();
              var itemN = item.where((element) => element["TYPE"] == "N").toList();
              var itemE = item.where((element) => element["TYPE"] == "E").toList();
              // dprint("itemRrrr ${itemR}");
              rqty.value = itemR.length > 0
                  ? g.mfnDbltoInt(itemR[0]["QTY"])
                  : 0;
              nqty.value = itemN.length > 0
                  ?  g.mfnDbltoInt(itemN[0]["QTY"])
                  : 0;
              eqty.value = itemE.length > 0
                  ?  g.mfnDbltoInt(itemE[0]["QTY"])
                  : 0;
              dprint("RQTY>>>>> ${rqty.value}");
              dprint("EQTY>>>>> ${eqty.value}");
              dprint("NQTY>>>>> ${nqty.value}");

              return AlertDialog(contentPadding: EdgeInsets.zero,
                  // title: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //
                  //     children: [
                  //
                  //       gapWC(5),
                  //       Bounce(
                  //           duration: const Duration(
                  //               milliseconds: 110),
                  //           onPressed: (){
                  //             Get.back();
                  //           },
                  //           child: Icon(Icons.close))
                  //     ] ),
                  shape:  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  scrollable: true,
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: Obx(() =>  Column(

                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: boxBaseDecoration(white, 20),
                            child: Bounce(child: const Icon(Icons.close),     duration: const Duration(
                                milliseconds: 110), onPressed: (){
                              Get.back();

                            }),
                          ),
                        ),
                        tc(itemName, txtColor, 12),
                        gapHC(8),
                        const Divider(),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            badges.Badge(
                              badgeContent: tcn(
                                  nqty.value.toString() ?? "",
                                  white,
                                  10),
                              showBadge: nqty.value == 0.0
                                  ? false
                                  : true,
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.circle,
                                padding: const EdgeInsets.all(7),
                                borderRadius:
                                BorderRadius.circular(1),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setstate(() {
                                    selectedItem.value = itemCode;
                                    selectedItemType.value = "N";
                                  });
                                },
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 3),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      border: Border.all(
                                        color: ((selectedItem.value ==
                                            itemCode &&
                                            selectedItemType.value ==
                                                "N")
                                            ? subColor
                                            : AppTheme
                                            .background),
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      tc("New", txtColor, 10),
                                      gapHC(3),
                                      tc("${nrate} AED", txtColor,
                                          10)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            gapHC(5),
                            badges.Badge(
                              badgeContent: tcn(
                                  rqty.value.toString() ?? "",
                                  white,
                                  10),
                              showBadge: rqty.value == 0.0
                                  ? false
                                  : true,
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.circle,
                                padding: const EdgeInsets.all(7),
                                borderRadius:
                                BorderRadius.circular(1),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setstate(() {
                                    selectedItem.value = itemCode;
                                    selectedItemType.value = "R";
                                  });
                                },
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 3),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      border: Border.all(
                                        color: ((selectedItem.value ==
                                            itemCode &&
                                            selectedItemType.value ==
                                                "R")
                                            ? subColor
                                            : AppTheme
                                            .background),
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      tc("Refill", txtColor, 10),
                                      gapHC(3),
                                      tc("${rrate} AED", txtColor,
                                          10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            gapHC(5),

                            badges.Badge(
                              badgeContent: tcn(
                                  eqty.value.toString() ?? "",
                                  white,
                                  10),
                              showBadge: eqty.value == 0.0
                                  ? false
                                  : true,
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.circle,
                                padding: const EdgeInsets.all(7),
                                borderRadius:
                                BorderRadius.circular(1),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setstate(() {
                                    selectedItem.value = itemCode;
                                    selectedItemType.value = "E";
                                  });
                                },
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 3),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      border: Border.all(
                                        color: ((selectedItem.value == itemCode && selectedItemType.value == "E")
                                            ? subColor
                                            : AppTheme
                                            .background),
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      tc("Empty", txtColor, 10),
                                      gapHC(3),
                                      tc("${erate} AED", txtColor,
                                          10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        gapHC(20),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            rqty.value != 0 && selectedItemType.value == "R" || nqty.value != 0 && selectedItemType.value == "N"||eqty.value != 0 && selectedItemType.value == "E"
                                ? Bounce(
                              onPressed: () {
                                setstate(() {
                                  if (selectedItem.value == null || selectedItem.value != itemCode) {
                                    wShowitemSelectedornot();
                                  }
                                  else  {
                                    fnChngeQty(itemCode, selectedItemType.value, "D",nrate,erate,rrate);
                                  }
                                });
                              },
                              duration: const Duration(
                                  milliseconds: 110),
                              child: Container(
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
                            )
                                : gapHC(0),
                            gapWC(5),
                            Bounce(
                              onPressed: () {
                                dprint("selectedIteqweqmType.value>>>>>>>>>${selectedItemType.value}");
                                setstate(() {
                                  if (selectedItem.value == null || selectedItem.value != itemCode) {
                                    wShowitemSelectedornot();
                                  }
                                  else {
                                    // rqty.value=rqty.value+1;
                                    // dprint( rqty.value);
                                    fnChngeQty(itemCode, selectedItemType.value,"A",nrate,erate,rrate);
                                  }
                                });
                              },
                              duration: const Duration(
                                  milliseconds: 110),
                              child: Container(
                                  height: 30,
                                  width: 55,
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
                    )),
                  )

              );
            } ,
          ),
        );
      },
    );






  }
  wDeletItemSelect(context,itemCodee,typee){

    selectedItemType.value = typee;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 45),
          child: StatefulBuilder(
            builder:(context,setstate){

              var item = lstrSalesList.where((el) => el["STKCODE"]==itemCodee).toList()??[];
              if(item.isEmpty){
                Get.back();
                return Container();
              }
              var itemName  = (item[0]["STKDESCP"]??"").toString();


              return AlertDialog(contentPadding: EdgeInsets.zero,

                  shape:  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  scrollable: true,
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child:  Column(

                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: boxBaseDecoration(white, 20),
                            child: Bounce(child: const Icon(Icons.close),     duration: const Duration(
                                milliseconds: 110), onPressed: (){
                              Get.back();

                            }),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            tc("Do You Want to Delete", txtColor, 13),
                            gapHC(10),
                            tcn(itemName, txtColor, 12),
                            gapHC(5),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                Bounce(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    duration: const Duration(
                                        milliseconds: 110),
                                    child: Container(
                                        height: 30,
                                        width: 35,
                                        decoration:boxDecorationS(primaryColor, 10),
                                        // decoration:qty!=0||qty!=0?boxGradientDecoration(0, 10):null,
                                        //        decoration:selectedcylinder=="new"&&newQty!=0?boxGradientDecoration(0, 10):null,
                                        child:  Center(
                                            child: tc("No", white, 12)))),

                                gapWC(5),
                                Bounce(
                                    onPressed: () {

                                      lstrSalesList.removeWhere((element) =>element["STKCODE"]==itemCodee &&element["TYPE"]==typee.toString());
                                      Get.back();

                                    },
                                    duration: const Duration(milliseconds: 110),
                                    child: Container(
                                        height: 30,
                                        width: 55,
                                        decoration:boxDecoration(primaryColor, 10),
                                        child:  Center(
                                            child: tc("Yes", white, 12)))),

                              ],
                            ),
                          ],
                        ),
                        gapHC(20),




                      ],
                    ),
                  )

              );
            } ,
          ),
        );
      },
    );






  }

  fnChngeQty(itemCode,type,mode,nrate,erate,rrate) {
    var taxAmount = ''.obs;
    var itemMenu = lstrProductItemDetailList.value.where((element) => element["STKCODE"] == itemCode).toList();
    dprint("MENUUUU  ${itemMenu}");
    dprint(lstrSalesList.where((e) => e["STKCODE"] == itemCode  && e["TYPE"]==type).isEmpty);

    if(mode == "A"){
      if(lstrSalesList.where((e) => e["STKCODE"] == itemCode  && e["TYPE"]==type).isEmpty){


        var datas = Map<String, Object>.from({
          "STKCODE": itemCode,
          "STKDESCP": itemMenu[0]["STKDESCP"],
          "QTY": 1,
          "HEADER_DISC": 0.0,
          "DISC_AMT": 0.0,
          "AMT": 0.0,
          "TYPE": type,
          "RATE": ((type == "N" )? itemMenu[0]["PRICE1"]:(type == "R" )? itemMenu[0]["PRICE2"] : itemMenu[0]["CYL_SELL_RATE"]??200),
          "TAX_PER":0.0,
          "TAXABLE_AMT": 0.0,
          "TOTAL_TAX_AMOUNT": 0.0,
          "NET_AMOUNT": 0.0,
          "NRATE":nrate,
          "ERATE":erate,
          "RRATE":rrate,
          "GR_AMT": 0.0,
          "UNIT":itemMenu[0]["UNIT"],
          "CYL_SELL_RATE":itemMenu[0]["CYL_SELL_RATE"]??"",
          "SALEUNIT":itemMenu[0]["SALEUNIT"]??"",
          "CYLINDER_YN":itemMenu[0]["CYLINDER_YN"]??"",
          "CATWEIGHT":itemMenu[0]["CATWEIGHT"]??"",
          "MATERIAL_CODE":itemMenu[0]["MATERIAL_CODE"]??"",
          "PRICE2":itemMenu[0]["PRICE2"]??"",
          "PRICE1":itemMenu[0]["PRICE1"]??"",

        });
        lstrSalesList.add(datas);
      }


      else{
        var item = lstrSalesList.where((element) => element["STKCODE"] == itemCode && element["TYPE"]==type).toList();
        dprint("MENUUUUqqwq  ${item}>>>>>>>>> ${item[0]["QTY"] }");
        if(item.isNotEmpty){
          item[0]["QTY"] = g.mfnDbltoInt(item[0]["QTY"]) + 1;
        }
      }
    }else{
      var item = lstrSalesList.where((element) => element["STKCODE"] == itemCode && element["TYPE"]==type).toList();
      if(item.isNotEmpty){
        item[0]["QTY"] = item[0]["QTY"] == 0?0: g.mfnDbltoInt(item[0]["QTY"]) - 1;
      }
    }
    lstrSalesList.removeWhere((element) => element["QTY"] <= 0);

    dprint("lstrSalesList>>>>>>>>>>>>>>>>>>>>>>> ${lstrSalesList.value}");

  }

  //**************************************************API

  apiViewSales(docno, mode) {
    futureform = ApiCall().apiViewSales(docno, mode);
    futureform.then((value) => apiViewSalesRes(value));
  }
  apiViewSalesRes(value) {
    if (g.fnValCheck(value)) {
      fnClear();
      fnFill(value);
    }
  }
  //
  // apiAddBuilding(code,name,context){
  //   futureform = ApiCall().addBuilding(code,name);
  //   futureform.then((value) => apiAddBuildinggRes(value,context));
  // }
  // apiAddBuildinggRes(value,context){
  //   dprint("ddvaaalaueeeeeeeeeee ${value}");
  //   if(g.fnValCheck(value)){
  //     var sts = value[0]["STATUS"];
  //     var msg = value[0]["MSG"];
  //     var buildingCode = value[0]["CODE"];
  //     if(sts=="1"){
  //       dprint(msg);
  //       txtBuildingCode.text = buildingCode;
  //       Get.back();
  //     }else{
  //       errorMsg(context, msg);
  //     }
  //
  //
  //   }
  //
  // }
  //
  // apiAddApartment(aprtmntcode,buildingcode,context){
  //   futureform = ApiCall().addAppartmnt(aprtmntcode,buildingcode);
  //   futureform.then((value) => apiAddApartmentRes(value,context));
  // }
  // apiAddApartmentRes(value,context){
  //   dprint("apaaaaaaaaart ${value}");
  //   if(g.fnValCheck(value)){
  //     var sts = value[0]["STATUS"];
  //     var msg = value[0]["MSG"];
  //     var buildingCode = value[0]["CODE"];
  //     if(sts=="1"){
  //       dprint(msg);
  //       txtApartmentCode.text = buildingCode;
  //       Get.back();
  //     }else{
  //       errorMsg(context, msg);
  //     }
  //
  //
  //   }
  //
  // }

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

    var columnList = 'STKCODE|STKDESCP|PRODUCT_TYPE|PRICE1|PRICE2|CYL_SELL_RATE|MATERIAL_CODE|CATWEIGHT|CYLINDER_YN|CYL_SELL_RATE|SALEUNIT|UNIT|';
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

}