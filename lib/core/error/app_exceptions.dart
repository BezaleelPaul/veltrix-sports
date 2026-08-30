class AppException implements Exception {
  final String message;
  final int? statusCode;
  final String? details;

  AppException({required this.message, this.statusCode, this.details});

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  NetworkException({String message = 'Network error occurred', int? statusCode, String? details})
      : super(message: message, statusCode: statusCode, details: details);
}

class AuthException extends AppException {
  AuthException({String message = 'Authentication error', int? statusCode, String? details})
      : super(message: message, statusCode: statusCode, details: details);
}

class ValidationException extends AppException {
  ValidationException({String message = 'Validation error', int? statusCode, String? details})
      : super(message: message, statusCode: statusCode, details: details);
}

class ServerException extends AppException {
  ServerException({String message = 'Server error occurred', int? statusCode, String? details})
      : super(message: message, statusCode: statusCode, details: details);
}

class CacheException extends AppException {
  CacheException({String message = 'Cache error occurred', int? statusCode, String? details})
      : super(message: message, statusCode: statusCode, details: details);
}

class PaymentException extends AppException {
  PaymentException({String message = 'Payment error occurred', int? statusCode, String? details})
      : super(message: message, statusCode: statusCode, details: details);
}

class PermissionException extends AppException {
  PermissionException({String message = 'Permission denied', int? statusCode, String? details})
      : super(message: message, statusCode: statusCode, details: details);
}
