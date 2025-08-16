import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/ui_utils.dart';
import '../../controllers/auth_controller.dart';

class VerifyOtpScreen extends GetView<AuthController> {
  const VerifyOtpScreen({super.key});

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
                'Verify OTP',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Enter the 6-digit code sent to your email',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // OTP Form
              _buildOtpForm(),
              
              const SizedBox(height: 32),
              
              // Resend OTP
              Center(
                child: TextButton(
                  onPressed: () {
                    Logger.info('Resend OTP requested');
                    // TODO: Implement resend OTP functionality
                    UiUtils.showInfoSnackBar(
                      title: 'Info',
                      message: 'Resend OTP functionality will be implemented',
                    );
                  },
                  child: Text(
                    'Resend OTP',
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

  Widget _buildOtpForm() {
    return Obx(() => Column(
      children: [
        // OTP Field
        TextFormField(
          controller: controller.otpController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          maxLength: 6,
          onChanged: (_) => controller.validateOtp(),
          onFieldSubmitted: (_) => _handleVerifyOtp(),
          decoration: InputDecoration(
            labelText: 'OTP Code',
            hintText: 'Enter 6-digit code',
            prefixIcon: const Icon(Icons.security),
            errorText: controller.otpError.value,
            counterText: '', // Hide character counter
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Verify Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: controller.isOtpFormValid && !controller.isLoading.value
                ? _handleVerifyOtp
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
                    'Verify OTP',
                    style: AppTextStyles.buttonLarge,
                  ),
          ),
        ),
      ],
    ));
  }

  void _handleVerifyOtp() async {
    if (!controller.isOtpFormValid) {
      UiUtils.showErrorSnackBar(
        title: 'Validation Error',
        message: 'Please enter a valid 6-digit OTP',
      );
      return;
    }

    try {
      await controller.verifyOtp();
    } catch (e) {
      Logger.error('Verify OTP error in UI', error: e);
      UiUtils.showErrorSnackBar(
        title: 'Verification Failed',
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }
}