import 'package:beams_gas_cylinder/views/components/common/commonButton.dart';
import 'package:beams_gas_cylinder/views/screens/assignmnets/controller/assignmnet_controller.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmDeliveryOrder.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmSalse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../components/common/common.dart';
import '../../components/common/tabButton.dart';
import '../../styles/colors.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentSCreenState();
}

class _AssignmentSCreenState extends State<AssignmentScreen> {
  final AssignmentController assignmentController = Get.put(AssignmentController());
  @override
  void initState() {
    assignmentController.pageController = PageController();
    assignmentController.lstrSelectedPage.value = "IT";
    assignmentController.selectedPage.value=0;
    dprint("empcooooooooooode  ${assignmentController.g.wstrempcode}");
    Future.delayed(const Duration(
      seconds: 3
    ),assignmentController.apiGetAssignment()
    );

   // assignmentController.apiGetAssignment("HLP0945");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return  Column(
        children: [
          Obx(() => Container(
            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
            decoration: boxDecoration(white, 25),
            child: Row(

              children: [
                Flexible(
                  child: TabButton(
                      width: 0.3,
                      text: "Today",
                      isWhite: true,
                      pageNumber: 0,
                      selectedPage: assignmentController.selectedPage.value,
                      onPressed: () {
                        assignmentController.lstrSelectedPage.value = "TD";
                        changePage(0);
                      },
                      icon: Icons.calendar_month),
                ),
                gapWC(3),
                Flexible(
                  child: TabButton(
                      isWhite: true,
                      width: 0.3,
                      text: "Pending",
                      pageNumber: 1,
                      selectedPage:assignmentController.selectedPage.value,
                      onPressed: () {
                        assignmentController.lstrSelectedPage.value= "PD";
                        changePage(1);
                      },
                      icon: Icons.all_inbox),
                ) ,
                gapWC(3),
                Flexible(
                  child: TabButton(
                      isWhite: true,
                      width: 0.3,
                      text: "All",
                      pageNumber: 2,
                      selectedPage:assignmentController.selectedPage.value,
                      onPressed: () {
                        assignmentController.lstrSelectedPage .value= "ALL";
                        changePage(2);
                      },
                      icon: Icons.all_inbox),
                ),

              ],
            ),
          )),
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
                            assignmentController.selectedPage.value = page;
                          },
                          controller: assignmentController.pageController,
                          children:  [
                            // 1st page design ------ Choose Item
                            todayAssignmnt(),
                            //2nd Page  design -----------------------------------
                            pendingAssignmnt(),

                            allAssignmnt()
                            // Container for  1st page   design -----------------------------------
                          ],
                        ),
                      ),
                    ],
                  )

              )
          )
        ]);


  }
  changePage(int pageNum) {
    assignmentController.selectedPage.value = pageNum;
    assignmentController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );


    if (pageNum == 0) {
      assignmentController.lstrSelectedPage.value = "TD";

    }

    if (pageNum == 1) {

      assignmentController.lstrSelectedPage.value = "PD";

    }
    if (pageNum == 1) {

      assignmentController.lstrSelectedPage.value = "ALL";

    }

  }

  pendingAssignmnt() {
    dprint(">>>>>AAA>>>>>  ${assignmentController.pendingAssignedList.value}");
    return  Obx(() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: assignmentController.pendingAssignedList.value.isEmpty || assignmentController.pendingAssignedList.value==[]?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: tcn("No Pending Assignmnet List", txtColor, 12),
          ),
        ],
      ): SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Column(
                children: wPendingAssignedList()
            ),
          ],
        ),
      ),
    )
    );
  }

  allAssignmnt() {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: assignmentController.allAssignedList.value.isEmpty || assignmentController.allAssignedList.value==[]?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: tcn("Assignmnet List is Empty", txtColor, 12),
          ),
        ],
      ): SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
                children: wAllAssignedList()
            ),
          ],
        ),
      ),
    ));
  }

  todayAssignmnt() {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: assignmentController.todayAssignedList.value.isEmpty || assignmentController.todayAssignedList.value==[]?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: tcn("No Today Assignmnet List", txtColor, 12),
          ),
        ],
      ): SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
                children: wTodayAssignedList()
            ),
          ],
        ),
      ),
    )

    );
  }


  List<Widget> wTodayAssignedList() {
    var todayList = assignmentController.todayAssignedList.value;
    List<Widget> rtnList = [] ;
    for(var e in todayList){
      var name = e["PARTY_NAME"]??"";
      var buildcode = e["BLDG_NO"]??"";
      var mobile = e["MOBILE"]??"";
      var apartment = e["APARTMENT_NO"]??"";
      var priority = e["PRIORITY"]??"";
      var bookingNumber = e["BOOKING_NO"]??"";
      rtnList.add(wAssignCard(name, priority, buildcode, apartment, mobile,bookingNumber));
    }

    return rtnList;
  }
  // List<Widget> wOthersAssignedList() {
  //   var otherList = assignmentController.otherAssignedList.value;
  //   List<Widget> rtnList = [] ;
  //   for(var e in otherList){
  //     var name = e["PartyName"];
  //     var buildcode = e["BuildCode"];
  //     var priority = e["Priority"];
  //     var mobile = e["Mobile"];
  //     var apartment = e["Apartment"];
  //     rtnList.add(wAssignCard(name, priority, buildcode, apartment, mobile));
  //   }
  //   return rtnList;
  // }

  List<Widget> wPendingAssignedList() {
    var pendingList = assignmentController.pendingAssignedList.value;
    List<Widget> rtnList = [] ;
    for(var e in pendingList){
      var name = e["PARTY_NAME"]??"";
      var buildcode = e["BLDG_NO"]??"";
      var mobile = e["MOBILE"]??"";
      var apartment = e["APARTMENT_NO"]??"";
      var priority = e["PRIORITY"]??"";
      var bookingNumber = e["BOOKING_NO"]??"";
      rtnList.add(wAssignCard(name, priority, buildcode, apartment, mobile,bookingNumber));
    }
    return rtnList;
  }
  List<Widget> wAllAssignedList() {
    var allAssignList = assignmentController.allAssignedList.value;
    List<Widget> rtnList = [] ;
    for(var e in allAssignList){
      var name = e["PARTY_NAME"]??"";
      var buildcode = e["BLDG_NO"]??"";
      var mobile = e["MOBILE"]??"";
      var apartment = e["APARTMENT_NO"]??"";
      var priority = e["PRIORITY"]??"";
      var bookingNumber = e["BOOKING_NO"]??"";
      rtnList.add(wAssignCard(name, priority, buildcode, apartment, mobile,bookingNumber));
    }
    return rtnList;
  }


  wAssignCard(name,priority,buildcode,apartment,mobile,bookingNumber){
    return Bounce(
      onPressed: (){
        dprint("bookingNUMBER>>>>> ${bookingNumber}");

        assignmentController.apiGetBooking(bookingNumber,"");
        wOpenBottomSheet(context,bookingNumber,name,priority,buildcode,apartment,mobile);
      },
      duration: const Duration(
          milliseconds: 110),
      child: Card(
        elevation: 2,
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3))),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration:  BoxDecoration(
              border: Border(
                left: BorderSide(color:(priority=="HIGH")?Colors.redAccent:(priority=="LOW")?Colors.blueGrey:Colors.blueAccent, width:5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.person,size: 14),
                          gapWC(4),
                          Expanded(child: tc(name, txtColor, 12)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        tc("//", primaryColor, 12),
                        gapWC(1),
                        tc(priority, txtColor, 12),

                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.apartment,size: 14),
                        gapWC(4),
                        tcn(buildcode, txtColor, 12),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.apartment,size: 14),
                        gapWC(4),
                        tcn(apartment, txtColor, 12),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone_android_rounded,size: 14),
                    gapWC(4),
                    tcn(mobile, txtColor, 12),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Bounce(
                      onPressed: (){
                        dprint("Location");
                      },
                      duration: const Duration(
                          milliseconds: 110),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                        decoration: boxDecorationS(subColor, 30),
                        child:       Row(
                          children: [
                            tcn("Location", white, 12),
                            const Icon(Icons.location_on,color: white,size: 12),
                          ],
                        ),),
                    ),
                    gapWC(10),

                    Bounce(
                      onPressed: (){
                        dprint("OPENN");
                      },
                      duration: const Duration(
                          milliseconds: 110),
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                          decoration: boxDecorationS(Colors.greenAccent, 30),
                          child: tcn("Open", txtColor, 12)),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  wOpenBottomSheet(context,bookingNumb,name,priority,buildcode,apartment,mobile) {

    Get.bottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:Radius.circular(30) ),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        StatefulBuilder(
          builder: (context,setState){
            return Obx(() => Container(
              height: MediaQuery.of(context).size.height*0.7,
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tc("Booking Details", txtColor, 15),
                          Container(
                            width: 80,
                            height: 5,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ],
                      ),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: (){
                          Get.back();
                        },
                        child: Container(
                            padding: EdgeInsets.all(4),

                            child: Icon(Icons.close)),
                      ),
                    ],
                  ),
                  gapHC(6),
                  tc(bookingNumb,txtColor,11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.person,size: 14),
                            gapWC(5),
                            Expanded(child: tcn(name, txtColor, 12)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone_android_rounded,size: 14),
                          gapWC(3),
                          tcn(mobile.toString(), txtColor, 12),
                        ],
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.apartment,size: 14),
                          gapWC(5),
                          tcn(buildcode.toString(), txtColor, 12),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.apartment,size: 14),
                          gapWC(3),
                          tcn(apartment.toString(), txtColor, 12),
                        ],
                      ),
                    ],
                  ),

                  Divider(),
                  Expanded(
                    child: Column(
                      children: wBookingItemList(),
                    ),
                  ),

                  CommonButton(btnName: "Delivery Order", onTap: (){
                    Get.back();
                    Get.to(()=>HmeDeliveryOrder(bookingNumber: bookingNumb,) );


                  },btnColor: subColor,txtColor: white),
                  gapHC(5),
                  CommonButton(btnName: "Sales Invoice", onTap: (){
                    Get.back();
                    Get.to(()=>HmeSales(bookingNumber: bookingNumb,) );
                  },btnColor: subColor,txtColor: white,)






                ],
              ),


            ));
          },

        )

    );
    // apiProductTypeDetails(34, callback);

  }

  wBookingItemList() {
    List<Widget> rtnBookingItemList = [];
    for (var e in assignmentController.bookingItemList.value) {

      rtnBookingItemList.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecorationS(white, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tcn(e["STOCK_DESC"].toString(), txtColor, 12),
                  tcn(e["QTY1"].toString(), txtColor, 12),
                ],
              ),
            ),
          ));

    }

    return rtnBookingItemList;
  }



}




