import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/auth/login_controller.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/auth/forget_password_screen.dart';
import 'package:task_trial/views/auth/sign_up_screen.dart';
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
              child: GetX<LoginController>(
                init: LoginController(),
                builder: (controller) => Form(
                  key: controller.formKey,
                child: SingleChildScrollView(
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
                       GoogleSignInUI(
                        onPressed: () {
                          controller.loginWithGoogle();
                        }
                      ),
                      const SizedBox(height: 20),
                      // or sign in with email
                      _theDivider(width),
                      const SizedBox(height: 20),
                      // email and password text fields
                      _emailField(controller),
                      const SizedBox(height: 15),
                      _passwordField(controller),
                      const SizedBox(height: 10),
                      // forgot password
                      _forgotPassword(),
                      const SizedBox(height: 40),
                      AuthButton(isLoading:controller.isLoading.value,onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.login();
                        }
                      }, title: 'Login'),
                      const SizedBox(height: 10),
                      // sign up
                      _signUp()
                    ],
                  ),
                ),
              ),)
            ),
          ),
        ),
      ),
    );
  }

   Widget _welcome() {
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
  _emailField(LoginController controller) {
    return  MyTextField(
      keyboardType: TextInputType.emailAddress,
      title: 'Email',
      hintText: 'mail@abc.com',
      controller: controller.emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!GetUtils.isEmail(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
  _passwordField(LoginController controller) {
    return MyTextField(
      keyboardType: TextInputType.visiblePassword,
      title: 'Password',
      hintText: '***********',
      isPassword: true,
      obscureText: controller.isPasswordVisible.value,
      controller: controller.passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      onPressed: () {
        controller.togglePasswordVisibility();
      },
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
            onPressed: () {
              Get.to(()=> const ForgetPasswordScreen());
            },
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
            onPressed: () {
              Get.offAll(
                () => const SignUpScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 500),
              );
            },
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
