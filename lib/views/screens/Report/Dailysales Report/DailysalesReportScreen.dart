
import 'package:beams_gas_cylinder/views/screens/Report/Dailysales%20Report/DailySalesReportController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../components/common/common.dart';
import '../../../components/common/commonTextField.dart';
import '../../../styles/colors.dart';

class DailySalesReportScreen extends StatefulWidget {
  const DailySalesReportScreen({Key? key}) : super(key: key);

  @override
  State<DailySalesReportScreen> createState() => _DailySalesReportScreenState();
}

class _DailySalesReportScreenState extends State<DailySalesReportScreen> {
  final DailySalesReportController dailySalesReportController=Get.put(DailySalesReportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: black),
        ),
        flexibleSpace: Container(
          decoration: boxDecoration(bgColor, 0),
        ),
        title: tcn('Daily Sales Report', black, 20),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.share,
              color: black, size: 25,),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(decoration: boxDecoration(white, 8),
              padding: const EdgeInsets.all(18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(decoration: boxDecoration(white, 20),
                        padding: const EdgeInsets.all(5),
                        child: tcn('Today', black, 12),
                      ),
                      gapWC(10),
                      Container(
                        decoration: boxDecoration(white, 20),
                        padding: const EdgeInsets.all(5),
                        child: tcn('Yesterday', black, 12),
                      ),
                      gapWC(10),
                      Container(
                        decoration: boxDecoration(white, 20),
                        padding: const EdgeInsets.all(5),
                        child: tcn('ThisMonth', black, 12),
                      ),
                      gapWC(10),
                      Container(decoration: boxDecoration(white, 10),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(Icons.arrow_drop_down_sharp,size: 18,),
                      ),
                    ],
                  ),
                  gapHC(3),
                  const Divider(),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tc('Date From', black, 12),
                          gapHC(3),
                          Bounce(
                            duration: const Duration(milliseconds: 110),
                            onPressed: () {
                              dailySalesReportController.wSelectDate(context);
                              gapHC(5);
                            },
                            child:  CommonTextField(
                              obscureY: false,
                              textStyle: const TextStyle(color: txtColor),
                              txtController: dailySalesReportController.txtFromdate,
                              prefixIcon: Icons.calendar_month,
                              prefixIconColor: black,
                              suffixIcon: Icons.search,
                              enableY: false,
                            ),
                          ),
                        ],
                      ),),
                      gapWC(10),
                      Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tc('Date To', black, 12),
                          gapHC(3),
                          Bounce(
                            duration: const Duration(milliseconds: 110),
                            onPressed: () {
                              dailySalesReportController.wSelectDateto(context);
                              gapHC(5);
                            },
                            child:  CommonTextField(
                              obscureY: false,
                              textStyle: const TextStyle(color: txtColor),
                              txtController: dailySalesReportController.txtTodate,
                              prefixIcon: Icons.calendar_month,
                              prefixIconColor: black,
                              suffixIcon: Icons.search,
                              enableY: false,
                            ),
                          ),
                        ],
                      ),)
                    ],
                  ),
                  gapHC(10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc('Driver', black, 12),
                            gapHC(3),
                            Container(decoration: boxBaseDecoration(greyLight, 20),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline_rounded,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      gapWC(5),
                                      tcn("SHAJAHAN", Colors.black, 13)
                                    ],
                                  ),
                                  gapWC(5),

                                  const Icon(Icons.search,size: 18,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      gapWC(10),
                      Flexible(
                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc('Vehicle', black, 12),
                            gapHC(3),
                            Container(decoration: boxBaseDecoration(greyLight, 20),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.drive_eta,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      gapWC(5),
                                      tcn("AGF34567", Colors.black, 13)
                                    ],
                                  ),
                                  gapWC(5),

                                  const Icon(Icons.search,size: 18,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  gapHC(10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc('Area', black, 12),
                            gapHC(3),
                            Container(decoration: boxBaseDecoration(greyLight, 20),
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
                          ],
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
            gapHC(15),
            Expanded(child: SingleChildScrollView(
              child: Container(decoration: boxOutlineCustom(white, 5, white),
                padding: const EdgeInsets.all(18),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                    gapH(),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tc('Total Sold Quantity', black, 15),
                        tc('60', black, 15)
                      ],
                    )
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
          tcn(text1, black, 10),
          tc(text2, black, 10)
        ]
    );
  }
}
