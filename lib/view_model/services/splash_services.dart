
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/view_model/user_view_model.dart';

import '../../model/user_model.dart';

class SplashServices{
  // we create getter method of UserViewModel => and get all data of user
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async{
    getUserData().then((value) async{

      // if user is not logged in go to login screen
      if(value.token.toString() == 'null' || value.token.toString() == ''){
      await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }
      // if user is logged in go to home screen
      else{
      await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });

  }
}
