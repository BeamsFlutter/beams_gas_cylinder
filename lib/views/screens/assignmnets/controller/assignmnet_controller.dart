import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignmentController extends GetxController{
  RxInt selectedPage = 0.obs;
  var lstrSelectedPage = "TD".obs;
  var pageIndex = 0.obs;
  late PageController pageController;
  var emergencyAssignedList = [{
    "PartyName":"Anas",
    "BuildCode":"2342",
    "Mobile":"9562015163",
    "Apartment":"333",
     "Priority":"High"

  },{
    "PartyName":"Shfeeq",
    "BuildCode":"453",
    "Mobile":"345456456",
    "Priority":"Normal",
    "Apartment":"567",
  },{
    "PartyName":"Hakeem",
    "BuildCode":"78",
    "Mobile":"69867869",
    "Apartment":"3657",
    "Priority":"High"
  }, {
      "PartyName":"Anas",
      "BuildCode":"2342",
      "Mobile":"9562015163",
      "Apartment":"333",
    "Priority":"Normal"
    }].obs;
  var otherAssignedList = [{
    "PartyName":"GAS",
    "BuildCode":"2342",
    "Mobile":"4534",
    "Apartment":"333",
    "Priority":"High"

  }, {
      "PartyName":"POIPIO",
      "BuildCode":"576",
      "Mobile":"089987",
      "Apartment":"34",
    "Priority":"Normal"
    }].obs;
  var pendingAssignedList = [{
    "PartyName":"Anas",
    "BuildCode":"2342",
    "Mobile":"9562015163",
    "Apartment":"333",
    "Priority":"High"

  },{
    "PartyName":"Anas",
    "BuildCode":"2342",
    "Mobile":"9562015163",
    "Apartment":"333",
    "Priority":"Normal"
  },{
    "PartyName":"Shfeeq",
    "BuildCode":"453",
    "Mobile":"345456456",
    "Priority":"Normal",
    "Apartment":"567",
  },{
    "PartyName":"Hakeem",
    "BuildCode":"78",
    "Mobile":"69867869",
    "Apartment":"3657",
    "Priority":"High"
  }, {
    "PartyName":"Anas",
    "BuildCode":"2342",
    "Mobile":"9562015163",
    "Apartment":"333",
    "Priority":"Normal"
  }].obs;
  var allAssignedList = [{
    "PartyName":"GAS",
    "BuildCode":"2342",
    "Mobile":"4534",
    "Apartment":"333",
    "Priority":"High"

  }, {
    "PartyName":"POIPIO",
    "BuildCode":"576",
    "Mobile":"089987",
    "Apartment":"34",
    "Priority":"Normal"
  }].obs;

}