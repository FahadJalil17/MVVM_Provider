import 'package:flutter/material.dart';
import 'package:mvvm_provider/resources/components/round_button.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  // ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // When pressing done on keyboard it will have a focus on next field for doing that
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final  height = MediaQuery.of(context).size.height * 1;  // 1 is full screen

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  prefixIcon: Icon(Icons.alternate_email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
                onFieldSubmitted: (value){
                  // FocusScope.of(context).requestFocus(passwordFocusNode);  // conventional method
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),

              SizedBox(height: 25,),

              ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child){
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecurePassword.value,
                    obscuringCharacter: "*",
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        prefixIcon: Icon(Icons.lock_open_outlined),
                        suffixIcon: InkWell(
                            onTap: (){
                              _obsecurePassword.value = !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value ? Icons.visibility_off_outlined : Icons.visibility)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )
                    ),
                  );
                },
              ),

              SizedBox(height: height * .081,),

              RoundButton(
                  title: "Login",
                  loading: authViewModel.loading,
                  onPress: (){
                if(_emailController.text.isEmpty){
                  Utils.flushBarErrorMessage("Please Enter Email", context);
                }else if(_passwordController.text.isEmpty){
                  Utils.flushBarErrorMessage("Please Enter Password", context);
                }else if(_passwordController.text.length < 6){
                  Utils.flushBarErrorMessage("Please Enter 6 Digit Password", context);
                }else{
                  Map data = {
                    "email" : _emailController.text.toString(),
                    "password" : _passwordController.text.toString(),
                  };
                  authViewModel.loginApi(data, context); // api will be called it required two parameters
                  print("Api hit");
                }

              }),
              SizedBox(height: height * .02,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.signup);
                },
                  child: Text("Don't have an account? Sign Up")),
            ],
          ),
        ),
      )
    );
  }
}

