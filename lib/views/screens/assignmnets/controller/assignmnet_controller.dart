import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/globalValues.dart';
import '../../../../servieces/api_controller.dart';
import '../../../components/common/common.dart';

class AssignmentController extends GetxController{
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "TD".obs;
  var pageIndex = 0.obs;
  var g  = Global();
  late Future <dynamic> futureform;
  late PageController pageController;

  // var emergencyAssignedList = [{
  //   "PartyName":"Anas",
  //   "BuildCode":"2342",
  //   "Mobile":"9562015163",
  //   "Apartment":"333",
  //    "Priority":"High"
  //
  // },{
  //   "PartyName":"Shfeeq",
  //   "BuildCode":"453",
  //   "Mobile":"345456456",
  //   "Priority":"Normal",
  //   "Apartment":"567",
  // }, {
  //   "PartyName":"Hakeem",
  //   "BuildCode":"78",
  //   "Mobile":"69867869",
  //   "Apartment":"3657",
  //   "Priority":"High"
  // }, {
  //     "PartyName":"Anas",
  //     "BuildCode":"2342",
  //     "Mobile":"9562015163",
  //     "Apartment":"333",
  //   "Priority":"Normal"
  //   }].obs;
  // var otherAssignedList = [{
  //   "PartyName":"GAS",
  //   "BuildCode":"2342",
  //   "Mobile":"4534",
  //   "Apartment":"333",
  //   "Priority":"High"
  //
  // }, {
  //     "PartyName":"POIPIO",
  //     "BuildCode":"576",
  //     "Mobile":"089987",
  //     "Apartment":"34",
  //   "Priority":"Normal"
  //   }].obs;
  var pendingAssignedList = [].obs;
  var upComingAssignedList = [].obs;
  var allAssignedList = [].obs;
  var todayAssignedList =[].obs;
  var bookingItemList =[].obs;
  //==============================================================================FUNCTION

  void fnFillGetAssignmnt(data) {
    dprint("GETassignmentListValue>>>>> ${data}");


    var todayAssignList = g.fnValCheck(data["TODAY"])?data["TODAY"]:[];
    var upcomingAssignList = g.fnValCheck(data["UPCOMING"])?data["UPCOMING"]:[];
    var completedAssignList = g.fnValCheck(data["COMPLETED"])?data["COMPLETED"]:[];
    var pendngAssignList = g.fnValCheck(data["PENDING"])?data["PENDING"]:[];
    var allAssignList = g.fnValCheck(data["ALL"])?data["ALL"]:[];
    todayAssignedList.value =todayAssignList;
    upComingAssignedList.value =upcomingAssignList;
    allAssignedList.value =allAssignList;
    pendingAssignedList.value =pendngAssignList;



    dprint("TODAY>>>>>>>>>>f>>>  ${todayAssignedList.value}");
    dprint("UPCOMING>>>>>>>>>>>>>  ${upcomingAssignList}");
    dprint("COMPLETED>>>>>>>>>>>>>  ${completedAssignList}");
  }

  fnFill(data){
    dprint("BookingValues>>>>>>>  ${data}");
    bookingItemList.value=[];
    var detList  = g.fnValCheck(data["DET"])?data["DET"]:[];
    bookingItemList.value = detList;
    dprint("bookingItemList.value>>>>>>> ${bookingItemList.value}");




  }



  //==============================================================================API

  apiGetAssignment(empcode){
    futureform = ApiCall().apiGetAssignment(empcode);
    futureform.then((value) => apiGetAssignmentRes(value));
  }
  apiGetAssignmentRes(value){
    if(g.fnValCheck(value)){
      fnFillGetAssignmnt(value);
    }

  }

  apiGetBooking(docno,mode){
    futureform = ApiCall().apiViewBooking(docno,mode);
    futureform.then((value) => apiGetBookingRes(value));
  }
  apiGetBookingRes(value){
    if(g.fnValCheck(value)){
      bookingItemList.value=[];
      fnFill(value);
    }

  }






}