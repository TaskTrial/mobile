import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_trial/controllers/auth/reset_password_controller.dart';

import 'package:task_trial/widgets/auth_button.dart';
import 'package:task_trial/widgets/my_text_field.dart';

import '../../utils/constants.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final ResetPasswordController controller = Get.put(ResetPasswordController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Reset Password",
                style: TextStyle(
                  fontFamily: Constants.primaryFont,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please Check your email for the verification code.",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: Constants.primaryFont),
              ),
              SizedBox(height: 24),
              MyTextField(
                title: "OTP code",
                hintText: "123456",
                controller: controller.otpController,
                validator: (value)  {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your OTP';
                  }
                  if (value.length != 6) {
                    return 'Password must be 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              MyTextField(
                title: "New Password",
                hintText: "*************",
                controller: controller.newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
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
                          controller.resetPassword();
                        }
                      }, title: 'Reset Password', isLoading: false)),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: (){
                    Get.back();
                  },
                  child: const Text("Send OTP Again!",
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
