

import 'package:beams_gas_cylinder/views/screens/Report/CustomerbalanceReport/CustomerBalanceReportController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../components/common/common.dart';
import '../../../components/common/commonTextField.dart';
import '../../../styles/colors.dart';

class CustomerBalanceReportScreen extends StatefulWidget {
  const CustomerBalanceReportScreen({Key? key}) : super(key: key);

  @override
  State<CustomerBalanceReportScreen> createState() => _CustomerBalanceReportScreenState();
}

class _CustomerBalanceReportScreenState extends State<CustomerBalanceReportScreen> {
  final CustomerBalaneReportController customerBalaneReportController=Get.put(CustomerBalaneReportController());
  var breportlist  = [

    {
      "CODE":"1",
      "DOCNO":"1234",
      "TNAME":"SALES",
      "DATE":"1-JUN-2023",
      "AMOUNT":"2500"
    },
    {
      "CODE":"2",
      "DOCNO":"1235",
      "TNAME":"COLLECTION",
      "DATE":"2-JUN-2023",
      "AMOUNT":"1500"
    },
    {
      "CODE":"3",
      "DOCNO":"1236",
      "TNAME":"SALES",
      "DATE":"12-JUN-2023",
      "AMOUNT":"2000"
    },
    {
      "CODE":"4",
      "DOCNO":"1237",
      "TNAME":"COLLECTION",
       "DATE":"11-JUN-2023",
      "AMOUNT":"3500"

    }

  ];
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
        title: tcn('Customer Balance Report', black, 20),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.share,
              color: black, size: 25,),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Container(decoration: boxDecoration(white, 8),
            padding: EdgeInsets.all(15),
            child: Column(
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
                      child: tcn('This Month', black, 12),
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
                    Flexible(child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tc('Date From ', black, 12),
                        gapHC(3),
                        Bounce(
                          duration: const Duration(milliseconds: 110),
                          onPressed: () {
                            customerBalaneReportController.wSelectDate(context);
                            gapHC(5);
                          },
                          child:  CommonTextField(
                            obscureY: false,
                            textStyle: const TextStyle(color: txtColor),
                            txtController: customerBalaneReportController.txtFromdate,
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
                            customerBalaneReportController.wSelectDateto(context);
                            gapHC(5);
                          },
                          child:  CommonTextField(
                            obscureY: false,
                            textStyle: const TextStyle(color: txtColor),
                            txtController: customerBalaneReportController.txtTodate,
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
              ],
            ),
          ),gapHC(10),
           tc('Party Details', black, 12),
            gapHC(5),
            Bounce(
              onPressed: () {
                dprint("lookupp");

              },
              duration: const Duration(milliseconds: 110),
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                decoration: boxDecoration(white, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person,size: 18,color: primaryColor),
                                gapWC(5),
                                tcn('SHAJAHAN', txtColor, 13),
                              ],
                            ),
                            gapHC(5),
                            Row(
                              children: [
                                const Icon(Icons.place,size: 18,color: primaryColor),
                                gapWC(5),
                                tcn("ALNAHDA", txtColor, 13),
                              ],
                            ),
                            gapHC(10),


                          ],
                        ),GestureDetector(
                          onTap: (){},
                          child: Container(
                              padding: const EdgeInsets.all(7),
                              child: const Icon(
                                Icons.search, color: txtColor,
                                size: 25,)),
                        ),
                      ],
                    ),
                    Container(decoration: boxBaseDecoration(bgColor, 30),
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          tc('BALANCE', Colors.black, 12),
                          tc('15200 AED',Colors.red,16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            gapHC(10),
            tc('Last Transactions', black, 12),
            gapHC(5),
            Expanded(child: SingleChildScrollView(
              child: Container(decoration: boxDecoration(white, 5),
                padding: EdgeInsets.all(10),
                child:
                Column(
                  children:
                  wFilledItemLIst(),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
  //===================================WIDGET
  wFilledItemLIst() {
    dprint("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrc      +"+breportlist.toString());
    List<Widget> rtnList = [] ;
    for (var e in breportlist) {
      var code =  e ["CODE"];
      var det =   (e["TNAME"]??"");
      var daten=(e["DATE"]);
      var amt = (e["AMOUNT"]);
      var doc = (e["DOCNO"]);
      rtnList.add(
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(decoration: boxOutlineCustom(white, 0, subColor),
                padding: EdgeInsets.all(10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        tc(code, black, 12),
                        gapWC(20),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tc(doc, black, 12),
                            tcn(det, black, 12),
                            tcn(daten, black, 12),
                          ],
                        ),
                      ],
                    ),
                    gapWC(20),
                    tc(amt, black, 12)
                  ],
                ),
              ),

            ],
          )
      );
    }
    return rtnList;


  }
}
