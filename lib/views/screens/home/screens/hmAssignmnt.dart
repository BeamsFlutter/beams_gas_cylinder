
import 'package:beams_gas_cylinder/views/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import 'package:get/get.dart';

import '../../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../../components/common/common.dart';
import '../../../components/common/tabButton.dart';
import '../../../styles/colors.dart';
import '../controller/hmAssignmntController.dart';


class HmeAssignmnet extends StatefulWidget {
  const HmeAssignmnet({Key? key}) : super(key: key);
  @override
  State<HmeAssignmnet> createState() => _HmeAssignmnetState();
}

class _HmeAssignmnetState extends State<HmeAssignmnet> {
  final HmAssignmentController hmAssignmnt = Get.put(HmAssignmentController());


  @override
  void initState() {
    hmAssignmnt.pageController = PageController();
    hmAssignmnt.wstrPageMode.value = 'VIEW';
    // assignmentController.apiViewAssignment('', "LAST");
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
            hmAssignmnt.fnBackPage(context);
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
                        hmAssignmnt.fnLookup("GCYLINDER_ASSIGNMENT");
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
                                tc(hmAssignmnt.frDocno.value, txtColor, 12)
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
                        tcn(setDate(7, hmAssignmnt.todyDate.value).toString().toUpperCase(), txtColor, 12)
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
                          hmAssignmnt.fnLookup("AREAMASTER");
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
                              tcn(hmAssignmnt.frLocation.value.toString(), txtColor, 13)
                            ],
                          ),
                        ),
                      ),
                      Bounce(
                        duration: const Duration(milliseconds: 110),
                        onPressed: () {
                          dprint("lookup>>>>>>>Priority");
                          hmAssignmnt.fnLookup("GPRIORITYMASTER");
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
                              tcn( hmAssignmnt.priorityvalue.value.toString(), txtColor, 13)
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
                                hmAssignmnt.fnLookup("CRDELIVERYMANMASTER");
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
                                          Flexible(child: tcn(hmAssignmnt.frdriverName.value, Colors.black, 13))
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
                                hmAssignmnt.fnLookup("CRVEHICLEMASTER");
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
                                        tcn(hmAssignmnt.frvehiclenumber.value, Colors.black, 13)
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              tcn("Last Assigned", black, 12),
                              tcn( setDate(7, hmAssignmnt.lastAssignedDate.value).toString().toUpperCase(), txtColor, 12)

                            ],
                          ),
                          tc("${hmAssignmnt.pendingAssignedValue.value}/${hmAssignmnt.totalAssignedValue.value}", txtColor,22)
                        ],
                      ),
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
                      selectedPage: hmAssignmnt.selectedPage.value,
                      onPressed: () {
                        hmAssignmnt.lstrSelectedPage.value = "AT";
                        changePage(0);
                      },
                      icon: Icons.calendar_month),
                  TabButton(
                      width: 0.3,
                      text: "Item Details",
                      pageNumber: 1,
                      selectedPage:hmAssignmnt.selectedPage.value,
                      onPressed: () {
                        hmAssignmnt.lstrSelectedPage .value= "ID";
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
                          hmAssignmnt.selectedPage.value = page;

                        },
                        controller: hmAssignmnt.pageController,
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
      bottomNavigationBar: (hmAssignmnt.wstrPageMode.value ==
          "VIEW")
          ? BottomNavigationItem(
        mode: hmAssignmnt.wstrPageMode.value,
        fnAdd: hmAssignmnt.fnAdd,
        fnEdit: hmAssignmnt.fnEdit,
        fnCancel: hmAssignmnt.fnCancel,
        fnPage: hmAssignmnt.fnPage,
        fnSave: hmAssignmnt.fnSave,
        fnDelete: hmAssignmnt.fnDelete,
      )
          : (hmAssignmnt.wstrPageMode.value == "ADD" ||
          hmAssignmnt.wstrPageMode.value == "EDIT")
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Bounce(
                onPressed: () {
                  // dprint("BUILDING CODE  ${commonController.wstrBuildingCode.value}");
                  // dprint("APRTMNT CODE  ${commonController.wstrAprtmntCode.value}");
                  hmAssignmnt.fnSave;
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
                hmAssignmnt.fnCancel();
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
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10,top: 5),

      width: size.width,
      //height: size.height * 0.2,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                child: Bounce(
                  duration: const Duration(milliseconds: 110),
                  onPressed: () {
                    if(hmAssignmnt.wstrPageMode=="VIEW"){
                      return;
                    }else{
                      dprint("Search bookingggggggggg");
                    }
                  },
                  child: Container (
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),   color: Colors.grey.shade200, ),
                      child:Container(

                        child:  const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.search),
                          ],
                        ),
                      )

                  ),
                ),
              ),
             hmAssignmnt.wstrPageMode.value=="VIEW"?gapHC(0):Checkbox(checkColor: primaryColor,
                value: hmAssignmnt.checkAll.value,
                onChanged: (bool ? checkvalu) {
                  hmAssignmnt.checkAll.value = checkvalu!;
                },

              )
            ],
          ),
          gapHC(5),
          Column(
            children: wBookingDetails(),
          )
        ],
      ),
    );

  }


  //===================================WIDGET
  wFilledItemLIst() {
    dprint("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrc      +"+hmAssignmnt.orderlist.toString());
    List<Widget> rtnList = [] ;
    for (var e in hmAssignmnt.orderlist) {
      var code =  e ["CODE"];
      var det =   (e["LOCATION"]??"");
      var type =  (e["PRIORITY"]??"");
      var name = (e["CNAME"]);
      var item = (e["ITEMS"]);
      rtnList.add(
          Padding(
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: boxDecoration(Colors.white, 10),
              child: Row(
                children: [
                  Container(
                    decoration: boxDecoration(Colors.white70, 3),
                    padding: const EdgeInsets.all(5),
                    child: const Center(
                      child: Icon(Icons.check),
                    ),
                  ),
                  gapWC(15),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(

                          children: [
                            Row(
                              children: [
                                const Icon(Icons.library_add),
                                tc(code.toString(), Colors.black, 12),
                              ],
                            ),
                            gapHC(5),
                            Row(
                              children: [
                                const Icon(Icons.priority_high),
                                tcn(type, Colors.black, 12),
                              ],
                            ),

                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),

                        Row(
                          children: [
                            const Icon(Icons.person),
                            tcn(name.toString(), Colors.black, 12),
                          ],
                        ),
                        gapHC(5),
                        Row(
                          children: [
                            const Icon(Icons.place),
                            tcn(det.toString(), Colors.black, 12),
                          ],
                        ),
                        gapHC(5),
                        Row(
                          children: [
                            const Icon(Icons.list),
                            tcn(item.toString(),Colors.black,12),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }
    return rtnList;


  }

  List<Widget>  wBookingDetails() {
    List<Widget> rtnList =[];
    for(var e  in hmAssignmnt.orderlist.value){
      var code = e["CODE"];
      var name = e["CNAME"];
      var priority = e["PRIORITY"];
      var location = e["LOCATION"];
      var items = e["ITEMS"];
      rtnList.add(
          Container(
            height: 70,
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: boxBaseDecoration(bgColor.withOpacity(0.9), 8),
            child: Row(
              children: [
                hmAssignmnt.wstrPageMode.value=="VIEW"?gapHC(0): Checkbox(value: hmAssignmnt.checkAll.value, activeColor: primaryColor,onChanged: (bool ? checkvalu) {
                  hmAssignmnt.checkAll.value = checkvalu!;
                },),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tcn(code, txtColor, 12),
                      tcn(name, txtColor, 12),
                      tcn(location, txtColor, 12),
                    ],
                  ),
                )
              ],
            ),
          )
      );



    }
     return rtnList;
  }


  changePage(int pageNum) {

    hmAssignmnt.selectedPage.value = pageNum;
    hmAssignmnt.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );


    if (pageNum == 0) {
      hmAssignmnt.lstrSelectedPage.value = "CB";

    }

    if (pageNum == 1) {

      hmAssignmnt.lstrSelectedPage.value = "ID";

    }


  }

  itemDetailScreen() {
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
                    children: [
                      tcn('Item', Colors.white, 10)
                    ],
                  )),

              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end,
                    children: [
                      tcn('Price', Colors.white, 10)
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end,
                    children: [
                      tcn('Qty', Colors.white, 10)
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end,
                    children: [
                      tcn('Total', Colors.white, 10)
                    ],
                  )),

            ],
          ),

        ),
      ],

    );
  }
}

