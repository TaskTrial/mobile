import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/login_controller.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/widgets/auth_button.dart';
import 'package:task_trial/widgets/my_text_field.dart';

import '../../widgets/google_sign_in_ui.dart';

class LoginScreen extends StatelessWidget {
 const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  // welcome text
                  _welcome(),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  // login message
                  _loginMessage(),
                  const SizedBox(height: 5),
                  // login message hint
                  _loginMessageHint(),
                  const SizedBox(height: 30),
                  // google sign in
                  const GoogleSignInUI(),
                  const SizedBox(height: 20),
                  // or sign in with email
                  _theDivider(width),
                  const SizedBox(height: 20),
                  // email and password text fields
                  MyTextField(
                    title: 'Email',
                    hintText: 'mail@abc.com',
                  ),
                  const SizedBox(height: 15),
                  GetX<LoginController>(
                    init: LoginController(),
                    builder: (controller) => MyTextField(
                    title: 'Password',
                    hintText: '***********',
                    isPassword: true,
                    obscureText: controller.isPasswordVisible.value,
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },
                  ),),
                  const SizedBox(height: 10),
                  // forgot password
                  _forgotPassword(),
                  const SizedBox(height: 40),
                  AuthButton(onPressed: () {}, title: 'Login'),
                  const SizedBox(height: 10),
                  // sign up
                  _signUp()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _welcome() {
    return Text(
      'Welcome ,',
      style: TextStyle(
        color: Constants.pageNameColor,
        fontSize: 50,
        fontWeight: FontWeight.w900,
        fontFamily: Constants.primaryFont,
      ),
    );
  }

  _loginMessage() {
    return Text(
      'Login to your Account',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        fontFamily: Constants.primaryFont,
        color: Constants.pageNameColor,
      ),
    );
  }

  _loginMessageHint() {
    return Text(
      'See what is going on with your business',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
        fontFamily: Constants.primaryFont,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _theDivider(double width) {
    return SizedBox(
      height: 20,
      width: width,
      child: Center(
          child: Text(
        '------------- or Sign in with Email ------------- ',
        style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.bold),
      )),
    );
  }

  _forgotPassword() {
    return GetX<LoginController>(
      init: LoginController(),
      builder: (controller) =>  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: controller.rememberMe.value,
                onChanged: (value) {
                  value= controller.toggleRememberMe();
                },
                checkColor: Colors.white,
                activeColor: Constants.primaryColor,
              ),
              const Text('Remember Me',
                  style: TextStyle(
                      color: Constants.pageNameColor,
                      fontSize: 14,
                      fontFamily: Constants.primaryFont,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?',
                style: TextStyle(color: Constants.primaryColor,
                    fontSize: 14,
                    fontFamily: Constants.primaryFont,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),);
  }
  _signUp() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Not Registered Yet?',
              style: TextStyle(
                  color: Constants.pageNameColor,
                  fontSize: 14,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.only(left: 7),
              foregroundColor: Constants.primaryColor.withOpacity(0.1),
            ),
            child: const Text('Create an account',
                style: TextStyle(color: Constants.primaryColor,
                    fontSize: 14,
                    fontFamily: Constants.primaryFont,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
