
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_provider/model/user_model.dart';
import 'package:mvvm_provider/repository/auth_repository.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepository = AuthRepository();
// loading for login
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  // loading for sign up
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

 setSignUpLoading(bool value){
   _signUpLoading = value;
   notifyListeners();
 }


  Future<dynamic> loginApi(dynamic data, BuildContext context) async{
    // when api is hit
    setLoading(true);

    // loginApi from AuthRepository class
    _myRepository.loginApi(data).then((value){
      setLoading(false);  // when response is get
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(
          token: value['token'].toString(),
        )
      );

      Utils.flushBarErrorMessage("Login Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);  // if login successfully go to home
      if(kDebugMode){
      print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString());
      }
    });

  }

  // For Sign Up
  Future<dynamic> signUpApi(dynamic data, BuildContext context)  async{
    setSignUpLoading(true);

    _myRepository.signUpApi(data).then((value){
      setSignUpLoading(false);
      Utils.flushBarErrorMessage("Sign Up Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

}
