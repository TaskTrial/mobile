import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/ui_utils.dart';
import '../../controllers/auth_controller.dart';

class ResetPasswordScreen extends GetView<AuthController> {
  const ResetPasswordScreen({super.key});

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
                'Reset Password',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Enter your new password',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Reset Password Form
              _buildResetPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Obx(() => Column(
      children: [
        // New Password Field
        TextFormField(
          controller: controller.passwordController,
          obscureText: true,
          textInputAction: TextInputAction.next,
          onChanged: (_) => controller.validatePassword(),
          decoration: InputDecoration(
            labelText: 'New Password',
            hintText: 'Enter your new password',
            prefixIcon: const Icon(Icons.lock_outlined),
            errorText: controller.passwordError.value,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Confirm Password Field
        TextFormField(
          controller: controller.confirmPasswordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onChanged: (_) => controller.validateConfirmPassword(),
          onFieldSubmitted: (_) => _handleResetPassword(),
          decoration: InputDecoration(
            labelText: 'Confirm New Password',
            hintText: 'Confirm your new password',
            prefixIcon: const Icon(Icons.lock_outlined),
            errorText: controller.confirmPasswordError.value,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Reset Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: controller.isResetPasswordFormValid && !controller.isLoading.value
                ? _handleResetPassword
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
                    'Reset Password',
                    style: AppTextStyles.buttonLarge,
                  ),
          ),
        ),
      ],
    ));
  }

  void _handleResetPassword() async {
    if (!controller.isResetPasswordFormValid) {
      UiUtils.showErrorSnackBar(
        title: 'Validation Error',
        message: 'Please fill in all required fields correctly',
      );
      return;
    }

    try {
      // Get token from route arguments or use a placeholder
      final token = AppRoutes.getArgument<String>('token') ?? 'placeholder_token';
      await controller.resetPassword(token);
    } catch (e) {
      Logger.error('Reset password error in UI', error: e);
      UiUtils.showErrorSnackBar(
        title: 'Reset Failed',
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }
}