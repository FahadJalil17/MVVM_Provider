import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
// why we set message as dynamic because it can change over period of time
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: EdgeInsets.all(15),
          duration: Duration(seconds: 3),
          positionOffset: 20,
          borderRadius: BorderRadius.circular(15),
          icon: Icon(
            Icons.error,
            size: 20,
            color: Colors.white,
          ),
        )..show(context) // ..show(context) => for showing flushbar
        );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // for having a focus on the next field
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus(); // removing focus from current
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // For ratings in get api
static double averageRating(List<int> rating){
    var avgRating = 0;
    for(int i=0; i<rating.length; i++){
      avgRating = avgRating + rating[i]; // rating on every index will be add with avgRating
    }
    return double.parse((avgRating/rating.length).toStringAsFixed(1));
}


}
