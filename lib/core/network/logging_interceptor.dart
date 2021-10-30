import 'package:dio/dio.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  LoggingInterceptors(this._dio);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
      print("--> ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl) + (options.path)}");
      print("Headers:");
      options.headers.forEach((k, v) => print('$k: $v'));
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
      if (options.data != null) {
        print("Body: ${options.data}");
      }
      print("--> END ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'}");

      if (options.headers.containsKey('requirestoken')) {
        options.headers.remove('requirestoken');
        // options.headers.addAll({'Authorization': 'Bearer $accessToken'});
      }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
    print(
        // ignore: unnecessary_null_comparison
          "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    print("Headers:");
    response.headers.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
  }
  
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    print(
        "<-- ${err.message} ${(err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
    print(
        "${err.response != null ? err.response!.data : 'Unknown Error'}");
    print("<-- End error");

    // int responseCode = err.response!.statusCode!;
    // String oldAccessToken = globals.token;
    // if (oldAccessToken != null && responseCode == 401) {
    //   _dio.interceptors.requestLock.lock();
    //   _dio.interceptors.responseLock.lock();
    //
    //   String refreshToken = globals.refreshToken;
    //   UserRepository userRepository = UserRepository();
    //   Auth baseResp = await userRepository.refreshToken(refreshToken);
    //   globals.token = baseResp.accessToken;
    //   globals.refreshToken = baseResp.refreshToken;
    //
    //   RequestOptions options = err.response.request;
    //   options.headers.addAll({'requirestoken': true});
    //   _dio.interceptors.requestLock.unlock();
    //   _dio.interceptors.responseLock.unlock();
    //   return _dio.request(options.path, options: options);
    // } else {
    //   super.onError(err, handler);
    // }
    super.onError(err, handler);
  }

  // @override
  // Future onError(DioError? err) async {
  //  
  // }
}