

import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';


class Global {

  static final Global _instance = Global._internal();

  // passes the instantiation to the _instance object
  factory Global() => _instance;

  //initialize variables in here
  Global._internal() {
    _wstrToken = '';
    _wstrIp = '';
    _wstrBaseUrl = "";
    _wstrVersionName = '';
    _wstrDeviceName ='';
    _wstrDeivceId ='';
    _wstrDeviceIP ='';
    _wstrCompany = "";
    _wstrYearcode = "";
    _wstrMainCompany = "";
    _wstrBuildingCode="";
    _wstrBuildingName="";

   _wstrLoginDate = "";
    _wstrUserCD = "";
     _wstrUsername = "";
    _wstrempcode="";

    _wstrVehicleNumber="";
    _wstrDrviverCode="";
    _wstrSman="";

  }
  var _wstrToken  = '';
  var _wstrIp = '';
  var _wstrBaseUrl = "";
  var _wstrVersionName = '';
  var _wstrDeviceName ='';
  var _wstrDeivceId ='';
  var _wstrDeviceIP ='';
  var _wstrCompany = "";
  var _wstrYearcode = "";
  var _wstrAppID = "";
  var  _wstrMainCompany = "";
  var  _wstrBuildingCode = "";
  var  _wstrBuildingName = "";
  var  _wstrApartmentCode = "";
  var  _wstrApartmentName = "";
  var  _wstrLoginDate = "";
  var  _wstrUserCD = "";
  var  _wstrUsername = "";
  var  _wstrempcode = "";
  var  _wstrCylinderContractYN = "";
  var  _wstrVehicleNumber="";
  var  _wstrDrviverCode="";
  var  _wstrSman="";


  get wstrBaseUrl => _wstrBaseUrl;
  set wstrBaseUrl(value) {
    _wstrBaseUrl = value;
  }


  get wstrLoginDate => _wstrLoginDate;
  set wstrLoginDate(value) {
    _wstrLoginDate = value;
  }
  get wstrUserCD => _wstrUserCD;
  set wstrUserCD(value) {
    _wstrUserCD = value;
  }
  get wstrUsername => _wstrUsername;
  set wstrUsername(value) {
    _wstrUsername = value;
  }
  get wstrempcode => _wstrempcode;
  set wstrempcode(value) {
    _wstrempcode = value;
  }

  get wstrBuildingName => _wstrBuildingName;
  set wstrBuildingName(value) {
    _wstrBuildingName = value;
  }

  get wstrBuildingCode => _wstrBuildingCode;
  set wstrBuildingCode(value) {
    _wstrBuildingCode = value;
  }
  get wstrApartmentName => _wstrApartmentName;
  set wstrApartmentName(value) {
    _wstrApartmentName = value;
  }

  get wstrApartmentCode => _wstrApartmentCode;
  set wstrApartmentCode(value) {
    _wstrApartmentCode = value;
  }

  get wstrIp => _wstrIp;
  set wstrIp(value) {
    _wstrIp = value;
  }

  get wstrToken => _wstrToken;
  set wstrToken(value) {
    _wstrToken = value;
  }

  get wstrVersionName => _wstrVersionName;
  set wstrVersionName(value) {
    _wstrVersionName = value;
  }

  get wstrDeviceName => _wstrDeviceName;
  set wstrDeviceName(value) {
    _wstrDeviceName = value;
  }

  get wstrDeivceId => _wstrDeivceId;
  set wstrDeivceId(value) {
    _wstrDeivceId = value;
  }

  get wstrDeviceIP => _wstrDeviceIP;
  set wstrDeviceIP(value) {
    _wstrDeviceIP = value;
  }

  get wstrAppID => _wstrAppID;
  set wstrAppID(value) {
    _wstrAppID = value;
  }

  get wstrCompany => _wstrCompany;
  set wstrCompany(value) {
    _wstrCompany = value;
  }

  get wstrMainCompany => _wstrMainCompany;
  set wstrMainCompany(value) {
    _wstrMainCompany = value;
  }

  get wstrYearcode => _wstrYearcode;
  set wstrYearcode(value) {
    _wstrYearcode = value;
  }
  get wstrCylinderContractYN => _wstrCylinderContractYN;
  set wstrCylinderContractYN(value) {
    _wstrCylinderContractYN = value;
  }



  get wstrVehicleNumber => _wstrVehicleNumber;
  set wstrVehicleNumber(value) {
    _wstrVehicleNumber = value;
  }

  get wstrDrviverCode => _wstrDrviverCode;
  set wstrDrviverCode(value) {
    _wstrDrviverCode = value;
  }
  get wstrSman => _wstrSman;
  set wstrSman(value) {
    _wstrSman = value;
  }

  bool fnValCheck(value){
    if(value == null){
      return false;
    }else{
      if(value.length > 0){
        return true;
      }else{
        return false;
      }
    }
  }
  mfnDbl(dbl){
    var lstrDbl = 0.0;

    try {
      lstrDbl =  double.parse((dbl??'0.0').toString());
    }
    catch(e){
      lstrDbl= 0.00;
    }
    return lstrDbl;
  }
  mfnInt(dbl){
    var lstrInt = 0;
    try {
      lstrInt =  int.parse((dbl??'0.0').toString());
    }
    catch(e){
      lstrInt= 0;
    }
    return lstrInt;
  }
  mfnJson(arr){
    var tempArray;
    try{
      if(fnValCheck(arr)){
        String tempString = jsonEncode(arr);
        tempArray  =  jsonDecode(tempString);
      }
    }catch(e){
      tempArray = [];
    }
    return tempArray;
  }
  mfnDbltoInt(dbl){

    var lstrInt = 0;
    try {
      lstrInt =  double.parse((dbl??'0.0').toString()).toInt();
    }
    catch(e){
      lstrInt= 0;
    }
    return lstrInt;
  }

}