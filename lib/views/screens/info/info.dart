import 'package:beams_gas_cylinder/views/components/common/common.dart';
import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/common/commonButton.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(decoration: boxDecoration(white, 20),
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(Icons.close),
                  )
                ],
              ),
              gapH(),
              tc1('Beams', subColor, 30),
              tc1('CYLINDER',subColor, 40),
              gapHC(40),
              tcn('Registration Details', black, 20),
              gapH(),
              Rowcard('Appcode', 'CYLINDER'),
              const Divider(),
              gapHC(5),
              Rowcard('Version', 'V.1.0.0'),
              const Divider(),
              gapHC(5),
              Rowcard('Registration', '1456523'),
              const Divider(),
              gapHC(5),
              Rowcard('Main Company', '0BMS1235'),
              const Divider(),
              gapHC(5),
              Rowcard('Company', '01 | BEAMS'),
              const Divider(),
              gapHC(5),
              Rowcard('Yearcode','2023'),
              gapHC(5),
              // CommonButton(btnName: "Register", btnColor: buttonGreen,iconYN: false,txtColor: Colors.white,
              //     onTap: (){
              //
              //     }),


            ],
          ),
        ),
      ),
    );
  }
  Widget Rowcard(text1, text2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    tcn(text1, black, 13),
    gapWC(5),
    tc(text2,black,13)
    ],
    );
  }
}
