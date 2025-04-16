import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/auth/login_controller.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/main_view_screen.dart';
import 'package:task_trial/widgets/auth_button.dart';
import 'package:task_trial/widgets/my_text_field.dart';
import 'package:task_trial/controllers/auth/sign_up_controller.dart';

import '../../widgets/google_sign_in_ui.dart';
import '../dashboard/dashboard_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                height: height,
                child: GetX<SignUpController>(
                  init: SignUpController(),
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
                          // login message
                          _loginMessage(),
                          const SizedBox(height: 5),
                          // login message hint
                          _loginMessageHint(),
                          const SizedBox(height: 30),
                          // google sign in
                           GoogleSignInUI(
                            onPressed: () {
                            },
                          ),
                          const SizedBox(height: 20),
                          // or sign in with email
                          _theDivider(width),
                          const SizedBox(height: 20),
                          MyTextField(
                            keyboardType: TextInputType.name,
                            title: 'Username',
                            hintText: 'John Doe',
                            controller: controller.userNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(child: MyTextField(
                                title: 'First Name',
                                hintText: 'John',
                                controller: controller.firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                              ),
                              SizedBox(width: 10),
                              Expanded(child: MyTextField(
                                title: 'Last Name',
                                hintText: 'Doe',
                                controller: controller.lastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          // email and password text fields
                          _emailField(controller),
                          const SizedBox(height: 15),
                          _passwordField(controller),
                          const SizedBox(height: 15),
                          // _confirmPasswordField(controller),
                          const SizedBox(height: 10),
                          const SizedBox(height: 40),
                          AuthButton(isLoading: controller.isLoading.value
                              ,onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.signUp();
                            }

                          }, title: 'Sign Up'),
                          const SizedBox(height: 10),
                          // sign up
                          _login()
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
      'Hello ,',
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
      'Sign Up ',
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
  _emailField(SignUpController controller) {
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
  _passwordField(SignUpController controller) {
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
  _confirmPasswordField(SignUpController controller) {
    return MyTextField(
      title: 'Confirm Password',
      hintText: '***********',
      isPassword: true,
      obscureText: controller.isConfirmPasswordVisible.value,
      controller: controller.confirmPasswordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (value != controller.passwordController.text) {
          return 'Password must match the password';
        }

        return null;
      },
      onPressed: () {
        controller.toggleConfirmPasswordVisibility();
      },
    );
  }
  _login() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('If you already have an account',
              style: TextStyle(
                  color: Constants.pageNameColor,
                  fontSize: 14,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () {
              Get.offAll(() => const LoginScreen(),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 500));
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,

              foregroundColor: Constants.primaryColor.withOpacity(0.1),
            ),
            child: const Text('Login',
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
