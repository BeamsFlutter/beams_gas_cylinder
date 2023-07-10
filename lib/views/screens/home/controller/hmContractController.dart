import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../../components/lookup/lookup.dart';
import '../../../styles/colors.dart';
// enum PaymentMode { cash, card,cheque }
class HmContractController extends GetxController{

  Rx<DateTime> contractDate = DateTime.now().obs;


  RxString frContractno="".obs;
  RxString frDocType="".obs;
  var g  = Global();
  var wstrPageMode = "VIEW".obs;
  late Future <dynamic> futureform;
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "DT".obs;
  RxString cstmrCode = "".obs;
  RxString cstmrName = "".obs;
  var pageIndex = 0.obs;
  var selectedproduct="".obs;
  late PageController pageController;
  var itemList = [].obs;
  var lstrProductTypeList = [].obs;
  var lstrProductItemDetailList =[].obs;
  var txtCustomerName = TextEditingController();
  var txtAreaCode = TextEditingController();
  final txtController = TextEditingController();
  var txtBuildingCode = TextEditingController();
  var txtBuildingName = TextEditingController();
  var txtApartmentCode = TextEditingController();
  var txtApartmentName = TextEditingController();
  final txtCustomerCode = TextEditingController();
  var txtContactNo = TextEditingController();
  var txtLandmark = TextEditingController();
  var txtAddress = TextEditingController();
  var txtFrqDeliveryDays = TextEditingController();
  var txtDepositAmount = TextEditingController();
  var txtRemark = TextEditingController();
  var txtWhatsappNumber = TextEditingController();
  var txtEmail = TextEditingController();

  var txtchequeNumber= TextEditingController();
  var txtchequeDate = TextEditingController();

  final customerformKey = GlobalKey<FormState>().obs;

