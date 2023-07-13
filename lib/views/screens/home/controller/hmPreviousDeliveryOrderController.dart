import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../components/common/common.dart';
import '../../../components/lookup/lookup.dart';

class HmPreviousDeliveryOrderController extends GetxController{
  RxString frDocno="".obs;
  RxString frDocType="".obs;
  var txtController= TextEditingController();
  var g  = Global();
  RxBool checkAll = false.obs;
  RxBool checkvalue = false.obs;
  RxString selected = "".obs;
  var itemList =[
    {
      "STKCODE":"1",
      "STKDESCR":"LPG 50KG",
      "QTY":3,
      "isCheck":false
    },
    {
      "STKCODE":"2",
      "STKDESCR":"LPG 10KG",
      "QTY":8,
      "isCheck":false

    },
    {
      "STKCODE":"3",
      "STKDESCR":"LPG 60KG",
      "QTY":2,
      "isCheck":false

    },    {
      "STKCODE":"5",
      "STKDESCR":"LPG 20KG",
      "isCheck":false,
      "QTY":4,

    },


  ].obs;
  var lstrProductItemDetailList =[  {
    "STKCODE":"1",
    "STKDESCR":"LPG 50KG",
    "QTY":3,
    "isCheck":false
  },
    {
      "STKCODE":"2",
      "STKDESCR":"LPG 10KG",
      "QTY":8,      "isCheck":false
    },
    {
      "STKCODE":"3",
      "STKDESCR":"LPG 60KG",
      "QTY":2,      "isCheck":false
    },
    {
      "STKCODE":"5",
      "STKDESCR":"LPG 20KG",
      "QTY":4,      "isCheck":false
    },
  ].obs;
  var multipleSelected = [].obs;
  fnChngeQty(itemCode,mode) {

    var itemMenu = lstrProductItemDetailList.value.where((element) => element["STKCODE"] == itemCode).toList();



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
        dprint("Itemi>>>>> ${item}");
        if(item.isNotEmpty){
          item[0]["QTY"] = g.mfnDbltoInt(item[0]["QTY"]) + 1;
        }
      }
    }else{

      var item = itemList.where((element) => element["STKCODE"] == itemCode).toList();
      dprint("ITEM>>>>>>>>>> ${item}");
      if(item.isNotEmpty){
        item[0]["QTY"] = item[0]["QTY"] == 0?0: g.mfnDbltoInt(item[0]["QTY"]) - 1;
      }
    }
    update();

    dprint("ITEM_LIST>>> ${itemList.value}");

  }
  fnCheckItems(itemCode,bool?value,check) {
    var item = itemList.where((element) => element["STKCODE"] == itemCode).toList();

    item[0]["isCheck"] = value!;
    update();
    dprint("Updated___ITEM>>>>>>>>>> ${item}");
    dprint("itemList>>>>>>>>>> ${itemList}");
  }
  fncheckAllItem(){

    for (var e in itemList) {
      if(checkAll.value==true){
        e["isCheck"] =true;
      }else{
        e["isCheck"] =false;
      }

    }
    update();
    dprint(">>> ${checkAll.value}");
    dprint("fncheckAllItem>>>>>>>>>> ${itemList}");
  }




  fnLookup(mode){
    dprint(mode);


    if(mode == "CRDELIVERYMANMASTER") {
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DEL_MAN_CODE', 'Display': 'Code'},
        {'Column': 'NAME', 'Display': 'Name'},
        {'Column': 'VEHICLE_NO', 'Display': 'VEHICLE_NO'},
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
    else if(mode == "GCYLINDER_DO" ){
      final List<Map<String, dynamic>> lookup_Columns = [
        {'Column': 'DOCNO', 'Display': 'DOCNO'},
        {'Column': "DOCTYPE", 'Display': 'DOCTYPE'},
      ];
      final List<Map<String, dynamic>> lookup_Filldata = [
      ];
      var lstrFilter =[];
      Get.to(
          Lookup(
            txtControl: txtController,
            oldValue: "",
            lstrTable: 'GCYLINDER_DO',
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

  void fnFillCustomerData(data, mode) {
    if (g.fnValCheck(data)) {
      if (mode == "GCYLINDER_DO") {
        frDocno.value = data["DOCNO"]??"";
        frDocType.value = data["DOCTYPE"]??"";
       //  apiViewSales(frDocno.value,"");

      }
    }
  }
}