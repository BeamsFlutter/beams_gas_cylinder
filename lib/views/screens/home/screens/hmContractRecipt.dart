import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/bottomNavigationBar/bottom_navigator_item.dart';
import '../../../components/common/common.dart';
import '../../../components/common/commonTextField.dart';
import '../../../styles/colors.dart';
import '../controller/hmContractReciptController.dart';

class HmeContractRecipt extends StatefulWidget {
  const HmeContractRecipt({super.key});

  @override
  State<HmeContractRecipt> createState() => _HmeContractReciptState();
}

class _HmeContractReciptState extends State<HmeContractRecipt> {
  final HmContractReciptController hmContractReciptController =   Get.put(HmContractReciptController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            hmContractReciptController.fnBackPage(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: tcn('Contract Receipt', Colors.white, 20),
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
      body: Padding(padding: EdgeInsets.all(10),
      child:Obx(() =>  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Bounce(
                  duration: const Duration(milliseconds: 110),
                  onPressed: () {


                    // hmDelivryOrderController.fnLookup("GCYLINDER_DO");
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
                            tc(hmContractReciptController.frDocno.value, txtColor, 12)
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
                        setDate(7, hmContractReciptController.docDate.value)
                            .toString()
                            .toUpperCase(),
                        txtColor,
                        12)
                  ],
                ),
              ],
            ),
            gapHC(10),
            tc("Contract Details", txtColor, 12),
            gapHC(5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: boxBaseDecoration(Colors.grey.shade200, 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tc("Contract Number :", txtColor, 12),
                    gapHC(5),
                    tc("Customer Name    :", txtColor, 12),
                    gapHC(5),
                    tc("Building Code        :", txtColor, 12),
                    gapHC(5),
                    tc("Apartment Code  :", txtColor, 12),
                    gapHC(5),
                    tc("Contact No             :", txtColor, 12),
                  ],
                ),
              ),
            ),
            gapHC(10),
            tc('Amount',txtColor, 12),
            gapHC(5),
            Container(

              child: CommonTextField(obscureY: false,txtController: hmContractReciptController.txtAmount,prefixIcon: Icons.attach_money,
                  keybordType: TextInputType.number,enableY:hmContractReciptController.wstrPageMode.value=="VIEW"? false:true,
                  inputformate: mfnInputDecFormatters(),textStyle: TextStyle(
                    color: txtColor
                  ),prefixIconColor: txtColor,
                  textAlignment: TextAlign.right,fnClear:(){
                    hmContractReciptController.txtAmount.clear();
                  } ),
            ),

            gapHC(10),

            tc('Payment Mode',txtColor, 12),
            gapHC(5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: boxBaseDecoration(Colors.grey.shade200, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<PaymentMode>(
                    title: const Text('Cash'),
                    value: PaymentMode.cash,
                    activeColor: primaryColor,
                    groupValue:hmContractReciptController.paymentMode.value,
                    onChanged: (value) {
                      if(hmContractReciptController.wstrPageMode.value=="VIEW"){
                        return;
                      }

                      hmContractReciptController.paymentMode.value = value!;
                      dprint(hmContractReciptController.paymentMode.value);

                    },
                  ),
                  RadioListTile<PaymentMode>(
                    title: const Text('Card'),
                    value: PaymentMode.card,
                    activeColor: primaryColor,
                    groupValue:hmContractReciptController.paymentMode.value,
                    onChanged: (PaymentMode? value) {
                      if(hmContractReciptController.wstrPageMode.value=="VIEW"){
                        return;
                      }
                      hmContractReciptController.paymentMode.value = value!;
                      dprint(hmContractReciptController.paymentMode.value);
                    },
                  ),
                  RadioListTile<PaymentMode>(
                    title: const Text('Cheque'),
                    activeColor: primaryColor,
                    value: PaymentMode.cheque,
                    groupValue:hmContractReciptController.paymentMode.value,
                    onChanged: (PaymentMode? value) {
                      if(hmContractReciptController.wstrPageMode.value=="VIEW"){
                        return;
                      }
                      hmContractReciptController.paymentMode.value = value!;
                      dprint(hmContractReciptController.paymentMode.value);
                    },
                  )
                ],
              ),
            ),
            gapHC(5),
            paymentModeDetails(hmContractReciptController.paymentMode.value)

          ],
        ),
      ))

      ),
      bottomNavigationBar: Obx(
            () => (hmContractReciptController.wstrPageMode.value == "VIEW")
            ? BottomNavigationItem(
          type: "booking",
          mode: hmContractReciptController.wstrPageMode.value,
          fnAdd: hmContractReciptController.fnAdd,
          fnEdit: hmContractReciptController.fnEdit,
          fnCancel: hmContractReciptController.fnCancel,
          fnPage: hmContractReciptController.fnPage,
          fnSave: hmContractReciptController.fnSave,
          fnDelete: hmContractReciptController.fnDelete,
        )
            : (hmContractReciptController.wstrPageMode.value == "ADD" ||
                hmContractReciptController.wstrPageMode.value == "EDIT")
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Bounce(
                  onPressed: () {
                    // dprint("BUILDING CODE  ${commonController.wstrBuildingCode.value}");
                    // dprint("APRTMNT CODE  ${commonController.wstrAprtmntCode.value}");

                    hmContractReciptController.fnSave(context);
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
                  hmContractReciptController.fnCancel();
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
  paymentModeDetails(payment_mode) {
    dprint("payment_mode>>> ${payment_mode}");
    if(payment_mode==PaymentMode.cheque){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          wRoundedInputField(maxLine: 1,
              hmContractReciptController.txtchequeNumber, "Cheque Number", "N",enable: hmContractReciptController.wstrPageMode.value=="VIEW"?false:true,
              prefixicon: Icons.apartment),
          gapHC(10),
          tc('Cheque Date', black, 12),
          gapHC(5),
          Bounce(
            duration: const Duration(milliseconds: 110),
            onPressed: () {
              if(hmContractReciptController.wstrPageMode.value  == "VIEW"){
                return;
              }
              hmContractReciptController.wSelectDate(context);
              gapHC(5);
            },
            child:  CommonTextField(
              obscureY: false,
              textStyle: const TextStyle(color: txtColor),
              txtController: hmContractReciptController.txtchequeDate,
              prefixIcon: Icons.calendar_month,
              prefixIconColor: black,
              sufixIconColor: Colors.black,
              enableY:false,
              suffixIcon: Icons.done,

            ),
          ),
        ],);

    }else{
      return gapHC(0);
    }

  }
  wRoundTxtField(controller,{disable,keybordType,fieldName,ValueChanged<String>? oncahnged}){
    return   Container(
      height: 40,
      width: 100,

      decoration: boxBaseDecoration(bGreyLight, 10),
      child: Center(
        child: TextFormField(
            enabled: hmContractReciptController.wstrPageMode=="VIEW" || disable=="D"?false:true,
            inputFormatters: mfnInputDecFormatters(),
            controller:controller,
            textAlign: TextAlign.center,
            keyboardType:keybordType=="txtKeybrd"?TextInputType.text: TextInputType.number,
            style: GoogleFonts.poppins(fontSize: 15,color: txtColor,fontWeight: FontWeight.w600),
            decoration:  InputDecoration(
              prefixIcon: Icon(Icons.attach_money,color: txtColor),
              contentPadding: EdgeInsets.symmetric(vertical: 4,),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Colors.blueGrey.withOpacity(0.5)), //<-- SEE HERE
              ),

            ),
            onChanged: oncahnged
        ),
      ),
    );
  }
}
