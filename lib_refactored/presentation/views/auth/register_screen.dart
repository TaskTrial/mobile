import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/ui_utils.dart';
import '../../controllers/auth_controller.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

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
                'Create Account',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Join TaskTrial and start managing your tasks',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Register Form
              _buildRegisterForm(),
              
              const SizedBox(height: 32),
              
              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.border)),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Logger.logNavigation('RegisterScreen', 'LoginScreen');
                      AppRoutes.goBack();
                    },
                    child: Text(
                      'Sign In',
                      style: AppTextStyles.link,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Obx(() => Column(
      children: [
        // First Name Field
        TextFormField(
          controller: controller.firstNameController,
          textInputAction: TextInputAction.next,
          onChanged: (_) => controller.validateFirstName(),
          decoration: InputDecoration(
            labelText: 'First Name',
            hintText: 'Enter your first name',
            prefixIcon: const Icon(Icons.person_outlined),
            errorText: controller.firstNameError.value,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Last Name Field
        TextFormField(
          controller: controller.lastNameController,
          textInputAction: TextInputAction.next,
          onChanged: (_) => controller.validateLastName(),
          decoration: InputDecoration(
            labelText: 'Last Name',
            hintText: 'Enter your last name',
            prefixIcon: const Icon(Icons.person_outlined),
            errorText: controller.lastNameError.value,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Email Field
        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (_) => controller.validateEmail(),
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: const Icon(Icons.email_outlined),
            errorText: controller.emailError.value,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Password Field
        TextFormField(
          controller: controller.passwordController,
          obscureText: true,
          textInputAction: TextInputAction.next,
          onChanged: (_) => controller.validatePassword(),
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
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
          onFieldSubmitted: (_) => _handleRegister(),
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Confirm your password',
            prefixIcon: const Icon(Icons.lock_outlined),
            errorText: controller.confirmPasswordError.value,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Register Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: controller.isRegisterFormValid && !controller.isLoading.value
                ? _handleRegister
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
                    'Create Account',
                    style: AppTextStyles.buttonLarge,
                  ),
          ),
        ),
      ],
    ));
  }

  void _handleRegister() async {
    if (!controller.isRegisterFormValid) {
      UiUtils.showErrorSnackBar(
        title: 'Validation Error',
        message: 'Please fill in all required fields correctly',
      );
      return;
    }

    try {
      await controller.register();
    } catch (e) {
      Logger.error('Register error in UI', error: e);
      UiUtils.showErrorSnackBar(
        title: 'Registration Failed',
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }
}