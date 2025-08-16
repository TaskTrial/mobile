import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/logger.dart';
import '../../domain/models/auth/login_model.dart';
import '../../domain/models/auth/user_model.dart';
import '../../domain/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  
  // Observable variables
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final currentUser = Rxn<UserModel>();
  
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();
  
  // Form validation
  final emailError = Rxn<String>();
  final passwordError = Rxn<String>();
  final confirmPasswordError = Rxn<String>();
  final otpError = Rxn<String>();
  
  AuthController({AuthService? authService})
      : _authService = authService ?? AuthService();
  
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
    Logger.info('AuthController initialized');
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    super.onClose();
  }
  
  // Check if user is logged in
  void _checkLoginStatus() {
    isLoggedIn.value = _authService.isLoggedIn();
    Logger.logStateChange('AuthController', 'Login status: ${isLoggedIn.value}');
  }
  
  // Login method
  Future<void> login() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    _clearErrors();
    
    try {
      final success = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
        onError: (error) {
          Logger.error('Login error: $error');
          // Handle specific error cases if needed
        },
        onSuccess: (loginModel) {
          Logger.info('Login successful');
          _handleLoginSuccess(loginModel);
        },
      );
      
      if (!success) {
        // Error is already handled in service
        return;
      }
    } catch (e) {
      Logger.error('Login controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Handle successful login
  void _handleLoginSuccess(LoginModel loginModel) {
    isLoggedIn.value = true;
    currentUser.value = loginModel.user;
    
    // Navigate to appropriate screen based on user state
    if (loginModel.user?.organizationId == null) {
      // User needs to create/join organization
      Get.offAllNamed('/create-organization');
    } else {
      // User has organization, go to main app
      Get.offAllNamed('/main');
    }
  }
  
  // Logout method
  Future<void> logout() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    
    try {
      final success = await _authService.logout(
        onSuccess: () {
          Logger.info('Logout successful');
          _handleLogoutSuccess();
        },
        onError: (error) {
          Logger.error('Logout error: $error');
          // Even if API fails, clear local data
          _handleLogoutSuccess();
        },
      );
      
      if (!success) {
        // Still handle logout locally
        _handleLogoutSuccess();
      }
    } catch (e) {
      Logger.error('Logout controller error', error: e);
      _handleLogoutSuccess();
    } finally {
      isLoading.value = false;
    }
  }
  
  // Handle successful logout
  void _handleLogoutSuccess() {
    isLoggedIn.value = false;
    currentUser.value = null;
    _clearFormData();
    Get.offAllNamed('/login');
  }
  
  // Forgot password
  Future<void> forgotPassword() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    _clearErrors();
    
    try {
      final success = await _authService.forgotPassword(
        email: emailController.text.trim(),
        onSuccess: () {
          Logger.info('Forgot password email sent');
          // Navigate to OTP verification screen
          Get.toNamed('/verify-otp');
        },
        onError: (error) {
          Logger.error('Forgot password error: $error');
          // Error is already handled in service
        },
      );
      
      if (!success) {
        return;
      }
    } catch (e) {
      Logger.error('Forgot password controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Verify OTP
  Future<void> verifyOtp() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    _clearErrors();
    
    try {
      final success = await _authService.verifyOtp(
        email: emailController.text.trim(),
        otp: otpController.text.trim(),
        onSuccess: () {
          Logger.info('OTP verified successfully');
          // Navigate to reset password screen
          Get.toNamed('/reset-password');
        },
        onError: (error) {
          Logger.error('OTP verification error: $error');
          // Error is already handled in service
        },
      );
      
      if (!success) {
        return;
      }
    } catch (e) {
      Logger.error('OTP verification controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Reset password
  Future<void> resetPassword(String token) async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    _clearErrors();
    
    try {
      final success = await _authService.resetPassword(
        token: token,
        newPassword: passwordController.text,
        onSuccess: () {
          Logger.info('Password reset successful');
          // Navigate to login screen
          Get.offAllNamed('/login');
        },
        onError: (error) {
          Logger.error('Password reset error: $error');
          // Error is already handled in service
        },
      );
      
      if (!success) {
        return;
      }
    } catch (e) {
      Logger.error('Password reset controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Load current user
  Future<void> loadCurrentUser() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    
    try {
      final user = await _authService.getCurrentUser(
        onError: (error) {
          Logger.error('Load current user error: $error');
          // Handle error - maybe logout user
          logout();
        },
      );
      
      if (user != null) {
        currentUser.value = user;
        Logger.info('Current user loaded: ${user.email}');
      }
    } catch (e) {
      Logger.error('Load current user controller error', error: e);
    } finally {
      isLoading.value = false;
    }
  }
  
  // Form validation methods
  void validateEmail() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emailError.value = 'Please enter a valid email';
    } else {
      emailError.value = null;
    }
  }
  
  void validatePassword() {
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (password.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
    } else {
      passwordError.value = null;
    }
  }
  
  void validateConfirmPassword() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
    } else if (password != confirmPassword) {
      confirmPasswordError.value = 'Passwords do not match';
    } else {
      confirmPasswordError.value = null;
    }
  }
  
  void validateOtp() {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      otpError.value = 'OTP is required';
    } else if (otp.length != 6) {
      otpError.value = 'OTP must be 6 digits';
    } else {
      otpError.value = null;
    }
  }
  
  // Clear all form errors
  void _clearErrors() {
    emailError.value = null;
    passwordError.value = null;
    confirmPasswordError.value = null;
    otpError.value = null;
  }
  
  // Clear form data
  void _clearFormData() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    otpController.clear();
    _clearErrors();
  }
  
  // Check if form is valid
  bool get isLoginFormValid {
    return emailController.text.trim().isNotEmpty &&
           passwordController.text.isNotEmpty &&
           emailError.value == null &&
           passwordError.value == null;
  }
  
  bool get isResetPasswordFormValid {
    return passwordController.text.isNotEmpty &&
           confirmPasswordController.text.isNotEmpty &&
           passwordError.value == null &&
           confirmPasswordError.value == null;
  }
  
  bool get isOtpFormValid {
    return otpController.text.trim().isNotEmpty &&
           otpError.value == null;
  }
}