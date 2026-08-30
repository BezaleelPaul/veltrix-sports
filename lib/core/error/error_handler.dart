import 'package:dio/dio.dart';
import 'app_exceptions.dart';

class ErrorHandler {
  static AppException handle(dynamic error) {
    if (error is AppException) {
      return error;
    }

    if (error is DioException) {
      return _handleDioError(error);
    }

    return AppException(message: error.toString());
  }

  static AppException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(message: 'Connection timeout. Please try again.');

      case DioExceptionType.connectionError:
        return NetworkException(message: 'No internet connection.');

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return AppException(message: 'Request was cancelled.');

      case DioExceptionType.unknown:
      default:
        return AppException(message: 'An unexpected error occurred.');
    }
  }

  static AppException _handleBadResponse(Response? response) {
    if (response == null) {
      return ServerException(message: 'No response from server.');
    }

    final statusCode = response.statusCode;
    final data = response.data;

    String message;
    switch (statusCode) {
      case 400:
        message = data['message'] ?? 'Bad request.';
        return ValidationException(message: message);
      case 401:
        message = data['message'] ?? 'Unauthorized. Please login again.';
        return AuthException(message: message);
      case 403:
        message = data['message'] ?? 'Access denied.';
        return AppException(message: message, statusCode: statusCode);
      case 404:
        message = data['message'] ?? 'Resource not found.';
        return AppException(message: message, statusCode: statusCode);
      case 422:
        message = data['message'] ?? 'Validation error.';
        return ValidationException(message: message);
      case 500:
        message = data['message'] ?? 'Internal server error.';
        return ServerException(message: message, statusCode: statusCode);
      default:
        message = data['message'] ?? 'Server error.';
        return ServerException(message: message, statusCode: statusCode);
    }
  }

  static String getErrorMessage(dynamic error) {
    final appException = handle(error);
    return appException.message;
  }
}
