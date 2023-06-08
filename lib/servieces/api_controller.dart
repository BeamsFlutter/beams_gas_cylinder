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
  Future<dynamic> addAppartmnt(code,aprtmntcode) async{
    dprint("cooooodeeeeeeeeeeeeeeee  ${code}");
    dprint("naaaaaaaaaaaaaaaaaame  ${aprtmntcode}");
    var request = jsonEncode(<dynamic, dynamic>{
      "COMPANY":g.wstrCompany,
      "BUILDING_CODE":code,
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
    // dprint(request);
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
    // dprint(request);
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

  //============================================  ASSIGNMENT
  Future<dynamic> apiViewAssignment(docno,mode) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docno,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'DOCTYPE':"GCA",
      'MODE':mode,

    });
    dprint('api/GetAssignment');
    // dprint(request);
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
      ApiParams.mode:mode,
      "TABLE_ASSIGNMENT":tableassignmnt,
      "TABLE_ASSIGNMENTDET":tableassignmntDetails,

    });
    dprint('api/SaveAssignment');
    // dprint(request);
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
  //============================================  SALE


  Future<dynamic> apiViewSales(docno,mode) async{

    var request = jsonEncode(<dynamic, dynamic>{
      'DOCNO':docno,
      ApiParams.company:g.wstrCompany,
      ApiParams.yearcode:g.wstrYearcode,
      'MODE':mode,
      "DOCTYPE":"CGI"

    });
    dprint('api/GetInvoice');
    // dprint(request);
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

  Future saveSales(mode,usercode,tableinvoice,tableinvoice_details)async{

    var request = jsonEncode(<dynamic, dynamic>{
      ApiParams.mode:mode,
      "MACHINENAME":g.wstrDeivceId,
      "USERCODE":usercode,
      "TABLE_INV":tableinvoice,
      "TABLE_INVDET":tableinvoice_details,
    });
    dprint('api/SaveInvoice');
    // dprint(request);
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


}