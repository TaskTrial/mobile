import '../../core/network/api_client.dart';
import '../../core/network/api_response.dart';
import '../../core/storage/local_storage.dart';
import '../../core/utils/logger.dart';
import '../models/auth/login_model.dart';
import '../models/auth/user_model.dart';

abstract class AuthRepository {
  Future<ApiResponse<LoginModel>> login(String email, String password);
  Future<ApiResponse<void>> logout();
  Future<ApiResponse<void>> forgotPassword(String email);
  Future<ApiResponse<void>> resetPassword(String token, String newPassword);
  Future<ApiResponse<void>> verifyOtp(String email, String otp);
  Future<ApiResponse<UserModel>> getCurrentUser();
  Future<ApiResponse<LoginModel>> refreshToken(String refreshToken);
  bool isLoggedIn();
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;
  
  AuthRepositoryImpl({
    ApiClient? apiClient,
    LocalStorage? localStorage,
  }) : _apiClient = apiClient ?? ApiClient.instance,
       _localStorage = localStorage ?? LocalStorage.instance;
  
  @override
  Future<ApiResponse<LoginModel>> login(String email, String password) async {
    try {
      Logger.logApiRequest('POST', '/auth/signin', data: {
        'email': email,
        'password': password,
      });
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/signin',
        data: {
          'email': email,
          'password': password,
        },
      );
      
      if (response.isSuccess && response.hasData) {
        final loginModel = LoginModel.fromJson(response.data!);
        
        // Save tokens and user data
        await _saveAuthData(loginModel);
        
        Logger.logApiResponse('POST', '/auth/signin', 200, data: response.data);
        return ApiResponse.success(loginModel);
      } else {
        Logger.logApiError('POST', '/auth/signin', response.error ?? 'Unknown error');
        return response.transform((_) => LoginModel());
      }
    } catch (e) {
      Logger.error('Login failed', error: e);
      return ApiResponse.error('Login failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> logout() async {
    try {
      Logger.logApiRequest('POST', '/auth/logout');
      
      final response = await _apiClient.post<void>('/auth/logout');
      
      // Clear local storage regardless of API response
      await _localStorage.clearAuthData();
      
      if (response.isSuccess) {
        Logger.logApiResponse('POST', '/auth/logout', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('POST', '/auth/logout', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Logout failed', error: e);
      // Still clear local storage even if API call fails
      await _localStorage.clearAuthData();
      return ApiResponse.error('Logout failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> forgotPassword(String email) async {
    try {
      Logger.logApiRequest('POST', '/auth/forgotPassword', data: {'email': email});
      
      final response = await _apiClient.post<void>(
        '/auth/forgotPassword',
        data: {'email': email},
      );
      
      if (response.isSuccess) {
        Logger.logApiResponse('POST', '/auth/forgotPassword', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('POST', '/auth/forgotPassword', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Forgot password failed', error: e);
      return ApiResponse.error('Forgot password failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> resetPassword(String token, String newPassword) async {
    try {
      Logger.logApiRequest('POST', '/auth/resetPassword', data: {
        'token': token,
        'newPassword': newPassword,
      });
      
      final response = await _apiClient.post<void>(
        '/auth/resetPassword',
        data: {
          'token': token,
          'newPassword': newPassword,
        },
      );
      
      if (response.isSuccess) {
        Logger.logApiResponse('POST', '/auth/resetPassword', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('POST', '/auth/resetPassword', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Reset password failed', error: e);
      return ApiResponse.error('Reset password failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<void>> verifyOtp(String email, String otp) async {
    try {
      Logger.logApiRequest('POST', '/auth/verifyOtp', data: {
        'email': email,
        'otp': otp,
      });
      
      final response = await _apiClient.post<void>(
        '/auth/verifyOtp',
        data: {
          'email': email,
          'otp': otp,
        },
      );
      
      if (response.isSuccess) {
        Logger.logApiResponse('POST', '/auth/verifyOtp', 200);
        return ApiResponse.success(null);
      } else {
        Logger.logApiError('POST', '/auth/verifyOtp', response.error ?? 'Unknown error');
        return response.transform((_) => null);
      }
    } catch (e) {
      Logger.error('Verify OTP failed', error: e);
      return ApiResponse.error('Verify OTP failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<UserModel>> getCurrentUser() async {
    try {
      final userId = _localStorage.getUserId();
      if (userId == null) {
        return ApiResponse.error('User ID not found');
      }
      
      Logger.logApiRequest('GET', '/users/$userId');
      
      final response = await _apiClient.get<Map<String, dynamic>>('/users/$userId');
      
      if (response.isSuccess && response.hasData) {
        final userModel = UserModel.fromJson(response.data!);
        Logger.logApiResponse('GET', '/users/$userId', 200, data: response.data);
        return ApiResponse.success(userModel);
      } else {
        Logger.logApiError('GET', '/users/$userId', response.error ?? 'Unknown error');
        return response.transform((_) => UserModel());
      }
    } catch (e) {
      Logger.error('Get current user failed', error: e);
      return ApiResponse.error('Get current user failed: $e');
    }
  }
  
  @override
  Future<ApiResponse<LoginModel>> refreshToken(String refreshToken) async {
    try {
      Logger.logApiRequest('POST', '/auth/refreshToken', data: {'refreshToken': refreshToken});
      
      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/refreshToken',
        data: {'refreshToken': refreshToken},
      );
      
      if (response.isSuccess && response.hasData) {
        final loginModel = LoginModel.fromJson(response.data!);
        
        // Save new tokens
        await _saveAuthData(loginModel);
        
        Logger.logApiResponse('POST', '/auth/refreshToken', 200, data: response.data);
        return ApiResponse.success(loginModel);
      } else {
        Logger.logApiError('POST', '/auth/refreshToken', response.error ?? 'Unknown error');
        return response.transform((_) => LoginModel());
      }
    } catch (e) {
      Logger.error('Refresh token failed', error: e);
      return ApiResponse.error('Refresh token failed: $e');
    }
  }
  
  @override
  bool isLoggedIn() {
    return _localStorage.isLoggedIn();
  }
  
  // Helper method to save auth data
  Future<void> _saveAuthData(LoginModel loginModel) async {
    await _localStorage.saveAccessToken(loginModel.accessToken ?? '');
    await _localStorage.saveRefreshToken(loginModel.refreshToken ?? '');
    await _localStorage.saveUserId(loginModel.user?.id?.toString() ?? '');
    await _localStorage.saveUserEmail(loginModel.user?.email ?? '');
    await _localStorage.saveUserRole(loginModel.user?.role ?? '');
  }
}