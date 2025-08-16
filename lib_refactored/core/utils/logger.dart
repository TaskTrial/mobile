import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

class Logger {
  static const String _tag = 'TaskTrial';
  
  static void debug(String message, {String? tag}) {
    _log(LogLevel.debug, message, tag: tag);
  }
  
  static void info(String message, {String? tag}) {
    _log(LogLevel.info, message, tag: tag);
  }
  
  static void warning(String message, {String? tag}) {
    _log(LogLevel.warning, message, tag: tag);
  }
  
  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, tag: tag, error: error, stackTrace: stackTrace);
  }
  
  static void fatal(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.fatal, message, tag: tag, error: error, stackTrace: stackTrace);
  }
  
  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;
    
    final timestamp = DateTime.now().toIso8601String();
    final levelString = level.name.toUpperCase();
    final tagString = tag ?? _tag;
    
    final logMessage = '[$timestamp] $levelString/$tagString: $message';
    
    switch (level) {
      case LogLevel.debug:
        print('🐛 $logMessage');
        break;
      case LogLevel.info:
        print('ℹ️ $logMessage');
        break;
      case LogLevel.warning:
        print('⚠️ $logMessage');
        break;
      case LogLevel.error:
        print('❌ $logMessage');
        if (error != null) {
          print('Error details: $error');
        }
        if (stackTrace != null) {
          print('Stack trace: $stackTrace');
        }
        break;
      case LogLevel.fatal:
        print('💀 $logMessage');
        if (error != null) {
          print('Fatal error details: $error');
        }
        if (stackTrace != null) {
          print('Stack trace: $stackTrace');
        }
        break;
    }
  }
  
  // API logging helpers
  static void logApiRequest(String method, String url, {Map<String, dynamic>? data}) {
    debug('API Request: $method $url', tag: 'API');
    if (data != null) {
      debug('Request data: $data', tag: 'API');
    }
  }
  
  static void logApiResponse(String method, String url, int statusCode, {dynamic data}) {
    final emoji = statusCode >= 200 && statusCode < 300 ? '✅' : '❌';
    debug('$emoji API Response: $method $url - $statusCode', tag: 'API');
    if (data != null) {
      debug('Response data: $data', tag: 'API');
    }
  }
  
  static void logApiError(String method, String url, String error) {
    error('API Error: $method $url - $error', tag: 'API');
  }
  
  // Navigation logging
  static void logNavigation(String from, String to) {
    info('Navigation: $from → $to', tag: 'Navigation');
  }
  
  // State management logging
  static void logStateChange(String controller, String state) {
    debug('State change in $controller: $state', tag: 'State');
  }
  
  // Performance logging
  static void logPerformance(String operation, Duration duration) {
    if (duration.inMilliseconds > 100) {
      warning('Slow operation: $operation took ${duration.inMilliseconds}ms', tag: 'Performance');
    } else {
      debug('Operation: $operation took ${duration.inMilliseconds}ms', tag: 'Performance');
    }
  }
}