import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
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
  var pageIndex = 0.obs;
  late PageController pageController;

  RxInt rqty = 0.obs;
  RxInt nqty = 0.obs;
  RxInt eqty = 0.obs;
  var selectedproduct="".obs;
  var selectedItem;
  var selectedItemType;
  var selectedRate;
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

  RxList lstrOrderList = [].obs;
  var lstrProductTypeList = [
    {
      "DESCP":"LPG",
    },
    {
      "DESCP":"CNG",
    },
    {
      "DESCP":"OXYGEN",
    },
    {
      "DESCP":"erw",
    },
    {
      "DESCP":"werw",
    },
    {
      "DESCP":"werwer",
    },   {
      "DESCP":"ert",
    },
    {
      "DESCP":"yuiyu",
    },
    {
      "DESCP":"pio",
    },


  ].obs;

  var lstrProductItemDetailList =[
    {  "STKCODE": "FIVE", "STKDESCP": "5L", "NRATE": 20.0, "RRATE": 10.0,"TYPE":"R","QTY":1,"PRICE2":22,"PRICE1":43},
    {  "STKCODE": "THREE", "STKDESCP": "3L", "NRATE": 30.0, "RRATE": 10.0,"TYPE":"R","QTY":1,"PRICE2":11,"PRICE1":73},
    {  "STKCODE": "TWO", "STKDESCP": "2L", "NRATE": 10.0, "RRATE": 10.0,"TYPE":"R","QTY":1,"PRICE2":27,"PRICE1":63},
    {  "STKCODE": "SIX", "STKDESCP": "6L", "NRATE": 40.0, "RRATE": 10.0,"TYPE":"R","QTY":1,"PRICE2":46,"PRICE1":40},
    {  "STKCODE": "SEVEN", "STKDESCP": "7L", "NRATE": 50.0, "RRATE": 10.0,"TYPE":"R","QTY":1,"PRICE2":21,"PRICE1":23},
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
      var productName = e["DESCP"];

      rtnPrdctList.add(
         Obx(() =>  Padding(
           padding: const EdgeInsets.only(left: 8),
           child: GestureDetector(
             onTap: (){
               selectedproduct.value=productName??"";

               dprint("aaaaaaaaaaaaac ${i}");
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
    dprint("bottomsheetvalue..........  ${lstrProductTypeList.value}");
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
              padding: const EdgeInsets.symmetric(horizontal: 15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        gapHC(10),
                        tc("Product Type", txtColor, 15),
                        Container(
                          width: 80,
                          height: 5,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
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
                              return Column(
                                children: [
                                  gapHC(3),

                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: lstrProductItemDetailList.value.length,
                                        itemBuilder: (context, index) {
                                          dprint("indexxx  ${index}  Listlength ${lstrProductItemDetailList.value.length}");
                                          //    {  "STKCODE": "FIVE", "STKDESCP": "5L", "NRATE": 20.0, "RRATE": 10.0,"TYPE":"R","QTY":1},
                                          var itemName = (lstrProductItemDetailList[index]["STKDESCP"] ?? "").toString();
                                          var itemCode = (lstrProductItemDetailList[index]["STKCODE"] ?? "").toString();

                                          var nrate = g.mfnDbl(lstrProductItemDetailList[index]["PRICE1"].toString());
                                          var rrate = g.mfnDbl(lstrProductItemDetailList[index]["PRICE2"].toString());
                                          var erate = g.mfnDbl(50.0);

                                          var item = lstrOrderList.where((element) => element["STKCODE"] == itemCode).toList();
                                          var itemR = item
                                              .where((element) => element["TYPE"] == "R")
                                              .toList();
                                          var itemN = item
                                              .where((element) => element["TYPE"] == "N")
                                              .toList();
                                          var itemE = item
                                              .where((element) => element["TYPE"] == "E")
                                              .toList();
                                          var vat = g.mfnDbl(
                                              lstrProductItemDetailList[index]["VAT"]
                                                  .toString());
                                          dprint("vaaattttttttttt  ${vat}");
                                          rqty.value = itemR.length > 0
                                              ? g
                                              .mfnDbltoInt(itemR[0]["QTY"].toString())
                                              : 0;
                                          nqty.value = itemN.length > 0
                                              ? g
                                              .mfnDbltoInt(itemN[0]["QTY"].toString())
                                              : 0;
                                          eqty.value = itemE.length > 0
                                              ? g
                                              .mfnDbltoInt(itemE[0]["QTY"].toString())
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
                                                            selectedItem = itemCode;
                                                            selectedItemType = "N";
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
                                                                color: ((selectedItem ==
                                                                    itemCode &&
                                                                    selectedItemType ==
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
                                                                  10),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    gapWC(10),
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
                                                            selectedItem = itemCode;
                                                            selectedItemType = "R";
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
                                                                color: ((selectedItem ==
                                                                    itemCode &&
                                                                    selectedItemType ==
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
                                                    gapWC(10),
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
                                                            selectedItem = itemCode;
                                                            selectedItemType = "E";
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
                                                                color: ((selectedItem == itemCode && selectedItemType == "E")
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
                                                    rqty.value != 0 && selectedItemType == "R" || nqty.value != 0 && selectedItemType == "N"||eqty.value != 0 && selectedItemType == "E"
                                                        ? Bounce(
                                                      onPressed: () {
                                                        setstate(() {
                                                          if (selectedItem ==
                                                              null ||
                                                              selectedItem !=
                                                                  itemCode) {
                                                            wShowitemSelectedornot();
                                                          } else {
                                                            fnChngeQty(
                                                                itemCode,
                                                                selectedItemType,
                                                                "D",
                                                                vat);
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
                                                          if (selectedItem == null ||
                                                              selectedItem != itemCode) {
                                                            wShowitemSelectedornot();
                                                          } else {
                                                            fnChngeQty(
                                                                itemCode,
                                                                selectedItemType,
                                                                "A",
                                                                vat);
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
                              );
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
      //   {  "STKCODE": "FIVE", "STKDESCP": "5L", "RATE": 10.0,"TYPE":"R"},
      dprint("Ordersdfrrrlistt >> ${lstrOrderList}");


      // Get.find<SalesController>().txtTotalAmt.value.text="" ;
      for(var e  in lstrOrderList.value){
        dprint("LstrOrderList>>>>>>>>>>>>>   ${e}");

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
                      tcn(itemName.toString(),
                          Colors.black, 10)
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


  fnChngeQty(itemCode, type, mode, vat) {
    var taxAmount = ''.obs;

    var itemMenu = lstrProductItemDetailList.value
        .where((element) => element["STKCODE"] == itemCode)
        .toList();

    dprint("Item>>>>>> ${itemMenu}");
    dprint("Vat>>>>>> ${vat}");
    dprint("Mode>>>>> ${mode}");

    var i = 0;
    var exist = 0;
    for (var item in lstrOrderList.value) {
      dprint("itttt>>>> ${item}");
      if (item["STKCODE"] == itemCode && item["TYPE"] == type) {
        exist = 1;
        if (mode == "A") {
          lstrOrderList.value[i]["QTY"] = g.mfnDbltoInt(item["QTY"]) + 1;
          lstrOrderList.value[i]["GR_AMT"] = item["RATE"] * g.mfnDbltoInt(item["QTY"]);
        }
        if (mode == "D" && item["QTY"] != 0) {
          lstrOrderList.value[i]["QTY"] = g.mfnDbltoInt(item["QTY"]) - 1;
          lstrOrderList.value[i]["GR_AMT"] = item["RATE"] * g.mfnDbltoInt(item["QTY"]);
        }
      }
      i++;
      dprint("taxxxxxxxxxxxam  ${taxAmount.value.toString()}");
    }
    // lstrOrderList.removeWhere((element) => commonController.mfnInt(element["QTY"]) <= 0);
    if (exist == 0) {
      var datas = Map<String, Object>.from({
        "STKCODE": itemCode,
        "STKDESCP": itemMenu[0]["STKDESCP"],
        // "RATE": (type == "N" ? itemMenu[0]["PRICE1"] : itemMenu[0]["PRICE2"]),
        "RATE": (type == "N") ? itemMenu[0]["PRICE1"]: (type == "R")? itemMenu[0]["PRICE2"]:g.mfnDbl(50.0),
        "QTY": 1,
        "TYPE": type,
        "TAX_PER": vat,
        "HEADER_DISC": 0.0,
        // "GR_AMT": (type == "N" ? itemMenu[0]["PRICE1"] : itemMenu[0]["PRICE2"]) * 1,
        "GR_AMT": (type == "N") ? itemMenu[0]["PRICE1"]??0 *1: (type == "R")? itemMenu[0]["PRICE2"]??0 *1:g.mfnDbl(50.0)*1,
        "DISC_AMT": 0.0,
        "AMT": 0.0,
        "TAXABLE_AMT": 0.0,
        "TOTAL_TAX_AMOUNT": 0.0,
        "NET_AMOUNT": 0.0,
      });
      dprint("dattttSalesssss${datas}");

      lstrOrderList.add(datas);
    }
    lstrOrderList.removeWhere((element) => element["QTY"] <= 0);

    dprint("Updatedlisttt ${lstrOrderList}");
    // fnTotal();
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

  void apiProductTypeDetails(product, void Function() callback) {}
}