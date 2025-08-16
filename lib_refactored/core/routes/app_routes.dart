import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/views/auth/login_screen.dart';
import '../../presentation/views/auth/register_screen.dart';
import '../../presentation/views/auth/forgot_password_screen.dart';
import '../../presentation/views/auth/verify_otp_screen.dart';
import '../../presentation/views/auth/reset_password_screen.dart';
import '../../presentation/views/landing_screen.dart';
import '../../presentation/views/main_view_screen.dart';
import '../../presentation/views/organization/create_organization_screen.dart';
import '../../presentation/views/organization/join_organization_screen.dart';
import '../../presentation/views/splash_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String landing = '/landing';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';
  static const String createOrganization = '/create-organization';
  static const String joinOrganization = '/join-organization';
  static const String main = '/main';
  
  // Route definitions
  static final List<GetPage> routes = [
    // Splash screen
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    
    // Landing screen
    GetPage(
      name: landing,
      page: () => const LandingScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // Auth routes
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    GetPage(
      name: verifyOtp,
      page: () => const VerifyOtpScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    GetPage(
      name: resetPassword,
      page: () => const ResetPasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // Organization routes
    GetPage(
      name: createOrganization,
      page: () => const CreateOrganizationScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    GetPage(
      name: joinOrganization,
      page: () => const JoinOrganizationScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // Main app routes
    GetPage(
      name: main,
      page: () => const MainViewScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
  
  // Navigation methods
  static void goToSplash() => Get.offAllNamed(splash);
  static void goToLanding() => Get.offAllNamed(landing);
  static void goToLogin() => Get.offAllNamed(login);
  static void goToRegister() => Get.toNamed(register);
  static void goToForgotPassword() => Get.toNamed(forgotPassword);
  static void goToVerifyOtp() => Get.toNamed(verifyOtp);
  static void goToResetPassword() => Get.toNamed(resetPassword);
  static void goToCreateOrganization() => Get.offAllNamed(createOrganization);
  static void goToJoinOrganization() => Get.toNamed(joinOrganization);
  static void goToMain() => Get.offAllNamed(main);
  
  // Navigation with arguments
  static void goToResetPasswordWithToken(String token) => 
      Get.toNamed(resetPassword, arguments: {'token': token});
  
  static void goToVerifyOtpWithEmail(String email) => 
      Get.toNamed(verifyOtp, arguments: {'email': email});
  
  // Back navigation
  static void goBack() => Get.back();
  static void goBackToLogin() => Get.offAllNamed(login);
  
  // Navigation with replacement
  static void replaceWithLogin() => Get.offAllNamed(login);
  static void replaceWithMain() => Get.offAllNamed(main);
  
  // Navigation with clear stack
  static void clearStackAndGoToLogin() => Get.offAllNamed(login);
  static void clearStackAndGoToMain() => Get.offAllNamed(main);
  
  // Navigation with data
  static void goToMainWithData(Map<String, dynamic> data) => 
      Get.offAllNamed(main, arguments: data);
  
  // Navigation with result
  static Future<T?> goToScreenWithResult<T>(String routeName, {Object? arguments}) => 
      Get.toNamed<T>(routeName, arguments: arguments);
  
  // Navigation with callback
  static void goToScreenWithCallback(String routeName, Function callback, {Object? arguments}) => 
      Get.toNamed(routeName, arguments: arguments).then((_) => callback());
  
  // Navigation with middleware
  static void goToScreenWithMiddleware(String routeName, {Object? arguments}) {
    // Add middleware logic here (e.g., check authentication)
    if (_isAuthenticated()) {
      Get.toNamed(routeName, arguments: arguments);
    } else {
      goToLogin();
    }
  }
  
  // Helper method to check authentication
  static bool _isAuthenticated() {
    // This should check with your auth service
    // For now, return true as placeholder
    return true;
  }
  
  // Get route arguments
  static Map<String, dynamic>? getArguments() {
    return Get.arguments as Map<String, dynamic>?;
  }
  
  // Get specific argument
  static T? getArgument<T>(String key) {
    final arguments = getArguments();
    return arguments?[key] as T?;
  }
  
  // Check if current route is
  static bool isCurrentRoute(String routeName) {
    return Get.currentRoute == routeName;
  }
  
  // Get current route name
  static String getCurrentRoute() {
    return Get.currentRoute;
  }
  
  // Get previous route name
  static String? getPreviousRoute() {
    return Get.previousRoute;
  }
  
  // Check if can go back
  static bool canGoBack() {
    return Get.canPop();
  }
  
  // Pop until specific route
  static void popUntil(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }
  
  // Pop until predicate
  static void popUntilPredicate(bool Function(GetPageRoute) predicate) {
    Get.until(predicate);
  }
}