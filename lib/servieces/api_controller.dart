import 'dart:convert';

import 'package:beams_gas_cylinder/global/globalValues.dart';
import 'package:beams_gas_cylinder/servieces/api_manager.dart';
import 'package:beams_gas_cylinder/servieces/api_params.dart';
import 'package:beams_gas_cylinder/servieces/app_exception.dart';
import 'package:beams_gas_cylinder/servieces/base_controller.dart';
import 'package:get/get.dart';

import '../views/components/common/common.dart';


class ApiCall  with BaseController{

  var g =Global();
  //============================================GLOBAL CHECK

  Future<dynamic> gapiCheckRegister(deviceId) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DEVICE_ID':deviceId,
      'APP_ID':"CYL",
    });
    dprint('api/check_device_reg');
    dprint(request);
    var response = await ApiManager().postGlobal('api/check_device_reg',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });

    if (response == null) return;


    return response;

  }
  Future<dynamic> gapiDeviceRegister(deviceId,appid,deviceName,mainCompany) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DEVICE_ID':deviceId,
      'APP_ID':appid,
      'MAIN_COMPANY':mainCompany,
      'DEVICE_NAME':deviceName,
    });
    dprint('api/device_reg');
    dprint(request);
    var response = await ApiManager().postGlobal('api/device_reg',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  //============================================LOGIN
  Future<dynamic> apiLogin(usercd,password) async{
    var request = jsonEncode(<dynamic, dynamic>{
      'USER_NAME':usercd,
      'USER_PWD':password,
      // 'DEVICE_ID':password,
    });
    dprint('api/userlogin');
    dprint(request);
    var response = await ApiManager().post('api/userlogin',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint("response,,,,,,,");
    dprint(response);
    if (response == null) return;

    return response;

  }


  //============================================LOOKUP
  Future<dynamic> LookupSearch(lstrTable,lstrColumn,lstrPage,lstrPageSize,lstrFilter) async {
    var request = jsonEncode(<dynamic, dynamic>{
      "lstrTable" : lstrTable,
      "lstrSearchColumn" :lstrColumn,
      "lstrPage" : lstrPage,
      "lstrLimit": lstrPageSize,
      "lstrFilter" : lstrFilter,
    });
    dprint('api/lookupSearch');
    dprint(request);
    var response = await ApiManager().post('api/lookupSearch',request).catchError((error){
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        //Fluttertoast.showToast(msg: apiError["reason"].toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    dprint(response);
    return response;

  }
  Future<dynamic> LookupValidate(lstrTable,lstrFilter) async {

    var request = jsonEncode(<dynamic, dynamic>{
      "lstrTable" : lstrTable,
      "lstrFilter" : lstrFilter
    });
    dprint('api/lookupValidate');
    dprint(request);
    var response = await ApiManager().post('api/lookupValidate',request).catchError((error){
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        //Fluttertoast.showToast(msg: apiError["reason"].toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    dprint(response);
    return response;

  }
  Future<dynamic> apiLookupValidate(lstrTable,key,value) async {
    var lstrFilter =[{'Column': key, 'Operator': '=', 'Value': value, 'JoinType': 'AND'}];
    var request = jsonEncode(<dynamic, dynamic>{
      "lstrTable" : lstrTable,
      "lstrFilter" : lstrFilter
    });
    dprint('api/lookupValidate');
    dprint(request);
    var response = await ApiManager().post('api/lookupValidate',request).catchError((error){
      if (error is BadRequestException) {
        // var apiError = json.decode(error.message!);
        //Fluttertoast.showToast(msg: apiError["reason"].toString());
      } else {
        handleError(error);
      }
    });
    if (response == null) return;
    return response;

  }


//============================================BOOKING CUSTOMER
  Future<dynamic> addBuilding(code,name) async{
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":g.wstrCompany,
      "BUILDING_CODE":code,
      "DESCP":name
    });
    dprint('api/saveBuildingMast');
    dprint(request);
    var response = await ApiManager().post('api/saveBuildingMast',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint("response,,,,,,,");
    dprint(response);
    if (response == null) return;

    return response;

  }
  Future<dynamic> addAppartmnt(aprtmntcode,buildingcode) async{
    dprint("cooooodeeeeeeeeeeeeeeee  ${buildingcode}");
    dprint("naaaaaaaaaaaaaaaaaame  ${aprtmntcode}");
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":g.wstrCompany,
      "BUILDING_CODE":buildingcode,
      "APARTMENT_CODE":aprtmntcode
    });
    dprint('api/saveApartmentMast');
    dprint(request);
    var response = await ApiManager().post('api/saveApartmentMast',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint("response,,,,,,,");
    dprint(response);
    if (response == null) return;

    return response;

  }

//============================================   BOOKING
  Future saveBooking(mode,header,det,assignmnt,assignmnt_details)async{

    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode,
      ApiParams.header:header,
      ApiParams.det:det,
      ApiParams.assignment:assignmnt,
      ApiParams.assignmentdetails:assignmnt_details,
    });
    dprint('api/SaveBooking');
     dprint(request);
    var response = await ApiManager().post('api/SaveBooking',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint("response,,,,,,,");
    dprint(response);
    if (response == null) return;

    return response;


  }
  Future<dynamic> apiViewBooking(docno,mode) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docno,
       ApiParams.company:g.wstrCompany,
       ApiParams.yearcode:g.wstrYearcode,
      'MODE':mode,

    });
    dprint('api/GetBooking');
     dprint(request);
    var response = await ApiManager().post('api/GetBooking',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }
  Future<dynamic> apiGetStockdetails(doctype) async{
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":g.wstrCompany,
      "DOCTYPE":doctype

    });
    dprint('api/getPrvDoc');
     dprint(request);
    var response = await ApiManager().post('api/getPrvDoc',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }

  //============================================  ASSIGNMENT
  Future<dynamic> apiViewAssignment(docno,mode,docType) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docno,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'DOCTYPE':docType,
      'MODE':mode,

    });
    dprint('api/GetAssignment');
    dprint(request);
    var response = await ApiManager().post('api/GetAssignment',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }
  Future saveAssignment(mode,tableassignmnt,tableassignmntDetails)async{

    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode=="EDIT"?"REASSIGN":"ADD",
      "TABLE_ASSIGNMENT":tableassignmnt,
      "TABLE_ASSIGNMENTDET":tableassignmntDetails,

    });
    dprint('api/SaveAssignment');
     dprint(request);
    var response = await ApiManager().post('api/SaveAssignment',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint("response,,,,,,,");
    dprint(response);
    if (response == null) return;

    return response;


  }
  Future<dynamic> apiGetAssignment() async{

    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.company:g.wstrCompany,
      "SMAN":g.wstrSman


    });
    dprint('api/GetAssignmentList');
    dprint(request);
    var response = await ApiManager().post('api/GetAssignmentList',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }

  //============================================  DELIVERY ORDER
  Future saveDeliveryOrder(mode,tableDoDet,tableDo)async{


    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode,
      "MACHINENAME":g.wstrDeivceId,
       "USERCODE":g.wstrUserCD,
      "TABLE_DO":tableDo,
      "TABLE_DODET":tableDoDet,
    });
    dprint('api/SaveDeliveryOrder');
     dprint(request);
    var response = await ApiManager().post('api/SaveDeliveryOrder',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;


  }
  Future<dynamic> apiViewDeliveryOrder(docno,mode,docType) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docno,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'DOCTYPE':docType,
      'MODE':mode,

    });
    dprint('api/GetDeliveryOrder');
    dprint(request);
    var response = await ApiManager().post('api/GetDeliveryOrder',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  //============================================  CONTRACT
  Future saveContract(mode,tableContractDet,tableContract)async{


    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode,
      "TABLE_CONTRACT":tableContract,
      "TABLE_CONTRACTDET":tableContractDet,
    });
    dprint('api/SaveContract');
    dprint(request);
    var response = await ApiManager().post('api/SaveContract',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;


  }
  Future<dynamic> apiViewContract(contarctNo,mode,docType) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'CONTRACT_NO':contarctNo,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'DOCTYPE':docType,
      'MODE':mode,

    });
    dprint('api/GetContract');
    dprint(request);
    var response = await ApiManager().post('api/GetContract',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }
  Future<dynamic> apiViewContractItem(contarctNo,docType) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'CONTRACT_NO':contarctNo,
      ApiParams.company:g.wstrCompany,
      'DOCTYPE':docType,


    });
    dprint('api/GetContractItems');
    dprint(request);
    var response = await ApiManager().post('api/GetContractItems',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }
  //============================================  COLLECTION

  Future<dynamic> apiGetInvoiceBalnce(contarctNo) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'CONTRACT_NO':contarctNo,
      ApiParams.company:g.wstrCompany,


    });
    dprint('api/GetInvoiceBalance');
    dprint(request);
    var response = await ApiManager().post('api/GetInvoiceBalance',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }
  Future saveCollection(mode,tableContractRec)async{


    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode,
      "TABLE_CONTRACTREC":tableContractRec,
    });
    dprint('api/SaveContractRec');
    dprint(request);
    var response = await ApiManager().post('api/SaveContractRec',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;


  }
  Future<dynamic> apiViewCollection(docNumber,mode,docType) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docNumber,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'DOCTYPE':docType,
      'MODE':mode,

    });
    dprint('api/GetInvRec');
    dprint(request);
    var response = await ApiManager().post('api/GetInvRec',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }

  //============================================  CUSTOMER DETAILS
  Future<dynamic> apiViewCustomerDetails(slcode) async{

    var request = jsonEncode(<dynamic, dynamic>{

      ApiParams.company:g.wstrCompany,
      "SLCODE":slcode


    });
    dprint('api/getCustomerDetails');
    dprint(request);
    var response = await ApiManager().post('api/getCustomerDetails',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  //============================================  CONTRACT Recipt
  Future saveContractRecipt(mode,tableContractRec)async{


    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode,
      "TABLE_CONTRACTREC":tableContractRec,
    });
    dprint('api/SaveContractRec');
    dprint(request);
    var response = await ApiManager().post('api/SaveContractRec',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;


  }
  Future<dynamic> apiViewContractRecipt(docNo,mode,docType) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docNo,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'DOCTYPE':docType,
      'MODE':mode,

    });
    dprint('api/GetContractRec');
    dprint(request);
    var response = await ApiManager().post('api/GetContractRec',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }
 //==============================================  Contract Balance
  Future<dynamic> apiViewContractBalance(contractNo) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'CONTRACT_NO':contractNo,
      ApiParams.company:g.wstrCompany,


    });
    dprint('api/GetContractBalance');
    dprint(request);
    var response = await ApiManager().post('api/GetContractBalance',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }


  //============================================  SALE
  Future<dynamic> apiViewSales(docno,mode,doctype) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docno,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'MODE':mode,
      "DOCTYPE":doctype

    });
    dprint('api/GetInvoice');
     dprint(request);
    var response = await ApiManager().post('api/GetInvoice',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }
  Future saveSales(mode,tableinvoice,tableinvoice_details)async{

    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode,
      "MACHINENAME":g.wstrDeivceId,
      "USERCODE":g.wstrUserCD,
      "TABLE_INV":tableinvoice,
      "TABLE_INVDET":tableinvoice_details,
    });
    dprint('api/SaveInvoice');
     dprint(request);
    var response = await ApiManager().post('api/SaveInvoice',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint("response,,,,,,,");
    dprint(response);
    if (response == null) return;

    return response;


  }

  //============================================  SALES ORDER
  Future saveSalesOrder(mode,header,details,invAdditional,doctype)async{
    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode,
      "DETAILS_TABLE":details,
      "HEADER_TABLE":header,
      "INV_ADDITIONAL":invAdditional,
      "DOCTYPE": doctype,
    });
    dprint('api/saveVoucher');
    dprint(request);
    var response = await ApiManager().post('api/saveVoucher',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;


  }
  Future<dynamic> apiViewSalesOrder(docno,mode,doctype) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docno,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'DOCTYPE':doctype,
      'MODE':mode,

    });
    dprint('api/GetSalesOrder');
    dprint(request);
    var response = await ApiManager().post('api/GetSalesOrder',request).catchError((error){
      if (error is BadRequestException) {
      } else {
        handleError(error);
      }
    });
    dprint(response);
    if (response == null) return;

    return response;

  }



}