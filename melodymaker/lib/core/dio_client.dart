import 'package:dio/dio.dart';
import 'logger_interceptor.dart';

/// Dio client setup with baseUrl and logger interceptor
class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    dio.interceptors.add(LoggerInterceptor());
  }
}
