import 'package:beams_gas_cylinder/views/components/common/common.dart';
import 'package:beams_gas_cylinder/views/styles/colors.dart';
import 'package:flutter/material.dart';

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
              const Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.close),
                ],
              ),
              gapH(),
              tc1('Beams', primaryColor, 30),
              tc1('CYLINDER',primaryColor, 40),
              gapHC(40),
              tc('Registration Details', black, 20),
              gapH(),
              Rowcard('Appcode', 'Cylinder'),
              const Divider(),
              gapHC(5),
              Rowcard('Version', 'V.1.0.0'),
              const Divider(),
              gapHC(5),
              Rowcard('Registration', 'reg'),
              const Divider(),
              gapHC(5),
              Rowcard('MainCompany', 'maincompany'),
              const Divider(),
              gapHC(5),
              Rowcard('Company', 'Beams'),
              const Divider(),
              gapHC(5),
              Rowcard('Yearcode','2023'),
              gapHC(5),
              CommonButton(btnName: "Register", btnColor: buttonGreen,iconYN: false,txtColor: Colors.white,
                  onTap: (){

                  }),


            ],
          ),
        ),
      ),
    );
  }
  Widget Rowcard(text1, text2) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
    tcn(text1, black, 15),
    gapWC(5),
    tcn(text2,black,15)
    ],
    );
  }
}
