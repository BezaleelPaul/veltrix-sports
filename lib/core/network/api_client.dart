import 'package:dio/dio.dart';
import '../error/app_exceptions.dart';
import '../error/error_handler.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  
  late final Dio _dio;

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.veltrixsports.com/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token
        handler.next(options);
      },
      onError: (error, handler) {
        final appException = ErrorHandler.handleDioError(error);
        handler.next(error);
      },
    ));
  }

  Dio get dio => _dio;
}
