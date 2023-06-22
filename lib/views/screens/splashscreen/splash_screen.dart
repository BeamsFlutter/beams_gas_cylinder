

import 'package:beams_gas_cylinder/views/screens/splashscreen/controller/splash_controller.dart';
import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../components/common/common.dart';
import '../../components/common/commonButton.dart';
import '../login/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // splashController.fnGetPageData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(),
                  tc1('Beams', Colors.white, 45),
                  tc1('CYLINDER',Colors.white, 55),
                  //tcn('Management Application',Colors.white, 13),
                ],
              ),
            ),
            splashController.tapedStartBtn.value!=true?  CommonButton(btnName: "Start", btnColor: white,iconSize: 17,iconYN: false,txtColor: Colors.grey.shade700,
                onTap: (){
                  splashController.fnGetPageData(context);
                }):const SpinKitThreeBounce(color:white,size: 20,),

            gapHC(30),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  tcn('Powered By', Colors.white.withOpacity(0.8), 8),
                  tc('BEAMS', Colors.white, 13),
                  tcn("V 1.0" , Colors.white, 10),
                  // tcn(splashController.g.wstrVersionName , Colors.white, 10),
                ],
              ),
            ),

            gapHC(15)





          ],
        )),
      ),
    );
  }

}
