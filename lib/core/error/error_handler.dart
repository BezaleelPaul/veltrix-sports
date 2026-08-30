import 'package:dio/dio.dart';
import 'app_exceptions.dart';

class ErrorHandler {
  static AppException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(message: 'Connection timeout. Please try again.');
      case DioExceptionType.connectionError:
        return NetworkException(message: 'No internet connection.');
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response?.statusCode, error.response?.data);
      case DioExceptionType.cancel:
        return NetworkException(message: 'Request was cancelled.');
      default:
        return NetworkException(message: 'An unexpected error occurred.');
    }
  }

  static AppException _handleResponseError(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return ValidationException(message: data['message'] ?? 'Bad request.');
      case 401:
        return AuthException(message: 'Unauthorized. Please login again.');
      case 403:
        return AuthException(message: 'Access denied.');
      case 404:
        return ServerException(message: 'Resource not found.');
      case 500:
        return ServerException(message: 'Internal server error.');
      default:
        return ServerException(message: 'Something went wrong.');
    }
  }
}
