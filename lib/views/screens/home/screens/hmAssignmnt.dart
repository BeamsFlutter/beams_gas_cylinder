
import 'package:beams_gas_cylinder/views/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import 'package:get/get.dart';

import '../../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../../components/common/common.dart';
import '../../../components/common/commonTextField.dart';
import '../../../components/common/tabButton.dart';
import '../../../styles/colors.dart';
import '../controller/hmAssignmntController.dart';


class HmeAssignmnet extends StatefulWidget {
  const HmeAssignmnet({Key? key}) : super(key: key);
  @override
  State<HmeAssignmnet> createState() => _HmeAssignmnetState();
}

class _HmeAssignmnetState extends State<HmeAssignmnet> {
  final HmAssignmentController hmAssignmntController = Get.put(HmAssignmentController());


  @override
  void initState() {
    hmAssignmntController.lstrSelectedPage.value = "CB";
    hmAssignmntController.pageController = PageController();
    hmAssignmntController.selectedPage.value=0;
    hmAssignmntController.wstrPageMode.value = 'VIEW';
    hmAssignmntController.apiViewAssignment('',"LAST");




    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
      // resizeToAvoidBottomInset : false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            hmAssignmntController.fnBackPage(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: tcn('Assignment', Colors.white, 20),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: () {
                        hmAssignmntController.fnLookup("GCYLINDER_ASSIGNMENT");
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
                                tc(hmAssignmntController.frDocno.value, txtColor, 12)
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
                        tcn(hmAssignmntController.txtdocDate.text, txtColor, 12)
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
                      Row(
                        children: [
                          Bounce(
                            duration: const Duration(milliseconds: 110),
                            onPressed: () {
                              dprint("lookup>>>>>>>location");
                              if(hmAssignmntController.wstrPageMode.value  == "VIEW"){
                                return;
                              }
                              hmAssignmntController.fnLookup("AREAMASTER");
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
                                  tcn(hmAssignmntController.frLocation.value.toString(), txtColor, 13),
                                  gapWC(13),

                                ],
                              ),
                            ),
                          ),
                       hmAssignmntController.wstrPageMode.value!="VIEW" && hmAssignmntController.frLocation.value.isNotEmpty?   Bounce(
                            duration: const Duration(milliseconds: 110),
                            onPressed: (){
                              dprint("&&&&&&&");
                              hmAssignmntController.frLocation.value="";

                            },
                            child: Container(decoration: boxDecoration(primaryColor, 30),
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.clear,size: 14,color: white,)),
                          ):gapHC(0)
                        ],
                      ),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          dprint("lookup>>>>>>>Priority");
                          if(hmAssignmntController.wstrPageMode.value  == "VIEW"){
                            return;
                          }
                          hmAssignmntController.fnLookup("GPRIORITYMASTER");
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
                              tcn( hmAssignmntController.priorityvalue.value.toString(), txtColor, 13)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                gapHC(5),
                tc('Assign To', Colors.black, 13),
                gapHC(5),
                Container(
                  decoration: boxDecorationS(white, 8),

                   padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Bounce(
                              onPressed: (){
                                if(hmAssignmntController.wstrPageMode.value  == "VIEW"){
                                  return;
                                }
                                hmAssignmntController.fnLookup("CRDELIVERYMANMASTER");
                              },
                              duration: const Duration(milliseconds: 110),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.person_outline,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                          gapWC(5),
                                          Flexible(child: tcn(hmAssignmntController.frdriverName.value, Colors.black, 13))
                                        ],
                                      ),
                                    ),

                                    const Icon(Icons.search,size: 18,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          gapWC(10),
                          Flexible(
                            child: Bounce(
                              onPressed: (){
                                if(hmAssignmntController.wstrPageMode.value  == "VIEW"){
                                  return;
                                }
                                hmAssignmntController.fnLookup("CRVEHICLEMASTER");
                              },
                              duration: const Duration(milliseconds: 110),

                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.drive_eta_outlined,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        gapWC(5),
                                        tcn(hmAssignmntController.frvehiclenumber.value, Colors.black, 13)
                                      ],
                                    ),

                                    const Icon(Icons.search,size: 18,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      gapHC(10),
                      tc('Delivery Date', black, 12),
                      gapHC(5),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          if(hmAssignmntController.wstrPageMode=="VIEW"){
                            return;
                          }

                          hmAssignmntController.wSelectDate(context);
                          gapHC(5);
                        },
                        child:  CommonTextField(
                          obscureY: false,
                          textStyle: const TextStyle(color: txtColor),
                          txtController: hmAssignmntController.txtdelivryDate,
                          prefixIcon: Icons.calendar_month,
                          prefixIconColor: black,
                          sufixIconColor: Colors.black,
                          enableY:false,
                          suffixIcon: Icons.done,

                        ),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         tcn("Last Assigned", black, 12),
                      //         tcn( setDate(7, hmAssignmnt.lastAssignedDate.value).toString().toUpperCase(), txtColor, 12)
                      //
                      //       ],
                      //     ),
                      //     tc("${hmAssignmnt.pendingAssignedValue.value}/${hmAssignmnt.totalAssignedValue.value}", txtColor,22)
                      //   ],
                      // ),
                    ],
                  ),
                ),
                gapHC(10),






              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: boxDecoration(primaryColor, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabButton(
                      width: 0.3,
                      text: "Choose Booking",
                      pageNumber: 0,
                      selectedPage: hmAssignmntController.selectedPage.value,
                      onPressed: () {
                        hmAssignmntController.lstrSelectedPage.value = "CB";
                        changePage(0);
                      },

                      icon: Icons.calendar_month),
                  TabButton(
                      width: 0.3,
                      text: "Item Details",
                      pageNumber: 1,
                      selectedPage:hmAssignmntController.selectedPage.value,
                      onPressed: () {
                        hmAssignmntController.lstrSelectedPage .value= "ID";
                        changePage(1);
                      },
                      icon: Icons.all_inbox),

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
                          hmAssignmntController.selectedPage.value = page;

                        },
                        controller: hmAssignmntController.pageController,
                        children:  [
                          // 1st page design ------ Choose Item
                          chooseBookingScreen(MediaQuery.of(context).size),

                          //2nd Page  design -----------------------------------
                          itemDetailScreen()

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
      ),
      bottomNavigationBar: (hmAssignmntController.wstrPageMode.value ==
          "VIEW")
          ? BottomNavigationItem(
        mode: hmAssignmntController.wstrPageMode.value,
        fnAdd: hmAssignmntController.fnAdd,
        fnEdit: hmAssignmntController.fnEdit,
        fnCancel: hmAssignmntController.fnCancel,
        fnPage: hmAssignmntController.fnPage,
        fnSave: hmAssignmntController.fnSave,
        fnDelete: hmAssignmntController.fnDelete,
      )
          : (hmAssignmntController.wstrPageMode.value == "ADD" ||
          hmAssignmntController.wstrPageMode.value == "EDIT")
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Bounce(
                onPressed: () {
                  // dprint("BUILDING CODE  ${commonController.wstrBuildingCode.value}");
                  // dprint("APRTMNT CODE  ${commonController.wstrAprtmntCode.value}");
                  hmAssignmntController.fnSave(context);
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
                      tcn('Assign', Colors.white, 15)
                    ],
                  ),
                ),
              ),
            ),
            Bounce(
              onPressed: () {
                hmAssignmntController.fnCancel();
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


  //////////////////////////    WIDGET
  chooseBookingScreen(Size size) {

    return SingleChildScrollView(
      child: Obx(() => Container(
        margin: const EdgeInsets.only(left: 10, right: 10,top: 5),

        width: size.width,
        //height: size.height * 0.2,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

           hmAssignmntController.wstrPageMode.value!="VIEW"? Row(
              children: [
                Expanded(
                  child: Bounce(
                    duration: const Duration(milliseconds: 110),
                    onPressed: () {
                      if(hmAssignmntController.wstrPageMode.value  == "VIEW"){
                        return;
                      }
                      if( hmAssignmntController.g.wstrCylinderContractYN=="Y"){
                        hmAssignmntController.fnLookup("SO");
                      }else{
                        hmAssignmntController.fnLookup("GCYLINDER_BOOKING");
                      }
                      //
                      // hmAssignmntController.fnLookup("GCYLINDER_BOOKING");
                    },
                    child: Container (
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),   color: Colors.grey.shade200, ),
                        child:Container(

                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                           tcn(hmAssignmntController.bookingNumber.value, txtColor, 12),
                      //    hmAssignmntController.g.wstrCylinderContractYN=="Y"?tcn(hmAssignmntController.lstrBookedItemList.value[0]["BOOKINGNUMB"], txtColor, 12): tcn(hmAssignmntController.bookingNumber.value, txtColor, 12),

                              Icon(Icons.search),
                            ],
                          ),
                        )

                    ),
                  ),
                ),
                // hmAssignmnt.wstrPageMode.value=="VIEW"?gapHC(0):Checkbox(checkColor: primaryColor,
                //    value: hmAssignmnt.checkAll.value,
                //    onChanged: (bool ? checkvalu) {
                //      hmAssignmnt.checkAll.value = checkvalu!;
                //    },
                //
                //  )
              ],
            ):gapHC(0),
            gapHC(5),
            Column(
              children: wBookingDetails(),
            )
          ],
        ),
      ),)
    );

  }
  itemDetailScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: boxBaseDecoration(subColor, 5),
            //padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        tcn('Booking NO', Colors.white, 10)
                      ],
                    )),
                Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start,
                      children: [
                        tcn('Item', Colors.white, 10)
                      ],
                    )),
                // Flexible(
                //     flex: 1,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment
                //           .end,
                //       children: [
                //         tcn('Qty', Colors.white, 10)
                //       ],
                //     )),


              ],
            ),

          ),
          Column(
            children: wItemDetails(),
          )
        ],

      ),
    );
  }

  //===================================WIDGET
  List<Widget> wItemDetails() {
    var bookedlist = hmAssignmntController.lstrBookedItemList.value;
    List<Widget> rtnList = [] ;

    for (var e in bookedlist) {
      dprint("bookedlist........... ${e.toString()}.");
      var itemName = (e["STKDESCP"] ?? "").toString();
      var bookingNumb = (e["BOOKINGNUMB"] ?? "").toString();
      var qty = hmAssignmntController.g.mfnDbl(e["QTY"].toString());

      // dprint("Qty>>> ${qty}");
      // dprint("bookingNumb>>> ${bookingNumb}");
      // hmAssignmnt.bookingNumber.value =bookingNumb;

      rtnList.add(Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Container(
          decoration: boxBaseDecoration(bGreyLight, 0),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [

              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      tcn(bookingNumb.toString(), Colors.black, 10),
                    ],
                  )),
              Expanded(
                  child: tcn(itemName.toString(), Colors.black, 10)),
              // Flexible(
              //     flex: 1,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         tcn(qty.toString(), Colors.black, 10),
              //       ],
              //     )),

            ],
          ),
        ),
      ));


    }
    return rtnList;
  }

  List<Widget>  wBookingDetails() {
    List<Widget> rtnList =[];
    for(var e  in hmAssignmntController.lstrBookedHeaderList.value){
      dprint("lstrBookedHeaderListitems>>>>>>>>>>>  ${e}");

      var partyname = (e["PARTY_NAME"] ?? "").toString();
      var phonunumber = (e["MOBILE_NO"] ?? "").toString();
      var boookingNumb = (e["BOOKINGNUMB"] ?? "").toString();
      var buildingCode =(e["BLDG_NO"] ?? "").toString();
      var areaCode = (e["AREA_CODE"] ?? "").toString();
      var apartmnt = (e["APARTMENT_NO"] ?? "").toString();
      var contractNumber = (e["CONTRACT_NO"] ?? "").toString();

      rtnList.add(
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: boxBaseDecoration(bgColor.withOpacity(0.9), 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boookingNumb.toString().isNotEmpty? Row(
                          children: [
                            Icon(Icons.confirmation_num,color:txtColor,size: 12),
                            gapWC(3),
                            tcn(boookingNumb.toString(), txtColor, 12),
                          ],
                        ):gapHC(0),
                        partyname.toString().isNotEmpty? Row(
                          children: [
                            Icon(Icons.person,color:txtColor,size: 12),
                            gapWC(3),
                            tcn(partyname.toString(), txtColor, 12),
                          ],
                        ):gapHC(0),
                        phonunumber.toString().isNotEmpty? Row(
                          children: [
                            Icon(Icons.phone_android,color:txtColor,size: 12),
                            gapWC(3),
                            tcn(phonunumber.toString(), txtColor, 12),
                          ],
                        ):gapHC(0),
                        buildingCode.toString().isNotEmpty? Row(
                          children: [
                            Icon(Icons.apartment,color:txtColor,size: 12),
                            gapWC(3),
                            tcn(buildingCode.toString(), txtColor, 12),
                          ],
                        ):gapHC(0),
                        apartmnt.toString().isNotEmpty? Row(
                          children: [
                            Icon(Icons.apartment,color:txtColor,size: 12),
                            gapWC(3),
                            tcn(apartmnt.toString(), txtColor, 12),
                          ],
                        ):gapHC(0),
                        areaCode.toString().isNotEmpty?  Row(
                          children: [
                            Icon(Icons.apartment,color:txtColor,size: 12),
                            gapWC(3),
                            tcn(areaCode.toString(), txtColor, 12),
                          ],
                        ):gapHC(0),
                        contractNumber.toString().isNotEmpty?  Row(
                          children: [
                            Icon(Icons.numbers_rounded,color:txtColor,size: 12),
                            gapWC(3),
                            tcn(contractNumber.toString(), txtColor, 12),
                          ],
                        ):gapHC(0),

                      ],
                    ),
                  ),
                hmAssignmntController.wstrPageMode=="VIEW"? gapHC(0) :Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: (){
                        dprint("Dadadada");
                        dprint(hmAssignmntController.lstrBookedHeaderList.value);
                        dprint("------------------------");
                        dprint(hmAssignmntController.lstrBookedItemList.value);
                        hmAssignmntController.bookingNumber.value="";
                        hmAssignmntController.salesOrderDocNO.value="";

                        hmAssignmntController.lstrBookedHeaderList.removeWhere((element) => element["BOOKINGNUMB"] == boookingNumb);
                        hmAssignmntController.lstrBookedItemList.value.removeWhere((element) => element["BOOKINGNUMB"] == boookingNumb);

                        //hmAssignmnt.lstrBookedHeaderList.value.removeWhere((element) => element["BOOKINGNUMB"]==hmAssignmnt.lstrBookedItemList.value.where((item) => item["DOCNO"]));

                     },

                      child: Icon(Icons.close))
                ],
              ),
            )
          )
      );



    }
     return rtnList;
  }


  changePage(int pageNum) {

    hmAssignmntController.selectedPage.value = pageNum;
    hmAssignmntController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );


    if (pageNum == 0) {
      hmAssignmntController.lstrSelectedPage.value = "CB";

    }

    if (pageNum == 1) {

      hmAssignmntController.lstrSelectedPage.value = "ID";

    }


  }
}

