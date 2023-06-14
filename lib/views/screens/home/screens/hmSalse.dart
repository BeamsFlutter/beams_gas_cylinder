import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../../components/common/common.dart';
import '../../../components/common/commonTextField.dart';
import '../../../components/common/tabButton.dart';
import '../../../styles/colors.dart';
import '../controller/hmDeliveryOrderController.dart';
import '../controller/hmSalesController.dart';

class HmeSales extends StatefulWidget {
  const HmeSales({super.key});

  @override
  State<HmeSales> createState() => _HmeSalesState();
}

class _HmeSalesState extends State<HmeSales> {
  final HmSalesController hmSalesController = Get.put(HmSalesController());
  @override
  void initState() {
    hmSalesController.pageController = PageController();
    hmSalesController.wstrPageMode.value = 'VIEW';
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              hmSalesController.fnBackPage(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: tcn('Sales', Colors.white, 20),
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
            padding: const EdgeInsets.all(8.0),
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          dprint("lookup>>>>>>>Booking");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
                                  tc(hmSalesController.frDocno.value,
                                      txtColor, 12)
                                ],
                              ),
                              gapWC(5),
                              const Icon(
                                Icons.search,
                                size: 14,
                              )
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
                              setDate(7, hmSalesController.docDate.value)
                                  .toString()
                                  .toUpperCase(),
                              txtColor,
                              12)
                        ],
                      ),
                    ],
                  ),
                  gapHC(15),
                  tc('Customer Details', txtColor, 12),
                  gapHC(5),
                  Bounce(
                    onPressed: () {},
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
                                  tc(
                                      hmSalesController
                                          .txtCustomerName.text,
                                      Colors.black,
                                      12)
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 0),
                                  width: MediaQuery.of(context).size.width - 95,
                                  child: const Divider(thickness: 1)),
                              const Icon(
                                Icons.search,
                                color: txtColor,
                                size: 25,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tc("${"Hassjls"} | ${"jjjdakk"}", Colors.black,
                                  12),
                              hmSalesController.wstrPageMode.value !=
                                  "VIEW"
                                  ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      tcn('Credit Balance', Colors.black,
                                          10)
                                    ],
                                  ),
                                  Container(
                                    height: 20,
                                    width: 1,
                                    decoration:
                                    boxDecoration(Colors.black, 10),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      tcn('Balance Coupon', Colors.black,
                                          10)
                                    ],
                                  ),
                                ],
                              )
                                  : gapHC(0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  gapHC(10),
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
                              hmSalesController.selectedPage.value,
                              onPressed: () {
                                hmSalesController.lstrSelectedPage.value = "IT";
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
                              hmSalesController.selectedPage.value,
                              onPressed: () {
                                hmSalesController.lstrSelectedPage.value = "CD";
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
                              hmSalesController.selectedPage.value,
                              onPressed: () {
                                hmSalesController.lstrSelectedPage.value = "OT";
                                changePage(2);
                              },
                              icon: Icons.more_horiz_outlined),
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
                                hmSalesController.selectedPage.value =
                                    page;
                              },
                              controller:
                              hmSalesController.pageController,
                              children: [
                                // 1st page design ------ Choose Item
                                wItemDetailScreen(MediaQuery.of(context).size),

                                //2nd Page  design -----------------------------------
                                wCustomerDetailsScreen(
                                    MediaQuery.of(context).size),
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
                ],
              ),
            )),
        bottomNavigationBar: Obx(
              () => (hmSalesController.wstrPageMode.value == "VIEW")
              ? BottomNavigationItem(
            type: "booking",
            mode: hmSalesController.wstrPageMode.value,
            fnAdd: hmSalesController.fnAdd,
            fnEdit: hmSalesController.fnEdit,
            fnCancel: hmSalesController.fnCancel,
            fnPage: hmSalesController.fnPage,
            fnSave: hmSalesController.fnSave,
            fnDelete: hmSalesController.fnDelete,
          )
              : (hmSalesController.wstrPageMode.value == "ADD" ||
                  hmSalesController.wstrPageMode.value == "EDIT")
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Bounce(
                    onPressed: () {
                      // dprint("BUILDING CODE  ${commonController.wstrBuildingCode.value}");
                      // dprint("APRTMNT CODE  ${commonController.wstrAprtmntCode.value}");

                      hmSalesController.fnSave();
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
                    hmSalesController.fnCancel();
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
        floatingActionButton: Obx(() => (hmSalesController.wstrPageMode.value != "VIEW" )? FloatingActionButton(
          backgroundColor: primaryColor,
          tooltip: 'Add Items',
          onPressed: () {
            hmSalesController.wOpenBottomSheet(context);
          },
          child: Icon(Icons.add),
        ):SizedBox())

    );
  }

  changePage(int pageNum) {
    hmSalesController.selectedPage.value = pageNum;
    hmSalesController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      hmSalesController.lstrSelectedPage.value = "IT";
    }

    if (pageNum == 1) {
      hmSalesController.lstrSelectedPage.value = "CD";
    }
    if (pageNum == 2) {
      hmSalesController.lstrSelectedPage.value = "OT";
    }
  }

  wRoundedInputField(contrlr, hintTxt, lookup, {maxLine, prefixicon,enable}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tc(hintTxt, txtColor, 12),
        gapHC(5),
        CommonTextField(
          prefixIcon: prefixicon,
          enableY: enable??false,
          txtController: contrlr,
          prefixIconColor: txtColor,
          obscureY: false,
          maxline: maxLine,
        )
      ],
    );
  }

  wAddBuildAprtmntCode(heading, codetxt, nametxt, codetxtController,
      nametxtController, prefixIcon, onTap) {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
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
              gapHC(5),






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
                          children: [tcn('N/R', Colors.white, 10)],
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
                          children: [tcn('Total', Colors.white, 10)],
                        )),
                  ],
                ),
              ),
              Column(
                children: hmSalesController.wDeliverItemList(),
              ),



            ]),
      ),
    );
  }

  wCustomerDetailsScreen(Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wRoundedInputField(
                hmSalesController.txtCustomerName, "Customer Name", "N",
                prefixicon: Icons.drive_file_rename_outline),
            gapHC(10),
            wRoundedInputField(
                hmSalesController.txtContactNo, "Contact No", "N",
                prefixicon: Icons.phone_android_outlined),
            gapHC(10),
            wRoundedInputField(
              hmSalesController.txtBuildingCode,
              "BuildingCode",
              "N",
              prefixicon: Icons.apartment,
            ),
            gapHC(10),
            wRoundedInputField(
              hmSalesController.txtApartmentName,
              "Apartment",
              "N",
              prefixicon: Icons.apartment,
            ),
            gapHC(10),
            wRoundedInputField(
              hmSalesController.txtAreacode,
              "Area Code",
              "N",
              prefixicon: Icons.apartment,
            ),
            gapHC(10),
            wRoundedInputField(
              hmSalesController.txtLandmark,
              "Landmark",
              "N",
              prefixicon: Icons.apartment,
            ),
            gapHC(10),
            wRoundedInputField(
              hmSalesController.txtAddress,
              "Address",
              "N",
              maxLine: 5,
              prefixicon: Icons.abc_outlined,
            ),
            gapHC(10),
            wRoundedInputField(
              hmSalesController.txtRemark,enable: true,
              "Remark",
              "N",
              maxLine: 5,
              prefixicon: Icons.apartment,
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
          // tc('Driver Details', txtColor, 12),
          // gapHC(10),
          wRoundedInputField(
            hmSalesController.txtDriver,enable: true,
            "Driver",
            "N",
            prefixicon: Icons.drive_eta_outlined,
          ),
          gapHC(10),
          wRoundedInputField(
            hmSalesController.txtVehiclenumber,enable: true,
            "Vehicle Number",
            "N",
            prefixicon: Icons.tag_outlined,
          ),
        ],

      ),);

  }


}
