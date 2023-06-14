import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../components/common/common.dart';
import '../../../styles/colors.dart';
import 'hmReport/hmAssignmentReportScreen.dart';
import 'hmReport/hmBookingReportScreen.dart';
import 'hmReport/hmCollectionReportScreen.dart';
import 'hmReport/hmDailysalesReportScreen.dart';
import '../controller/hmReportController.dart';

class HmReport extends StatefulWidget {
  const HmReport({super.key});

  @override
  State<HmReport> createState() => _HmReportState();
}

class _HmReportState extends State<HmReport> {
  final HmReportController hmReportController = Get.put(HmReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            hmReportController.fnBackPage(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: tcn('Reports', Colors.white, 20),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.water_drop_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 11),
          child:Column(
            children: [
              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: wFilledItemLIst(),
                ),
              ))
            ],
          )
      ),
    );
  }
  //===================================WIDGET
  var tapedReport="".obs;
  wFilledItemLIst() {
    dprint("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrc      +"+hmReportController.reportlist.toString());
    List<Widget> rtnList = [] ;
    int i=1;
    for (var e in hmReportController.reportlist) {
      var code =  e ["CODE"];
      var det =   (e["RNAME"]??"");
      rtnList.add(
          Bounce(
            duration: const Duration(milliseconds: 110),
            onPressed: (){
              var report = det;
              moveToScreen(report);

            },

            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(decoration: boxOutlineCustom(white, 30, subColor),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),

                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description_outlined,size: 17),
                          gapWC(5),
                          tcn(det, txtColor, 15),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
                gapHC(10),

              ],
            ),
          )
      );
      i++;
    }
    return rtnList;


  }

  void moveToScreen(String report) {
       dprint("ccccccccccccc... ${report}");
       switch(report){
         case "Daily Sales Reports": {
          Get.to(HmeDailySalesReportScreen());
         }
         break;
         case "Collection Reports": {
           Get.to(HmeCollectionReportScreen());
         }
         break;
         case "Assignemnt Details": {
           Get.to(HmeAssignmentReportScreen());
         }
         break;
         case "Booking Details": {
           Get.to(HmeBookingReportScreen());
         }
         break;

       }

  }
}
