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
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('Appcode:', black, 15),
                  gapWC(5),
                  tcn('Cylinder',black,15)
                ],
              ),
              const Divider(),
              gapHC(5),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('Version:', black, 15),
                  gapWC(5),
                  tcn('version 1.0.0',black,15)
                ],
              ),
              const Divider(),
              gapHC(5),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('Registration:', black, 15),
                  gapWC(5),
                  tcn('reg',black,15)
                ],
              ),
              const Divider(),
              gapHC(5),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('MainCompany:', black, 15),
                  gapWC(5),
                  tcn('maincompany',black,15)
                ],
              ),
              const Divider(),
              gapHC(5),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('Company:', black, 15),
                  gapWC(5),
                  tcn('BEAMS',black,15)
                ],
              ),
              const Divider(),
              gapHC(5),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tcn('Yearcode:', black, 15),
                  gapWC(5),
                  tcn('2023',black,15)
                ],
              ),
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
}
