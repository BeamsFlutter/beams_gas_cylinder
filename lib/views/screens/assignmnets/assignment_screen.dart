import 'package:beams_gas_cylinder/views/screens/assignmnets/controller/assignmnet_controller.dart';
import 'package:flutter/material.dart';
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
    return Center(
      child: tc("Pending", txtColor, 12),
    );
  }

  allAssignmnt() {
    return Center(
    child: tc("ALLL", txtColor, 12),
    );
  }
}

todayAssignmnt() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
 children: [
     tc("Emergency", txtColor, 12),
     gapHC(3),
     Flexible(
       child: Column(
         children: [
           Container(
             height: 60,
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: bgColor),
           ),
           gapHC(3),
           Container(
             height: 60,
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: bgColor),
           ),
           gapHC(3),

         ],
       ),
     ),
   tc("Others", txtColor, 12),
   gapHC(3),
   Column(
     children: [
       Container(
         height: 60,
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: bgColor),
       ),
       gapHC(3),
       Container(
         height: 60,
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: bgColor),
       ),
       gapHC(3),
       Container(
         height: 60,
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: bgColor),
       ),
       gapHC(3),
       Container(
         height: 60,
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: bgColor),
       ),
     ],
   )

 ],
    ),
  );
}
