import 'package:beams_gas_cylinder/views/components/common/common.dart';
import 'package:beams_gas_cylinder/views/components/common/commonButton.dart';
import 'package:beams_gas_cylinder/views/components/common/commonTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../../components/common/tabButton.dart';
import '../../../styles/colors.dart';
import '../controller/hmBookingController.dart';
import '../controller/home_controller.dart';

class HmeBooking extends StatefulWidget {
  const HmeBooking({Key? key}) : super(key: key);

  @override
  State<HmeBooking> createState() => _HmeBookingState();
}

class _HmeBookingState extends State<HmeBooking> {
  final HmBookingController hmBookingController =
      Get.put(HmBookingController());
  @override
  void initState() {
    hmBookingController.pageController = PageController();
    hmBookingController.wstrPageMode.value = 'VIEW';
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            hmBookingController.fnBackPage(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: tcn('Booking', Colors.white, 20),
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
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 6,vertical: 5),
            child: Column(
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
                                tc(hmBookingController.frDocno.value, txtColor, 12)
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
                            setDate(7, hmBookingController.docDate.value)
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          dprint("lookup>>>>>>>location");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.shade200,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 18, color: primaryColor),
                              gapWC(3),
                              tcn("AL NAHDA", txtColor, 13)
                            ],
                          ),
                        ),
                      ),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          dprint("lookup>>>>>>>Priority");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.shade200,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.circle,
                                  size: 18, color: Colors.red),
                              gapWC(4),
                              tcn("Emergency", txtColor, 13)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.greenAccent.shade400,
                            borderRadius: BorderRadius.circular(10)),
                        child: tcn("Assigned", white, 12),
                      )
                    ],
                  ),
                ),
                gapHC(8),
                Container(

                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),


                  decoration: boxDecoration(primaryColor, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TabButton(
                            width: 0.3,
                            text: "Customer",
                            pageNumber: 0,
                            selectedPage:
                                hmBookingController.selectedPage.value,
                            onPressed: () {
                              hmBookingController.lstrSelectedPage.value = "CD";
                              changePage(0);
                            },
                            icon: Icons.person_outline_rounded),
                      ),
                      Flexible(
                        child: TabButton(
                            width: 0.3,
                            text: " Items",
                            pageNumber: 1,
                            selectedPage:
                                hmBookingController.selectedPage.value,
                            onPressed: () {
                              hmBookingController.lstrSelectedPage.value = "CI";
                              changePage(1);
                            },
                            icon: Icons.shopping_cart_outlined),
                      ),
                      Flexible(
                        child: TabButton(
                            width: 0.3,
                            text: " Delivery",
                            pageNumber: 2,
                            selectedPage:
                                hmBookingController.selectedPage.value,
                            onPressed: () {
                              hmBookingController.lstrSelectedPage.value = "DD";
                              changePage(2);
                            },
                            icon: Icons.fire_truck),
                      ),
                    ],
                  ),
                ),
                gapHC(8),
                Expanded(
                  child: Container(
                    width: size.width,
                    decoration: boxDecoration(white, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PageView(
                            onPageChanged: (int page) {
                              hmBookingController.selectedPage.value = page;
                            },
                            controller: hmBookingController.pageController,
                            children: [
                              // 1st page design ------ Choose Item
                              Customertab(),
                              //2nd Page  design -----------------------------------
                              Itemtab(),
                              // 3rd Page for Delivery Details
                              Deliverytab()
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
          ),
          bottomNavigationBar: (hmBookingController.wstrPageMode.value ==
                  "VIEW")
              ? BottomNavigationItem(
                  type: "booking",
                  mode: hmBookingController.wstrPageMode.value,
                  fnAdd: hmBookingController.fnAdd,
                  fnEdit: hmBookingController.fnEdit,
                  fnCancel: hmBookingController.fnCancel,
                  fnPage: hmBookingController.fnPage,
                  fnSave: hmBookingController.fnSave,
                  fnDelete: hmBookingController.fnDelete,
                )
              : (hmBookingController.wstrPageMode.value == "ADD" ||
                      hmBookingController.wstrPageMode.value == "EDIT")
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Bounce(
                              onPressed: () {
                                // dprint("BUILDING CODE  ${commonController.wstrBuildingCode.value}");
                                // dprint("APRTMNT CODE  ${commonController.wstrAprtmntCode.value}");

                                hmBookingController.fnSave();
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
                              hmBookingController.fnCancel();
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
        ));
  }

  //===================================WIDGET
  // List<Widget> wPriorityLIst(controller) {
  //   List<Widget> rtnList = [];
  //   for (var e in controller.priorityList) {
  //     var code = e["CODE"];
  //     var det = (e["PNAME"] ?? "");
  //     rtnList.add(ListTile(
  //       contentPadding: EdgeInsets.zero,
  //       title: Transform.translate(
  //         offset: const Offset(-20, 0),
  //         child: tcn(det.toString(), txtColor, 12),
  //       ),
  //       leading: Radio(
  //           value: code.toString(),
  //           activeColor: Colors.red,
  //           groupValue: controller.priorityvalue,
  //           onChanged: (value) => controller.onClickRadioButton(value)),
  //     ));
  //   }
  //   return rtnList;
  // }

  Widget Customertab() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      width: size.width,
      child: SingleChildScrollView(
          child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            tc(hmBookingController.txtCustomerName.text,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tc("${"Hassjls"} | ${"jjjdakk"}",
                            Colors.black, 12),
                        hmBookingController.wstrPageMode.value != "VIEW"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      tcn('Credit Balance', Colors.black, 10)
                                    ],
                                  ),
                                  Container(
                                    height: 20,
                                    width: 1,
                                    decoration: boxDecoration(Colors.black, 10),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      tcn('Balance Coupon', Colors.black, 10)
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
            tc("Customer Code", txtColor, 12),
            gapHC(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CommonTextField(prefixIconColor: txtColor,
                  txtController: hmBookingController.txtCustomerCode,
                  obscureY: false,
                      prefixIcon: Icons.tag_outlined,
                )),
                hmBookingController.wstrPageMode.value != 'VIEW'?   gapWC(10):gapWC(0),
                hmBookingController.wstrPageMode.value != 'VIEW'
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: size.width * 0.12,
                          decoration: boxDecoration(primaryColor, 10),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : gapHC(0)
              ],
            ),
            gapHC(10),
            wRoundedInputField(
                hmBookingController.txtCustomerName, "Customer Name", "N",prefixicon: Icons.drive_file_rename_outline ),
            gapHC(10),
            wRoundedInputField(
                hmBookingController.txtContactNo, "Contact No", "N",prefixicon: Icons.phone_android_outlined ),
            gapHC(10),
            tc("Building Code", txtColor, 12),
            gapHC(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CommonTextField(
                  txtController: hmBookingController.txtCustomerCode,
                  obscureY: false,
                      prefixIconColor: txtColor,
                      prefixIcon: Icons.apartment,
                )),
                hmBookingController.wstrPageMode.value != 'VIEW'?   gapWC(10):gapWC(0),
                hmBookingController.wstrPageMode.value != 'VIEW'
                    ? Bounce(
                      duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          wAddBuildAprtmntCode("Add Building", "Building Code", "Building Name", hmBookingController.txtBuildingCode, hmBookingController.txtBuildingName, Icons.apartment,
                              (){
                            dprint("Building adddddddddddd");

                              });
                        },
                        child: Container(
                          height: 40,
                          width: size.width * 0.12,
                          decoration: boxDecoration(primaryColor, 10),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : gapHC(0)
              ],
            ),
            gapHC(10),
            tc("Apartment", txtColor, 12),
            gapHC(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CommonTextField(
                      prefixIcon:   Icons.apartment,
                  txtController: hmBookingController.txtCustomerCode,
                  obscureY: false,prefixIconColor: txtColor,
                )),
                hmBookingController.wstrPageMode.value != 'VIEW'?   gapWC(10):gapWC(0),
                hmBookingController.wstrPageMode.value != 'VIEW'
                    ? Bounce(
                  duration: const Duration(milliseconds: 110),
                  onPressed: () {
                    wAddBuildAprtmntCode("Add Apartment", "Apartment Code", "Apartment Name", hmBookingController.txtApartmentCode, hmBookingController.txtApartmentName, Icons.apartment,
                            (){
                          dprint("Apartment adddddddddddd");

                        });
                  },
                child: Container(
                  height: 40,
                  width: size.width * 0.12,
                  decoration: boxDecoration(primaryColor, 10),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),)
                    : gapHC(0)
              ],
            ),
            gapHC(10),
            tc("AreaCode", txtColor, 12),
            gapHC(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CommonTextField(
                      prefixIcon:   Icons.apartment,prefixIconColor: txtColor,
                  txtController: hmBookingController.txtCustomerCode,
                  obscureY: false,
                )),

              ],
            ),
            gapHC(10),
            wRoundedInputField(
                hmBookingController.txtLandmark, "Landmark", "N",        prefixicon:   Icons.apartment,),
            gapHC(10),
            wRoundedInputField(hmBookingController.txtAddress, "Address", "N",maxLine: 5,        prefixicon:   Icons.abc_outlined,),
            gapHC(10),
            wRoundedInputField(hmBookingController.txtRemark, "Remark", "N",maxLine: 5,        prefixicon:   Icons.apartment,),
          ],
        ),
      )),
    );
  }

  wRoundedInputField(contrlr, hintTxt, lookup, {maxLine,prefixicon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tc(hintTxt, txtColor, 12),
        gapHC(5),
        CommonTextField(prefixIcon:prefixicon ,

          txtController: contrlr,
          prefixIconColor: txtColor,
          obscureY: false,
          maxline: maxLine,
        )
      ],
    );
  }

  Widget Itemtab() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget Deliverytab() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tc('Priority',txtColor, 12),
            gapHC(5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: boxBaseDecoration(Colors.grey.shade200, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  GetBuilder<HmBookingController>(
                      builder: (controller){

                        return  Column(
                          children: controller.priorityList.asMap().entries.map((e) =>

                              RadioListTile(
                                  title: tcn(e.value["DESCP"].toString(), txtColor,12),
                                  value: e.value["DESCP"],
                                  activeColor: primaryColor,
                                  groupValue: controller.priorityvalue.value,
                                  onChanged: controller.onClickRadioButton
                              )).toList(),
                        );
                      }

                  ),
                ],
              ),
            ),
            gapHC(10),
            tc('Delivery Required date', black, 12),
            gapHC(5),
            Bounce(
                    duration: const Duration(milliseconds: 110),
                    onPressed: () {
                      hmBookingController.wSelectDate(context);
                      gapHC(5);
                    },
              child:  CommonTextField(
                obscureY: false,
                textStyle: const TextStyle(color: txtColor),
                txtController: hmBookingController.txtdelivryDate,
                prefixIcon: Icons.calendar_month,
                prefixIconColor: black,
                suffixIcon: Icons.done,
                enableY: false,
              ),
            ),
            gapHC(10),
            tc('Driver', black, 12),
            gapHC(5),
            const CommonTextField(
              obscureY: false,
              prefixIcon: Icons.directions_car_filled_outlined,
              prefixIconColor: black,
            ),
            gapHC(10),
            tc('Vehicle Number', black, 12),
            gapHC(5),
            const CommonTextField(
              obscureY: false,
              prefixIcon: Icons.tag,
              prefixIconColor: black,
            )
          ],
        ),
      ),
    );
  }

  wAddBuildAprtmntCode(heading,codetxt,nametxt,codetxtController,nametxtController,prefixIcon,onTap){
    return  Get.bottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:Radius.circular(30) ),
        ),
      backgroundColor: Colors.white,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      gapHC(15),
                      tc(codetxt, txtColor, 12),
                      gapHC(5),
                      CommonTextField(obscureY: false,txtController: codetxtController,prefixIcon: prefixIcon,prefixIconColor: black),
                      gapHC(10),
                      tc(nametxt, txtColor, 12),
                      gapHC(5),
                      CommonTextField(obscureY: false,txtController:nametxtController,prefixIcon: prefixIcon,prefixIconColor: black),
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
                          padding:
                          const EdgeInsets.symmetric(vertical: 10),
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

  //===================================FUNCTIONS
  changePage(int pageNum) {
    hmBookingController.selectedPage.value = pageNum;
    hmBookingController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      hmBookingController.lstrSelectedPage.value = "CD";
    }

    if (pageNum == 1) {
      hmBookingController.lstrSelectedPage.value = "CI";
    }

    if (pageNum == 2) {
      hmBookingController.lstrSelectedPage.value = "DD";
    }
  }
}
