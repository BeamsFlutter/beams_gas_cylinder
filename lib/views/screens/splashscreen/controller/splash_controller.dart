import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:platform_device_id/platform_device_id.dart';



import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/alertDialog/alertDialog.dart';
import '../../../components/common/common.dart';
import '../../login/login_screen.dart';


class SplashController extends GetxController{

  //Global
   Global g = Global();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late Future<dynamic> futureGlobal;
  late Future <dynamic> futureform;
  //Page variables
  RxString deviceId = ''.obs;
  RxString deviceName = ''.obs;
  RxString deviceIp = ''.obs;
  RxString deviceMode =''.obs;
  RxString appError = "".obs;

  var appMode  = "A";

  //Controller

  final TextEditingController txtMainCompany = TextEditingController();
  //==================================PPAGE FN

  fnGetPageData(context){
    initPlatformState(context);
    fnDefaultPageSettings();
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() async{
   Get.offAll(()=>LoginScreen());
  }

  //========================================SYSTEM INFO
  Future<void> initPlatformState(context) async {

    var deviceData = <String, dynamic>{};
    try {
      if (kIsWeb) {
        _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);

      } else {
        if (Platform.isAndroid) {
          _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    g.wstrDeviceName = deviceName.value;
    g.wstrDeivceId = deviceId.value;
    g.wstrDeviceIP = deviceIp.value;
    dprint("Device ID ::>>>> ${g.wstrDeivceId}");
    // fnCheckReg(context);
    gapiCheckDevice(context,g.wstrDeivceId);
  }
  _readAndroidBuildData(AndroidDeviceInfo build) {

      deviceMode.value = '';
      deviceId.value = build.id??'';
      deviceName.value =  build.model??'';

  }
  _readIosDeviceInfo(IosDeviceInfo data) {

      deviceMode.value = '';
      deviceId.value = data.name??'';
      deviceName.value =  data.systemName??'';

  }
  _readLinuxDeviceInfo(LinuxDeviceInfo data) {

  }
  _readWebBrowserInfo(WebBrowserInfo data)  {


      deviceMode.value = 'W';
      deviceId.value = describeEnum(data.browserName);
      deviceName.value =  describeEnum(data.browserName);



  }
  _readMacOsDeviceInfo(MacOsDeviceInfo data) {

      deviceMode.value = '';
      deviceId.value = data.systemGUID??'';
      deviceName.value =  data.computerName;

  }
  _readWindowsDeviceInfo(WindowsDeviceInfo data) {

      deviceMode.value = '';
      deviceId.value = data.computerName;
      deviceName.value =  data.computerName;

  }


  fnLoadApp(){
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }
  fnDefaultPageSettings() async{
    g.wstrVersionName = "V 1.0";
    g.wstrAppID = "CYL";


  }


  fnRegisterScreen(context){
    PageDialog().registerDialog(context, Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tcn('APP ID : ${g.wstrAppID}', Colors.black, 12),
          tcn('Device Id : ${g.wstrDeivceId}', Colors.black, 12),
          gapHC(10),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: boxOutlineCustom1(Colors.white, 10, Colors.grey, 0.5),
            child: TextFormField(
              controller: txtMainCompany,
              decoration: const InputDecoration(
                hintText: 'Main Company',
                border: InputBorder.none,
              ),
            ),
          ),
          gapHC(15),
          GestureDetector(
            onTap: (){
              gApiRegister();
            },
            child: Container(
              decoration: boxDecoration(Colors.green, 10),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('Register', Colors.white, 15)
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
  fnRegisterDone(value) async{
        g.wstrMainCompany = (value[0]["MAIN_COMPANY"]??"").toString();
        g.wstrBaseUrl = (value[0]["API_URL"]??"").toString();
        g.wstrCompany = (value[0]["COMPANY"]??"").toString();
        g.wstrYearcode = (value[0]["YEARCODE"]??"").toString();
        g.wstrBaseUrl=(value[0]["API_URL"]??"").toString();
      fnLoadApp();

  }


  //==================================API
  gApiRegister(){
    futureGlobal = ApiCall().gapiDeviceRegister(g.wstrDeivceId.toString(),g.wstrAppID.toString(), g.wstrDeviceName.toString(),txtMainCompany.text);
    futureGlobal.then((value) => gApiRegisterRes(value));
  }
  gApiRegisterRes(value){

      //{MAIN_COMPANY: 0BMS0000000, APP_ID: ESS, API_URL: http://laptop-vi4dgus9:1110/, COMPANY: 01, YEARCODE: 2023, MULTIPLE_COMPANY_YN: N, STATUS: 1, NOTE: TEST}
      if(g.fnValCheck(value)){
        var status =  (value[0]["STATUS"]??"").toString();
        if(status == "1"){
          Get.back();
          fnRegisterDone(value);
        }
      }else{
          appError.value = (value[0]["MESSAGE"]??"").toString();


    }
  }

  gapiCheckDevice(context,deviceId){
    futureGlobal = ApiCall().gapiCheckRegister(deviceId);
    futureGlobal.then((value) => gapiCheckDeviceRes(value,context));
  }

  gapiCheckDeviceRes(value,context){
    //[{STATUS: 0, MESSAGE: DEVICE NOT REGISTERED}]
    dprint("dddddddddd  ${value.toString()}");

      if(g.fnValCheck(value)){
        var sts =  (value[0]["STATUS"]??"").toString();
        var msg =  (value[0]["MESSAGE"]??"").toString();

        if(sts == "1"){
          fnRegisterDone(value);
        }else{
          fnRegisterScreen(context);
        }

      }else{
        fnRegisterScreen(context);
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

}