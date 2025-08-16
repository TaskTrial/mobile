import '../../core/network/api_response.dart';
import '../../core/utils/logger.dart';
import '../../core/utils/ui_utils.dart';
import '../../core/utils/validators.dart';
import '../../data/repositories/auth_repository.dart';
import '../models/auth/login_model.dart';
import '../models/auth/user_model.dart';

class AuthService {
  final AuthRepository _authRepository;
  
  AuthService({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepositoryImpl();
  
  // Login with validation
  Future<bool> login({
    required String email,
    required String password,
    required Function(String) onError,
    required Function(LoginModel) onSuccess,
  }) async {
    try {
      // Validate inputs
      final emailError = Validators.validateEmail(email);
      if (emailError != null) {
        onError(emailError);
        return false;
      }
      
      final passwordError = Validators.validatePassword(password);
      if (passwordError != null) {
        onError(passwordError);
        return false;
      }
      
      Logger.info('Attempting login for email: $email');
      
      final response = await _authRepository.login(email, password);
      
      return response.fold(
        onSuccess: (loginModel) {
          Logger.info('Login successful for user: ${loginModel.user?.email}');
          onSuccess(loginModel);
          UiUtils.showSuccessSnackBar(
            title: 'Success',
            message: 'Login successful!',
          );
          return true;
        },
        onError: (error) {
          Logger.error('Login failed: $error');
          onError(error);
          UiUtils.showErrorSnackBar(
            title: 'Login Failed',
            message: error,
          );
          return false;
        },
      );
    } catch (e) {
      Logger.error('Login service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
  
  // Logout
  Future<bool> logout({
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      Logger.info('Attempting logout');
      
      final response = await _authRepository.logout();
      
      return response.fold(
        onSuccess: (_) {
          Logger.info('Logout successful');
          onSuccess();
          UiUtils.showSuccessSnackBar(
            title: 'Success',
            message: 'Logged out successfully',
          );
          return true;
        },
        onError: (error) {
          Logger.error('Logout failed: $error');
          onError(error);
          UiUtils.showErrorSnackBar(
            title: 'Logout Failed',
            message: error,
          );
          return false;
        },
      );
    } catch (e) {
      Logger.error('Logout service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
  
  // Forgot password
  Future<bool> forgotPassword({
    required String email,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      // Validate email
      final emailError = Validators.validateEmail(email);
      if (emailError != null) {
        onError(emailError);
        return false;
      }
      
      Logger.info('Attempting forgot password for email: $email');
      
      final response = await _authRepository.forgotPassword(email);
      
      return response.fold(
        onSuccess: (_) {
          Logger.info('Forgot password email sent successfully');
          onSuccess();
          UiUtils.showSuccessSnackBar(
            title: 'Email Sent',
            message: 'Password reset instructions sent to your email',
          );
          return true;
        },
        onError: (error) {
          Logger.error('Forgot password failed: $error');
          onError(error);
          UiUtils.showErrorSnackBar(
            title: 'Failed',
            message: error,
          );
          return false;
        },
      );
    } catch (e) {
      Logger.error('Forgot password service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
  
  // Reset password
  Future<bool> resetPassword({
    required String token,
    required String newPassword,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      // Validate new password
      final passwordError = Validators.validatePassword(newPassword);
      if (passwordError != null) {
        onError(passwordError);
        return false;
      }
      
      Logger.info('Attempting password reset');
      
      final response = await _authRepository.resetPassword(token, newPassword);
      
      return response.fold(
        onSuccess: (_) {
          Logger.info('Password reset successful');
          onSuccess();
          UiUtils.showSuccessSnackBar(
            title: 'Success',
            message: 'Password reset successfully',
          );
          return true;
        },
        onError: (error) {
          Logger.error('Password reset failed: $error');
          onError(error);
          UiUtils.showErrorSnackBar(
            title: 'Failed',
            message: error,
          );
          return false;
        },
      );
    } catch (e) {
      Logger.error('Password reset service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
  
  // Verify OTP
  Future<bool> verifyOtp({
    required String email,
    required String otp,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    try {
      // Validate email
      final emailError = Validators.validateEmail(email);
      if (emailError != null) {
        onError(emailError);
        return false;
      }
      
      // Validate OTP
      if (otp.isEmpty || otp.length != 6) {
        onError('Please enter a valid 6-digit OTP');
        return false;
      }
      
      Logger.info('Attempting OTP verification for email: $email');
      
      final response = await _authRepository.verifyOtp(email, otp);
      
      return response.fold(
        onSuccess: (_) {
          Logger.info('OTP verification successful');
          onSuccess();
          UiUtils.showSuccessSnackBar(
            title: 'Success',
            message: 'OTP verified successfully',
          );
          return true;
        },
        onError: (error) {
          Logger.error('OTP verification failed: $error');
          onError(error);
          UiUtils.showErrorSnackBar(
            title: 'Failed',
            message: error,
          );
          return false;
        },
      );
    } catch (e) {
      Logger.error('OTP verification service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
  
  // Get current user
  Future<UserModel?> getCurrentUser({
    Function(String)? onError,
  }) async {
    try {
      Logger.info('Fetching current user');
      
      final response = await _authRepository.getCurrentUser();
      
      return response.fold(
        onSuccess: (user) {
          Logger.info('Current user fetched successfully: ${user.email}');
          return user;
        },
        onError: (error) {
          Logger.error('Get current user failed: $error');
          onError?.call(error);
          return null;
        },
      );
    } catch (e) {
      Logger.error('Get current user service error', error: e);
      onError?.call('An unexpected error occurred');
      return null;
    }
  }
  
  // Check if user is logged in
  bool isLoggedIn() {
    return _authRepository.isLoggedIn();
  }
  
  // Refresh token
  Future<bool> refreshToken({
    required String refreshToken,
    required Function(LoginModel) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      Logger.info('Attempting token refresh');
      
      final response = await _authRepository.refreshToken(refreshToken);
      
      return response.fold(
        onSuccess: (loginModel) {
          Logger.info('Token refresh successful');
          onSuccess(loginModel);
          return true;
        },
        onError: (error) {
          Logger.error('Token refresh failed: $error');
          onError(error);
          return false;
        },
      );
    } catch (e) {
      Logger.error('Token refresh service error', error: e);
      onError('An unexpected error occurred');
      return false;
    }
  }
}