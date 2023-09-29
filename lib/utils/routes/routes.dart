
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/view/home_screen.dart';
import 'package:mvvm_provider/view/login_view.dart';
import 'package:mvvm_provider/view/signup_view.dart';
import 'package:mvvm_provider/view/splash_view.dart';

class Routes{
  // both will work
  static Route<dynamic> generateRoute(RouteSettings settings){
  // static MaterialPageRoute generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashView());

      case RoutesName.home:  // it comes from RouteNames class
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginView());

      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignUpView());

      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });
    }

  }
}