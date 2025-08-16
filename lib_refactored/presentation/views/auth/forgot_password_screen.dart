import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/ui_utils.dart';
import '../../controllers/auth_controller.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              
              // Back button
              IconButton(
                onPressed: () => AppRoutes.goBack(),
                icon: const Icon(Icons.arrow_back),
                color: AppColors.textPrimary,
              ),
              
              const SizedBox(height: 32),
              
              // Header
              Text(
                'Forgot Password',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Enter your email to receive password reset instructions',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Forgot Password Form
              _buildForgotPasswordForm(),
              
              const SizedBox(height: 32),
              
              // Back to Login
              Center(
                child: TextButton(
                  onPressed: () {
                    Logger.logNavigation('ForgotPasswordScreen', 'LoginScreen');
                    AppRoutes.goBack();
                  },
                  child: Text(
                    'Back to Login',
                    style: AppTextStyles.link,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
    return Obx(() => Column(
      children: [
        // Email Field
        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onChanged: (_) => controller.validateEmail(),
          onFieldSubmitted: (_) => _handleForgotPassword(),
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email address',
            prefixIcon: const Icon(Icons.email_outlined),
            errorText: controller.emailError.value,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: controller.isEmailValid && !controller.isLoading.value
                ? _handleForgotPassword
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Send Reset Link',
                    style: AppTextStyles.buttonLarge,
                  ),
          ),
        ),
      ],
    ));
  }

  void _handleForgotPassword() async {
    if (!controller.isEmailValid) {
      UiUtils.showErrorSnackBar(
        title: 'Validation Error',
        message: 'Please enter a valid email address',
      );
      return;
    }

    try {
      await controller.forgotPassword();
    } catch (e) {
      Logger.error('Forgot password error in UI', error: e);
      UiUtils.showErrorSnackBar(
        title: 'Request Failed',
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }
}