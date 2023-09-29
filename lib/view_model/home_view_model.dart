
import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider/data/response/api_response.dart';
import 'package:mvvm_provider/model/movies_model.dart';
import 'package:mvvm_provider/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier{

  final _myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response){
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async{
    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value){
      setMoviesList(ApiResponse.completed(value));

    }).onError((error, stackTrace){
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }

}
