import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../../servieces/api_params.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../../components/lookup/lookup.dart';
import '../../../styles/colors.dart';
import 'package:badges/badges.dart' as badges;

class HmSalesController extends GetxController{

  Rx<DateTime> docDate = DateTime.now().obs;
  Rx<DateTime> delivryDate = DateTime.now().obs;
  RxString frDocno="".obs;
  var frDocType="CGI".obs;
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
  var contractNumber=''.obs;
  var contractDocType=''.obs;
  //************************CONTROLLER
  final txtCustomerCode = TextEditingController();
  var txtContactNo = TextEditingController();
  var txtRemark = TextEditingController();
  var txtLandmark = TextEditingController();
  var txtAddress = TextEditingController();
  var txtCustomerName = TextEditingController();

  var txtBuildingCode = TextEditingController();
  var txtBuildingName = TextEditingController();
  var txtApartmentCode = TextEditingController();
  var txtApartmentName = TextEditingController();
  var txtAreacode = TextEditingController();
  var txtDriver = TextEditingController();
  var txtVehiclenumber= TextEditingController();
  var txtController= TextEditingController();
  var txtlocation= TextEditingController();
  var txtsman= TextEditingController();

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
  RxList lstrStockDetailList =[].obs;
  var lstrProductTypeList = [].obs;
  var bookingList =[].obs;
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

  fnClear(){
    dprint("######################   clear #####################");
    frDocno.value="";
    // frDocType.value="CGI";
    txtLandmark.clear();
    txtRemark.clear();
    txtAddress.clear();
    txtAreacode.clear();
    docDate.value=DateTime.now();
    cstmrName.value="";
    cstmrCode.value="";
    delivryDate.value=DateTime.now();
    lstrSalesList.value=[];
    txtTotalAmt.text="";
    txtDriver.clear();
    txtContactNo.clear();
    cstmrCode.value="";
    cstmrName.value="";
    txtCustomerName.clear();
    txtApartmentCode.text="";
    txtAreacode.text="";
    txtApartmentName.clear();
    txtTotalAmt.clear();
    txtVehiclenumber.clear();
    txtApartmentName.clear();
    txtBuildingCode.clear();
    txtBuildingName.clear();
    txtAddlAmt.clear();
    txtDiscountAmt.clear();
    txtlocation.clear();
    txtBalanceAmt.clear();
    txtPaidAmt.clear();
    txtNetAmt.clear();
    selectedItem.value="";
    selectedproduct.value="";
    txtRoundAmt.clear();
    txtTaxAmt.clear();
    txtTaxAmt.text='';
    txtNetAmt.clear();



  }

