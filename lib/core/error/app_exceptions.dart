class AppException implements Exception {
  final String message;
  final int? statusCode;
  final String? code;

  AppException({
    required this.message,
    this.statusCode,
    this.code,
  });

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({String? message})
      : super(
          message: message ?? 'Network error occurred. Please check your connection.',
          code: 'NETWORK_ERROR',
        );
}

class AuthException extends AppException {
  AuthException({String? message})
      : super(
          message: message ?? 'Authentication failed.',
          code: 'AUTH_ERROR',
        );
}

class ValidationException extends AppException {
  ValidationException({String? message})
      : super(
          message: message ?? 'Validation error.',
          code: 'VALIDATION_ERROR',
        );
}

class ServerException extends AppException {
  ServerException({String? message, int? statusCode})
      : super(
          message: message ?? 'Server error occurred.',
          statusCode: statusCode,
          code: 'SERVER_ERROR',
        );
}

class CacheException extends AppException {
  CacheException({String? message})
      : super(
          message: message ?? 'Cache error occurred.',
          code: 'CACHE_ERROR',
        );
}

class PaymentException extends AppException {
  PaymentException({String? message})
      : super(
          message: message ?? 'Payment failed.',
          code: 'PAYMENT_ERROR',
        );
}

class PermissionException extends AppException {
  PermissionException({String? message})
      : super(
          message: message ?? 'Permission denied.',
          code: 'PERMISSION_ERROR',
        );
}
