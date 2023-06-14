import 'package:beams_gas_cylinder/views/components/common/commonTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../../components/common/common.dart';
import '../../../components/common/textInputField.dart';
import '../../../styles/colors.dart';
import '../controller/hmCollectionController.dart';

class HmeCollections extends StatefulWidget {
  const HmeCollections({Key? key}) : super(key: key);

  @override
  State<HmeCollections> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<HmeCollections> {

  final HmCollectionController hmcollectionController = Get.put(HmCollectionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              hmcollectionController.fnBackPage(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: tcn('Collection', Colors.white, 20),
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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                tc(hmcollectionController.frDocno.value, txtColor, 12)
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
                            setDate(7, hmcollectionController.docDate.value)
                                .toString()
                                .toUpperCase(),
                            txtColor,
                            12)
                      ],
                    ),
                  ],
                ),
                gapHC(15),
                tc('Party Details', black, 12.0),
                gapHC(10),
                Bounce(
                  onPressed: () {
                    dprint("lookupp");

                  },
                  duration: const Duration(milliseconds: 110),
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                    decoration: boxDecoration(white, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person,size: 18,color: primaryColor),
                                    gapWC(5),
                                    tcn('SHAJAHAN', txtColor, 13),
                                  ],
                                ),
                                gapHC(5),
                                Row(
                                  children: [
                                    const Icon(Icons.place,size: 18,color: primaryColor),
                                    gapWC(5),
                                    tcn("ALNAHDA", txtColor, 13),
                                  ],
                                ),
                                gapHC(10),


                              ],
                            ),GestureDetector(
                              onTap: (){},
                              child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: const Icon(
                                    Icons.search, color: txtColor,
                                    size: 25,)),
                            ),
                          ],
                        ),
                        Container(decoration: boxBaseDecoration(bgColor, 30),
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tc('BALANCE', Colors.black, 12),
                              tc('15200 AED',Colors.red,16),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
                gapHC(10),
                tc('Collection Amount', black, 12.0),
                gapHC(5),
                CommonTextField(obscureY: false,txtController: hmcollectionController.txtCollectionAmt,prefixIcon: Icons.attach_money,
                  keybordType: TextInputType.number,enableY:hmcollectionController.wstrPageMode.value=="VIEW"? false:true,
                inputformate: mfnInputDecFormatters(),
                textAlignment: TextAlign.right,),
                gapHC(10),
                tc('Payment Details', black, 12),

                GetBuilder<HmCollectionController>(builder: (controller){

                      return  Column(
                        children: controller.paymentList.asMap().entries.map((e) =>

                            RadioListTile(contentPadding: EdgeInsets.zero,
                                title: tcn(e.value["PDETAILS"].toString(), txtColor,12),
                                value: e.value["PDETAILS"],
                                activeColor: primaryColor,
                                groupValue: controller.paymentvalue.value,
                                onChanged: controller.onClickChoosePyment
                            )).toList(),
                      );
                    }

                ),
                tc('Total', black, 12),
                gapHC(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tcn('Outstanding Amount', black, 12),
                    tc("20", txtColor, 13)

                  ],
                ),
                gapHC(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tcn('Paid Amount', black, 12),
                    tc("20", txtColor, 13)

                  ],
                ),
                gapHC(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tcn('Balance Amount', black, 12),
                    tc("20", txtColor, 13)

                  ],
                ),








              ],
            )), 
          ),
        ),
        bottomNavigationBar: Obx(() => (hmcollectionController.wstrPageMode.value == "VIEW")
            ? BottomNavigationItem(
          type: "collection",
          mode: hmcollectionController.wstrPageMode.value,
          fnAdd: hmcollectionController.fnAdd,
          fnEdit: hmcollectionController.fnEdit,
          fnCancel: hmcollectionController.fnCancel,
          fnPage: hmcollectionController.fnPage,
          fnSave: hmcollectionController.fnSave,
          fnDelete: hmcollectionController.fnDelete,
        )
            : (hmcollectionController.wstrPageMode.value == "ADD" || hmcollectionController.wstrPageMode.value == "EDIT")
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Bounce(
                  onPressed: () {
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
                  hmcollectionController.fnCancel();
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
        ):BottomAppBar())

    );
  }
  //===================================WIDGET
  List<Widget> wPriorityLIst(controller) {
    List<Widget> rtnList = [];
    for (var e in controller.paymentList) {
      var code = e["CODE"];
      var det = (e["PNAME"] ?? "");
      rtnList.add(ListTile(
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: Offset(-20, 0),
          child: tcn(det.toString(), txtColor, 12),
        ),
        leading: Radio(
            value: code.toString(),
            activeColor: Colors.red,
            groupValue: controller.paymentvalue,
            onChanged: (value) => controller.onClickRadioButton(value)),
      ));
    }
    return rtnList;
  }



}