import 'package:beams_gas_cylinder/views/screens/home/screens/previousDeliveryOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../../components/common/common.dart';
import '../../../components/common/commonTextField.dart';
import '../../../components/common/tabButton.dart';
import '../../../styles/colors.dart';
import '../controller/hmDeliveryOrderController.dart';

class HmeDeliveryOrder extends StatefulWidget {
  final String ? bookingNumber;
  const HmeDeliveryOrder({super.key,this.bookingNumber});

  @override
  State<HmeDeliveryOrder> createState() => _HmeDeliveryOrderState();
}

class _HmeDeliveryOrderState extends State<HmeDeliveryOrder> {
  final HmDeliveryOrderController hmDelivryOrderController =   Get.put(HmDeliveryOrderController());
  @override
  void initState() {
    hmDelivryOrderController.pageController = PageController();
    hmDelivryOrderController.apiGetStockDetails("CCD");

    hmDelivryOrderController.apiProductType();
    var bookingNumber = widget.bookingNumber??"";
    Future.delayed(const Duration(
        seconds: 1
    ),() {
      if(bookingNumber.isNotEmpty){
        hmDelivryOrderController.wstrPageMode.value = "ADD";
        dprint("Call Booking Detail Api");
        hmDelivryOrderController.apiGetBooking(bookingNumber, "mode");

      }else{
        hmDelivryOrderController.wstrPageMode.value = 'VIEW';
        hmDelivryOrderController.apiViewDeliveryOrder("", "LAST");
      }
    },

    );








    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              hmDelivryOrderController.fnBackPage(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: tcn('Delivery Order', Colors.white, 20),
          actions:  [
            hmDelivryOrderController.wstrPageMode.value=="VIEW"? const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.water_drop_outlined,
                color: Colors.white,
                size: 25,
              ),
            ):Bounce(
              duration: const Duration(milliseconds: 110),
              onPressed: (){
                Get.to(()=>PreviousDeliveryOrder());

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                child: Container(
                    decoration: boxDecoration(white, 30),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Center(child: tc("Previous", txtColor, 12))),
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: () {


                        hmDelivryOrderController.fnLookup("GCYLINDER_DO");
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
                                tc(hmDelivryOrderController.frDocno.value, txtColor, 12)
                              ],
                            ),
                            gapWC(5),
                            const Icon(Icons.search,size: 14,)
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 15,
                        ),
                        gapWC(3),
                        tcn(
                            setDate(7, hmDelivryOrderController.docDate.value)
                                .toString()
                                .toUpperCase(),
                            txtColor,
                            12)
                      ],
                    ),
                  ],
                ),
                gapHC(15),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade200,
                  ),
                  child:     Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black,
                              size: 15,
                            ),
                            gapWC(5),
                            Expanded(
                              child: tc(hmDelivryOrderController.cstmrName.value,
                                  Colors.black, 12),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.tag_outlined,
                            color: Colors.black,
                            size: 15,
                          ),
                          gapWC(5),
                          tc(hmDelivryOrderController.cstmrCode.value,
                              Colors.black, 12)
                        ],
                      ),
                    ],
                  ),
                ),
                gapHC(5),


                // hmDelivryOrderController.wstrPageMode.value!="VIEW"?    tc('Search Customer', txtColor, 12):gapHC(0),
                // hmDelivryOrderController.wstrPageMode.value!="VIEW"?   gapHC(5):gapHC(0),
                // hmDelivryOrderController.wstrPageMode.value!="VIEW"?   Bounce(
                //   onPressed: () {
                //     hmDelivryOrderController.fnLookup("GUESTMASTER");
                //
                //   },
                //   duration: const Duration(milliseconds: 110),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.grey.shade200,
                //
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     padding: const EdgeInsets.all(10),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Row(
                //               children: [
                //                 const Icon(
                //                   Icons.account_circle_outlined,
                //                   color: Colors.black,
                //                   size: 15,
                //                 ),
                //                 gapWC(5),
                //                 tc(hmDelivryOrderController.cstmrCode.value,
                //                     Colors.black, 12)
                //               ],
                //             ),
                //
                //           ],
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Container(
                //                 margin: const EdgeInsets.symmetric(horizontal:0),
                //                 width: size.width-95,
                //                 child: const Divider(thickness:1)),
                //
                //             const Icon(
                //               Icons.search,
                //               color: txtColor,
                //               size: 25,
                //             )
                //           ],
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             tc(hmDelivryOrderController.cstmrName.value, Colors.black, 12),
                //             tcn("Credit Balance", Colors.black, 10),
                //
                //           ],
                //         ),
                //
                //       ],
                //     ),
                //   ),
                // ):gapHC(0),
                //
                // hmDelivryOrderController.wstrPageMode.value!="VIEW"?   gapHC(10):gapHC(0),


                Container(

                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),


                  decoration: boxDecoration(primaryColor, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TabButton(
                            width: 0.3,
                            text: "Items",
                            pageNumber: 0,
                            selectedPage:
                            hmDelivryOrderController.selectedPage.value,
                            onPressed: () {
                              hmDelivryOrderController.lstrSelectedPage.value = "IT";
                              changePage(0);
                            },
                            icon: Icons.shopping_cart_outlined),
                      ),
                      Flexible(
                        child: TabButton(
                            width: 0.3,
                            text: " Customer",
                            pageNumber: 1,
                            selectedPage:
                            hmDelivryOrderController.selectedPage.value,
                            onPressed: () {
                              hmDelivryOrderController.lstrSelectedPage.value = "CD";
                              changePage(1);
                            },
                            icon: Icons.person_2_outlined),
                      ),
                      Flexible(
                        child: TabButton(
                            width: 0.3,
                            text: "Others",
                            pageNumber: 2,
                            selectedPage:
                            hmDelivryOrderController.selectedPage.value,
                            onPressed: () {
                              hmDelivryOrderController.lstrSelectedPage.value = "OT";
                              changePage(2);
                            },
                            icon: Icons.more_horiz),
                      ),
                    ],
                  ),
                ),
                gapHC(8),
                Expanded(
                  child: Container(
                    width: size.width,
                    decoration: boxDecoration(white, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PageView(
                            onPageChanged: (int page) {
                              hmDelivryOrderController.selectedPage.value =
                                  page;
                            },
                            controller:
                            hmDelivryOrderController.pageController,
                            children: [
                              // 1st page design ------ Choose Item
                              wItemDetailScreen(MediaQuery.of(context).size),

                              //2nd Page  design -----------------------------------
                              wCustomerDetailsScreen(MediaQuery.of(context).size),
                              wOthersScreen( MediaQuery.of(context).size)

                              // 3rd Page for Delivery Details
                              // Container for  1st page   design -----------------------------------
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                gapHC(10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  decoration: boxDecoration(nearlyWhite, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      tcn('Net Amount', txtColor, 16),
                      gapWC(40),
                      tc(hmDelivryOrderController.txtNetAmt.text,Colors.black,15)
                    ],
                  ),
                )
              ],
            )),
        bottomNavigationBar: Obx(
              () => (hmDelivryOrderController.wstrPageMode.value == "VIEW")
              ? BottomNavigationItem(
            type: "booking",
            mode: hmDelivryOrderController.wstrPageMode.value,
            fnAdd: hmDelivryOrderController.fnAdd,
            fnEdit: hmDelivryOrderController.fnEdit,
            fnCancel: hmDelivryOrderController.fnCancel,
            fnPage: hmDelivryOrderController.fnPage,
            fnSave: hmDelivryOrderController.fnSave,
            fnDelete: hmDelivryOrderController.fnDelete,
          )
              : (hmDelivryOrderController.wstrPageMode.value == "ADD" ||
              hmDelivryOrderController.wstrPageMode.value == "EDIT")
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Bounce(
                    onPressed: () {
                      // dprint("BUILDING CODE  ${commonController.wstrBuildingCode.value}");
                      // dprint("APRTMNT CODE  ${commonController.wstrAprtmntCode.value}");

                      hmDelivryOrderController.fnSave(context);
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
                          tcn('Save', Colors.white, 15)
                        ],
                      ),
                    ),
                  ),
                ),
                Bounce(
                  onPressed: () {
                    hmDelivryOrderController.fnCancel();
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
              : const BottomAppBar(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,

        floatingActionButton: Obx(() => (hmDelivryOrderController.wstrPageMode.value != "VIEW" )? Padding(
          padding: const EdgeInsets.only(bottom: 67),
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            tooltip: 'Add Items',
            onPressed: () {
              hmDelivryOrderController.wOpenBottomSheet(context);
            },
            child: Icon(Icons.add),
          ),
        ):SizedBox())

    ));
  }

  changePage(int pageNum) {
    hmDelivryOrderController.selectedPage.value = pageNum;
    hmDelivryOrderController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      hmDelivryOrderController.lstrSelectedPage.value = "IT";
    }

    if (pageNum == 1) {
      hmDelivryOrderController.lstrSelectedPage.value = "CD";
    }
    if (pageNum == 2) {
      hmDelivryOrderController.lstrSelectedPage.value = "OT";
    }
  }

  wRoundedInputField(TextEditingController contrlr, hintTxt, lookup, {maxLine, prefixicon,enable}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tc(hintTxt, txtColor, 12),
        gapHC(5),
        CommonTextField(
          prefixIcon: prefixicon,
          enableY: enable,
          txtController: contrlr,
          prefixIconColor: txtColor,
          obscureY: false,
          textStyle: GoogleFonts.poppins(fontSize: 12,color: txtColor),
          maxline: maxLine,
          fnClear: (){
            contrlr.clear();
          },

        )
      ],
    );
  }

  wAddBuildAprtmntCode(heading, codetxt, nametxt, codetxtController,nametxtController, prefixIcon, onTap) {
    return Get.bottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        backgroundColor: Colors.white,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapHC(10),
                      tc(heading, txtColor, 15),
                      Container(
                        width: 80,
                        height: 5,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      gapHC(15),
                      tc(codetxt, txtColor, 12),
                      gapHC(5),
                      CommonTextField(
                          obscureY: false,
                          txtController: codetxtController,
                          prefixIcon: prefixIcon,
                          prefixIconColor: black),
                      gapHC(10),
                      tc(nametxt, txtColor, 12),
                      gapHC(5),
                      CommonTextField(
                          obscureY: false,
                          txtController: nametxtController,
                          prefixIcon: prefixIcon,
                          prefixIconColor: black),
                      gapHC(20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Bounce(
                        onPressed: onTap,
                        duration: const Duration(milliseconds: 110),
                        child: Container(
                          decoration: boxDecoration(primaryColor, 30),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 15,
                              ),
                              gapWC(5),
                              tcn('Add', Colors.white, 15)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Bounce(
                      onPressed: () {
                        Get.back();
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
            ],
          ),
        ));
  }

  wItemDetailScreen(Size size) {
    return SingleChildScrollView(
      child: Column(
          children: [
            // hmDelivryOrderController.wstrPageMode.value != "VIEW" ? Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Bounce(
            //       duration: const Duration(milliseconds: 110),
            //       onPressed: (){
            //         hmDelivryOrderController.wOpenBottomSheet(context);
            //       },
            //       child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            //         decoration: boxBaseDecoration(primaryColor,30),
            //           child: Row(
            //             children: [
            //               Icon(Icons.add,size: 15,color: white),
            //               gapWC(1),
            //               tc('Add Items', white, 12),
            //             ],
            //           )),
            //     ),
            //   ],
            // ) : gapHC(0),

            Container(
            decoration: boxBaseDecoration(subColor, 5),
          //padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            padding: const EdgeInsets.all(10),
            child: Row(
            children: [
              Flexible(
                  flex: 3,
                  child: Row(
                    children: [tcn('Item', Colors.white, 10)],
                  )),

              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [tcn('Price', Colors.white, 10)],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [tcn('Qty', Colors.white, 10)],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [tcn('R.Qty', Colors.white, 10)],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [tcn('Total', Colors.white, 10)],
                  )),
            ],
          ),
        ),
            hmDelivryOrderController.lstrDeliveredList.isEmpty?gapHC(10):gapHC(0),
            Column(
              children: [
                Column(
                  children: hmDelivryOrderController.wDeliverItemList(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tc('Payment  Details', txtColor, 12),
                  gapHC(5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tcn('Total Amount', txtColor, 12),
                        wRoundTxtField(hmDelivryOrderController.txtTotalAmt,disable: "D")
                      ],
                    ),
                  ),
                  gapHC(5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tcn('Discount Amount', txtColor, 12),
                        wRoundTxtField(hmDelivryOrderController.txtDiscountAmt,fieldName: "disAmt",
                            oncahnged: (value){
                              // salesController.fnCalc();
                              hmDelivryOrderController.fnPaymntCalc();
                            })
                      ],
                    ),
                  ),
                  gapHC(5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tcn('Tax Amount', txtColor, 12),
                        wRoundTxtField(hmDelivryOrderController.txtTaxAmt,disable: "D")
                      ],
                    ),
                  ),

                  gapHC(5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tcn('Round Of Amount', txtColor, 12),
                        wRoundTxtField(hmDelivryOrderController.txtRoundAmt,keybordType: "txtKeybrd",oncahnged: (val){
                          // salesController.fnCalc();
                          hmDelivryOrderController.fnPaymntCalc();
                        })
                      ],
                    ),
                  ),
                  gapHC(5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tcn('Net Amount', txtColor, 12),
                        wRoundTxtField(hmDelivryOrderController.txtNetAmt,disable: "D")
                      ],
                    ),
                  ),
                  gapHC(5),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 5, horizontal: 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       tcn('Additional Amount', txtColor, 12),
                  //       wRoundTxtField(hmDelivryOrderController.txtAddlAmt,
                  //           oncahnged: (val){
                  //             // salesController.fnCalc();
                  //             hmDelivryOrderController.fnPaymntCalc();
                  //           })
                  //     ],
                  //   ),
                  // ),
                  // gapHC(5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tcn('Paid Amount', txtColor, 12),
                        wRoundTxtField(hmDelivryOrderController.txtPaidAmt,
                            oncahnged: (val){
                              // salesController.fnCalc();
                              hmDelivryOrderController.fnPaymntCalc();
                            })
                      ],
                    ),
                  ),
                  gapHC(5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        tcn('Balance Amount', txtColor, 12),
                        wRoundTxtField(hmDelivryOrderController.txtBalanceAmt,disable: "D")
                      ],
                    ),
                  ),
                  gapHC(15),

                ],
              ),
            ),






      ]),
    );
  }

  wCustomerDetailsScreen(Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Bounce(
              onPressed: () {
                if(hmDelivryOrderController.wstrPageMode=="VIEW"){
                  return;
                }
                hmDelivryOrderController.fnLookup("SLMAST");

              },
              duration: const Duration(milliseconds: 110),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,

                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black,
                              size: 15,
                            ),
                            gapWC(5),
                            tc(hmDelivryOrderController.cstmrCode.value,
                                Colors.black, 12)
                          ],
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal:0),
                            width: size.width-95,
                            child: const Divider(thickness:1)),

                        const Icon(
                          Icons.search,
                          color: txtColor,
                          size: 25,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: tc(hmDelivryOrderController.cstmrName.value, Colors.black, 12)),
                        tcn("Credit Balance", Colors.black, 10),

                      ],
                    ),

                  ],
                ),
              ),
            ),
            gapHC(5),

            wRoundedInputField(
                hmDelivryOrderController.txtCustomerName, "Customer Name", "N",enable: false,
                prefixicon: Icons.drive_file_rename_outline),
            gapHC(10),
            wRoundedInputField(
                hmDelivryOrderController.txtContactNo, "Contact No", "N",enable: false,
                prefixicon: Icons.phone_android_outlined),
            gapHC(10),

            wRoundedInputField(
                hmDelivryOrderController.txtBuildingCode, "Building Code", "N",enable: false,
                prefixicon: Icons.apartment),
            gapHC(10),
            wRoundedInputField(
                hmDelivryOrderController.txtApartmentCode, "Apartment Code", "N",enable: false,
                prefixicon: Icons.apartment),
            gapHC(10),
            wRoundedInputField(
                hmDelivryOrderController.txtAreaCode, "Area Code", "N",enable: false,
                prefixicon: Icons.apartment),
            // gapHC(10),
            // wRoundedInputField(
            //   hmDelivryOrderController.txtLandmark,
            //   "Landmark",
            //   "N",
            //   prefixicon: Icons.apartment,enable: false,
            // ),
            gapHC(10),
            wRoundedInputField(
              hmDelivryOrderController.txtAddress,enable: false,
              "Address",
              "N",
              maxLine: 5,
              prefixicon: Icons.abc_outlined,
            ),
            gapHC(10),
            wRoundedInputField(
              hmDelivryOrderController.txtRemark,enable: hmDelivryOrderController.wstrPageMode=="VIEW"?false:true,
              "Remark",
              "N",
              maxLine: 5,
              prefixicon: Icons.note_alt_outlined,
            ),
            gapHC(15),

          ],
        ),
      ),
    );
  }

  wOthersScreen(Size size){
    return Padding(padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tc('Driver', black, 12),
        gapHC(5),
        Bounce(
          duration: const Duration(milliseconds: 110),
          onPressed: (){
            if(hmDelivryOrderController.wstrPageMode.value  == "VIEW"){
              return;
            }else{
              dprint(" Driver Lookupp");
              hmDelivryOrderController.fnLookup("CRDELIVERYMANMASTER");
            }
          },
          child: CommonTextField(
            sufixIconColor: Colors.black,
            lookupY: true,
            obscureY: false,
            textStyle: const TextStyle(color:txtColor,fontSize: 12),
            prefixIcon: Icons.directions_car_filled_outlined,
            prefixIconColor: black,
            txtController: hmDelivryOrderController.txtDriver,
            enableY:false,
          ),
        ),
        gapHC(10),
        tc('Vehicle Number', black, 12),
        gapHC(5),
        Bounce(
          duration: const Duration(milliseconds: 110),
          onPressed: (){
            if(hmDelivryOrderController.wstrPageMode.value  == "VIEW"){
              return;
            }else{
              dprint(" VehicleNumb Lookupp");
              hmDelivryOrderController.fnLookup("CRVEHICLEMASTER");
            }
          },
          child: CommonTextField(
            lookupY: true,
            obscureY: false,

            textStyle: const TextStyle(color:txtColor,fontSize: 12),
            prefixIcon: Icons.tag,
            sufixIconColor: Colors.black,
            prefixIconColor: black,
            txtController: hmDelivryOrderController.txtVehiclenumber,
            enableY:false,
          ),
        ),
        gapHC(10),
        tc('S.Man', black, 12),
        gapHC(5),
        Bounce(
          duration: const Duration(milliseconds: 110),
          onPressed: (){
            if(hmDelivryOrderController.wstrPageMode.value  == "VIEW"){
              return;
            }else{
              dprint(" SMANMAST Lookupp");
              hmDelivryOrderController.fnLookup("SMANMAST");
            }
          },
          child: CommonTextField(
            lookupY: true,
            obscureY: false,

            textStyle: const TextStyle(color:txtColor,fontSize: 12),
            prefixIcon: Icons.tag,
            sufixIconColor: Colors.black,
            prefixIconColor: black,
            txtController: hmDelivryOrderController.txtsman,
            enableY:false,
          ),
        ),
        gapHC(10),
        tc('Location', black, 12),
        gapHC(5),
        Bounce(
          duration: const Duration(milliseconds: 110),
          onPressed: (){
            if(hmDelivryOrderController.wstrPageMode.value  == "VIEW"){
              return;
            }else{
              dprint(" VehicleNumb Lookupp");
              hmDelivryOrderController.fnLookup("LOCMAST");
            }
          },
          child: CommonTextField(
            lookupY: true,
            obscureY: false,

            textStyle: const TextStyle(color:txtColor,fontSize: 12),
            prefixIcon: Icons.location_on_outlined,
            sufixIconColor: Colors.black,
            prefixIconColor: black,
            txtController: hmDelivryOrderController.txtlocation,
            enableY:false,
          ),
        )
      ],

    ),);

  }
  wRoundTxtField(controller,{disable,keybordType,fieldName,ValueChanged<String>? oncahnged}){
    return   Container(
      height: 40,
      width: 100,

      decoration: boxBaseDecoration(bGreyLight, 10),
      child: Center(
        child: TextFormField(
            enabled: hmDelivryOrderController.wstrPageMode=="VIEW" || disable=="D"?false:true,
            inputFormatters: mfnInputDecFormatters(),
            controller:controller,
            textAlign: TextAlign.center,
            keyboardType:keybordType=="txtKeybrd"?TextInputType.text: TextInputType.number,
            style: GoogleFonts.poppins(fontSize: 12,color: txtColor),
            decoration:  InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4,),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Colors.blueGrey.withOpacity(0.5)), //<-- SEE HERE
              ),

            ),
            onChanged: oncahnged
        ),
      ),
    );
  }

}
