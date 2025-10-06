import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

/// Dio Interceptor for logging requests & responses
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("🚀 [REQUEST] => ${options.method} ${options.uri}");
    debugPrint("Headers: ${options.headers}");
    debugPrint("Data: ${options.data}");
    options.headers = {"Content-Type": "application/json"};
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("✅ [RESPONSE] => ${response.statusCode} ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("❌ [ERROR] => ${err.message}");
    super.onError(err, handler);
  }
}
