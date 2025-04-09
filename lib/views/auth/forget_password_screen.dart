import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/login_controller.dart';
import 'package:task_trial/views/auth/login_screen.dart';
import 'package:task_trial/views/auth/reset_password_screen.dart';
import 'package:task_trial/widgets/auth_button.dart';
import 'package:task_trial/widgets/my_text_field.dart';

import '../../utils/constants.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   foregroundColor: Colors.black,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontFamily: Constants.primaryFont,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter your email address to reset your password.",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: Constants.primaryFont),
              ),
              SizedBox(height: 24),
              MyTextField(
                title: "Email",
                hintText: "Enter your email",
                controller: controller.emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                  width: 200,
                  child: AuthButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.sendOTP();

                        }
                      }, title: 'Send OTP', isLoading: false)),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: (){
                    Get.back();
                  },
                  child: const Text("Back to Login",
                      style: TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 14,
                          fontFamily: Constants.primaryFont,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
