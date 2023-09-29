
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mvvm_provider/data/app_exceptions.dart';
import 'package:mvvm_provider/data/network/base_api_service.dart';

class NetworkApiServices extends BaseApiServices{
  // url will be basically url of Api

  // For Get Api => The only work of this  function is to handle the request of all get api
  @override
  Future getGetApiResponse(String url) async{ // you have to provide this String url and your work is done

    dynamic responseJson;  // it is local variable accessible only inside the function

    try{
      // if you don't work like this you have to repeat this process again and again
      final response  = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);  // calling returnResponse here and passing response to it
    } on SocketException{  // it is basically no internet
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }


  // For Post Api => In Post api we post data on server
  @override
  Future getPostApiResponse(String url, dynamic data) async{
    dynamic responseJson;
    try{
      Response response = await post(
          Uri.parse(url),
        body: data, // in post api there is body and we send parameters in it
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }


  dynamic returnResponse(http.Response response){

    switch(response.statusCode){
      // 200 status code is successful
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException("Error Occurred While Communicating With Server "+'with status code'+  response.statusCode.toString());
    }
  }

}
