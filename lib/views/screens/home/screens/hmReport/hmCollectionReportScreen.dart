
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../components/common/common.dart';
import '../../../../components/common/commonTextField.dart';
import '../../../../styles/colors.dart';
import '../../controller/hmReportController/hmCollectionReportController.dart';

class HmeCollectionReportScreen extends StatefulWidget {
   HmeCollectionReportScreen({Key? key}) : super(key: key);

  @override
  State<HmeCollectionReportScreen> createState() => _HmeCollectionReportScreenState();

}

class _HmeCollectionReportScreenState extends State<HmeCollectionReportScreen> {
  final HmCollectionReportController collectionReportController= Get.put(HmCollectionReportController());
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            collectionReportController.fnBackPage(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: tcn('Collection Report', Colors.white, 20),
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
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Obx(() =>     Container(
            padding: const EdgeInsets.all(10),
            decoration: boxBaseDecoration(white, 10),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Bounce(

                          duration: const Duration(milliseconds: 110),
                          onPressed: (){

                          },
                          child: Container(
                            decoration: boxDecoration(white, 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: tcn('Today', black, 12),
                          ),
                        ),
                        gapWC(10),
                        Bounce(
                          duration: const Duration(milliseconds: 110),
                          onPressed: (){

                          },
                          child: Container(
                            decoration: boxDecoration(white, 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: tcn('Yesterday', black, 12),
                          ),
                        ),
                        gapWC(10),
                        Bounce(
                          duration: const Duration(milliseconds: 110),
                          onPressed: (){

                          },
                          child: Container(
                            decoration: boxDecoration(white, 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: tcn('ThisMonth', black, 12),
                          ),
                        ),
                        gapWC(10),

                      ],
                    ),
                    Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: (){
                        collectionReportController.isExpanded.value=!collectionReportController.isExpanded.value;
                        dprint(collectionReportController.isExpanded.value);
                      },
                      child: Container(
                        decoration: boxDecoration(white, 10),
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child:  Icon(collectionReportController.isExpanded.value==true?Icons.arrow_drop_down_sharp:Icons.arrow_drop_up,size: 18,),
                      ),
                    ),
                  ],
                ),




                collectionReportController.isExpanded.value==true?  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Container(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          gapHC(3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    tc("Date From", txtColor, 12),
                                    gapHC(3),
                                    Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        collectionReportController.wSelectFromDate(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                                gapWC(5),
                                                tcn(setDate(15,collectionReportController.fromDate.value).toString(), Colors.black, 13)
                                              ],
                                            ),

                                            const Icon(Icons.search,size: 18,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              gapWC(10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    tc("Date To", txtColor, 12),
                                    gapHC(3),
                                    Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){
                                        collectionReportController.wSelectToDate(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                                gapWC(5),
                                                tcn(setDate(15,collectionReportController.toDate.value).toString(), Colors.black, 13)
                                              ],
                                            ),

                                            const Icon(Icons.search,size: 18,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          gapHC(10),


                        ],
                      ),
                    ),
                    Container(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    tc("Driver", txtColor, 12),
                                    gapHC(3),
                                    Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){

                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.account_circle_outlined,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                                gapWC(5),
                                                tcn("SHAJAHAN", Colors.black, 13)
                                              ],
                                            ),

                                            const Icon(Icons.search,size: 18,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              gapWC(10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    tc("Vehicle", txtColor, 12),
                                    gapHC(3),
                                    Bounce(
                                      duration: const Duration(milliseconds: 110),
                                      onPressed: (){},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.drive_eta_outlined,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                                gapWC(5),
                                                tcn("AF64487", Colors.black, 13)
                                              ],
                                            ),

                                            const Icon(Icons.search,size: 18,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          gapHC(10),


                        ],
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tc('Customer', black, 12),
                              gapHC(3),
                              Bounce(

                                duration: const Duration(milliseconds: 110),
                                onPressed: () {  },
                                child: Container(decoration: boxBaseDecoration(greyLight, 20),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                          gapWC(5),
                                          tcn("Customer Code", Colors.black, 13)
                                        ],
                                      ),
                                      gapWC(5),

                                      const Icon(Icons.search,size: 18,)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    )
                  ],
                ):gapHC(0)

              ],
            ),
          ),),
            gapHC(10),
            Expanded(child: SingleChildScrollView(
              child: Container(        decoration: boxDecoration(white, 10),
                  padding: const EdgeInsets.all(10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tc('Collection Details', black, 12),
                      const Divider(),
                      ReportCard('Total Collection Amount','5000 AED'),
                      gapHC(10),
                      ReportCard('Total Quantity', '50'),
                      gapHC(10),
                      ReportCard('Number of Receipts', '25'),
                      gapH(),
                      tc('Payment Mode Wise', black, 12),
                      const Divider(),
                      ReportCard('Cash', '50'),
                      gapHC(10),
                      ReportCard('Card', '30'),
                      gapHC(10),
                      ReportCard('Credit', '20'),

                    ],
                  )
              ),
            ))
          ],
        ),
      ),
    );
  }
  Widget ReportCard(text1,text2){
   return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tcn(text1, black, 12),
        tc(text2, black, 13)
      ]
    );
  }
}
