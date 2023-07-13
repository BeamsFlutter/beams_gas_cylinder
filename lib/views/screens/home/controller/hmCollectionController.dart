
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../../components/lookup/lookup.dart';
enum PaymentMode { cash, card,cheque }
class HmCollectionController extends GetxController{

  var g  = Global();


  //Page Variables
  Rx<DateTime> docDate = DateTime.now().obs;
  var wstrPageMode = "VIEW".obs;
  var paymentvalue="".obs;
  late Future <dynamic> futureform;
  RxString frDocno="".obs;
  RxString frDocType="CIR".obs;
  RxString contractNumber="".obs;
  RxString contractDocType="".obs;
  RxString partyName="".obs;
  RxString partyCode="".obs;
  RxString partyLocation="".obs;
  RxString frBuildingCode="".obs;
  RxString frBuildingName="".obs;
  RxString frAprtmntCode="".obs;
 // RxDouble balanceAmount=0.0.obs;
  var getinvoiceDatas=[].obs;
  final paymentMode = PaymentMode.cash.obs;
  var txtCollectionAmt = TextEditingController();
  var txtController = TextEditingController();
  var txtchequeNumber = TextEditingController();
  var txtchequeDate = TextEditingController();


  var paymentList=[
    { "CODE":"001",
      "PDETAILS":"CASH",
    },
    { "CODE":"002",
      "PDETAILS":"CARD",},
    { "CODE":"003",
      "PDETAILS":"CREDIT",},
  ].obs;

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

