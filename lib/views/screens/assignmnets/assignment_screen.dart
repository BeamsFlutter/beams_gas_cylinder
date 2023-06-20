import 'package:beams_gas_cylinder/views/screens/assignmnets/controller/assignmnet_controller.dart';
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
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Obx(() => Container(
  
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
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
                        assignmentController.lstrSelectedPage .value= "PD";
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
              ),
            ),
          ),
        ],
      ),
    ));
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
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tc("Emergency", txtColor, 12),
            gapHC(3),
            Column(

                children: wPendingAssignedList()
            ),
          ],
        ),
      ),
    );
  }

  allAssignmnt() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tc("Emergency", txtColor, 12),
          gapHC(3),
          Column(
              children: wAllAssignedList()
          ),
        ],
      ),
    );
  }

  todayAssignmnt() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tc("Emergency", txtColor, 12),
            gapHC(3),
            Column(
              children: wEmergencyAssignedList()
            ),    gapHC(10),

            tc("Others", txtColor, 12),
            gapHC(3),
            Column(children: wOthersAssignedList()

            )


          ],
        ),
      ),
    );
  }


  List<Widget> wEmergencyAssignedList() {
    var emergncyList = assignmentController.emergencyAssignedList.value;
    List<Widget> rtnList = [] ;
    for(var e in emergncyList){
      var name = e["PartyName"];
      var buildcode = e["BuildCode"];
      var mobile = e["Mobile"];
      var apartment = e["Apartment"];
      var priority = e["Priority"];
      rtnList.add(wAssignCard(name, priority, buildcode, apartment, mobile));
    }
    return rtnList;
  }
  List<Widget> wOthersAssignedList() {
    var otherList = assignmentController.otherAssignedList.value;
    List<Widget> rtnList = [] ;
    for(var e in otherList){
      var name = e["PartyName"];
      var buildcode = e["BuildCode"];
      var priority = e["Priority"];
      var mobile = e["Mobile"];
      var apartment = e["Apartment"];
      rtnList.add(wAssignCard(name, priority, buildcode, apartment, mobile));
    }
    return rtnList;
  }

  List<Widget> wPendingAssignedList() {
    var emergncyList = assignmentController.pendingAssignedList.value;
    List<Widget> rtnList = [] ;
    for(var e in emergncyList){
      var name = e["PartyName"];
      var buildcode = e["BuildCode"];
      var mobile = e["Mobile"];
      var apartment = e["Apartment"];
      var priority = e["Priority"];
      rtnList.add(wAssignCard(name, priority, buildcode, apartment, mobile));
    }
    return rtnList;
  }
  List<Widget> wAllAssignedList() {
    var otherList = assignmentController.allAssignedList.value;
    List<Widget> rtnList = [] ;
    for(var e in otherList){
      var name = e["PartyName"];
      var buildcode = e["BuildCode"];
      var priority = e["Priority"];
      var mobile = e["Mobile"];
      var apartment = e["Apartment"];
      rtnList.add(wAssignCard(name, priority, buildcode, apartment, mobile));
    }
    return rtnList;
  }


  wAssignCard(name,priority,buildcode,apartment,mobile){
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: bgColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tc(name, txtColor, 12),
                tc(priority, txtColor, 12),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tcn(buildcode, txtColor, 12),
                tcn(apartment, txtColor, 12),
              ],
            ),
            tcn(mobile, txtColor, 12),
            Divider(),
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
                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                    decoration: boxDecorationS(subColor, 30),
                    child:       Row(
                      children: [
                        tcn("Location", white, 12),
                        Icon(Icons.location_on,color: white,size: 12),
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
                      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                      decoration: boxDecorationS(Colors.greenAccent, 30),
                      child: tcn("Open", txtColor, 12)),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }


}




