
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:beams_gas_cylinder/servieces/app_exception.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import '../global/globalValues.dart';
import '../views/components/common/common.dart';

class ApiManager {

  var mainBaseUrl = "http://beamsdts-001-site1.atempurl.com/api/"; //Test

  var baseUrl = Global().wstrBaseUrl;
  var token =   Global().wstrToken;
  var wstrIp =  Global().wstrIp;
  var g =Global();


  //==================================================================GET
  Future<dynamic> get(String api) async {
    if(wstrIp != ""){
      baseUrl = wstrIp;
    }
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.get(uri);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  //==================================================================POST
  Future<dynamic> post(String api, dynamic body) async {
    dprint("Endpointtt.............. ${api}");
    if(wstrIp != ""){
      baseUrl = wstrIp;
    }

    var url="${baseUrl+'/'+ api}";
    var uri = Uri.parse(url);
    dprint("Uriiiddd......... ${uri}");
    dprint("bodyyyy......... ${body}");

    var payload = body;
    try {
      var response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'COMPANY' : g.wstrCompany,
            'YEARCODE' : g.wstrYearcode,
            'TOKEN': g.wstrToken
          },
          body: payload);
      return _processResponse(response);
    } on SocketException {

      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  Future<dynamic> postGlobal(String api, dynamic body) async {

    var uri = Uri.parse(mainBaseUrl + api);
    dprint(uri);
    var payload = body;
    try {
      var response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'COMPANY' : g.wstrCompany,
            'YEARCODE' : g.wstrYearcode,
            'TOKEN': g.wstrToken
          },
          body: payload);
      return _processResponse(response);
    } on SocketException {

      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  //==================================================================RESPONSE
  dynamic _processResponse(http.Response response) {
    dprint("responseeeeeeeeeeeee");
    dprint(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
        break;
      case 201:
        var responseJson = jsonDecode(response.body);
        return responseJson;
        break;
      case 204:
        var responseJson = jsonDecode(response.body);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      default:
        throw FetchDataException('BE100', response.request!.url.toString());
    }
  }

}