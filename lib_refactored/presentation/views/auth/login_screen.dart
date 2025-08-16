import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/ui_utils.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

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
                'Welcome Back',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Sign in to continue to TaskTrial',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Login Form
              _buildLoginForm(),
              
              const SizedBox(height: 24),
              
              // Forgot Password
              Center(
                child: TextButton(
                  onPressed: () {
                    Logger.logNavigation('LoginScreen', 'ForgotPasswordScreen');
                    AppRoutes.goToForgotPassword();
                  },
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyles.link,
                  ),
                ),
              ),
              
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
              
              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Logger.logNavigation('LoginScreen', 'RegisterScreen');
                      AppRoutes.goToRegister();
                    },
                    child: Text(
                      'Sign Up',
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

  Widget _buildLoginForm() {
    return Obx(() => Column(
      children: [
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
          textInputAction: TextInputAction.done,
          onChanged: (_) => controller.validatePassword(),
          onFieldSubmitted: (_) => _handleLogin(),
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outlined),
            errorText: controller.passwordError.value,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Login Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: controller.isLoginFormValid && !controller.isLoading.value
                ? _handleLogin
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
                    'Login',
                    style: AppTextStyles.buttonLarge,
                  ),
          ),
        ),
      ],
    ));
  }

  void _handleLogin() async {
    if (!controller.isLoginFormValid) {
      UiUtils.showErrorSnackBar(
        title: 'Validation Error',
        message: 'Please fill in all required fields correctly',
      );
      return;
    }

    try {
      await controller.login();
    } catch (e) {
      Logger.error('Login error in UI', error: e);
      UiUtils.showErrorSnackBar(
        title: 'Login Failed',
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }
}