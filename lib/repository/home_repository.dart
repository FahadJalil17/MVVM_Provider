
import 'package:mvvm_provider/data/network/base_api_service.dart';
import 'package:mvvm_provider/data/network/network_api_service.dart';
import 'package:mvvm_provider/resources/app_urls.dart';

import '../model/movies_model.dart';

class HomeRepository{
  BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieListModel> fetchMoviesList() async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);
    }
    catch(error){
      throw error;
    }

  }

}
