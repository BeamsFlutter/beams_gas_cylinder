
import 'package:flutter/material.dart';

import '../views/components/bottomNavigationBar/bottom_navigator_item.dart';
import '../views/components/common/common.dart';
import '../views/styles/colors.dart';

class HomeIcons extends StatefulWidget {
  const HomeIcons({Key? key}) : super(key: key);

  @override
  State<HomeIcons> createState() => _HomeIconsState();
}

class _HomeIconsState extends State<HomeIcons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(decoration: boxDecoration(Colors.white, 10),
          padding: EdgeInsets.all(20),
          child: Column(//crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Homecard('Booking'),
                  gapWC(30),
                  Homecard('Assignment'),
                ],
              ),
              gapH(),
              Row(
                children: [
                  Homecard('Delivery Order'),
                  gapWC(30),
                  Homecard('Sales'),
                ],
              ),



              gapH(),
              Container(
                height: 60,
                padding: EdgeInsets.all(12),
                decoration: boxDecoration(Colors.blueGrey.shade50, 15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tc('Collection', txtColor, 12),
                    Icon(Icons.wallet),
                  ],
                ),
              ),
              gapH(),
              Container(
                height: 60,
                padding: EdgeInsets.all(12),
                decoration: boxDecoration(Colors.blueGrey.shade50, 15),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tc('Reports', txtColor, 12),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget Homecard(text){
    return Flexible(child: Container(
      height: 100,
      padding: EdgeInsets.all(12),
      decoration: boxDecoration(Colors.blueGrey.shade50, 15),
      alignment: Alignment.bottomLeft,
      child: tc(text, txtColor, 12),
    ),);
  }
}
