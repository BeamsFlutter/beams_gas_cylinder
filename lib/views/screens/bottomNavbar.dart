import 'package:beams_gas_cylinder/views/components/common/commonButton.dart';
import 'package:beams_gas_cylinder/views/screens/assignmnets/assignment_screen.dart';
import 'package:beams_gas_cylinder/views/screens/assignmnets/controller/assignmnet_controller.dart';
import 'package:beams_gas_cylinder/views/screens/home/controller/hmAssignmntController.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmAssignmnt.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmBooking.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmCollection.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmContract.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmContractRecipt.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmDeliveryOrder.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmReport.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmSalesOrder.dart';
import 'package:beams_gas_cylinder/views/screens/home/screens/hmSalse.dart';
import 'package:beams_gas_cylinder/views/screens/report/screens/RepAssignment.dart';
import 'package:beams_gas_cylinder/views/screens/report/screens/RepBooking.dart';
import 'package:beams_gas_cylinder/views/screens/report/screens/RepCollection.dart';
import 'package:beams_gas_cylinder/views/screens/report/screens/RepCustomerbalanceScreen.dart';
import 'package:beams_gas_cylinder/views/screens/report/screens/RepDailySales.dart';
import 'package:beams_gas_cylinder/views/screens/report/screens/RepOthers.dart';
import 'package:beams_gas_cylinder/views/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/common/common.dart';
import '../styles/colors.dart';
import 'home/controller/home_controller.dart';
import 'package:badges/badges.dart' as badges;

class BottomnavBar extends StatefulWidget {
  const BottomnavBar({super.key});

  @override
  State<BottomnavBar> createState() => _BottomnavBarState();
}

class _BottomnavBarState extends State<BottomnavBar> {
  final HmAssignmentController hmAssignmentController = Get.put(HmAssignmentController());
  final AssignmentController assignmentController = Get.put(AssignmentController());
  var pages = [];
  final GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  void initState() {
    Future.delayed(const Duration(
        seconds: 3
    ),assignmentController.apiGetAssignment()
    );

    pages = [
      const AssignmentScreen(),
      wHome(),
      wReport(),
      const SettingsScreen()];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Scaffold(
        key: key,
        backgroundColor: bgColor,
        drawer:  wDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              gapHC(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: () {
                        key.currentState!.openDrawer();
                      },
                      child: const Icon(Icons.segment, color: Colors.black, size: 25)),
                  Bounce(
                    duration: const Duration(milliseconds: 110),
                    onPressed: (){
                      dprint("SignOut.......");
                    },
                    child: const Icon(
                      Icons.power_settings_new_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),
              gapHC(15),
              Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Good Morning,',
                              style: TextStyle(color: white, fontSize: 15)),
                          TextSpan(
                            text: ' ${hmAssignmentController.g.wstrUsername.toString()}',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: white,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    tcn(setDate(15, DateTime.now()), white, 17),
                    gapHC(10),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                tcn("Delivered", white, 14),
                                gapWC(5),
                                tc("18", white, 16),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15),
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                tcn("Pending", white, 14),
                                gapWC(20),
                                tc("24", white, 16),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              gapHC(10),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: pages[hmAssignmentController.pageIndex.value],
                  )),
              // wHome()
            ],
          ),
        ),
        bottomNavigationBar: buildMyNavBar(context),
      )),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade400, blurRadius: 10, spreadRadius: 6),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Bounce(
            onPressed: () {
              assignmentController.apiGetAssignment();
              hmAssignmentController.pageIndex.value = 0;

            },
            duration: const Duration(milliseconds: 110),
            child: hmAssignmentController.pageIndex.value == 0
                ? badges.Badge(
              showBadge: assignmentController.todayAssignedList.value.isEmpty?false:true,
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                padding: const EdgeInsets.all(7),
                borderRadius: BorderRadius.circular(1),
              ),
              badgeContent: tcn(assignmentController.todayAssignedList.value.length.toString(), white, 10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade300),
                child: Row(
                  children: [
                    const Icon(Icons.assignment,
                        size: 20, color: primaryColor),
                    gapWC(5),
                    tc("Assignments", black, 12)
                  ],
                ),
              ),
            )
                : badges.Badge(
              showBadge: assignmentController.todayAssignedList.value.isEmpty?false:true,
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                padding: const EdgeInsets.all(7),
                borderRadius: BorderRadius.circular(1),
              ),
              badgeContent: tcn(assignmentController.todayAssignedList.value.length.toString(), white, 10),
              child: const Icon(
                Icons.assignment,
                size: 25,
              ),
            ),
          ),
          Bounce(
            onPressed: () {
              hmAssignmentController.pageIndex.value = 1;
            },
            duration: const Duration(milliseconds: 110),
            child: hmAssignmentController.pageIndex.value == 1
                ? Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade300),
              child: Row(
                children: [
                  const Icon(Icons.home, size: 20, color: primaryColor),
                  gapWC(5),
                  tc("Home", black, 12)
                ],
              ),
            )
                : const Icon(
              Icons.home,
              size: 25,
            ),
          ),
          Bounce(
            onPressed: () {
              hmAssignmentController.pageIndex.value = 2;
            },
            duration: const Duration(milliseconds: 110),
            child: hmAssignmentController.pageIndex.value == 2
                ? Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade300),
              child: Row(
                children: [
                  const Icon(Icons.bar_chart,
                      size: 20, color: primaryColor),
                  gapWC(5),
                  tc("Report", black, 12)
                ],
              ),
            )
                : const Icon(
              Icons.bar_chart,
              size: 25,
            ),
          ),
          Bounce(
            onPressed: () {
              hmAssignmentController.pageIndex.value = 3;
            },
            duration: const Duration(milliseconds: 110),
            child: hmAssignmentController.pageIndex.value == 3
                ? Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade300),
              child: Row(
                children: [
                  const Icon(Icons.settings,
                      size: 20, color: primaryColor),
                  gapWC(5),
                  tc("Settings", black, 12)
                ],
              ),
            )
                : const Icon(
              Icons.settings,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }



  wReport() {
    return   GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0,physics: BouncingScrollPhysics(),
        mainAxisSpacing: 2.0,
        shrinkWrap: false,
        children: wReportButtons(context)


    );
  }

  wHome() {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 2.0,physics: BouncingScrollPhysics(),
              mainAxisSpacing: 2.0,
              shrinkWrap: false,
              children: wHomeButtons(context)


          ),
        ),        gapHC(10),

        wCollCard("Report", Icons.report, 44, (){
          Get.to(()=>HmReport());

        }),
        gapHC(10),


      ],
    );
  }

  wDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: tc("Name", white, 12),
            accountEmail: tc("abc@gmail.com", white, 12),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: tc("A", primaryColor, 40),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_month_outlined, color: black),
                    title: const Text("Booking"),
                    onTap: () {

                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment, color: black),
                    title: const Text("Assignment"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.delivery_dining, color: black),
                    title: const Text("Delivery Order"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.point_of_sale, color: black),
                    title: const Text("Sales"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart, color: black),
                    title: const Text("Report"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: black),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading:
                    const Icon(Icons.info_outline_rounded, color: black),
                    title: const Text("AppInfo"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
            child: CommonButton(
                btnName: "SignOut ",
                btnColor: primaryColor,
                iconYN: true,
                iconSize: 23,
                icon: Icons.power_settings_new,
                txtColor: white,
                onTap: () {}),
          ),
          tcn("Beams  V1.0.1", txtColor, 12),
          gapHC(5)
        ],
      ),
    );
  }

  wMenuCard(title, icon, double iconSize,VoidCallback onTap) {
    return Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: subColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,


                  color: subColor.withOpacity(0.8), size: iconSize),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tc(title, subColor, 14),
                ],
              ),
            ],
          ),
        ));
  }

  wCollCard(title, icon, double iconSize,onTap) {
    return Bounce(
        duration: const Duration(milliseconds: 110),
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: subColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tc(title, subColor, 14),
              Icon(icon, color: subColor, size: iconSize),
            ],
          ),
        ));
  }

