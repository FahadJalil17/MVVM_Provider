
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// we create this class and will use shared preferences => Through model we will save data
// user related information will be saved in this class
class UserViewModel with ChangeNotifier{

  // save user
  Future<bool> saveUser(UserModel user) async{  // through model we will pass data
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  // get user
  Future<UserModel> getUser() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return UserModel(
      token: token.toString()
    );
  }

  // When user logout remove the session
Future<bool> remove() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    notifyListeners();
    return true;
}

}
