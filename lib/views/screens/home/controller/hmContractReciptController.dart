import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../../components/lookup/lookup.dart';
enum PaymentMode { cash, card,cheque }
class HmContractReciptController extends GetxController{
  RxString frDocno="".obs;
  RxString frDocType="CCR".obs;
  RxString frContractNumber="".obs;
  RxString frCustomerName="".obs;
  RxString frCustomerCode="".obs;
  RxString frBuildingCode="".obs;
  RxString frBuildingName="".obs;
  RxString frAprtmntCode="".obs;
  RxString frContactNo="".obs;

  var g  = Global();
  var wstrPageMode = "VIEW".obs;
  late Future <dynamic> futureform;
  Rx<DateTime> docDate = DateTime.now().obs;

  var txtchequeNumber= TextEditingController();
  var txtchequeDate = TextEditingController();
  var txtAmount = TextEditingController();
  var txtController = TextEditingController();

  final paymentMode = PaymentMode.cash.obs;

  var contractReciptList =[].obs;

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
  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }
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
    // apiViewDeliveryOrder('', 'LAST');
  }

  fnPage(mode) {

    switch (mode) {
      case 'FIRST':
        apiViewContarctRecipt('', mode,frDocType.value);
        break;
      case 'LAST':
        apiViewContarctRecipt('', mode,frDocType.value);
        break;
      case 'NEXT':
        apiViewContarctRecipt(frDocno.value, mode,frDocType.value);
        break;
      case 'PREVIOUS':
        apiViewContarctRecipt(frDocno.value, mode,frDocType.value);
        break;
    }
  }

  fnClear(){





  }
  fnDelete(){}

  fnSave(context){
    var paymode;
    if(PaymentMode.card==paymentMode.value){
      paymode="CR";
    }else  if(PaymentMode.cash==paymentMode.value){
      paymode="CS";
    }else  if(PaymentMode.cheque==paymentMode.value){
      paymode="CQ";
    }
    dprint("Paymoooooooooode  ${paymode}");




   var tableContractRec =[];
   tableContractRec.add({
     "COMPANY" : g.wstrCompany,
     "YEARCODE" : g.wstrYearcode,
     "DOCNO" : frDocno.value,
     "DOCTYPE" : frDocType.value,
     "DOCDATE" : setDate(2,docDate.value),
     "CONTRACT_NO" : frContractNumber.value,
     "SLCODE" : frCustomerCode.value,
     "SLDESCP" : frCustomerName.value,
     "BUILDING_CODE" : frBuildingCode.value,
     "BUILDING_NAME" : frBuildingName.value,
     "APARTMENT_CODE" : frAprtmntCode.value,
     "SMAN" : "",
     "CURR" : "AED",
     "CURRATE" : 1.0,
     "CHQBANK" : "",
     "CHQBANKDESCP" : "",
     "DEPBANK" : "",
     "CHQBANK_BRANCH" : "",
     "PAYMODE" : paymode,
     "REMITTO" : "",
     "CHQNO" : txtchequeNumber.text,
     "CHQDATE" : txtchequeDate.text,
     "AMT" : g.mfnDbl(txtAmount.text),
     "AMTFC" :  g.mfnDbl(txtAmount.text),
     "PDC_YN" : "",
     "REMARKS" : "",
     "REF1" : "",
     "REF2" : "",
     "REF3" : "",
     "REF4" : "",
     "REF5" : "",
     "REF6" : "",
     "ACTIVITY1" : "",
     "ACTIVITY2" : "",
     "ACTIVITY3" : "",
     "CREDITCARD" : ""

   });

   apiSaveContractRecipt(tableContractRec, context);

  }


  //====================lookup=================================================
  fnLookup(mode){
    dprint(mode);
    if(mode == "gcylinder_contractrec" ){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'DOC_No'},
        {'Column': 'DOCTYPE', 'Display': 'N'},


      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[];
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'gcylinder_contractrec',
            title: 'Doc Number',
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

  //===============================================================FUNCTIONS

  fnFill(data) {
    dprint("DTTTTTAA ${data}");
    var contractrec = g.fnValCheck(data["CONTRACTREC"])
        ? data["CONTRACTREC"][0]
        : [];
    if (g.fnValCheck(contractrec)) {
      frDocno.value = (contractrec["DOCNO"] ?? "").toString();
      frDocType.value = (contractrec["DOCTYPE"] ?? "").toString();
      if(contractrec["DOCDATE"]  != null|| contractrec["DOCDATE"]  != ""){
        try{
          docDate.value=DateTime.parse(contractrec["DOCDATE"] .toString());
        }catch(e){
          docDate.value =DateTime.now();
        }
      }
      frContractNumber.value = (contractrec["CONTRACT_NO"] ?? "").toString();
      frCustomerName.value = (contractrec["SLDESCP"] ?? "").toString();
      frBuildingCode.value = (contractrec["BUILDING_CODE"] ?? "").toString();
      frAprtmntCode.value = (contractrec["APARTMENT_CODE"] ?? "").toString();
      txtAmount.text=(contractrec["AMTFC"] ?? "").toString();
      var payMode=(contractrec["PAYMODE"] ?? "").toString();
      if(payMode=="CR"){
        paymentMode.value =PaymentMode.card;
      }else   if(payMode=="CS"){
        paymentMode.value =PaymentMode.cash;
      }else   if(payMode=="CQ"){
        paymentMode.value =PaymentMode.cheque;
        txtchequeNumber.text=(contractrec["CHQNO"] ?? "").toString();
        txtchequeDate.text=setDate(6, DateTime.parse((contractrec["CHQDATE"] ?? "").toString()));
      }

    }
  }
  fnFillContractRecipt(data){
    dprint("DDDDDDAAfnFillContractRecipt  ${data}");

    // if(data[0]["DOCDATE"]  != null|| data[0]["DOCDATE"]  != ""){
    //   try{
    //     docDate.value=DateTime.parse(data[0]["DOCDATE"] .toString());
    //   }catch(e){
    //     docDate.value =DateTime.now();
    //   }
    // }
    frContractNumber.value = (data[0]["CONTRACT_NO"] ?? "").toString();
    frCustomerName.value = (data[0]["SLDESCP"] ?? "").toString();
    frBuildingCode.value = (data[0]["BUILDING_CODE"] ?? "").toString();
    frAprtmntCode.value = (data[0]["APARTMENT_CODE"] ?? "").toString();
  //  txtAmount.text=(data[0]["AMTFC"] ?? "").toString();
    frContactNo.value = (data[0]["MOBILE1"] ?? "").toString();
    txtAmount.text =(data[0]["BALANCE_AMOUNT"] ?? "").toString();
    }
  fnFillCustomerData(data,mode){
    if(g.fnValCheck(data)){
     if(mode  ==  "gcylinder_contractrec"){
      frDocno.value  = data["DOCNO"]??"";
      frDocType.value  = data["DOCTYPE"]??"";
      apiViewContarctRecipt(frDocno.value,"",frDocType.value);

    }
    }


  }


    //===============================================================API

    apiViewContarctRecipt(docNo,mode,docType) {
      dprint("vvvvvvvvv");
      futureform = ApiCall().apiViewContractRecipt(docNo, mode,docType);
      futureform.then((value) => apiViewContarctReciptRes(value));
    }
    apiViewContarctReciptRes(value) {
      if (g.fnValCheck(value)) {
        fnClear();
        fnFill(value);
      }
    }

  apiViewContarctBalance(contractNumbr) {
    dprint("vvvvvvvvv");
    futureform = ApiCall().apiViewContractBalance(contractNumbr);
    futureform.then((value) => apiViewContarctBalanceRes(value));
  }
  apiViewContarctBalanceRes(value) {
    if (g.fnValCheck(value)) {
      fnClear();
      fnFillContractRecipt(value);
    }
  }



    apiSaveContractRecipt(tableContractRec, context) {
      dprint("!!!!!!!!!!!!!apiiii");
      futureform =
          ApiCall().saveContractRecipt(wstrPageMode.value, tableContractRec);
      futureform.then((value) => apiSaveContractReciptRes(value, context));
    }
    apiSaveContractReciptRes(value, context) {
      if (g.fnValCheck(value)) {
        dprint("Get Result>> Crecipt>>>>>>>>>>>>> ${value}");
        var sts = value[0]["STATUS"];
        var msg = value[0]["MSG"] ?? "";
        if (sts == "1") {
          frDocno.value = value[0]["CODE"];
          frDocType.value = value[0]["DOCTYPE"];
          wstrPageMode.value = "VIEW";
            apiViewContarctRecipt(frDocno.value, "LAST", frDocType.value);
          successMsg(context, msg);
        } else {
          errorMsg(context, msg);
        }
      }
    }
  }
