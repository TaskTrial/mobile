import 'package:flutter/material.dart';
import 'package:get/get.dart';  
import 'package:task_trial/controllers/auth/verify_controller.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/widgets/auth_button.dart';
import 'package:task_trial/widgets/my_text_field.dart';
class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GetBuilder<VerifyController>(
              init: VerifyController(),
              builder: (controller) => Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    // verify message
                    _verifyMessage(),
                    const SizedBox(height: 5),
                    // verify message hint
                    _verifyMessageHint(),
                    const SizedBox(height: 30),
                    MyTextField(
                      title: 'Verification Code',
                      hintText: '123456',
                      controller: controller.codeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the verification code';
                        }
                        if (value.length != 6) {
                          return 'The verification code must be 6 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      title: 'Verify',
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.verifyCode();
                        }
                      }, isLoading: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _verifyMessage() {
    return const Text(
      'Verify Your Account',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Widget _verifyMessageHint() {
    return const Text(
      'Enter the verification code sent to your email',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

}