  fnFill(data){
    var headerList  =g.fnValCheck(data["HEADER"])? data["HEADER"][0]:[];
    var detList  = g.fnValCheck(data["DET"])?data["DET"]:[];
    dprint("FIlled  HEADER>>>>  ${headerList}");
    dprint("FIlled  DET>>>>  ${detList}");



    if(g.fnValCheck(headerList)){
      g.wstrCompany=(headerList["COMPANY"]??"").toString();
      g.wstrYearcode=(headerList["YEARCODE"]??"").toString();
      frDocno.value = (headerList["DOCNO"]??"").toString();
      frDocType.value = (headerList["DOCTYPE"]??"").toString();
      cstmrName.value = (headerList["PARTYNAME"]??"").toString();
      txtCustomerCode.text = (headerList["PARTYCODE"]??"").toString();
      cstmrCode.value = (headerList["PARTYCODE"]??"").toString();
      txtlocation.text = (headerList["LOC"]??"").toString();
      txtCustomerName.text = (headerList["PARTYNAME"]??"").toString();
      txtVehiclenumber.text = (headerList["VEHICLE_NO"]??"").toString();
      txtDriver.text = (headerList["DRIVER"]??"").toString();
      txtRoundAmt.text =(headerList["ROUND_OFF_AMT"]??"").toString();
      txtAddlAmt.text =(headerList["ADDL_AMT"]??"").toString();
      txtTaxAmt.text =(headerList["TOTAL_TAXAMT"]??"").toString();
      txtBalanceAmt.text =(headerList["BAL_AMT"]??"").toString();
      txtPaidAmt.text =(headerList["PAID_AMT"]??"").toString();
      txtNetAmt.text =(headerList["NETAMT"]??"").toString();
      txtDiscountAmt.text =(headerList["DISC_AMT"]??"").toString();
      txtBuildingCode.text = (headerList["BUILDING_CODE"]??"").toString();
      txtRemark.text = (headerList["REMARKS"]??"").toString();
      txtAddress.text = (headerList["ADDRESS1"]??"").toString();
      txtsman.text=g.wstrSman;
      txtContactNo.text = (headerList["MOBILE"]??"").toString();
      txtAreacode.text = (headerList["AREA_CODE"]??"").toString();
      txtlocation.text = (headerList["LOC"]??"").toString();
      txtTotalAmt.text = (headerList["GRAMTFC"]??"").toString();

      txtApartmentCode.text = (headerList["PROPERTY_CODE"]??"").toString();
      if(headerList["DELIVERY_REQ_DATE"] != null|| headerList["DELIVERY_REQ_DATE"] != ""){
        try{
          delivryDate.value =setDate(15, DateTime.parse(headerList["DELIVERY_REQ_DATE"].toString()));

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
      lstrSalesList.value = [];


      var totalAmount = 0.0;
      var totalGrAmt = 0.0;
      var totalTaxAmt = 0.0;
      var totalDiscountAmt = 0.0;
      var balanceAmount = 0.0;
      var addlAmount =  0.0;
      var netAmount = 0.0;
      var currRate =  1.0;
      var srno = 0;
      for(var e in detList){
        var qty = g.mfnDbl(e["QTY2"]);
        var rtnQty  = g.mfnDbl(e["RETURN_QTY"]);
        var price =  g.mfnDbl(e["RATE2"]);
        var soldrate =g.mfnDbl(e["CYL_SELL_RATE"]);
        var disc  =0.0;

        var soldQty = qty - rtnQty;
        var gasAmount  =  qty * price ;
        var soldAmount =  soldQty * soldrate;

        var gramt =  gasAmount + soldAmount;
        var amt = gramt - disc;
        totalAmount = totalAmount + amt;
      }

      for (var e in detList) {
        dprint("##########gg##########  ${e}");
        var qty2 = g.mfnDbl(e["QTY2"]);
        var returnQty  = g.mfnDbl(e["RETURN_QTY"]);
        var price =  g.mfnDbl(e["RATE2"]);
        var soldRate = g.mfnDbl(e["CYL_SELL_RATE"]);
        var vat = g.mfnDbl(e["VAT_PERC"]);
        var disc  = 0.0;
        var unitCf = g.mfnDbl(e["CAT_WEIGHT"]) == 0?1:0;

        var qty1 = qty2 * unitCf;

        var rate2 = price;
        var rate1 = price*unitCf;

        var unit1 = e["UNIT"];
        var unit2 = e["UNIT2"];

        dprint("##########qty1##########  ${qty1}");
        dprint("##########qty2##########  ${qty2}");

        var datas =Map<String,dynamic>.from({
          "STKCODE": e["STKCODE"],
          "STKDESCP": e["STKDESCP"],
          "QTY": qty2,
          "RETURN_QTY": returnQty,
          "DISC_AMT": e["DISC_AMT"],
          "RATE": e["RATE2"],
          "VAT_PERC":e["VAT_PERC"],
          "NQTY":e["QTY2"],
          "EQTY":e["RETURN_QTY"],
          "RQTY":0,
          "UNIT":unit1,
          "UNIT2":unit2,
          "CYL_SELL_RATE":e["SOLD_RATE"],
          "SALEUNIT":unit2,
          "CYLINDER_YN":"Y",
          "CATWEIGHT":e["UNITCF"],
          "MATERIAL_CODE":e["MATERIAL_CODE"]??"",
          "PRICE2":e["PRICE2"]??"",
          "PRICE1":e["PRICE1"]??"",
          "CYLINDER_TYPE":e["CYLINDER_CAT"],
        });


        lstrSalesList.value.add(datas);
        i++;
        update();
      }

      // txtTotalAmt.text =  totalAmount.toStringAsFixed(2);



    }


  }
  fnfillStockDetails(data) {
    lstrStockDetailList.value  =data["Table1"];
    dprint("Stoc>>>>>>>>>>>> ${lstrStockDetailList.value}");

  }
  fnSave(context){
    if(lstrSalesList.isEmpty){
      errorMsg(context, "Choose Items");
      return;

    }
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

    if(txtlocation.text.isEmpty){
      errorMsg(context, "Choose Location");
      return;
    }

    List tableInv=[];
    List tableInvDet =[];

    var taxincldYN = lstrStockDetailList[0]["Column1"];


    var totalAmount = 0.0;
    var totalGrAmt = 0.0;
    var totalTaxAmt = 0.0;
    var totalDiscountAmt = 0.0;
    var balanceAmount = 0.0;
    var taxAmount =  0.0;

    totalDiscountAmt =  g.mfnDbl(txtDiscountAmt.text);
    var roundOfAmount =  g.mfnDbl(txtRoundAmt.text);

    var paidAmount =  g.mfnDbl(txtPaidAmt.text);
    var netAmount = 0.0;

    var currRate =  1.0;

    var vatAmount=0.0;
    var vatB=0.0;

    var srno = 0;




    for(var e in lstrSalesList.value){
      var qty = g.mfnDbl(e["QTY"]);
      var rtnQty  = g.mfnDbl(e["RETURN_QTY"]);
      var price =  g.mfnDbl(e["RATE"]);
      var soldrate =g.mfnDbl(e["CYL_SELL_RATE"]);
      var disc  =0.0;

      var soldQty = qty - rtnQty;
      var gasAmount  =  qty * price ;
      var soldAmount =  soldQty * soldrate;

      var gramt =  gasAmount + soldAmount;
      var amt = gramt - disc;
      totalAmount = totalAmount + amt;
    }

    int i=1;
    for(var e in lstrSalesList.value){

      dprint("******************* lstrSalesList ${lstrSalesList}");
      dprint("******************* txtBuildingCode ${txtBuildingCode.text}");
      dprint("******************* txtdelivryDate ${delivryDate}");
      dprint("******************* txtlocation.text ${txtlocation.text}");

      var qty2 = g.mfnDbl(e["QTY"]);
      var returnQty  = g.mfnDbl(e["RETURN_QTY"]);
      var price =  g.mfnDbl(e["RATE"]);
      var soldRate = g.mfnDbl(e["CYL_SELL_RATE"]);
      var vat = g.mfnDbl(e["VAT_PERC"]);
      var disc  = 0.0;
      var unitCf = g.mfnDbl(e["CATWEIGHT"]) == 0?1:g.mfnDbl(e["CATWEIGHT"]);
      var grAmount =  0.0;

      var qty1 = qty2 * unitCf;
      var rate2 = price;
      var rate1 = price/unitCf;
      var unit1 = e["UNIT"];
      var unit2 = e["UNIT2"];
      var soldQty = qty2 - returnQty;
      var gasAmount  =  qty2 * price ;
      var soldAmount =  soldQty * soldRate;
      var gramt =  gasAmount + soldAmount;
      var amt = gramt - disc;


      dprint("AMTTTT ${amt}");
      dprint("totalllllll ${totalAmount}");

      var headerDiscount  = (amt/totalAmount) * totalDiscountAmt;
      var total = amt-headerDiscount;
      var net = 0.0;


      if(taxincldYN == 'Y' && vat > 0){
        var dvd = 100 /(100+vat);
        vatB =  total * dvd;
        vatAmount = total - vatB;
        net = total;
      }else{
        vatB = (vat)/100;
        vatAmount = total * vatB;
        net = total+vatAmount;
      }


      dprint("HEADERDDI ${headerDiscount}");
      var taxAmtV = (amt-headerDiscount)*vat;
      var taxAmt  = taxAmtV !=0 ? (taxAmtV/100):0.0;
      //totalCalc For Header
      totalGrAmt = totalGrAmt + gramt;
      totalTaxAmt = totalTaxAmt + taxAmt;
      grAmount = grAmount + gramt;
      taxAmount =  taxAmount +vatAmount;
      netAmount = netAmount + net ;




      tableInvDet.add({
        "COMPANY" : g.wstrCompany,
        "YEARCODE" :g.wstrYearcode,
        "DOCNO" : frDocno.value,
        "DOCTYPE" : frDocType.value,
        "AREA_CODE":txtAreacode.text,
        "DOCDATE":  setDate(2,docDate.value),
        "SRNO": i,
        "REMARKS":txtRemark.text,
        "STKCODE" : e["STKCODE"],
        "STKDESCP" : e["STKDESCP"],
        "MATERIAL_CODE": e["MATERIAL_CODE"],
        "LOC": txtlocation.text,
        "VEHICLE_NO": txtVehiclenumber.text,
        "QTY1": qty1,
        "QTY2": qty2,
        "RATE": rate1,
        "RATEFC": rate1*currRate,
        "RATE2": rate2,
        "QTYRET":returnQty,
        "RATEFC2": rate2*currRate,
        "AMT": amt,
        "AMTFC": amt*currRate,
        "RETURN_QTY": returnQty,
        "SOLD_QTY": soldQty,
        "SOLD_RATE": soldRate,
        "SOLD_RATEFC": soldRate*currRate,
        "SOLD_AMT": soldAmount,
        "SOLD_AMTFC": soldAmount*currRate,
        "NETAMT": netAmount,
        "NETAMTFC": netAmount*currRate,
        "PRVDOCTABLE": "",
        "PRVYEARCODE": "",
        "PRVDOCNO": "",
        "PRVDOCTYPE": "",
        "PRVDOCSRNO": 0,
        "PRVDOCQTY": 0,
        "DBACCODE": "",
        "CRACCODE": "",
        "DBCOSTSALE": "",
        "BUILDING_CODE":txtBuildingCode.text??"",
        "DBINVENTORY": "",
        "CRCOSTSALE": "",
        "CRINVENTORY": "",
        "CYL_DBACCODE": "",
        "CYL_CRACCODE": "",
        "CYL_DBCOSTSALE": "",
        "CYL_DBINVENTORY": "",
        "CYL_CRCOSTSALE": "",
        "CYL_CRINVENTORY": "",
        "CYLINDER_CAT":e["CYLINDER_TYPE"],
        "UNIT1": unit1,
        "UNITCF": unitCf,
        "UNIT2": unit2,
        "CYLINDER_STKCODE":  e["STKCODE"],
        "CYLINDER_CODE":  e["STKCODE"],
        "CYLINDER_STKDESCP": e["STKDESCP"],
        "CYLINDER_QTY1": qty2,
        "CYLINDER_UNIT": unit2,
        "DRIVER": txtDriver.text,
        "SMAN": txtsman.text??g.wstrSman,
        "PARTYCODE" : cstmrCode.value,
        "PARTYNAME" : cstmrName.value,
        "DUEDATE": "",
        "AM": "",
        "DELIVERY_DATE" : setDate(2,delivryDate.value),
        "ACTUAL_DELIVERY_DATE" : setDate(2,docDate.value),
        "HEADER_DISC_AMT":headerDiscount,
        "HEADER_DISC_AMTFC":headerDiscount*currRate,
        "VAT_PERC" : vat,
        "VAT_AMTFC" : taxAmt*currRate,
        "VAT_AMT" : taxAmt,
        "TOT_TAX_AMTFC" : taxAmt*currRate,
        "TOT_TAX_AMT" : taxAmt,
        "CRCURR" : "AED",
        "CRCURRATE" : currRate,
        "CASH_CREDIT" : "CR",
        "CURR" : "AED",
        "CREATE_USER":g.wstrUsername,
        "EDIT_USER":g.wstrUsername,


      });
      i++;


    }

    netAmount =  netAmount +  roundOfAmount;
    balanceAmount =netAmount-paidAmount;
    dprint("NETAMOUNT>>>>>>>>>>>>>>>>> ${netAmount}");
    dprint("BALANCEAMOUNT>>>>>>>>>>>>>>>>> ${balanceAmount}");
    dprint("txtRemark.text>>>>>>>>>>>>>>>>> ${txtRemark.text}");


    tableInv.add({
      ApiParams.company : g.wstrCompany,
      ApiParams.yearcode  : g.wstrYearcode,
      "DOCNO" : frDocno.value,
      "DOCTYPE" : frDocType.value,
      "DOCDATE" : setDate(2,docDate.value),
      "PARTYCODE" : cstmrCode.value,
      "PARTYNAME" : cstmrName.value,
      "DRIVER" : txtDriver.text??g.wstrDrviverCode,
      "VEHICLE_NO" :txtVehiclenumber.text??g.wstrVehicleNumber,
      "LOC" : txtlocation.text,
      "CASH_CREDIT" : "CR",
      "CURR" : "AED",
      "CURRATE" : currRate,
      "GRAMT" : totalGrAmt,
      "GRAMTFC" : totalGrAmt*currRate,
      "DISC_AMT" : totalDiscountAmt,
      "DISC_AMTFC" : totalDiscountAmt*currRate,
      "ADDL_AMT" : 0.0,
      "ADDL_AMTFC" : 0.0,
      "DISCPERCENT" : 0,
      "NETAMT" : netAmount,
      "NETAMTFC" : netAmount*currRate,
      "PAID_AMT" : paidAmount,
      "PAID_AMTFC" : paidAmount*currRate,
      "BAL_AMT" : balanceAmount,
      "BAL_AMTFC" :balanceAmount*currRate,
      "REMARKS" : txtRemark.text,
      "TAX_AMT" : totalTaxAmt,
      "TAX_AMTFC" : totalTaxAmt*currRate,
      "ROUND_OFF_AMT" : roundOfAmount,
      "ROUND_OFF_AMTFC" :roundOfAmount*currRate,
      "PRVMULTIDOCNO" : "",
      "VAT_PERC" : vatB,
      "TOTAL_TAXAMTFC" : totalTaxAmt*currRate,
      "TOTAL_TAXAMT" : totalTaxAmt,
      "BUILDING_CODE" : txtBuildingCode.text,
      "PROPERTY_CODE" : txtApartmentCode.text,
      "DELIVERY_DATE" :setDate(2,delivryDate.value) ,
      "CHG_AMT" : 0,
      "CHG_AMTFC" : 0,
      "CRDAYS" : 0,
      "CREATE_USER" : g.wstrUserCD,
      "EDIT_USER": g.wstrUserCD,
      "BRNCODE": "",
      "DIVCODE": "",
      "CCCODE": "",
      "SMAN": txtsman.text??g.wstrSman,
      "CONTRACT_NO":contractNumber.value,
      "CONTRACT_DOCTYPE":contractDocType.value

    });
    dprint("INVV>>>>>>>>>>>  ${tableInv}");
    dprint("INVV det>>>>>>>>>>>  ${tableInvDet}");

    apiSaveSales(tableInv,tableInvDet,context);

  }

  fnDelete(){}
  fnBackPage(context){
    PageDialog().exitDialog(context, fnEnd);
  }
  fnEnd(context){
    Get.back();
    Get.back();

  }

  fnPaymntCalc() {
    dprint("******************************PAYMNET_CALC********************     ${lstrStockDetailList.value[0]["Column1"]}");
    var totalAmount =  0.0;
    var taxAmount =  0.0;
    var netAmount =  0.0;
    var balanceAmount =  0.0;
    var grAmount =  0.0;

    var discAmount =  g.mfnDbl(txtDiscountAmt.text);
    var roundOfAmount =  g.mfnDbl(txtRoundAmt.text);
    var addlAmount =  0.0;
    var paidAmount =  g.mfnDbl(txtPaidAmt.text);
    var taxincldYN = lstrStockDetailList[0]["Column1"];
    for(var e in lstrSalesList.value){
      var qty = g.mfnDbl(e["QTY"]);
      var rtnQty  = g.mfnDbl(e["RETURN_QTY"]);
      var price =  g.mfnDbl(e["RATE"]);
      var soldRate = g.mfnDbl(e["CYL_SELL_RATE"]);
      var disc  = 0.0;

      var soldQty = qty - rtnQty;
      var gasAmount  =  qty * price ;
      var soldAmount =  soldQty * soldRate;

      var gramt =  gasAmount + soldAmount;
      var amt = gramt - disc;
      totalAmount = totalAmount + amt;

      dprint("TOTAL>>>>>>>>>>> ${totalAmount}");

    }

    for(var e in lstrSalesList){
      var qty = g.mfnDbl(e["QTY"]);
      var rtnQty  = g.mfnDbl(e["RETURN_QTY"]);
      var price =  g.mfnDbl(e["RATE"]);
      var soldRate = g.mfnDbl(e["CYL_SELL_RATE"]);
      var vat = g.mfnDbl(e["VAT_PERC"]);
      var disc  = 0.0;

      var soldQty = qty - rtnQty;
      var gasAmount  =  qty * price ;
      var soldAmount =  soldQty * soldRate;

      var gramt =  gasAmount + soldAmount;
      var amt = gramt - disc;
      var vatAmount=0.0;
      var vatB=0.0;
      var net = 0.0;

      var headerDiscount  = (amt/totalAmount) * discAmount;
      var total = amt-headerDiscount;

      if(taxincldYN == 'Y' && vat > 0){
        var dvd = 100 /(100+vat);
        vatB =  total * dvd;
        vatAmount = total - vatB;
        net = total;
      }else{
        vatB = (vat)/100;
        vatAmount = total * vatB;
        net = total+vatAmount;
      }



      grAmount = grAmount + gramt;
      taxAmount =  taxAmount +vatAmount;

      dprint("NETT>>>> INCLUSIVE ${net}");
      netAmount = netAmount + net ;

    }

    netAmount =  netAmount +  roundOfAmount;
    balanceAmount =  netAmount - paidAmount;

    txtTotalAmt.text =  totalAmount.toStringAsFixed(2);
    txtTaxAmt.text =  taxAmount.toStringAsFixed(2);
    txtNetAmt.text =  netAmount.toStringAsFixed(2);
    txtBalanceAmt.text =  balanceAmount.toStringAsFixed(2);

  }
  //**************************************************LOOKUP

  fnLookup(mode){
    dprint(mode);


    if(mode == "CRDELIVERYMANMASTER") {
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DEL_MAN_CODE', 'Display': 'Code'},
        {'Column': 'NAME', 'Display': 'Name'},
        {'Column': 'VEHICLE_NO', 'Display': 'N'},
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
    else if(mode == "SMANMAST"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'CODE', 'Display': 'Code'},
        {'Column': "DESCP", 'Display': 'N'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[];

      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'SMANMAST',
            title: 'sman',
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
    else   if(mode == "SLMAST"){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'SLCODE', 'Display': 'Code'},
        {'Column': 'SLDESCP', 'Display': 'Name'},
        {'Column': 'MOBILE', 'Display': 'Mobile'},
        {'Column': 'EMAIL', 'Display': 'Email'},
        {'Column': 'BUILDING_CODE', 'Display': 'Building'},
        {'Column': 'APARTMENT_CODE', 'Display': 'Apartment'},
        // {'Column': 'LANDMARK', 'Display': ''},
        // {'Column': 'REMARKS', 'Display': ''},
        // {'Column': 'AREA_CODE', 'Display': ''},
        {'Column': 'ADDRESS1', 'Display': ''},
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
    else if(mode == "Gcylinder_inv" ){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'DOCNO'},
        {'Column': "DOCTYPE", 'Display': 'N'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[];
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'Gcylinder_inv',
            title: 'Docnumber',
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

  //**************************************************FUNCTION
  void fnFillData(data, mode) {}

  void fnFillCustomerData(data, mode) {
    if (g.fnValCheck(data)) {
      if (mode == "LOCMAST") {
        txtlocation.text = data["CODE"] ?? "";

        //   apiGetCustomerDetails();
      }
      else if (mode == "SLMAST") {
        dprint("RRRRRRRRRR ${data}");
        txtCustomerCode.text = data["SLCODE"] ?? "";
        txtCustomerName.text = data["SLDESCP"] ?? "";
        txtContactNo.text = data["MOBILE"] ?? "";
        // frEmail.value  = data["EMAIL"]??"";
        cstmrCode.value = data["SLCODE"] ?? "";
        cstmrName.value = data["SLDESCP"] ?? "";
        txtApartmentCode.text = data["APARTMENT_CODE"] ?? "";
        txtAddress.text = data["ADDRESS1"] ?? "";
        txtBuildingCode.text = data["BUILDING_CODE"] ?? "";
        g.wstrBuildingCode = data["BUILDING_CODE"] ?? "";
        g.wstrApartmentCode = data["APARTMENT_CODE"] ?? "";
        //    apiGetCustomerInfo();
      }
      else if (mode == "CRDELIVERYMANMASTER") {
        dprint("fdfd ${data}");
        txtDriver.text = data["DEL_MAN_CODE"]??g.wstrDrviverCode;
        txtVehiclenumber.text = data["VEHICLE_NO"]??g.wstrVehicleNumber;
        //    apiGetCustomerInfo();
      }
      else if (mode == "CRVEHICLEMASTER") {
        dprint("RRRRRRRRRR ${data}");
        txtVehiclenumber.text = data["VEHICLE_NO"];

        //    apiGetCustomerInfo();
      }
      else if (mode == "SMANMAST") {
        dprint("SMANMASTsssssssss ${data}");
        txtsman.text = data["CODE"];

        //    apiGetCustomerInfo();
      }
      else if (mode == "Gcylinder_inv") {
        frDocno.value = data["DOCNO"]??"";
        frDocType.value = data["DOCTYPE"]??"";
        apiViewSales(frDocno.value,"");

        //    apiGetCustomerInfo();
      }
    }
  }


  fnFillBookingDetails(data){
    dprint("ddddddddata  ${data}");
    var headerList  =g.fnValCheck(data["HEADER"])? data["HEADER"][0]:[];
    var detList  = g.fnValCheck(data["DET"])?data["DET"]:[];
    var assignmentList  = g.fnValCheck(data["ASSIGNMENTDET"])?data["ASSIGNMENTDET"]:[];
    dprint("hhhhhhhhhh${headerList}");
    txtCustomerCode.text = headerList["PARTY_CODE"].toString();
    cstmrCode.value = headerList["PARTY_CODE"].toString();
    cstmrName.value = headerList["PARTY_NAME"].toString();
    txtCustomerName.text = headerList["PARTY_NAME"].toString();
    txtContactNo.text = headerList["MOBILE_NO"].toString();
    txtBuildingCode.text = headerList["BLDG_NO"].toString();
    txtApartmentCode.text = headerList["APARTMENT_NO"].toString();
    txtAreacode.text = headerList["AREA_CODE"].toString();
    txtLandmark.text = headerList["LANDMARK"].toString();
    txtAddress.text = headerList["CUST_ADDRESS"].toString();
    txtRemark.text = headerList["REMARKS"].toString();
    contractNumber.value = headerList["CONTRACT_NO"].toString();
    contractDocType.value = headerList["CONTRACT_DOCTYPE"].toString();
    txtDriver.text =detList[0]["DEL_MAN_CODE"].toString();
    txtVehiclenumber.text =detList[0]["VEHICLE_NO"].toString();
    txtsman.text=g.wstrSman;

    if(g.fnValCheck(detList)){
      int i = 1;
      lstrSalesList.value = [];


      var totalAmount = 0.0;
      var totalGrAmt = 0.0;
      var totalTaxAmt = 0.0;
      var totalDiscountAmt = 0.0;
      var balanceAmount = 0.0;
      var addlAmount =  0.0;
      var netAmount = 0.0;
      var currRate =  1.0;
      var srno = 0;
      for(var e in detList){
        var qty = g.mfnDbl(e["QTY1"]);
        var rtnQty  = g.mfnDbl(e["RETURN_QTY"]);
        var price =  g.mfnDbl(e["RATE"]);
        var soldrate =g.mfnDbl(e["CYL_SELL_RATE"]);
        var disc  =0.0;

        var soldQty = qty - rtnQty;
        var gasAmount  =  qty * price ;
        var soldAmount =  soldQty * soldrate;

        var gramt =  gasAmount + soldAmount;
        var amt = gramt - disc;
        totalAmount = totalAmount + amt;
      }

      for (var e in detList) {
        dprint("##########saleee##########  ${e}");
        var qty2 = g.mfnDbl(e["QTY2"]);
        var returnQty  = g.mfnDbl(e["RETURN_QTY"]);
        var price =  g.mfnDbl(e["RATE"]);
        var soldRate = g.mfnDbl(e["CYL_SELL_RATE"]);
        var vat = g.mfnDbl(e["VAT"]);
        var disc  = 0.0;
        var unitCf = g.mfnDbl(e["CAT_WEIGHT"]) == 0?1:0;

        var qty1 = qty2 * unitCf;

        var rate2 = price;
        var rate1 = price*unitCf;

        var unit1 = e["UNIT"];
        var unit2 = e["UNIT2"];
        dprint("##########qty1##########  ${qty1}");
        dprint("##########qty2##########  ${qty2}");

        var datas =Map<String,dynamic>.from({
          "STKCODE": e["STOCK_CODE"],
          "STKDESCP": e["STOCK_DESC"],
          "QTY": e["QTY1"],
          "RATE": e["RATE"],
          "VAT_PERC":e["VAT"],
          "RETURN_QTY": returnQty,
          "DISC_AMT": e["DISC_AMT"],
          "NQTY":g.mfnDbl(e["QTY2"]),
          "EQTY":g.mfnDbl(e["RETURN_QTY"]),
          "RQTY":0,
          "UNIT":unit1,
          "UNIT2":unit2,
          "CYL_SELL_RATE":e["SOLD_RATE"],
          "SALEUNIT":unit2,
          "CYLINDER_YN":"Y",
          "CATWEIGHT":e["UNITCF"],
          "MATERIAL_CODE":e["MATERIAL_CODE"]??"",
          "PRICE2":e["PRICE2"]??"",
          "PRICE1":e["PRICE1"]??"",
          "CYLINDER_TYPE":e["CYLINDER_CAT"],
        });




        lstrSalesList.value.add(datas);
        i++;
        update();
      }
      dprint("Calll  payment............");
      // fnPaymntCalc();

      // txtTotalAmt.text =  totalAmount.toStringAsFixed(2);



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

                                          var itemName = (lstrProductItemDetailList[index]["STKDESCP"] ?? "").toString();
                                          var itemCode = (lstrProductItemDetailList[index]["STKCODE"] ?? "").toString();

                                          var rate = g.mfnDbl(lstrProductItemDetailList[index]["PRICE1"].toString());
                                          var sellRate = g.mfnDbl(lstrProductItemDetailList[index]["CYL_SELL_RATE"].toString());
                                          var item = lstrSalesList.value.where((element) => element["STKCODE"] == itemCode).toList()
                                          ;
                                          rqty.value = item.isNotEmpty
                                              ? g.mfnDbltoInt(item[0]["RQTY"].toString())
                                              : 0;
                                          nqty.value = item.isNotEmpty
                                              ?  g.mfnDbltoInt(item[0]["NQTY"].toString())
                                              : 0;
                                          eqty.value = item.isNotEmpty
                                              ?  g.mfnDbltoInt(item[0]["EQTY"].toString())
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
                                                              tc("$rate AED", txtColor,
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
                                                              tc("${rate - sellRate} AED", txtColor,
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
                                                              tc("$sellRate AED", txtColor,
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
                                                            fnChngeQty(itemCode, selectedItemType.value, "D");
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
                                                            fnChngeQty(itemCode,selectedItemType.value,"A",);
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
      fnPaymntCalc();
      // fnCalc();

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

    for(var e  in lstrSalesList.value){


      var itemName  = (e["STKDESCP"]??"").toString();
      var itemCode  = (e["STKCODE"]??"").toString();
      var rate  = g.mfnDbl(e["RATE"].toString());
      var qty  = g.mfnDbl(e["QTY"].toString());
      var returnQty  = g.mfnDbl(e["RETURN_QTY"].toString());
      var total = qty*rate;

      rtnList.add( Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: InkWell(
          onLongPress: (){
            if(wstrPageMode.value=="VIEW"){
              return;
            }
            wDeletItemSelect(context,itemCode);

          },


          onTap: (){

            if(wstrPageMode.value=="VIEW"){
              return;
            }
            wItemSelect(context,itemCode,qty);
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
                        tcn(returnQty.toString(),
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
      ));

    }

    return rtnList;
  }

  wItemSelect(context,itemCodee,itemqty){

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
              var sellRate  = g.mfnDbl(item[0]["CYL_SELL_RATE"].toString());
              var qty  = itemqty;

              // dprint("itemRrrr ${itemR}");
              rqty.value = item.isNotEmpty
                  ? g.mfnDbltoInt(item[0]["RQTY"])
                  : 0;
              nqty.value = item.isNotEmpty
                  ?  g.mfnDbltoInt(item[0]["NQTY"])
                  : 0;
              eqty.value = item.isNotEmpty
                  ?  g.mfnDbltoInt(item[0]["EQTY"])
                  : 0;

              return AlertDialog(contentPadding: EdgeInsets.zero,
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
                            padding: const EdgeInsets.all(4),
                            decoration: boxBaseDecoration(white, 20),
                            child: Bounce(duration: const Duration(
                                milliseconds: 110),
                                onPressed: (){
                                  Get.back();
                                }, child: const Icon(Icons.close)),
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
                                      tc("${rate} AED", txtColor,
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
                                      tc("${(rate - sellRate)} AED", txtColor,
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
                                      tc("$sellRate AED", txtColor,
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
                                    fnChngeQty(itemCode, selectedItemType.value, "D");
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
                    )),
                  )

              );
            } ,
          ),
        );
      },
    );






  }
  wDeletItemSelect(context,itemCodee){

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
                            padding: const EdgeInsets.all(4),
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

                                      lstrSalesList.removeWhere((element) =>element["STKCODE"]==itemCodee);
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

  fnChngeQty(itemCode,type,mode) {
    var taxAmount = ''.obs;
    var itemMenu = lstrProductItemDetailList.value.where((element) => element["STKCODE"] == itemCode).toList();
    dprint("ITEMmUNU>>>>>>>>>>>> ${itemMenu}");

    if(mode == "A"){
      dprint(">>>>>>>>>>>AAAAAAAAAAAAAAAA");
      if(lstrSalesList.where((e) => e["STKCODE"] == itemCode).isEmpty){
        dprint(">>>>>>>>>>>AAAAAAAAAAAAAAAAempty");
        var lQty = 0.0;
        var nQty = 0.0;
        var eQty = 0.0;
        var rQty = 0.0;
        var lReturnQty = 0.0;

        if(type == "N"){
          lQty = 1.0;
          nQty = 1.0;
        }else if(type == "R"){
          lQty = 1.0;
          rQty = 1.0;
          lReturnQty = 1.0;
        }else if(type == "E"){
          lReturnQty = 1.0;
          eQty = 1.0;
        }


        var datas = Map<String, Object>.from({
          "STKCODE": itemCode,
          "STKDESCP": itemMenu[0]["STKDESCP"]??"",
          "QTY": lQty,
          "RETURN_QTY": lReturnQty,
          "DISC_AMT": 0.0,
          "RATE": itemMenu[0]["PRICE1"]??"",
          "VAT_PERC":itemMenu[0]["VAT_PERC"]??"",
          "NQTY":nQty,
          "EQTY":eQty,
          "RQTY":rQty,
          "UNIT":itemMenu[0]["UNIT"]??"",
          "UNIT2":itemMenu[0]["SALEUNIT"]??"",
          "CYL_SELL_RATE":itemMenu[0]["CYL_SELL_RATE"]??"",
          "SALEUNIT":itemMenu[0]["SALEUNIT"]??"",
          "CYLINDER_YN":itemMenu[0]["CYLINDER_YN"]??"",
          "CATWEIGHT":itemMenu[0]["CATWEIGHT"]??"",
          "MATERIAL_CODE":itemMenu[0]["MATERIAL_CODE"]??"",
          "PRICE2":itemMenu[0]["PRICE2"]??"",
          "PRICE1":itemMenu[0]["PRICE1"]??"",
          "CYLINDER_TYPE":itemMenu[0]["PRODUCT_TYPE1"]??"",

        });
        lstrSalesList.add(datas);
      }
      else{
        dprint(">>>>>>>>>>>AAAAAAAAAAAAAAAAnotempty");
        var item = lstrSalesList.where((element) => element["STKCODE"] == itemCode).toList();
        if(item.isNotEmpty){
          dprint("***********rt***********  ${item}");
          dprint("***********rt***********  ${item[0]["QTY"]}");

          var lQty = item[0]["QTY"];

          var nQty = item[0]["NQTY"];
          var eQty = item[0]["EQTY"];
          var rQty = item[0]["RQTY"];

          var lReturnQty = 0.0;

          if(type == "N"){
            lQty = item[0]["QTY"]+ 1.0;
            nQty = item[0]["NQTY"] +1.0;
            lReturnQty = item[0]["RETURN_QTY"];
          }else if(type == "R"){
            lQty = item[0]["QTY"]+ 1.0;
            rQty =item[0]["RQTY"] + 1.0;
            lReturnQty = item[0]["RETURN_QTY"]+ 1.0;
          }else if(type == "E"){
            lReturnQty = item[0]["RETURN_QTY"]+ 1.0;
            eQty =item[0]["EQTY"] + 1.0;
          }



          item[0]["QTY"] = lQty;
          item[0]["RETURN_QTY"] = lReturnQty;
          item[0]["NQTY"] = nQty;
          item[0]["EQTY"] = eQty;
          item[0]["RQTY"] = rQty;
        }
      }
    }else{

      var item = lstrSalesList.where((element) => element["STKCODE"] == itemCode ).toList();
      if(item.isNotEmpty){
        var lQty = item[0]["QTY"];
        var nQty = item[0]["NQTY"];
        var eQty = item[0]["EQTY"];
        var rQty = item[0]["RQTY"];
        var lReturnQty = 0.0;
        if(type == "N"){
          lQty = item[0]["QTY"]- 1.0;
          nQty = item[0]["NQTY"] -1.0;
          lReturnQty = item[0]["RETURN_QTY"];
        }else if(type == "R"){
          lQty = item[0]["QTY"]-1.0;
          rQty =item[0]["RQTY"] - 1.0;
          lReturnQty = item[0]["RETURN_QTY"]- 1.0;
        }else if(type == "E"){
          lReturnQty = item[0]["RETURN_QTY"]- 1.0;
          eQty =item[0]["EQTY"] - 1.0;
        }
        item[0]["QTY"] = lQty < 0?0.0:lQty;
        item[0]["RETURN_QTY"] = lReturnQty< 0?0.0:lReturnQty;
        item[0]["NQTY"] = nQty< 0?0.0:nQty;
        item[0]["EQTY"] = eQty< 0?0.0:eQty;
        item[0]["RQTY"] = rQty< 0?0.0:rQty;
      }
    }
    lstrSalesList.removeWhere((element) => g.mfnDbl(element["QTY"])+g.mfnDbl(element["RETURN_QTY"]) <= 0);
    dprint("lstrSalessssssssList>>>>>>>>>>>>>>>>>>>>>>>> ${lstrSalesList.value}");
    fnPaymntCalc();

  }

  //**************************************************API

  apiViewSales(docno, mode) {
    futureform = ApiCall().apiViewSales(docno, mode,frDocType.value);
    futureform.then((value) => apiViewSalesRes(value));
  }
  apiViewSalesRes(value) {
    if (g.fnValCheck(value)) {
      fnClear();
      fnFill(value);
    }
  }

  apiSaveSales(tableinvoice,tableinvoice_details,context){
    dprint("save deliiiiiii");
    futureform = ApiCall().saveSales(wstrPageMode.value,tableinvoice,tableinvoice_details);
    futureform.then((value) => apiSaveSalesRes(value,context));
  }
  apiSaveSalesRes(value,context){

    if(g.fnValCheck(value)){
      dprint("VVVVVVVVVVVVVVVV  4{}${value}");
      var sts  =  value[0]["STATUS"];
      var msg  =  value[0]["MSG"]??"";
      if(sts == "1"){
        frDocno.value = value[0]["CODE"];
        var doctype = value[0]["DOCTYPE"];
        wstrPageMode.value ="VIEW";
        apiViewSales(frDocno.value, "LAST");
        successMsg(context, msg);

      }else{
        errorMsg(context, msg);
      }
    }
  }



  // saveSales


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

    var columnList = 'STKCODE|STKDESCP|PRODUCT_TYPE|PRICE1|PRICE2|CYL_SELL_RATE|MATERIAL_CODE|CATWEIGHT|CYLINDER_YN|CYL_SELL_RATE|SALEUNIT|UNIT|VAT_PERC|PRODUCT_TYPE|';
    futureform = ApiCall().LookupSearch('(SELECT A.*,B.VAT AS VAT_PERC FROM STOCKMASTER A LEFT JOIN TAX_INV_ACCOUNT B ON  (A.TAXACGROUP =  B.CODE)) AS TABLE1', columnList, 0, 100, lstrFilter);
    futureform.then((value) => apiProductTypeDetailsRes(value));
  }
  apiProductTypeDetailsRes(value) {
    if (g.fnValCheck(value)) {
      dprint("Producttypeppp43243ppppp  ${value}");
      lstrProductItemDetailList.value = value;
      update();
    }
  }
  apiGetStockDetails(doctype){
    futureform = ApiCall().apiGetStockdetails(doctype);
    futureform.then((value) => apiGetStockDetailsRes(value));
  }
  apiGetStockDetailsRes(value){
    if(g.fnValCheck(value)){
      dprint("GetStockDetails>>>>>>>>>>>DETAILS>>>>>>>>>>> ${value}");
      fnfillStockDetails(value);
    }

  }

  apiGetBooking(docno,mode){
    futureform = ApiCall().apiViewBooking(docno,mode);
    futureform.then((value) => apiGetBookingRes(value));
  }
  apiGetBookingRes(value){
    if(g.fnValCheck(value)){
      bookingList.value=[];
      fnClear();
      fnFillBookingDetails(value);
      dprint("<<<<<<<<<<Calll  payment............>>>>>>>>>>");
      fnPaymntCalc();
    }

  }

}