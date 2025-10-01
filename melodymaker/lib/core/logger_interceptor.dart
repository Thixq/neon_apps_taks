import 'package:dio/dio.dart';

/// Dio Interceptor for logging requests & responses
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("🚀 [REQUEST] => ${options.method} ${options.uri}");
    print("Headers: ${options.headers}");
    print("Data: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("✅ [RESPONSE] => ${response.statusCode} ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("❌ [ERROR] => ${err.message}");
    super.onError(err, handler);
  }
}
