import 'package:flutter/material.dart';
import 'package:mvvm_provider/resources/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;  // this is used when we will call api
  final VoidCallback onPress;
  RoundButton({Key? key, required this.title, this.loading = false, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Center(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: loading ? CircularProgressIndicator(color: Colors.white,) : Text(title, style: TextStyle(color: AppColors.whiteColor, fontSize: 17),)),
        ),
      ),
    );
  }
}

