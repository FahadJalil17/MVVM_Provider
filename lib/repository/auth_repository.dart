import 'package:mvvm_provider/data/network/base_api_service.dart';
import 'package:mvvm_provider/data/network/network_api_service.dart';
import 'package:mvvm_provider/resources/app_urls.dart';

class AuthRepository{
  // this _apiServices will give us access of NetworkApiServices class
BaseApiServices _apiServices = NetworkApiServices();

Future<dynamic> loginApi(dynamic data) async{
  try{
    dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
    return response;
  }catch(error){
    throw error;
  }
}

Future<dynamic> signUpApi(dynamic data) async{
  try{
    dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerApiEndPoint, data);
    return response;
  }catch(error){
    throw error;
  }
}

}