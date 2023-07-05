import 'dart:convert';

import 'package:beams_gas_cylinder/views/components/common/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../components/common/common.dart';
import '../../../styles/colors.dart';
import '../controller/hmPreviousSaleController.dart';

class PreviousSales extends StatefulWidget {
  const PreviousSales({super.key});

  @override
  State<PreviousSales> createState() => _PreviousSalesState();
}

class _PreviousSalesState extends State<PreviousSales> {
  final HmPreviousSalesController hmPreviousSalesController = Get.put(HmPreviousSalesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(10),
        child:Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tc("DocType", txtColor, 12),
                    gapHC(3),
                    Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: () {
                        hmPreviousSalesController.fnLookup("Gcylinder_inv");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(30)
                        ),

                        child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.tag,
                                  color: black,
                                  weight: 100,
                                  size: 15,
                                ),
                                tc(hmPreviousSalesController.frDocType.value, txtColor, 12)
                              ],
                            ),
                            gapWC(5),
                            const Icon(Icons.search,size: 14,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(     crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    tc("DocNo", txtColor, 12),
                    gapHC(3),
                    Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: () {
                        hmPreviousSalesController.fnLookup("Gcylinder_inv");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(30)
                        ),

                        child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.tag,
                                  color: black,
                                  weight: 100,
                                  size: 15,
                                ),
                                tc(hmPreviousSalesController.frDocno.value, txtColor, 12)
                              ],
                            ),
                            gapWC(5),
                            const Icon(Icons.search,size: 14,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            gapHC(10),
            CommonButton(btnName: "Genereate",txtColor: white,btnColor: primaryColor, onTap: (){

            }),
            gapHC(10),
            Container(
              decoration: boxBaseDecoration(subColor, 5),
              //padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Container(
                      width: 18,height: 19,

                      child: Checkbox(
                          //
                          // side: MaterialStateBorderSide.resolveWith(
                          //       (states) => BorderSide(width: 2.0,),
                          // ),
                          activeColor: primaryColor,focusColor: primaryColor,
                          value: hmPreviousSalesController.checkAll.value,
                          onChanged: (value){
                            hmPreviousSalesController.checkAll.value=value!;
                            hmPreviousSalesController.fncheckAllItem();

                          }
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: tcn('Item', Colors.white, 10),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: tcn('Qty', Colors.white, 10),
                  ),

                ],
              ),
            ),

            GetBuilder<HmPreviousSalesController>(builder: (controller){
              return  Column(
                children: wFilledItemLIst(controller)
              );
            }

            ),



          ],
        ),)
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Bounce(
                onPressed: () {

                  // hmSalescontroller.fnSave(context);
                },
                duration: const Duration(milliseconds: 110),
                child: Container(
                  decoration: boxDecoration(primaryColor, 30),
                  padding:
                  const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.task_alt,
                        color: Colors.white,
                        size: 15,
                      ),
                      gapWC(5),
                      tcn('Done', Colors.white, 15)
                    ],
                  ),
                ),
              ),
            ),
            Bounce(
              onPressed: () {
                Get.back();
                // hmSalescontroller.fnCancel();
              },
              duration: const Duration(milliseconds: 110),
              child: Container(
                decoration: boxBaseDecoration(baseLight, 30),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cancel_outlined,
                      color: Colors.black,
                      size: 15,
                    ),
                    gapWC(5),
                    tcn('Cancel', Colors.black, 12)
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }


  List<Widget> wFilledItemLIst(controller) {
    var itemList = controller.itemList.value;
    List<Widget> rtnList = [] ;
    for (var e in itemList) {


      var itemName = (e["STKDESCR"] ?? "").toString();
      var itemCode = (e["STKCODE"] ?? "").toString();
      var qty = controller.g.mfnDbl(e["QTY"].toString());
      bool? check = e["isCheck"] as bool?;
      rtnList.add(Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child:    Container(
          decoration: boxBaseDecoration(
              subColor.withOpacity(0.1), 5),
          padding: EdgeInsets.only(right: 10),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      activeColor: primaryColor,
                      value: check,
                      onChanged: (value){
                        if(e["isCheck"]==false){
                          hmPreviousSalesController.checkAll.value=false;
                        }

                        controller.fnCheckItems(itemCode,value,check);
                      }
                  ),
                  tc(itemName, txtColor, 12)

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bounce(
                    onPressed: () {
                      controller.fnChngeQty(itemCode, "A",);
                    },
                    duration: const Duration(
                        milliseconds: 110),
                    child: Container(
                        height: 20,
                        width:20,
                        decoration:boxDecoration(primaryColor, 10),
                        child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ))),
                  ),
                  gapWC(5),
                  tcn(qty.toString(), Colors.black, 10),
                  gapWC(5),
                  Bounce(
                    onPressed: () {
                      controller.fnChngeQty(itemCode, "D",);
                    },
                    duration: const Duration(
                        milliseconds: 110),
                    child: Container(
                        height: 20,
                        width:20,
                        decoration:boxDecoration(primaryColor, 10),
                        child: const Center(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 16,
                            ))),
                  )

                ],

              )

            ],
          ),
        ),
      ));


    }
    return rtnList;
  }
}