  //============================================MENU
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
    apiViewCollection('', "LAST");

  }

  fnPage(mode) {

    switch (mode) {
      case 'FIRST':
        apiViewCollection('', mode);
        break;
      case 'LAST':
        apiViewCollection('', mode);
        break;
      case 'NEXT':
        apiViewCollection(frDocno.value, mode);
        break;
      case 'PREVIOUS':
        apiViewCollection(frDocno.value, mode);
        break;
    }
  }
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
    List tableContractRec =[];


    tableContractRec.add({
      "COMPANY" : g.wstrCompany,
      "YEARCODE" :g.wstrYearcode,
      "DOCNO" : frDocno.value,
      "DOCTYPE" : frDocType.value,
      "DOCDATE" : setDate(2,docDate.value),
      "CONTRACT_NO" : contractNumber.value,
      "SLCODE" : partyCode.value,
      "SLDESCP" : partyName.value,
      "BUILDING_CODE" :frBuildingCode.value,
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
      "AMT" :  g.mfnDbl(txtCollectionAmt.text),
      "AMTFC" :  g.mfnDbl(txtCollectionAmt.text),
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

    if(partyCode.value.isEmpty){
      errorMsg(context, "Select Party");
      return;
    }
    if(double.parse(txtCollectionAmt.text)<0){
      errorMsg(context, "No Pending Payment");
      return;
    }
    if(paymode==""){
      errorMsg(context, "Choose Paymode");
      return;
    }


    apiSaveCollection(tableContractRec, context);


  }

  fnDelete(){

  }
  fnClear(){

    partyName.value="";
    partyCode.value="";


  }
  //============================================FUNCTIONS
  void onClickChoosePyment(value) {
    dprint("paymets...........   "+value);
    if(wstrPageMode.value  == "VIEW"){
      return;
    }
    paymentvalue.value = value;
    update();
  }

  fnFillCustomerData(data,mode,context){
    if(g.fnValCheck(data)){
      dprint(data);
      if(mode  ==  "GCYLINDER_CONTRACT"){
        contractNumber.value  = data["CONTRACT_NO"]??"";
        contractDocType.value = data["DOCTYPE"]??"";
        apiViewInvoiceBalnce(contractNumber.value,context);

      }
    }


  }

  fnFill(data,context){

    dprint("ddddda ${data}");
    getinvoiceDatas.value =data;
    dprint("getinvoiceDatas.value?>>>>>>>>>>>>>> ${getinvoiceDatas.value}");




      partyName.value = (getinvoiceDatas[0]["SLDESCP"]??"").toString();
      partyCode.value = (getinvoiceDatas[0]["SLCODE"]??"").toString();
       txtCollectionAmt.text =(getinvoiceDatas[0]["BALANCE_AMOUNT"] ?? "").toString();
       contractNumber.value =(getinvoiceDatas[0]["CONTRACT_NO"] ?? "").toString();
       frBuildingCode.value =(getinvoiceDatas[0]["BUILDING_CODE"] ?? "").toString();
       frBuildingName.value =(getinvoiceDatas[0]["BUILDING_NAME"] ?? "").toString();
       frAprtmntCode.value =(getinvoiceDatas[0]["APARTMENT_CODE"] ?? "").toString();
      if(double.parse(txtCollectionAmt.text)<=0){
       errorMsg(context, "No Pending Payments");
       partyName.value="";
       partyCode.value="";
      }

      dprint(partyName.value);






    }
  fnFillCollectionDatas(data){
    dprint("DDDDDDDDDDDDDDAA  ${data}");
    var contractrec  = g.fnValCheck(data["CONTRACTREC"])?data["CONTRACTREC"][0]:[];
    if(g.fnValCheck(contractrec)){
      frDocno.value = (contractrec["DOCNO"]??"").toString();
      frDocType.value = (contractrec["DOCTYPE"]??"").toString();
      contractNumber.value = (contractrec["CONTRACT_NO"]??"").toString();
      partyCode.value = (contractrec["SLCODE"]??"").toString();
      partyName.value = (contractrec["SLDESCP"]??"").toString();
      frBuildingCode.value = (contractrec["BUILDING_CODE"]??"").toString();
      frBuildingName.value = (contractrec["BUILDING_NAME"]??"").toString();
      frAprtmntCode.value = (contractrec["APARTMENT_CODE"]??"").toString();
      txtCollectionAmt.text=(contractrec["AMTFC"] ?? "").toString();
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

      if(contractrec["DOCDATE"] != null|| contractrec["DOCDATE"] != ""){
        try{
          docDate.value=DateTime.parse(contractrec["DOCDATE"].toString());
        }catch(e){
          docDate.value =DateTime.now();
        }
      };



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
  //====================lookup=================================================
  fnLookup(mode,context){
    dprint(mode);
    if(mode == "GCYLINDER_CONTRACT" ){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'CONTRACT_NO', 'Display': 'CONTRACT_NO'},
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
            title: 'Doc Number',
            lstrColumnList: lookup_Columns,
            lstrFilldata: lookup_Filldata,
            lstrPage: '0',
            lstrPageSize: '100',
            lstrFilter: lstrFilter,
            keyColumn: 'CONTRACT_NO',
            mode: "S",
            layoutName: "B",
            callback: (data){
              fnFillCustomerData(data,mode,context);
            },
            searchYn: 'Y',
          )
      );
    }



  }
  //====================API=================================================
  apiViewInvoiceBalnce(contrNo,context){
    futureform = ApiCall().apiGetInvoiceBalnce(contrNo);
    futureform.then((value) => apiGetInvoiceBalnceRes(value,context));
  }
  apiGetInvoiceBalnceRes(value,context){
    if(g.fnValCheck(value)){
      fnClear();
      fnFill(value,context);
    }

  }


  apiViewCollection(docNumber,mode){
    futureform = ApiCall().apiViewCollection(docNumber,mode,frDocType.value);
    futureform.then((value) => apiViewCollectionRes(value));
  }
  apiViewCollectionRes(value){
    if(g.fnValCheck(value)){
      fnClear();
      fnFillCollectionDatas(value);
    }

  }


  apiSaveCollection(tableContractRec,context){
    dprint("!!!!!!!!!!!!!apiiii");
    futureform = ApiCall().saveCollection(wstrPageMode.value, tableContractRec);
    futureform.then((value) => apiSaveCollectionRes(value,context));
  }
  apiSaveCollectionRes(value,context){

    if(g.fnValCheck(value)){
      dprint("Get Result>>>>>>>>>>>>>>> ${value}");
      var sts  =  value[0]["STATUS"];
      var msg  =  value[0]["MSG"]??"";
      if(sts == "1"){
        frDocno.value = value[0]["CODE"];
         frDocType.value = value[0]["DOCTYPE"];
        wstrPageMode.value ="VIEW";
        apiViewCollection(frDocno.value, "LAST");
        successMsg(context, msg);
      }else{
        errorMsg(context, msg);
      }
    }
  }

}