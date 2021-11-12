
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'cache_logging.dart';
import 'logging_interceptor.dart';

class BaseDio{

  Dio get dio => _dio();

   Response? response;

  Dio _dio() {


    final options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
      contentType:  "application/json;charset=utf-8",
    );

    var dio = Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.interceptors..add(CacheInterceptor())
      ..add(LoggingInterceptors(dio));

    return dio;
  }

}