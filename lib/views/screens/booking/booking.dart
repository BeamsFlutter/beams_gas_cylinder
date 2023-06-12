// import 'package:beams_gas_cylinder/views/screens/home/controller/home_controller.dart';
// import 'package:beams_gas_cylinder/views/styles/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounce/flutter_bounce.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../../components/bottomNavigationBar/bottom_navigator_item.dart';
// import '../../components/common/Roundinputfield.dart';
// import '../../components/common/common.dart';
// import '../../components/common/tabButton.dart';
//
// class BookingScreen extends StatefulWidget {
//   const BookingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }
//
// class _BookingScreenState extends State<BookingScreen> {
//   late PageController pageController;
//   RxInt selectedPage = 0.obs;
//   var lstrSelectedPage = "CD".obs;
//   var txtCustomerName = TextEditingController();
//   RxString ctmrApartmentDescp = "".obs;
//   RxString ctmrBuildingDescp = "".obs;
//   var wstrPageMode = "VIEW".obs;
//   final txtCustomerCode = TextEditingController().obs;
//   var txtContactNo = TextEditingController();
//   var txtRemark = TextEditingController();
//   var txtLandmark = TextEditingController();
//   var txtAddress = TextEditingController();
//   RxString frBuildingCode = "".obs;
//   RxString frApartmentCode = "".obs;
//   var lstrPriority = '';
//   RxList priorityList = [].obs;
//   final HomeController homeController = Get.put(HomeController());
//   @override
//   void initState() {
//     pageController = PageController();
//     wstrPageMode.value = 'VIEW';
//     // TODO: implement initState
//     super.initState();
//   }
//
//   setselectedRadioId(var val, name) {
//     setState(() {
//       lstrPriority = name;
//     });
//   }
//
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Obx(() => Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             leading: IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.arrow_back_ios_new_outlined, color: black),
//             ),
//             flexibleSpace: Container(
//               decoration: boxDecoration(bgColor, 0),
//             ),
//             title: tcn('Booking', black, 20),
//             actions: const [
//               Padding(
//                 padding: EdgeInsets.all(12.0),
//               ),
//             ],
//           ),
//           body: Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [Icon(Icons.tag), tc('BK1256300', black, 15)],
//                     ),
//                     tc(setDate(13, DateTime.now()).toString().toUpperCase(),
//                         txtColor, 10),
//                   ],
//                 ),
//                 gapHC(25),
//                 Container(
//                   decoration: boxBaseDecoration(bgColor, 30),
//                   padding: EdgeInsets.all(5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.place,
//                             color: primaryColor,
//                           ),
//                           tcn('Al Nahda', black, 13)
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.circle,
//                             color: primaryColor,
//                           ),
//                           tcn('Emergency', black, 13)
//                         ],
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 15),
//                         decoration: boxDecoration(Colors.green.shade500, 10),
//                         child: tcn('Assigned', Colors.white, 13),
//                       )
//                     ],
//                   ),
//                 ),
//                 gapH(),
//                 Container(
//                   margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//                   decoration: boxDecoration(primaryColor, 10),
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 6.0,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TabButton(
//                           width: 0.3,
//                           text: "Customer",
//                           pageNumber: 0,
//                           selectedPage: selectedPage.value,
//                           onPressed: () {
//                             lstrSelectedPage.value = "CD";
//                             changePage(0);
//                           },
//                           icon: Icons.person_outline_rounded),
//                       TabButton(
//                           width: 0.3,
//                           text: " Items",
//                           pageNumber: 1,
//                           selectedPage: selectedPage.value,
//                           onPressed: () {
//                             lstrSelectedPage.value = "CI";
//                             changePage(1);
//                           },
//                           icon: Icons.shopping_cart_outlined),
//                       TabButton(
//                           width: 0.3,
//                           text: " Delivery",
//                           pageNumber: 2,
//                           selectedPage: selectedPage.value,
//                           onPressed: () {
//                             lstrSelectedPage.value = "DD";
//                             changePage(2);
//                           },
//                           icon: Icons.fire_truck),
//                     ],
//                   ),
//                 ),
//                 gapH(),
//                 Expanded(
//                   child: Container(
//                     width: size.width,
//                     decoration: boxDecoration(white, 15),
//                     margin: const EdgeInsets.only(
//                         left: 15.0, right: 10.0, bottom: 5.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: PageView(
//                             onPageChanged: (int page) {
//                               selectedPage.value = page;
//                             },
//                             controller: pageController,
//                             children: [
//                               // 1st page design ------ Choose Item
//                               Customertab(),
//                               //2nd Page  design -----------------------------------
//                               Itemtab(),
//                               // 3rd Page for Delivery Details
//                               Deliverytab()
//                               // Container for  1st page   design -----------------------------------
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           bottomNavigationBar: (wstrPageMode.value == "VIEW")
//               ? BottomNavigationItem(
//                   type: "booking",
//                   mode: wstrPageMode.value,
//                   fnAdd: homeController.fnAdd,
//                   fnEdit: homeController.fnEdit,
//                   fnCancel: homeController.fnCancel,
//                   fnPage: homeController.fnPage,
//                   fnSave: homeController.fnSave,
//                   fnDelete: homeController.fnDelete,
//                 )
//               : (wstrPageMode.value == "ADD" || wstrPageMode.value == "EDIT")
//                   ? Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Bounce(
//                               onPressed: () {
//                                 // dprint("BUILDING CODE  ${commonController.wstrBuildingCode.value}");
//                                 // dprint("APRTMNT CODE  ${commonController.wstrAprtmntCode.value}");
//
//                                 fnSave(context);
//                               },
//                               duration: const Duration(milliseconds: 110),
//                               child: Container(
//                                 decoration: boxDecoration(primaryColor, 30),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(
//                                       Icons.task_alt,
//                                       color: Colors.white,
//                                       size: 15,
//                                     ),
//                                     gapWC(5),
//                                     tcn('Save', Colors.white, 15)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Bounce(
//                             onPressed: () {
//                               fnCancel();
//                             },
//                             duration: const Duration(milliseconds: 110),
//                             child: Container(
//                               decoration: boxBaseDecoration(baseLight, 30),
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.cancel_outlined,
//                                     color: Colors.black,
//                                     size: 15,
//                                   ),
//                                   gapWC(5),
//                                   tcn('Cancel', Colors.black, 12)
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : const BottomAppBar(),
//         ));
//   }
//
//   changePage(int pageNum) {
//     selectedPage.value = pageNum;
//     pageController.animateToPage(
//       pageNum,
//       duration: const Duration(milliseconds: 1000),
//       curve: Curves.fastLinearToSlowEaseIn,
//     );
//
//     if (pageNum == 0) {
//       lstrSelectedPage.value = "CD";
//     }
//
//     if (pageNum == 1) {
//       lstrSelectedPage.value = "CI";
//     }
//
//     if (pageNum == 2) {
//       lstrSelectedPage.value = "DD";
//     }
//   }
//
//   Widget Customertab() {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 3),
//       width: size.width,
//       height: size.height * 0.5,
//       child: SingleChildScrollView(
//           child: Obx(
//         () => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             tc('Customer Details', txtColor, 12),
//             gapHC(5),
//             Bounce(
//               onPressed: () {},
//               duration: const Duration(milliseconds: 110),
//               child: Container(
//                 decoration: boxOutlineCustom(
//                     Colors.white, 5, Colors.blueGrey.withOpacity(0.5)),
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.account_circle_outlined,
//                               color: Colors.black,
//                               size: 12,
//                             ),
//                             gapWC(5),
//                             tc(txtCustomerName.text, Colors.black, 12)
//                           ],
//                         ),
//                         const Icon(
//                           Icons.search,
//                           color: txtColor,
//                           size: 15,
//                         )
//                       ],
//                     ),
//                     const Divider(),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         tc("${ctmrApartmentDescp.value}|${ctmrBuildingDescp.value}",
//                             Colors.black, 12),
//                         wstrPageMode.value != "VIEW"
//                             ? Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       tcn('Credit Balance', Colors.black, 10)
//                                     ],
//                                   ),
//                                   Container(
//                                     height: 20,
//                                     width: 1,
//                                     decoration: boxDecoration(Colors.black, 10),
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       tcn('Balance Coupon', Colors.black, 10)
//                                     ],
//                                   ),
//                                 ],
//                               )
//                             : gapHC(0),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             gapHC(10),
//             //  wRoundedInputField(bookingController.txtCustomerCode.value, "Customer Code","N"),
//             gapHC(10),
//
//             tc("Customer Code", txtColor, 12),
//             gapHC(5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: wstrPageMode.value != 'VIEW'
//                         ? 260
//                         : MediaQuery.of(context).size.width - 60,
//                     child: TextFormField(
//                       controller: txtCustomerCode.value,
//                       maxLines: 1,
//                       decoration: InputDecoration(
//                         enabled: false,
//                         hintText: 'Customer Code',
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               width: 1,
//                               color: Colors.blueGrey
//                                   .withOpacity(0.5)), //<-- SEE HERE
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 gapWC(10),
//                 wstrPageMode.value != 'VIEW'
//                     ? GestureDetector(
//                         onTap: () {},
//                         child: Container(
//                           height: 40,
//                           width: size.width * 0.12,
//                           decoration: boxDecoration(bgColor, 10),
//                           child: const Center(
//                             child: Icon(
//                               Icons.close,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       )
//                     : gapHC(0)
//               ],
//             ),
//
//             gapHC(10),
//
//             wRoundedInputField(txtCustomerName, "Customer Name", "N"),
//             gapHC(10),
//             wRoundedInputField(txtContactNo, "Contact No", "N"),
//
//             gapHC(10),
//             tc("Building Code", txtColor, 12),
//             gapHC(5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: wstrPageMode.value != 'VIEW'
//                         ? 260
//                         : MediaQuery.of(context).size.width - 60,
//                     child: Bounce(
//                       onPressed: () {},
//                       duration: const Duration(milliseconds: 110),
//                       child: Container(
//                         padding: const EdgeInsets.all(5),
//                         decoration: boxOutlineCustom(
//                             Colors.white, 5, Colors.blueGrey.withOpacity(0.5)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onLongPress: () {
//                                     // salesController.  fnFillCustomerData(
//                                     //     [], "APARTMENT");
//                                   },
//                                   child: Container(
//                                       padding: const EdgeInsets.all(7),
//                                       decoration:
//                                           boxBaseDecoration(greyLight, 5),
//                                       child: const Icon(
//                                         Icons.apartment,
//                                         color: txtColor,
//                                         size: 25,
//                                       )),
//                                 ),
//                                 gapWC(10),
//                                 Expanded(
//                                     child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     //  tc('Building Code', color2, 12),
//
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         tc(frBuildingCode.value, txtColor, 10),
//                                       ],
//                                     )
//                                   ],
//                                 )),
//                                 Container(
//                                     padding: const EdgeInsets.all(7),
//                                     child: const Icon(
//                                       Icons.search,
//                                       color: txtColor,
//                                       size: 15,
//                                     )),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 gapWC(10),
//                 wstrPageMode.value != 'VIEW'
//                     ? GestureDetector(
//                         onTap: () {},
//                         child: Container(
//                           height: 40,
//                           width: size.width * 0.12,
//                           decoration: boxDecoration(primaryColor, 10),
//                           child: const Center(
//                             child: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       )
//                     : gapHC(0)
//               ],
//             ),
//
//             gapHC(10),
//             tc("Apartment", txtColor, 12),
//             gapHC(5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: wstrPageMode.value != 'VIEW' &&
//                             frBuildingCode.value != ""
//                         ? 260
//                         : MediaQuery.of(context).size.width - 60,
//                     child: Bounce(
//                       onPressed: () {},
//                       duration: const Duration(milliseconds: 110),
//                       child: Container(
//                         padding: const EdgeInsets.all(5),
//                         decoration: boxOutlineCustom(
//                             Colors.white, 5, Colors.blueGrey.withOpacity(0.5)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onLongPress: () {},
//                                   child: Container(
//                                       padding: const EdgeInsets.all(7),
//                                       decoration:
//                                           boxBaseDecoration(greyLight, 5),
//                                       child: const Icon(
//                                         Icons.apartment,
//                                         color: txtColor,
//                                         size: 25,
//                                       )),
//                                 ),
//                                 gapWC(10),
//                                 Expanded(
//                                     child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     //  tc('Building Code', color2, 12),
//
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         tc(frApartmentCode.value, txtColor, 10),
//                                       ],
//                                     )
//                                   ],
//                                 )),
//                                 Container(
//                                     padding: const EdgeInsets.all(7),
//                                     child: const Icon(
//                                       Icons.search,
//                                       color: txtColor,
//                                       size: 15,
//                                     )),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 gapWC(10),
//                 wstrPageMode.value != 'VIEW' && frBuildingCode.value != ""
//                     ? GestureDetector(
//                         onTap: () {},
//                         child: Container(
//                           height: 40,
//                           width: size.width * 0.12,
//                           decoration: boxDecoration(primaryColor, 10),
//                           child: const Center(
//                             child: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       )
//                     : gapHC(0)
//               ],
//             ),
//             gapHC(10),
//             tc("AreaCode", txtColor, 12),
//             gapHC(5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: wstrPageMode.value != 'VIEW' &&
//                             frBuildingCode.value != ""
//                         ? 260
//                         : MediaQuery.of(context).size.width - 60,
//                     child: Bounce(
//                       onPressed: () {},
//                       duration: const Duration(milliseconds: 110),
//                       child: Container(
//                         padding: const EdgeInsets.all(5),
//                         decoration: boxOutlineCustom(
//                             Colors.white, 5, Colors.blueGrey.withOpacity(0.5)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onLongPress: () {},
//                                   child: Container(
//                                       padding: const EdgeInsets.all(7),
//                                       decoration:
//                                           boxBaseDecoration(greyLight, 5),
//                                       child: const Icon(
//                                         Icons.apartment,
//                                         color: txtColor,
//                                         size: 25,
//                                       )),
//                                 ),
//                                 gapWC(10),
//                                 Expanded(
//                                     child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     //  tc('Building Code', color2, 12),
//
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         tc(frApartmentCode.value, txtColor, 10),
//                                       ],
//                                     )
//                                   ],
//                                 )),
//                                 Container(
//                                     padding: const EdgeInsets.all(7),
//                                     child: const Icon(
//                                       Icons.search,
//                                       color: txtColor,
//                                       size: 15,
//                                     )),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 gapWC(10),
//                 wstrPageMode.value != 'VIEW' && frBuildingCode.value != ""
//                     ? GestureDetector(
//                         onTap: () {},
//                         child: Container(
//                           height: 40,
//                           width: size.width * 0.12,
//                           decoration: boxDecoration(primaryColor, 10),
//                           child: const Center(
//                             child: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       )
//                     : gapHC(0)
//               ],
//             ),
//             gapHC(10),
//             wRoundedInputField(txtRemark, "Remark", "N"),
//             gapHC(10),
//             wRoundedInputField(txtLandmark, "Landmark", "N"),
//             gapHC(10),
//
//             wRoundedInputField(txtAddress, "Address", "N"),
//           ],
//         ),
//       )),
//     );
//   }
//
//   wRoundedInputField(contrlr, hintTxt, lookup) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         tc(hintTxt, txtColor, 12),
//         gapHC(5),
//         TextFormField(
//           controller: contrlr,
//           maxLines: hintTxt == "Address" ? 5 : 1,
//           decoration: InputDecoration(
//             suffixIcon: wstrPageMode.value != 'VIEW' && lookup == "Y"
//                 ? Icon(Icons.search)
//                 : null,
//             enabled: wstrPageMode.value == 'VIEW' || hintTxt == "Customer Code"
//                 ? false
//                 : true,
//             hintText: hintTxt,
//             border: OutlineInputBorder(
//               borderSide: BorderSide(
//                   width: 1,
//                   color: Colors.blueGrey.withOpacity(0.5)), //<-- SEE HERE
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   fnSave(context) {}
//
//   fnCancel() {}
//
//   Widget Itemtab() {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: boxDecoration(bgColor, 30),
//           child: Row(
//             children: [
//               Flexible(
//                   flex: 3,
//                   child: Row(
//                     children: [tcn('Item', Colors.black, 10)],
//                   )),
//               Flexible(
//                   flex: 1,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [tcn('N/R', Colors.black, 10)],
//                   )),
//               Flexible(
//                   flex: 1,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [tcn('Rate', Colors.black, 10)],
//                   )),
//               Flexible(
//                   flex: 1,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [tcn('Qty', Colors.black, 10)],
//                   )),
//               Flexible(
//                   flex: 1,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [tcn('Total', Colors.black, 10)],
//                   )),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget Deliverytab() {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             decoration: boxDecoration(bgColor, 2),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.priority_high),
//                     tc('Priority', black, 20)
//                   ],
//                 ),
//                 GetBuilder<HomeController>(builder: (controller) {
//                   return Column(
//                     children: controller.priorityList
//                         .asMap()
//                         .entries
//                         .map((e) => RadioListTile(
//                               title: tcn(
//                                   e.value["PNAME"].toString(), txtColor, 12),
//                               value: e.value["PNAME"],
//                               groupValue: homeController.priorityvalue.value,
//                               onChanged: controller.onClickRadioButton,
//                               activeColor: Colors.black,
//                             ))
//                         .toList(),
//                   );
//                 })
//               ],
//             ),
//           ),
//           gapH(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               tc('Delivery Required date', txtColor, 12),
//               Bounce(
//                 duration: const Duration(milliseconds: 110),
//                 onPressed: () {},
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.calendar_month,
//                       color: Colors.black,
//                       size: 15,
//                     ),
//                     gapWC(5),
//                     tc(setDate(15, DateTime.now()).toString().toUpperCase(),
//                         txtColor, 12)
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           gapH(),
//           tc('Driver', black, 15),
//           gapHC(5),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Container(
//                   width:
//                       wstrPageMode.value != 'VIEW' && frBuildingCode.value != ""
//                           ? 260
//                           : MediaQuery.of(context).size.width - 60,
//                   child: Bounce(
//                     onPressed: () {},
//                     duration: const Duration(milliseconds: 110),
//                     child: Container(
//                       padding: const EdgeInsets.all(5),
//                       decoration: boxOutlineCustom(
//                           Colors.white, 5, Colors.blueGrey.withOpacity(0.5)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               GestureDetector(
//                                 onLongPress: () {},
//                                 child: Container(
//                                     padding: const EdgeInsets.all(7),
//                                     decoration: boxBaseDecoration(greyLight, 5),
//                                     child: const Icon(
//                                       Icons.fire_truck,
//                                       color: txtColor,
//                                       size: 25,
//                                     )),
//                               ),
//                               gapWC(10),
//                               Expanded(
//                                   child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   //  tc('Building Code', color2, 12),
//
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       tc(frApartmentCode.value, txtColor, 10),
//                                     ],
//                                   )
//                                 ],
//                               )),
//                               Container(
//                                   padding: const EdgeInsets.all(7),
//                                   child: const Icon(
//                                     Icons.search,
//                                     color: txtColor,
//                                     size: 15,
//                                   )),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               gapWC(10),
//               wstrPageMode.value != 'VIEW' && frBuildingCode.value != ""
//                   ? GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         height: 40,
//                         width: size.width * 0.12,
//                         decoration: boxDecoration(primaryColor, 10),
//                         child: const Center(
//                           child: Icon(
//                             Icons.add,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     )
//                   : gapHC(0)
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   //===================================WIDGET
//   List<Widget> wPriorityLIst(controller) {
//     List<Widget> rtnList = [];
//     for (var e in controller.priorityList) {
//       var code = e["CODE"];
//       var det = (e["PNAME"] ?? "");
//       rtnList.add(ListTile(
//         contentPadding: EdgeInsets.zero,
//         title: Transform.translate(
//           offset: Offset(-20, 0),
//           child: tcn(det.toString(), txtColor, 12),
//         ),
//         leading: Radio(
//             value: code.toString(),
//             activeColor: Colors.red,
//             groupValue: controller.priorityvalue,
//             onChanged: (value) => controller.onClickRadioButton(value)),
//       ));
//     }
//     return rtnList;
//   }
// }
