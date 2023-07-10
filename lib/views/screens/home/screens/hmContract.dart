import 'package:beams_gas_cylinder/views/screens/home/screens/hmContractRecipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../../components/common/common.dart';
import '../../../components/common/commonTextField.dart';
import '../../../components/common/tabButton.dart';
import '../../../styles/colors.dart';
import '../controller/hmContractController.dart';

class HmeContract extends StatefulWidget {
  const HmeContract({super.key});

  @override
  State<HmeContract> createState() => _HmeContractState();
}

class _HmeContractState extends State<HmeContract> {
  final HmContractController hmContractController =   Get.put(HmContractController());

  @override
  void initState() {
    hmContractController.pageController = PageController();
    hmContractController.apiProductType();
    hmContractController.lstrSelectedPage.value = "DT";
    hmContractController.wstrPageMode.value = "VIEW";
    hmContractController.apiViewContarct("","LAST");
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
              hmContractController.fnBackPage(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: tcn('Contract', Colors.white, 20),
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
            padding: const EdgeInsets.all(10.0),
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
                         hmContractController.fnLookup("gcylinder_contract");
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
                                  tc(hmContractController.frContractno.value, txtColor, 12)
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
                              setDate(7, hmContractController.contractDate.value)
                                  .toString()
                                  .toUpperCase(),
                              txtColor,
                              12)
                        ],
                      ),
                    ],
                  ),
                  // gapHC(15),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(30),
                  //     color: Colors.grey.shade200,
                  //   ),
                  //   child:     Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           const Icon(
                  //             Icons.account_circle_outlined,
                  //             color: Colors.black,
                  //             size: 15,
                  //           ),
                  //           gapWC(5),
                  //           tc(hmContractController.cstmrName.value,
                  //               Colors.black, 12)
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           const Icon(
                  //             Icons.tag_outlined,
                  //             color: Colors.black,
                  //             size: 15,
                  //           ),
                  //           gapWC(5),
                  //           tc(hmContractController.cstmrCode.value,
                  //               Colors.black, 12)
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  gapHC(5),





                  Container(

                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),


                    decoration: boxDecoration(primaryColor, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TabButton(
                              width: 0.3,
                              text: "Details",
                              pageNumber: 0,
                              selectedPage:
                              hmContractController.selectedPage.value,
                              onPressed: () {
                                hmContractController.lstrSelectedPage.value = "DT";
                                changePage(0);
                              },
                              icon: Icons.view_list_outlined),
                        ),
                        Flexible(
                          child: TabButton(
                              width: 0.3,
                              text: " Items",
                              pageNumber: 1,
                              selectedPage:
                              hmContractController.selectedPage.value,
                              onPressed: () {
                                hmContractController.lstrSelectedPage.value = "IT";
                                changePage(1);
                              },
                              icon: Icons.shopping_cart_outlined),
                        ),
                        Flexible(
                          child: TabButton(
                              width: 0.3,
                              text: "Payments",
                              pageNumber: 2,
                              selectedPage:
                              hmContractController.selectedPage.value,
                              onPressed: () {
                                hmContractController.lstrSelectedPage.value = "PT";
                                changePage(2);
                              },
                              icon: Icons.payment),
                        ),
                      ],
                    ),
                  ),
                  gapHC(8),
                  Expanded(
                    child: Container(
                      width: size.width,
                      decoration: boxDecoration(white, 8),
                      child: Form(
                              key: hmContractController.customerformKey.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: PageView(
                                onPageChanged: (int page) {
                                  hmContractController.selectedPage.value =
                                      page;
                                },
                                controller:
                                hmContractController.pageController,
                                children: [
                                  // 1st page design ------ Choose Item
                                  wDetailScreen(MediaQuery.of(context).size),

                                  //2nd Page  design -----------------------------------
                                  wItemScreen(MediaQuery.of(context).size),
                                  wPaymentScreen( MediaQuery.of(context).size)

                                  // 3rd Page for Delivery Details
                                  // Container for  1st page   design -----------------------------------
                                ],
                              ),
                            ),
                            hmContractController.wstrPageMode.value=="VIEW" ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Bounce(
                                      onPressed: () {
                                         Get.to(()=>HmeContractRecipt(
                                             contractNumber: hmContractController.frContractno.value,
                                           //   customerName: hmContractController.txtCustomerName.text,
                                           // apartmntCode:hmContractController.txtApartmentCode.text ,
                                           // buildingCode:hmContractController.txtBuildingCode.text ,
                                           // contactNumber:hmContractController.txtContactNo.text ,

                                         ));

                                        //  hmContractController.fnSave(context);
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
                                            tcn('PayNow', Colors.white, 15)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):gapHC(0)

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        bottomNavigationBar: Obx(
              () => (hmContractController.wstrPageMode.value == "VIEW")
              ? BottomNavigationItem(
            type: "booking",
            mode: hmContractController.wstrPageMode.value,
            fnAdd: hmContractController.fnAdd,
            fnEdit: hmContractController.fnEdit,
            fnCancel: hmContractController.fnCancel,
            fnPage: hmContractController.fnPage,
            fnSave: hmContractController.fnSave,
            fnDelete: hmContractController.fnDelete,
          )
              : (hmContractController.wstrPageMode.value == "ADD" ||
                  hmContractController.wstrPageMode.value == "EDIT")
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Bounce(
                    onPressed: () {
                      // dprint("BUILDING CODE  ${commonController.wstrBuildingCode.value}");
                      // dprint("APRTMNT CODE  ${commonController.wstrAprtmntCode.value}");

                      hmContractController.fnSave(context);
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
                    hmContractController.fnCancel();
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
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,

        floatingActionButton: Obx(() => (hmContractController.wstrPageMode.value != "VIEW" )? Padding(
          padding: const EdgeInsets.only(bottom: 67),
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            tooltip: 'Add Items',
            onPressed: () {
              hmContractController.wOpenBottomSheet(context);
            },
            child: Icon(Icons.add),
          ),
        ):SizedBox())

    );
  }
  //========================================================================FUNCTIONS
  changePage(int pageNum) {
    hmContractController.selectedPage.value = pageNum;
    hmContractController.pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    if (pageNum == 0) {
      hmContractController.lstrSelectedPage.value = "DT";
    }

    if (pageNum == 1) {
      hmContractController.lstrSelectedPage.value = "IT";
    }
    if (pageNum == 2) {
      hmContractController.lstrSelectedPage.value = "PT";
    }
  }


  //========================================================================WIDGETS
  wDetailScreen(Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bounce(
                  onPressed: () {
                    if(hmContractController.wstrPageMode=="VIEW"){
                      return;
                    }
                     hmContractController.fnLookup("SLMAST");

                  },
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
                                tc(hmContractController.cstmrCode.value,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: tc(hmContractController.cstmrName.value, Colors.black, 12)),
                            tcn("Credit Balance", Colors.black, 10),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                gapHC(5),


                wRoundedInputField(
                    hmContractController.txtCustomerName, "Customer Name", "N",enable: false,
                    prefixicon: Icons.drive_file_rename_outline),
                gapHC(10),
                wRoundedInputField(
                    hmContractController.txtContactNo, "Contact No", "N",enable: false,
                    prefixicon: Icons.phone_android_outlined),
                gapHC(10),
                wRoundedInputField(
                    hmContractController.txtWhatsappNumber, "WhatsApp No", "N",  enable: hmContractController.wstrPageMode.value=="VIEW"?false:true,
                    prefixicon: Icons.phone_android_outlined),
                gapHC(10),
                wRoundedInputField(
                    hmContractController.txtEmail, "Email", "N",  enable: hmContractController.wstrPageMode.value=="VIEW"?false:true,
                    prefixicon: Icons.email_outlined),
                gapHC(10),
                wRoundedInputField(
                    hmContractController.txtBuildingCode, "Building Code", "N",enable: false,
                    prefixicon: Icons.apartment),
                gapHC(10),
                wRoundedInputField(
                    hmContractController.txtApartmentCode, "Apartment Code", "N",enable: false,
                    prefixicon: Icons.apartment),
                gapHC(10),
                wRoundedInputField(
                    hmContractController.txtAreaCode, "Area Code", "N",enable: false,
                    prefixicon: Icons.apartment),
                gapHC(10),
                // wRoundedInputField(
                //   hmContractController.txtLandmark,
                //   "Landmark",
                //   "N",
                //   prefixicon: Icons.apartment,enable: false,
                // ),
                // gapHC(10),
                wRoundedInputField(
                  hmContractController.txtAddress,enable: false,
                  "Address",
                  "N",
                  maxLine: 5,
                  prefixicon: Icons.abc_outlined,
                ),
                gapHC(10),
                wRoundedInputField(hmContractController.txtRemark, "Remark", "N",maxLine: 5,   enable: hmContractController.wstrPageMode.value=="VIEW"?false:true,
                  prefixicon:   Icons.note_alt_outlined,),

                gapHC(10),
                wRoundedInputField(
                    hmContractController.txtFrqDeliveryDays, "Frequency Of Delivery Days", "N",enable: hmContractController.wstrPageMode.value=="VIEW"?false:true,
                    prefixicon: Icons.calendar_month_outlined,
                     keybordType: TextInputType.number),


                gapHC(15),

              ],
            ),

          ],
        ),
      ),
    );
  }

  wItemScreen(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: boxBaseDecoration(subColor, 5),
            //padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    child: tcn('Item', Colors.white, 10)),

                Padding(
                  padding:  EdgeInsets.only(right:22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [tcn('Qty', Colors.white, 10)],
                  ),
                ),

              ],
            ),
          ),
          Obx(() => Column(
            children: wFilledItemLIst(),
          )),
        ],
      ),
    );
  }

  wPaymentScreen(Size size) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tc('Deposit Amount',txtColor, 12),
          gapHC(5),
          CommonTextField(obscureY: false,txtController: hmContractController.txtDepositAmount,prefixIcon: Icons.attach_money,
              keybordType: TextInputType.number,enableY:hmContractController.wstrPageMode.value=="VIEW"? false:true,
              inputformate: mfnInputDecFormatters(),textStyle: TextStyle(
                  color: txtColor
              ),prefixIconColor: txtColor,
              textAlignment: TextAlign.right,fnClear:(){
                hmContractController.txtDepositAmount.clear();
              } ),
        ],
      ),
    );
  }


  wRoundedInputField(TextEditingController contrlr, hintTxt, lookup, {maxLine,keybordType, prefixicon,enable}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tc(hintTxt, txtColor, 12),
        gapHC(5),
        CommonTextField(
          prefixIcon: prefixicon,
          enableY: enable,
          txtController: contrlr,
          prefixIconColor: txtColor,
          obscureY: false,
          keybordType: keybordType,
          textStyle: GoogleFonts.poppins(fontSize: 12,color: txtColor),
          maxline: maxLine,
          fnClear: (){
            contrlr.clear();
          },

        )
      ],
    );
  }

  List<Widget> wFilledItemLIst() {
    var itemList = hmContractController.itemList.value;
    List<Widget> rtnList = [] ;
    var ftotal = 0.0;
    //   {  "STKCODE": "FIVE", "STKDESCP": "5L", "RATE": 10.0,"TYPE":"R"},



    for (var e in itemList) {
      dprint(e);

      var itemName = (e["STKDESCP"] ?? "").toString();
      var itemCode = (e["STKCODE"] ?? "").toString();
    //  var rate = hmContractController.g.mfnDbl(e["RATE"].toString());
      var qty = hmContractController.g.mfnDbl(e["QTY"].toString());
   //   var total = qty * rate;
      dprint("Qty>>> ${qty}");
   //   dprint("Rate>>> ${rate}");
   //   dprint("Total>>> ${total}");
  //    dprint("Total>>> ${total}");

   //   var amt = total;
    //  ftotal += amt;
    //  dprint("FNTotal>>> ${ftotal}");
      rtnList.add(Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Container(
          decoration: boxBaseDecoration(bGreyLight, 0),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: tcn(itemName.toString(), Colors.black, 10)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hmContractController.wstrPageMode!="VIEW"?  Bounce(
                    onPressed: () {
                      hmContractController.fnChngeQty(itemCode, "A",);
                    },
                    duration: const Duration(
                        milliseconds: 110),
                    child: Container(
                        height: 20,
                        width:20,
                        decoration:boxDecoration(primaryColor, 10),
                        child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ))),
                  ):gapHC(0),
                  gapWC(5),
                  Padding(
                    padding:  EdgeInsets.only(right: hmContractController.wstrPageMode.value=="VIEW"?20:0),
                    child: tcn(qty.toString(), Colors.black, 10),
                  ),
                  gapWC(5),
                  hmContractController.wstrPageMode!="VIEW"?   Bounce(
                    onPressed: () {
                      hmContractController.fnChngeQty(itemCode, "D",);
                    },
                    duration: const Duration(
                        milliseconds: 110),
                    child: Container(
                        height: 20,
                        width:20,
                        decoration:boxDecoration(primaryColor, 10),
                        child: const Center(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 16,
                            ))),
                  ):gapHC(0),

                ],

              ),

            ],
          ),
        ),
      ));


    }
    return rtnList;
  }



}
