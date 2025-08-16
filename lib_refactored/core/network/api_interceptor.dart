import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../storage/local_storage.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add auth token if available
    final token = LocalStorage.instance.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    if (kDebugMode) {
      print('🌐 API Request: ${options.method} ${options.path}');
      print('📤 Headers: ${options.headers}');
      if (options.data != null) {
        print('📦 Data: ${options.data}');
      }
    }
    
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('✅ API Response: ${response.statusCode} ${response.requestOptions.path}');
      print('📥 Data: ${response.data}');
    }
    
    handler.next(response);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('❌ API Error: ${err.type} - ${err.message}');
      print('🔗 URL: ${err.requestOptions.path}');
      print('📊 Status: ${err.response?.statusCode}');
      print('📥 Response: ${err.response?.data}');
    }
    
    // Handle token refresh logic here if needed
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh
      _handleTokenRefresh(err, handler);
      return;
    }
    
    handler.next(err);
  }
  
  Future<void> _handleTokenRefresh(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final refreshToken = LocalStorage.instance.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        // No refresh token, redirect to login
        LocalStorage.instance.clearAuthData();
        handler.next(err);
        return;
      }
      
      // Create a new Dio instance for token refresh to avoid infinite loop
      final dio = Dio();
      final response = await dio.post(
        '${err.requestOptions.baseUrl}/auth/refreshToken',
        data: {'refreshToken': refreshToken},
      );
      
      if (response.statusCode == 200) {
        final newToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];
        
        // Save new tokens
        LocalStorage.instance.saveAccessToken(newToken);
        LocalStorage.instance.saveRefreshToken(newRefreshToken);
        
        // Retry original request with new token
        final originalRequest = err.requestOptions;
        originalRequest.headers['Authorization'] = 'Bearer $newToken';
        
        final retryResponse = await dio.fetch(originalRequest);
        handler.resolve(retryResponse);
      } else {
        // Refresh failed, redirect to login
        LocalStorage.instance.clearAuthData();
        handler.next(err);
      }
    } catch (e) {
      if (kDebugMode) {
        print('🔄 Token refresh failed: $e');
      }
      LocalStorage.instance.clearAuthData();
      handler.next(err);
    }
  }
}