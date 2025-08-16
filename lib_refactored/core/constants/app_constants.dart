class AppConstants {
  // App Information
  static const String appName = 'TaskTrial';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://tasktrial-prod.vercel.app/api';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // API Endpoints
  static const String authSignIn = '/auth/signin';
  static const String authSignUp = '/auth/signup';
  static const String authForgotPassword = '/auth/forgotPassword';
  static const String authResetPassword = '/auth/resetPassword';
  static const String authVerifyOtp = '/auth/verifyOtp';
  static const String authRefreshToken = '/auth/refreshToken';
  
  // User Endpoints
  static const String users = '/users';
  
  // Organization Endpoints
  static const String organizations = '/organizations';
  
  // Project Endpoints
  static const String projects = '/projects';
  
  // Task Endpoints
  static const String tasks = '/tasks';
  
  // Team Endpoints
  static const String teams = '/teams';
  
  // Department Endpoints
  static const String departments = '/departments';
  
  // Storage Keys
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String userIdKey = 'id';
  static const String userEmailKey = 'email';
  static const String userRoleKey = 'role';
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Snackbar Durations
  static const Duration snackbarDuration = Duration(seconds: 4);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}