List<Widget> wHomeButtons(context){
  List<Widget> rtnList =[];

  for(var e  in hmAssignmentController.hmButtonsList){



    var buttonName  = (e["ButtonName"]??"").toString();
    var buttonCode = (e["ButtonCode"]??"").toString();


    rtnList.add(

        wMenuCard(buttonName,
            (buttonCode=="B")?Icons.calendar_month_outlined:(buttonCode=="C")?Icons.handshake_outlined:(buttonCode=="CR")?Icons.receipt:(buttonCode=="SO")?Icons.point_of_sale:
            (buttonCode=="A")?Icons.assignment:(buttonCode=="DO")?Icons.delivery_dining:(buttonCode=="CB")?Icons.account_balance_wallet_outlined:Icons.point_of_sale_sharp,
            55.0,
              (buttonCode=="B")?(){
                Get.to(()=>HmeBooking());

              }:(buttonCode=="CN")?(){
                Get.to(()=>HmeCollections());
              }:(buttonCode=="CR")?(){
               Get.to(()=> HmeContractRecipt(contractNumber: "",));

                dprint("Contract recipt");
              }:(buttonCode=="SO")?(){
                Get.to(()=> HmeSalesOrder());
                     dprint("SAlesOrder");
              }:
              (buttonCode=="A")?(){
                Get.to(()=>HmeAssignmnet());
              }:(buttonCode=="DO")?(){
                Get.to(()=>HmeDeliveryOrder());
              }:
              (buttonCode=="C")?(){
                dprint("Contract");
               Get.to(()=>HmeContract());
              }:
              (buttonCode=="S")?(){

                 Get.to(()=>HmeSales());
              }:
              (buttonCode=="CB")?(){

                Get.to(()=>RepCustomerBalanceScreen());
              }:
                  (){
                // Get.to(()=>HmeBooking());




    }));

  }

  return rtnList;
}
List<Widget> wReportButtons(context){
  List<Widget> rtnList =[];

  for(var e  in hmAssignmentController.repButtonsList){



    var buttonName  = (e["ButtonName"]??"").toString();
    var buttonCode = (e["ButtonCode"]??"").toString();


    rtnList.add(

        wMenuCard(buttonName,
            (buttonCode=="DS")?Icons.calendar_month_outlined:(buttonCode=="CN")?Icons.featured_play_list_outlined:(buttonCode=="A")?Icons.assignment:(buttonCode=="B")?Icons.calendar_month_outlined:
            (buttonCode=="CB")?Icons.account_balance_wallet_outlined:Icons.more_horiz,
            55.0,  (buttonCode=="B")?(){
              Get.to(()=>RepBookingScreen());

            }:(buttonCode=="CN")?(){
              Get.to(()=>RepCollectionScreen());
            }:(buttonCode=="DS")?(){
              Get.to(()=>RepDailySalesScreen());
            }:(buttonCode=="A")?(){
              Get.to(()=>RepAssignmentScreen());
            }:
            (buttonCode=="CB")?(){
              Get.to(()=>RepCustomerBalanceScreen());
            }:(){
              Get.to(()=>RepOthers());
            }

    ));

  }

  return rtnList;
}


}
