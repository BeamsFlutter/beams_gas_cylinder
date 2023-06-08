

import 'package:beams_gas_cylinder/views/screens/splashscreen/controller/splash_controller.dart';
import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/common/common.dart';
import '../../components/common/commonButton.dart';


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
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 tc('Beams', Colors.white, 55),
                 tc('Cylinder',Colors.white, 70),

               ],
           ),
            ),
            CommonButton(btnName: "Start", btnColor: white,iconYN: false,txtColor: Colors.grey.shade700,
                onTap: (){

              dprint("strt>>>>>>>>>>");
            }),
            gapHC(15),
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
        ),
      ),
    );
  }

}
