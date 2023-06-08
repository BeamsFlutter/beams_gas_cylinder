
import 'package:beams_gas_cylinder/views/components/common/commonButton.dart';
import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../components/common/common.dart';
import '../../components/common/commonTextField.dart';
import '../../components/common/textInputField.dart';
import 'loginController/login_controller.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final LoginController loginController = Get.put(LoginController());
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      // appBar: AppBar(elevation: 0,backgroundColor: primaryColor,  automaticallyImplyLeading: false,),
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            heightFactor: 0.45,
            alignment: Alignment.topCenter,
            child: Container(
              decoration: const BoxDecoration(
                  color:primaryColor
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tc1('Beams', Colors.white, 45),
                  tc1('CYLINDER',Colors.white, 50),
                  gapHC(40)

                ],
              ),
            ),
          ),
          Positioned(
             top: 35,right: 5,
              child: IconButton(onPressed: (){}, icon: const Icon(Icons.settings_outlined,color: white,size: 35,))),
          FractionallySizedBox(
            heightFactor: 0.7,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 50,right: 50,bottom: 20),
              decoration:  const BoxDecoration(
                  color:white,
                  borderRadius: BorderRadius.all(Radius.circular(80))
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gapHC(40),
                          tc("User Login", txtColor, 25),

                          gapHC(30),
                          tcn(" Username", txtColor, 14),
                          gapHC(1),
                          CommonTextField(
                            obscureY: false,
                            prefixIcon: Icons.account_circle_outlined,
                            hintText: " Username",
                            prefixIconColor: Colors.grey.shade600,
                            txtSize: 12,
                          ),
                          gapHC(15),
                          tcn(" Password", txtColor, 14),
                          gapHC(1),
                          Obx(() => CommonTextField(
                            obscureY: loginController.passWordView.value,
                            prefixIcon: Icons.lock_outline,
                            hintText: "Password",
                            prefixIconColor: Colors.grey.shade600,
                            txtSize: 12,
                            suffixIcon:loginController.passWordView.value==true? Icons.visibility_outlined:Icons.visibility_off_outlined,
                            suffixIconOnclick: (){
                              dprint( loginController.passWordView.value);
                              loginController.passWordView.value =  loginController.passWordView.value? false:true;
                            },


                          )),
                          gapHC(20),
                          CommonButton(btnName: "Login",iconYN: true,icon:Icons.arrow_forward_rounded,btnColor: primaryColor,txtColor: white,onTap: (){
                            dprint("Login...........");
                          }),
                          gapHC(50),
                          Divider(thickness: 1,color:Colors.grey.shade400,endIndent: 70,indent: 70,),
                          gapHC(5),
                          Center(child: tcn("Registration Details? Click Here", Colors.grey.shade700, 13))

                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        tcn('Powered By', txtColor, 10),
                        tc('BEAMS', txtColor, 13),

                      ],
                    ),
                  ),
                  gapHC(10)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  //====================================
  Widget wCodeInput(String inputValue){
    return Card(
      elevation: 20,
      shadowColor: Colors.grey.shade50,
      color:inputValue==""?Colors.white:primaryColor,
      child:  const SizedBox(
        height: 40,
        width: 40,
      ),
    );
  }


}
