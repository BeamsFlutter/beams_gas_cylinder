

import 'package:beams_gas_cylinder/views/screens/Collection/Controller/collectioncontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../components/common/common.dart';
import '../../components/common/textInputField.dart';
import '../../styles/colors.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  var txtAmt = TextEditingController();
  var fnAmt = FocusNode();
  var wstrPageMode = "VIEW".obs;
  final CollectionController collectionController = Get.put(CollectionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       elevation: 0,
       leading: IconButton(
         onPressed: () {collectionController.fnBackPage(context);},
         icon: Icon(Icons.arrow_back_ios_new_outlined, color: black),
       ),
       flexibleSpace: Container(
         decoration: boxDecoration(bgColor, 0),
       ),
       title: tcn('Collection', black, 20),
       actions: const [
         Padding(
           padding: EdgeInsets.all(12.0),
         ),
       ],
     ),
     body: Padding(
       padding: EdgeInsets.all(15),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Row(
                 children: [Icon(Icons.tag), tc('BK1256300', black, 15)],
               ),
               tc(setDate(13, DateTime.now()).toString().toUpperCase(), txtColor, 10),
             ],
           ),
           gapHC(5),
           Bounce(
             onPressed: () {

             },
             duration: const Duration(milliseconds: 110),
             child: Container(padding: const EdgeInsets.all(10),
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
                               const Icon(Icons.person),
                               gapWC(5),
                               tcn('SHAJAHAN', txtColor, 12),
                             ],
                           ),
                           gapHC(5),
                           Row(
                             children: [
                               const Icon(Icons.place),
                               gapWC(5),
                               tcn("ALNAHDA", txtColor, 9),
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
                               size: 15,)),
                       ),
                     ],
                   ),
                   Container(decoration: boxBaseDecoration(bgColor, 30),
                     padding: EdgeInsets.all(5),
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         tc('BALANCE', Colors.black, 12),
                         tc('15200',Colors.red,12),
                       ],
                     ),
                   )

                 ],
               ),
             ),
           ),
           gapH(),
           Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               tc('Collection', black, 14.0),
               gapHC(5),
               Container(

                 child: TextInputField(
                   hintText: '',
                   txtRadius: 3,
                   txtWidth: 1,
                   txtController: txtAmt,
                   focusNode: fnAmt,
                   textType: TextInputType.text,
                   txtSize : 12,

                 ),
               ),
             ],
           ),
           gapH(),
           tc('Payment Details', black, 18),
           Container(decoration: boxDecoration(primaryColor, 5),height: 5,width: 100,),
           gapHC(10),
           GetBuilder<CollectionController>(builder: (controller) {
             return Column(
               children: controller.paymentList.asMap().entries.map((e) => RadioListTile(
                 title: tcn(
                     e.value["PDETAILS"].toString(), txtColor, 12),
                 value: e.value["PDETAILS"],
                 groupValue: collectionController.paymentvalue.value,
                 onChanged: controller.onClickRadioButton1,
                 activeColor: Colors.black,
               )).toList(),
             );
           })

         ],
       ),
     ),
      bottomNavigationBar: (wstrPageMode.value == "VIEW")
          ? BottomNavigationItem(
        type: "collection",
        mode: wstrPageMode.value,
        fnAdd: collectionController.fnAdd,
        fnEdit: collectionController.fnEdit,
        fnCancel: collectionController.fnCancel,
        fnPage: collectionController.fnPage,
        fnSave: collectionController.fnSave,
        fnDelete: collectionController.fnDelete,
      )
          : (wstrPageMode.value == "ADD" || wstrPageMode.value == "EDIT")
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
      ):BottomAppBar()

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