  //====================MENU=================================================
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
    apiViewContarct('', "LAST");

  }

  fnPage(mode) {

    switch (mode) {
      case 'FIRST':
       apiViewContarct('', mode);
        break;
      case 'LAST':
        apiViewContarct('', mode);
        break;
      case 'NEXT':
        apiViewContarct(frContractno.value, mode);
        break;
      case 'PREVIOUS':
        apiViewContarct(frContractno.value, mode);
        break;
    }
  }

  fnClear(){

    dprint("######################   clear #####################");
    frContractno.value="";
    frDocType.value="";
    contractDate.value=DateTime.now();
    cstmrName.value="";
    cstmrCode.value="";

    cstmrCode.value="";
    cstmrName.value="";
    txtCustomerName.clear();
    txtContactNo.clear();
    txtBuildingCode.text="";
    txtBuildingName.text="";
    txtApartmentCode.text="";
    txtApartmentName.text="";
    txtAreaCode.text="";
    txtLandmark.text="";
    txtAddress.text="";
    txtDepositAmount.text="";
    itemList.value=[];
    txtEmail.clear();
    txtWhatsappNumber.clear();
    txtWhatsappNumber.text="";
    txtDepositAmount.text="";
    txtDepositAmount.clear();
    txtEmail.text="";
    txtFrqDeliveryDays.clear();
    txtFrqDeliveryDays.text="";
    txtRemark.clear();
    txtRemark.text="";
    txtWhatsappNumber.clear();
    txtWhatsappNumber.text="";
    txtchequeNumber.text="";
    txtchequeNumber.clear();
    txtchequeDate.text =setDate(15,DateTime.now());
    wstrPageMode.value="VIEW";




  }
  fnDelete(){}
  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }
  fnSave(context){
    if (customerformKey.value.currentState!.validate()) {
      dprint("contract.value>>>>  ${itemList.value}");
     // dprint("FREQUENCY_OF_DELIVERY_DAYS>>>>  ${int.parse(txtFrqDeliveryDays.text)} Type:: ${int.parse(txtFrqDeliveryDays.text).runtimeType}");

      List tableContract =[];
      List tableContractDet=[];

      tableContract.add({
        "COMPANY" : g.wstrCompany,
        "DOCTYPE" : "GCC",
        "YEARCODE" : g.wstrYearcode,
        "CONTRACT_NO" : frContractno.value,
        "CONTRACT_DATE" :  setDate(2,contractDate.value),
        "BUILDING_CODE" : txtBuildingCode.text,
        "BUILDING_NAME" : txtBuildingName.text,
        "APARTMENT_CODE" : txtApartmentCode.text,
        "SLCODE" :cstmrCode.value ,
        "SLDESCP" : cstmrName.value,
        "CONTRACT_FROM_DATE" : setDate(2,contractDate.value),
        "CONTRACT_TO_DATE" : "",
        "EMAIL" : txtEmail.text,
        "ADD1" : txtAddress.text,
        "ADD2" : "",
        "MOBILE1" : txtContactNo.text,
        "MOBILE2" : txtContactNo.text,
        "WHATSAPP" : txtWhatsappNumber.text,
        "TEL" : "",
        "FREQUENCY_OF_DELIVERY_DAYS" :g.mfnInt(txtFrqDeliveryDays.text),
        "DEPOSIT_AMT" : txtDepositAmount.text,
        "REMARKS" : txtRemark.text,
        "REF1" : "",
        "REF2" : "",
        "REF3" : "",
        "REF4" : "",
        "REF5" : "",
        "REF6" : "",
        "REF7" : "",
        "REF8" : "",
        "REF9" : "",
        "REF10" : "",
        "ONLINE_SYNCH_STATUS" : "3",
        "RENEW_CONTRACT_NO" : ""


      });

      int i=1;
      for(var e in itemList.value){
        tableContractDet.add(
          {
            "COMPANY" : g.wstrCompany,
            "DOCTYPE" : "GCC",
            "YEARCODE" : g.wstrYearcode,
            "CONTRACT_NO" :frContractno.value,
            "SRNO" : i,
            "STKCODE" : e["STKCODE"],
            "STKDESCP" : e["STKDESCP"],
            "PLANNED_QTY" : e["QTY"]
          },
        );

        i++;
      }
      fnProceedToSave(context, tableContract, tableContractDet);
    }else{
      dprint("Not validate..........................");
    }
  }

  fnProceedToSave(context,tableContract,tableContractDet,){
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

    if(itemList.value.isEmpty){
      errorMsg(context, "Choose Items");
      return;
    }


    apiSaveContract(tableContract, tableContractDet, context);




  }

  //====================FUNCTIONS=================================================
  fnFillCustomerData(data,mode){
    if(g.fnValCheck(data)){
      if(mode  ==  "GBUILDINGMASTER"){
        dprint("1111111111111111111111   >> ${data["BUILDING_CODE"]}");

        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        txtBuildingName.text = data["DESCP"]??"";
        g.wstrBuildingCode = data["BUILDING_CODE"]??"";
        g.wstrBuildingName = data["DESCP"]??"";
        // txtAreaCode.text = data["AREA"]??"";


      }
      else if(mode  ==  "GAPARTMENTMASTER"){
        g.wstrApartmentCode  = data["APARTMENT_CODE"]??"";
        txtApartmentCode.text =data["APARTMENT_CODE"]??"";
        //   apiGetCustomerDetails();
      }
      else if(mode  ==  "gcylinder_contract"){
        dprint("ddddddddddddd  ${data}");

        frContractno.value  = data["CONTRACT_NO"]??"";
        frDocType.value =data["DOCTYPE"]??"";
        apiViewContarct(frContractno.value,"");

      }
      else if(mode  ==  "SLMAST"){
        dprint("RRRRRRRRRR ${data}");
        txtCustomerCode.text  = data["SLCODE"]??"";
        txtCustomerName.text  = data["SLDESCP"]??"";
        txtContactNo.text  = data["MOBILE"]??"";
        // frEmail.value  = data["EMAIL"]??"";
        cstmrCode.value=data["SLCODE"]??"";
        cstmrName.value= data["SLDESCP"]??"";
        txtContactNo.text  = data["MOBILE"]??"";
        txtApartmentCode.text = data["APARTMENT_CODE"]??"";
        txtAddress.text = data["ADDRESS1"]??"";
        txtBuildingCode.text = data["BUILDING_CODE"]??"";
        g.wstrBuildingCode  = data["BUILDING_CODE"]??"";
        g.wstrApartmentCode  = data["APARTMENT_CODE"]??"";
         apiGetCustomerDetails(txtCustomerCode.text);
      }
    }


  }

  fnChngeQty(itemCode,mode) {
    var taxAmount = ''.obs;
    var itemMenu = lstrProductItemDetailList.value.where((element) => element["STKCODE"] == itemCode).toList();

    dprint("Item>>>>>> ${itemMenu}");
    dprint("Mode>>>>> ${mode}");


    if(mode == "A"){
      if(itemList.where((e) => e["STKCODE"] == itemCode).isEmpty){
        var datas = Map<String, Object>.from({
          "STKCODE": itemCode,
          "STKDESCP": itemMenu[0]["STKDESCP"],
          "QTY": 1,

        });
        itemList.add(datas);
      }
      else{
        var item = itemList.where((element) => element["STKCODE"] == itemCode).toList();
        if(item.isNotEmpty){
          item[0]["QTY"] = g.mfnDbltoInt(item[0]["QTY"]) + 1;
        }
      }
    }else{
      var item = itemList.where((element) => element["STKCODE"] == itemCode).toList();
      if(item.isNotEmpty){
        item[0]["QTY"] = item[0]["QTY"] == 0?0: g.mfnDbltoInt(item[0]["QTY"]) - 1;
      }
    }
    itemList.removeWhere((element) => element["QTY"] <= 0);

  }

  fnFill(data){
    dprint("contractVALUEEEEEEEEE>>>>>>>  ${data}");
    // fnClear();



    var contract  =g.fnValCheck(data["CONTRACT"])? data["CONTRACT"][0]:[];
    var contractDet  = g.fnValCheck(data["CONTRACTDET"])?data["CONTRACTDET"]:[];


    dprint("CONTRACT>>>>>>> ${contract}");


    if(g.fnValCheck(contract)){
      frContractno.value = (contract["CONTRACT_NO"]??"").toString();
      frDocType.value = (contract["DOCTYPE"]??"").toString();
      txtBuildingCode.text = (contract["BUILDING_CODE"]??"").toString();
      txtBuildingName.text = (contract["BUILDING_NAME"]??"").toString();
      txtApartmentCode.text = (contract["APARTMENT_CODE"]??"").toString();
      txtCustomerName.text = (contract["SLDESCP"]??"").toString();
      cstmrName.value = (contract["SLDESCP"]??"").toString();
      txtCustomerCode.text = (contract["SLCODE"]??"").toString();
      cstmrCode.value = (contract["SLCODE"]??"").toString();
      txtEmail.text = (contract["EMAIL"]??"").toString();
      txtAddress.text = (contract["ADD1"]??"").toString();
      txtContactNo.text = (contract["MOBILE1"]??"").toString();
      txtWhatsappNumber.text = (contract["WHATSAPP"]??"").toString();
      txtFrqDeliveryDays.text = (contract["FREQUENCY_OF_DELIVERY_DAYS"]??"").toString();
      txtDepositAmount.text = (contract["DEPOSIT_AMT"]??"").toString();
      txtRemark.text = (contract["REMARKS"]??"").toString();
      if(contract["CONTRACT_DATE"] != null|| contract["CONTRACT_DATE"] != ""){
        try{
          contractDate.value=DateTime.parse(contract["CONTRACT_DATE"].toString());
        }catch(e){
          contractDate.value =DateTime.now();
        }
      }

      // txtLandmark.text = (contract["LANDMARK"]??"").toString();
      // txtAreaCode.text = (contract["AREA_CODE"]??"").toString();

      // if(contract["DELIVERY_REQ_DATE"] != null|| contract["DELIVERY_REQ_DATE"] != ""){
      //   try{
      //     txtdelivryDate.text =setDate(15, DateTime.parse(contract["DELIVERY_REQ_DATE"].toString()));
      //
      //   }catch(e){
      //     dprint(e);
      //   }
      // }



    }
    if(g.fnValCheck(contractDet)){
      int i = 1;
      itemList.value = [];
      for (var e in contractDet) {
        var datas = Map<String,dynamic>.from({
          "STKCODE":e["STKCODE"],
          "STKDESCP":e["STKDESCP"],
          "QTY": e["PLANNED_QTY"],
        });
        itemList.value.add(datas);
        i++;
        update();
      }
      update();

    }


  }
  fnFillCustomerDetails(data){

    dprint("datttssfnFillCustomerDetails ${data}");
    var customerDatas  =g.fnValCheck(data[0])? data[0]:[];
    txtEmail.text = (customerDatas["EMAIL"]??"").toString();
    txtRemark.text = (customerDatas["REMARKS"]??"").toString();
    txtContactNo.text = (customerDatas["MOBILE"]??"").toString();
    txtAddress.text = (customerDatas["ADDRESS1"]??"").toString();
    dprint("txtEmailaaaaaaaaa ${  txtEmail.text}");

  }

  //====================lookup=================================================
  fnLookup(mode){
    dprint(mode);
    if(mode == "SLMAST"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'SLCODE', 'Display': 'Code'},
        {'Column': 'SLDESCP', 'Display': 'Name'},
        {'Column': 'MOBILE', 'Display': 'Mobile'},
        {'Column': 'EMAIL', 'Display': 'Email'},
        {'Column': 'BUILDING_CODE', 'Display': 'Building'},
        {'Column': 'APARTMENT_CODE', 'Display': 'Apartment'},
        {'Column': 'ADDRESS2', 'Display': ''},
        // {'Column': 'REMARKS', 'Display': ''},
        // {'Column': 'AREA_CODE', 'Display': ''},
        {'Column': 'ADDRESS1', 'Display': ''},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [];
      var lstrFilter =[
        {'Column': "COMPANY", 'Operator': '=', 'Value': g.wstrCompany, 'JoinType': 'AND'},
        {'Column': "ACTYPE", 'Operator': '=', 'Value': 'AR', 'JoinType': 'AND'},
      ];

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
    else if(mode == "gcylinder_contract" ){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'CONTRACT_NO', 'Display': 'Contract_No'},
        {'Column': 'DOCTYPE', 'Display': 'N'},


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



  }
  //====================WIDGETS=================================================

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

                                          var item = itemList.where((element) => element["STKCODE"] == itemCode).toList();
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
                                                            fnChngeQty(itemCode,"D");
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
                                                              fnChngeQty(itemCode,"A");
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

  Future<void> wSelectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate:DateTime(2025, 8),
        initialDate: DateTime.now());
    if (pickedDate != null){


      txtchequeDate.text =setDate(15, pickedDate);
    }

  }


  //====================API=====================================================
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

  apiViewContarct(contrNo,mode){
    futureform = ApiCall().apiViewContract(contrNo,mode);
    futureform.then((value) => apiViewContarctRes(value));
  }
  apiViewContarctRes(value){
    if(g.fnValCheck(value)){
      fnClear();
      fnFill(value);
    }

  }

  apiGetCustomerDetails(slcode){
    futureform = ApiCall().apiViewCustomerDetails(slcode);
    futureform.then((value) => apiGetCustomerDetailsRes(value));
  }
  apiGetCustomerDetailsRes(value){
    if(g.fnValCheck(value)){
      fnFillCustomerDetails(value);
    }

  }

  apiSaveContract(tableContract,tableContractDet,context){
    dprint("!!!!!!!!!!!!!apiiii");
    futureform = ApiCall().saveContract(wstrPageMode.value, tableContractDet,tableContract);
    futureform.then((value) => apiSaveContractRes(value,context));
  }
  apiSaveContractRes(value,context){

    if(g.fnValCheck(value)){
      dprint("Get Result>>>>>>>>>>>>>>> ${value}");
      var sts  =  value[0]["STATUS"];
      var msg  =  value[0]["MSG"]??"";
      if(sts == "1"){
        frContractno.value = value[0]["CODE"];
        var doctype = value[0]["DOCTYPE"];
        wstrPageMode.value ="VIEW";
       apiViewContarct(frContractno.value, "LAST");
        successMsg(context, msg);
      }else{
        errorMsg(context, msg);
      }
    }
  }





}