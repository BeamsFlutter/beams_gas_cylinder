
import 'package:beams_gas_cylinder/views/screens/report/controller/repCustomerBalanceController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import '../../../components/common/common.dart';
import '../../../components/common/commonTextField.dart';
import '../../../styles/colors.dart';






class RepCustomerBalanceScreen extends StatefulWidget {
  const RepCustomerBalanceScreen({Key? key}) : super(key: key);

  @override
  State<RepCustomerBalanceScreen> createState() => _RepCustomerBalanceScreenState();
}

class _RepCustomerBalanceScreenState extends State<RepCustomerBalanceScreen> {
  final RepCustomerBalaneController customerBalaneReportController = Get.put(RepCustomerBalaneController());


  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            customerBalaneReportController.fnBackPage(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: tcn('Customer Balance Report', Colors.white, 20),
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
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Obx(() =>    Container(
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
                           customerBalaneReportController.isExpanded.value=!customerBalaneReportController.isExpanded.value;
                           dprint(customerBalaneReportController.isExpanded.value);
                         },
                         child: Container(
                           decoration: boxDecoration(white, 10),
                           padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                           child:  Icon(customerBalaneReportController.isExpanded.value==true?Icons.arrow_drop_down_sharp:Icons.arrow_drop_up,size: 18,),
                         ),
                       ),
                     ],
                   ),




                   customerBalaneReportController.isExpanded.value==true?  Column(
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
                                           customerBalaneReportController.wSelectFromDate(context);
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
                                                   tcn(setDate(15,customerBalaneReportController.fromDate.value).toString(), Colors.black, 13)
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
                                           customerBalaneReportController.wSelectToDate(context);
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
                                                   tcn(setDate(15,customerBalaneReportController.toDate.value).toString(), Colors.black, 13)
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
              tc('Party Details', black, 13.0),
              gapHC(10),
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
              tc('Last Transactions', black, 13),
              gapHC(5),
              Container(decoration: boxDecoration(white, 5),
                padding: EdgeInsets.all(10),
                child:
                Column(
                  children:
                  wFilledItemLIst(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //===================================WIDGET
  wFilledItemLIst() {
    dprint("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrc      +"+customerBalaneReportController.breportlist.toString());
    List<Widget> rtnList = [] ;
    for (var e in customerBalaneReportController.breportlist) {
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
