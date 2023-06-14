
import 'package:beams_gas_cylinder/views/screens/home/controller/hmReportController/hmDailySalesReportController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../components/common/common.dart';
import '../../../../components/common/commonTextField.dart';
import '../../../../styles/colors.dart';

class HmeDailySalesReportScreen extends StatefulWidget {
  const HmeDailySalesReportScreen({Key? key}) : super(key: key);

  @override
  State<HmeDailySalesReportScreen> createState() => _HmeDailySalesReportScreenState();
}

class _HmeDailySalesReportScreenState extends State<HmeDailySalesReportScreen> {
  final HmDailySalesReportController dailySalesReportController=Get.put(HmDailySalesReportController());
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            dailySalesReportController.fnBackPage(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: tcn('Daily Sales Report', Colors.white, 20),
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
        child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                          dailySalesReportController.isExpanded.value=!dailySalesReportController.isExpanded.value;
                          dprint(dailySalesReportController.isExpanded.value);
                        },
                        child: Container(
                          decoration: boxDecoration(white, 10),
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          child:  Icon(dailySalesReportController.isExpanded.value==true?Icons.arrow_drop_down_sharp:Icons.arrow_drop_up,size: 18,),
                        ),
                      ),
                    ],
                  ),




                  dailySalesReportController.isExpanded.value==true?  Column(
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
                                          dailySalesReportController.wSelectFromDate(context);
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
                                                  tcn(setDate(15,dailySalesReportController.fromDate.value).toString(), Colors.black, 13)
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
                                          dailySalesReportController.wSelectToDate(context);
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
                                                  tcn(setDate(15,dailySalesReportController.toDate.value).toString(), Colors.black, 13)
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

                            gapHC(3),
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
                                tc('Area', black, 12),
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
                                              Icons.place,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                            gapWC(5),
                                            tcn("Area Code", Colors.black, 13)
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
            ),
            gapHC(10),
            Expanded(child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: boxDecoration(white, 10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tc('Sales', black, 12),
                      const Divider(),
                      ReportCard('Build Count', '15'),
                      gapHC(10),
                      ReportCard('Total Quantity', '50'),
                      gapHC(10),
                      ReportCard('Sale Amount', '2500 AED'),
                      gapH(),
                      tc('Delivery Order', black, 12),
                      const Divider(),
                      ReportCard('Build Count', '15'),
                      gapHC(10),
                      ReportCard('Total Quantity', '50'),
                      gapH(),
                      tc('Booking', black, 12),
                      const Divider(),
                      ReportCard('Total Booking', '15'),
                      gapH(),
                      tc('Assignment Status', black, 12),
                      const Divider(),
                      ReportCard('Assigned', '50'),
                      gapHC(10),
                      ReportCard('Completed', '30'),
                      gapHC(10),
                      ReportCard('Pending', '20'),
                      gapH(),
                      tc('Collection', black, 12),
                      const Divider(),
                      ReportCard('Collection Amount', '5000 AED'),

                      // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     tc('Total Sold Quantity', black, 15),
                      //     tc('60', black, 15)
                      //   ],
                      // )
                    ],
                  )
              ),
            )),

          ],
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          height: 50,decoration: boxDecoration(primaryColor, 30),
          child:   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc('Total Sold Quantity', white, 15),
              tc('60', white, 15)
            ],
          ) ,
        ),
      ),

    );
  }
  Widget ReportCard(text1,text2){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          tcn(text1,txtColor, 12),
          tc(text2, txtColor, 13)
        ]
    );
  }
}
