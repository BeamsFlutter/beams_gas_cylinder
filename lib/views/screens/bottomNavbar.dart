import 'package:beams_gas_cylinder/views/components/common/commonButton.dart';
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
  final HomeController homeController = Get.put(HomeController());
  var pages = [];
  @override
  void initState() {
    pages = [wAssignmnt(), wHome(), wReport(), const SettingsScreen()];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Scaffold(
            backgroundColor: bgColor,
            drawer: wDrawer(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  gapHC(20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.segment, color: Colors.black, size: 25),
                      Icon(
                        Icons.power_settings_new_outlined,
                        color: Colors.black,
                        size: 25,
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
                                text: ' Beams',
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
                  Expanded(child: Padding(padding: EdgeInsets.only(bottom: 10),child: pages[homeController.pageIndex.value],)),
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
              homeController.pageIndex.value = 0;
            },
            duration: const Duration(milliseconds: 110),
            child: homeController.pageIndex.value == 0
                ? badges.Badge(
                    showBadge: true,
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      padding: const EdgeInsets.all(7),
                      borderRadius: BorderRadius.circular(1),
                    ),
                    badgeContent: tcn("6", white, 10),
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
                : const Icon(
                    Icons.assignment,
                    size: 25,
                  ),
          ),
          Bounce(
            onPressed: () {
              homeController.pageIndex.value = 1;
            },
            duration: const Duration(milliseconds: 110),
            child: homeController.pageIndex.value == 1
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
              homeController.pageIndex.value = 2;
            },
            duration: const Duration(milliseconds: 110),
            child: homeController.pageIndex.value == 2
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
              homeController.pageIndex.value = 3;
            },
            duration: const Duration(milliseconds: 110),
            child: homeController.pageIndex.value == 3
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

  wAssignmnt() {
    return Container(
      child: tc("Assignmnetr", black, 12),
    );
  }

  wReport() {
    return Container(

      decoration: boxDecoration(bgColor, 12),

      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    wMenuCard("Booking",Icons.calendar_month,55.0),
                    gapWC(10),
                    wMenuCard("Assignment",Icons.assignment,55.0)
                  ],
                ),
              ),
              gapHC(10),
              Flexible(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    wMenuCard("Delivery Order",Icons.delivery_dining,55.0),
                    gapWC(10),
                    wMenuCard("Sales",Icons.point_of_sale,55.0),
                  ],
                ),
              ),
              gapHC(10),


            ],
          )
      ),
    );
  }

  wHome() {
    return Container(

      decoration: boxDecoration(bgColor, 12),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible( 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  wMenuCard("Booking",Icons.calendar_month,55.0),
                  gapWC(10),
                  wMenuCard("Assignment",Icons.assignment,55.0)
                ],
              ),
            ),
            gapHC(10),
            Flexible(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  wMenuCard("Delivery Order",Icons.delivery_dining,55.0),
                  gapWC(10),
                  wMenuCard("Sales",Icons.point_of_sale,55.0),
                ],
              ),
            ),
            gapHC(10),
            wCollCard("Collections", Icons.collections_bookmark, 25),
            gapHC(10),
            wCollCard("Reports", Icons.arrow_forward_ios_outlined, 25)
          ],
        )
      ),
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
                    leading: const Icon(Icons.receipt_long_sharp, color: black),
                    title: const Text("Home"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.history, color: black),
                    title: const Text("History"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart,
                        color: black),
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

  wMenuCard(title,icon,double iconSize) {
    return Flexible(
      child: Bounce(
          duration: const Duration(milliseconds: 110),
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
                color: subColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,color: subColor.withOpacity(0.8),size: iconSize),
                gapHC(3),
                tc(title, subColor, 14),
              ],
            )),
          )),
    );
  }
  wCollCard(title,icon,double iconSize) {
    return Flexible(
      child: Bounce(
          duration: const Duration(milliseconds: 110),
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: subColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tc(title, subColor, 14),
                Icon(icon,color: subColor,size: iconSize),


              ],
            ),
          )),
    );
  }
}
