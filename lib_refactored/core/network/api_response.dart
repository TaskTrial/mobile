class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool isSuccess;
  final int? statusCode;
  
  ApiResponse._({
    this.data,
    this.error,
    required this.isSuccess,
    this.statusCode,
  });
  
  factory ApiResponse.success(T data, {int? statusCode}) {
    return ApiResponse._(
      data: data,
      isSuccess: true,
      statusCode: statusCode,
    );
  }
  
  factory ApiResponse.error(String error, {int? statusCode}) {
    return ApiResponse._(
      error: error,
      isSuccess: false,
      statusCode: statusCode,
    );
  }
  
  factory ApiResponse.loading() {
    return ApiResponse._(
      isSuccess: false,
      error: 'Loading...',
    );
  }
  
  // Helper methods
  bool get hasData => data != null;
  bool get hasError => error != null && error!.isNotEmpty;
  
  // Transform data if needed
  ApiResponse<R> transform<R>(R Function(T) transform) {
    if (isSuccess && hasData) {
      return ApiResponse.success(transform(data as T), statusCode: statusCode);
    }
    return ApiResponse.error(error ?? 'Unknown error', statusCode: statusCode);
  }
  
  // Handle success and error cases
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(String error) onError,
  }) {
    if (isSuccess && hasData) {
      return onSuccess(data as T);
    }
    return onError(error ?? 'Unknown error');
  }
  
  // Execute callback on success
  ApiResponse<T> onSuccess(void Function(T data) callback) {
    if (isSuccess && hasData) {
      callback(data as T);
    }
    return this;
  }
  
  // Execute callback on error
  ApiResponse<T> onError(void Function(String error) callback) {
    if (hasError) {
      callback(error!);
    }
    return this;
  }
  
  @override
  String toString() {
    return 'ApiResponse{data: $data, error: $error, isSuccess: $isSuccess, statusCode: $statusCode}';
  }
}