
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../components/common/common.dart';
import '../../styles/colors.dart';
import 'controller/Reportcontroller.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportController reportController=Get.put(ReportController());
  var reportlist  = [

    {
      "CODE":"001",
      "RNAME":"DAILY SALES REPORT",
    },
    {
      "CODE":"002",
      "RNAME":"COLLECTION REPORT",
    },
    {
      "CODE":"003",
      "RNAME":"ASSIGNMENT DETAILS",
    },
    {
      "CODE":"004",
      "RNAME":"BOOKING DETAILS",

    }

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {reportController.fnBackPage(context);},
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: black),
        ),
        flexibleSpace: Container(
          decoration: boxDecoration(bgColor, 0),
        ),
        title: tcn('Reports', black, 20),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 40),
          child:Column(
            children: [
              Expanded(child: SingleChildScrollView(
                child: Container(
                  child:
                  Column(
                    children:
                    wFilledItemLIst(),
                  ),
                ),
              ))
            ],
          )
      ),
    );
  }
  //===================================WIDGET
  wFilledItemLIst() {
    dprint("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrc      +"+reportlist.toString());
    List<Widget> rtnList = [] ;
    for (var e in reportlist) {
      var code =  e ["CODE"];
      var det =   (e["RNAME"]??"");
      rtnList.add(
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(decoration: boxOutlineCustom(white, 30, subColor),
                padding: EdgeInsets.all(20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.description_outlined),
                        tcn(det, txtColor, 18),
                      ],
                    ),
                    IconButton(onPressed: (){
                    }, icon: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
              gapH(),
            ],
          )
      );
    }
    return rtnList;


  }
}
