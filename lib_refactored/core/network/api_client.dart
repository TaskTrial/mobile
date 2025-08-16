import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../storage/local_storage.dart';
import 'api_interceptor.dart';
import 'api_response.dart';

class ApiClient {
  static ApiClient? _instance;
  late Dio _dio;
  
  ApiClient._() {
    _dio = Dio(_createDioOptions());
    _dio.interceptors.add(ApiInterceptor());
  }
  
  static ApiClient get instance {
    _instance ??= ApiClient._();
    return _instance!;
  }
  
  BaseOptions _createDioOptions() {
    return BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: Duration(milliseconds: AppConstants.connectionTimeout),
      receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
  
  // GET request
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }
  
  // POST request
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }
  
  // PUT request
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }
  
  // DELETE request
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }
  
  // PATCH request
  Future<ApiResponse<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse.success(response.data as T);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }
  
  ApiResponse<T> _handleDioError<T>(DioException e) {
    if (kDebugMode) {
      print('DioError: ${e.type} - ${e.message}');
    }
    
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiResponse.error('Request timeout. Please try again.');
        
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Server error occurred';
        
        if (statusCode == 401) {
          // Handle unauthorized - trigger token refresh or logout
          _handleUnauthorized();
          return ApiResponse.error('Session expired. Please login again.');
        } else if (statusCode == 403) {
          return ApiResponse.error('Access denied.');
        } else if (statusCode == 404) {
          return ApiResponse.error('Resource not found.');
        } else if (statusCode == 500) {
          return ApiResponse.error('Internal server error.');
        } else {
          return ApiResponse.error(message);
        }
        
      case DioExceptionType.cancel:
        return ApiResponse.error('Request was cancelled.');
        
      case DioExceptionType.connectionError:
        return ApiResponse.error('No internet connection.');
        
      case DioExceptionType.badCertificate:
        return ApiResponse.error('Certificate error.');
        
      case DioExceptionType.unknown:
      default:
        return ApiResponse.error('An unexpected error occurred.');
    }
  }
  
  void _handleUnauthorized() {
    // Clear stored tokens and redirect to login
    LocalStorage.instance.clearAuthData();
    // You can add navigation logic here if needed
  }
  
  // Set authorization header
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
  
  // Clear authorization header
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}