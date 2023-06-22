import 'package:beams_gas_cylinder/views/components/alertDialog/alertDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/common/common.dart';
import '../../../styles/colors.dart';
import '../../bottomNavbar.dart';

class LoginController extends GetxController{
  RxBool passWordView = true.obs;
  late Future <dynamic> futureform;
  RxBool loginsts = true.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //Controller
  var txtUserName  = TextEditingController();
  var fnUserName =  FocusNode();
  var txtPassword  = TextEditingController();
  var fnPassword =  FocusNode();
  var g =Global();
  RxString lstrErrorMsg = "".obs;
  fnLogin(){

    if (formKey.currentState!.validate()) {
      // TODO submit
      apiLogin();
    }



  }
  fnLoginDone(data,mode) async{
    dprint("*******************  ${data}");


    try{
      var now = DateTime.now();
      var lstrLoginDate = setDate(9,now);
      g.wstrToken =  data["TOKEN"];
      g.wstrLoginDate = lstrLoginDate;
      g.wstrUserCD= data["USER_CD"]??"";
      g.wstrUsername= data["USER_NAME"]??"";
      g.wstrempcode= data["EMPCODE"]??"";
      fnClear();
      fnGoHome();

    }catch(e){
      dprint(e);
    }

  }
  fnGoHome(){
    Get.to(BottomnavBar());
  }
  fnClear(){
    txtUserName.clear();
    txtPassword.clear();
    lstrErrorMsg.value ="";
  }



  //*****************************************************API
  apiLogin(){
    dprint("usernameeeee ${txtUserName.text.toString()}");
    dprint("passworddddd ${txtPassword.text.toString()}");
    loginsts.value = false;
    futureform = ApiCall().apiLogin(txtUserName.text.toString().trim(),txtPassword.text.toString().trim());
    futureform.then((value) => apiLoginRes(value,""));
  }
  apiLoginRes(value,mode){


    dprint("Apiiiivaluee......................");
    dprint(value);

    loginsts.value = true;
    if(g.fnValCheck(value)){
      var sts  =  value["STATUS"];
      var msg  =  value["MSG"]??"";
      if(sts == "1"){
        dprint("wqewqeqweqweqwrerrrrrr");
        var data =  value["DATA"];
        if(g.fnValCheck(data)){
          fnLoginDone(data,mode);
        }
      }else{
        lstrErrorMsg.value = "Please try again";
        Get.showSnackbar(
          GetSnackBar(
            title:"Login Failed",
            message: lstrErrorMsg.value,
            icon: const Icon(Icons.refresh,color: white),
            duration: const Duration(seconds: 3),
          ),
        );

      }




    }else{




    }
  }
}