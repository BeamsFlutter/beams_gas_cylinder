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

class HmDelivryOrderController extends GetxController{

  Rx<DateTime> docDate = DateTime.now().obs;
  RxString frDocno="BS25534".obs;
  var g  = Global();
  var wstrPageMode = "VIEW".obs;
  late Future <dynamic> futureform;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "IT".obs;
  RxString cstmrCode = "".obs;
  RxString cstmrName = "".obs;
  var pageIndex = 0.obs;
  late PageController pageController;
  RxList lstrDeliveredList =[].obs;
  RxInt rqty = 0.obs;
  RxInt nqty = 0.obs;
  RxInt eqty = 0.obs;
  var selectedproduct="".obs;
  var selectedItem=''.obs;
  var selectedItemType=''.obs;
  var selectedRate=''.obs;
  //************************CONTROLLER
  final txtController = TextEditingController();
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
  var txtAreaCode = TextEditingController();
  var txtDriver = TextEditingController();
  var txtVehiclenumber= TextEditingController();


  var lstrProductTypeList = [].obs;
  var lstrProductItemDetailList =[


  ].obs;
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
    apiViewDeliveryOrder('', 'LAST');
  }

  fnPage(mode) {

    switch (mode) {
      case 'FIRST':
        apiViewDeliveryOrder('', mode);
        break;
      case 'LAST':
        apiViewDeliveryOrder('', mode);
        break;
      case 'NEXT':
        apiViewDeliveryOrder(frDocno.value, mode);
        break;
      case 'PREVIOUS':
        apiViewDeliveryOrder(frDocno.value, mode);
        break;
    }
  }

  fnClear(){}

  fnFill(value){}

  fnSave(){}

  fnDelete(){}
  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }


  //**************************************************FUNCTION


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
              padding: EdgeInsets.symmetric(horizontal: 10),


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

                                          var item = lstrDeliveredList.value.where((element) => element["STKCODE"] == itemCode).toList();
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
                                                            fnChngeQty(itemCode, selectedItemType.value, "D",);
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
                                                            fnChngeQty(itemCode, selectedItemType.value,"A");
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

    );



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
  List<Widget> wDeliverItemList(){
      List<Widget> rtnList =[];
      var ftotal  = 0.0;
      var ftaxamount  = 0.0;



      // Get.find<SalesController>().txtTotalAmt.value.text="" ;
      for(var e  in lstrDeliveredList.value){


        var itemName  = (e["STKDESCP"]??"").toString();
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





        rtnList.add( Container(
          decoration: boxBaseDecoration(
              bGreyLight, 0),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Flexible(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: tcn(itemName.toString(),
                            Colors.black, 10),
                      )
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end,
                    children: [
                      tcn(type.toString(), Colors.black, 10)
                    ],
                  )),
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

        ));

      }

      return rtnList;
    }


  fnChngeQty(itemCode,type,mode) {
    var taxAmount = ''.obs;
    var itemMenu = lstrProductItemDetailList.value.where((element) => element["STKCODE"] == itemCode).toList();

    if(mode == "A"){
      if(lstrDeliveredList.where((e) => e["STKCODE"] == itemCode  && e["TYPE"]==type).isEmpty){
        var datas = Map<String, Object>.from({
          "STKCODE": itemCode,
          "STKDESCP": itemMenu[0]["STKDESCP"],
          "QTY": 1,
          "HEADER_DISC": 0.0,
          "DISC_AMT": 0.0,
          "AMT": 0.0,
           "TYPE": type,
          "RATE": ((type == "N" )? itemMenu[0]["PRICE1"]:(type == "R" )? itemMenu[0]["PRICE2"] : 200.0),
          "TAX_PER":0.0,
          "TAXABLE_AMT": 0.0,
          "TOTAL_TAX_AMOUNT": 0.0,
          "NET_AMOUNT": 0.0,
        });
        lstrDeliveredList.add(datas);
      }


      else{
        var item = lstrDeliveredList.where((element) => element["STKCODE"] == itemCode && element["TYPE"]==type).toList();
        if(item.isNotEmpty){
          item[0]["QTY"] = g.mfnDbltoInt(item[0]["QTY"]) + 1;
        }
      }
    }else{
      var item = lstrDeliveredList.where((element) => element["STKCODE"] == itemCode).toList();
      if(item.isNotEmpty){
        item[0]["QTY"] = item[0]["QTY"] == 0?0: g.mfnDbltoInt(item[0]["QTY"]) - 1;
      }
    }
    lstrDeliveredList.removeWhere((element) => element["QTY"] <= 0);



  }

  fnFillData(data,mode){

  }
  fnFillCustomerData(data,mode){
    if(g.fnValCheck(data)){
      if(mode  ==  "GBUILDINGMASTER"){
        dprint("1111111111111111111111   >> ${data["BUILDING_CODE"]}");

        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        txtBuildingName.text = data["DESCP"]??"";
        g.wstrBuildingCode = data["BUILDING_CODE"]??"";
        g.wstrBuildingName = data["DESCP"]??"";
        txtAreaCode.text = data["AREA"]??"";


      }
      else if(mode  ==  "GAPARTMENTMASTER"){
        g.wstrApartmentCode  = data["APARTMENT_CODE"]??"";
        txtApartmentCode.text =data["APARTMENT_CODE"]??"";
        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "GUESTMASTER"){
        dprint("RRRRRRRRRR ${data}");
        txtCustomerCode.text  = data["GUEST_CODE"]??"";
        txtCustomerName.text  = data["GUEST_NAME"]??"";
        txtContactNo.text  = data["MOBILE"]??"";
        // frEmail.value  = data["EMAIL"]??"";
        cstmrCode.value=data["GUEST_CODE"]??"";
        cstmrName.value= data["GUEST_NAME"]??"";
        txtContactNo.text  = data["MOBILE"]??"";
        txtApartmentCode.text = data["APARTMENT_CODE"]??"";
        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        g.wstrBuildingCode  = data["BUILDING_CODE"]??"";
        g.wstrApartmentCode  = data["APARTMENT_CODE"]??"";
        //    apiGetCustomerInfo();
      }
      else if(mode  ==  "CRDELIVERYMANMASTER"){
        dprint("1111111111111111111111");
        txtDriver.text = data["DEL_MAN_CODE"]??"";
        frDocno.value = data["DEL_MAN_CODE"]??"";

      }
      else if(mode  ==  "CRVEHICLEMASTER"){
        txtVehiclenumber.text = data["VEHICLE_NO"]??"";

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
  }

  //**************************************************API

  apiViewDeliveryOrder(docno,mode){
    futureform = ApiCall().apiViewAssignment(docno,mode);
    futureform.then((value) => apiViewDeliveryOrderRes(value));
  }
  apiViewDeliveryOrderRes(value){
    if(g.fnValCheck(value)){
      fnClear();
      fnFill(value);
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
}