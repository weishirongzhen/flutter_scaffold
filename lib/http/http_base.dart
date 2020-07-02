import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_scaffold/events.dart';
import 'package:flutter_scaffold/flutter_bus.dart';
import 'package:flutter_scaffold/http/api_address.dart';
import 'package:flutter_scaffold/http/interceptors/custom_error_interceptor.dart';
import 'package:flutter_scaffold/http/interceptors/custom_header_interceptor.dart';
import 'package:flutter_scaffold/http/interceptors/custom_log_interceptor.dart';

typedef HttpSuccessCallback = void Function(Response response);
typedef HttpFailedCallback = void Function(DioError dioError);

class HttpBase {
  factory HttpBase() => _getInstance();
  static HttpBase _instance;
  Dio _dio;
  DioCacheManager _dioCacheManager;
  CancelToken cancelToken = CancelToken();

  HttpBase._() {
    _dio = Dio();

    BaseOptions();
    _dioCacheManager = DioCacheManager(CacheConfig(baseUrl: ApiAddress.baseUrl));
    _dio.options.connectTimeout = 5000; //毫秒
    _dio.options.receiveTimeout = 5000; // 毫秒
    _dio.options.contentType = Headers.formUrlEncodedContentType;
    var cookieJar=CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.add(_dioCacheManager.interceptor);
    _dio.interceptors.add(CustomErrorInterceptor());
    _dio.interceptors.add(CustomHeaderInterceptor());
    _dio.interceptors.add(CustomLogInterceptor());
    _dio.interceptors.add(RetryInterceptor(
        dio: _dio,
        options: const RetryOptions(
          retries: 3, // Number of retries before a failure
          retryInterval: const Duration(milliseconds: 500), // Interval between each retry
        )));

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
  }

  void cancelAll() {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
    }
  }

  static HttpBase _getInstance() {
    if (_instance == null) {
      _instance = HttpBase._();
    }
    return _instance;
  }

  Response _process(Response response) {
    //如果需要在解析前处理数据，则在这处理
    return response;
  }

  Future<Response> get(
    String path, {
    String baseUrl = ApiAddress.baseUrl,
    Map<String, dynamic> params,
    Options options,
    ProgressCallback onReceiveProgress,
    HttpSuccessCallback successCallback,
    HttpFailedCallback failedCallback,
  }) async {
    try {
      Response response = await _dio.get(
        baseUrl + path,
        queryParameters: params,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      if (successCallback != null) {
        successCallback(_process(response));
      }
      return _process(response);
    } on DioError catch (e) {
      if (failedCallback != null) {
        failedCallback(e);
      } else {
        FlutterBus().postEvent(DioErrorEvent(e));
      }
      return null;
    }
  }

  Future<Response> post(
    String path, {
    String baseUrl = ApiAddress.baseUrl,
    Map<String, dynamic> params,
    Map<String, dynamic> data,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    HttpSuccessCallback successCallback,
    HttpFailedCallback failedCallback,
  }) async {
    try {
      var response = await _dio.post(
        baseUrl + path,
        queryParameters: params,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      if (successCallback != null) {
        successCallback(_process(response));
      }
      return _process(response);
    } on DioError catch (e) {
      if (failedCallback != null) {
        failedCallback(e);
      } else {
        FlutterBus().postEvent(DioErrorEvent(e));
      }
      return null;
    }
  }

  Future<Response> patch(
    String path, {
    String baseUrl = ApiAddress.baseUrl,
    dynamic data,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    HttpSuccessCallback successCallback,
    HttpFailedCallback failedCallback,
  }) async {
    try {
      var response = await _dio.patch(
        baseUrl + path,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      if (successCallback != null) {
        successCallback(_process(response));
      }
      return _process(response);
    } on DioError catch (e) {
      if (failedCallback != null) {
        failedCallback(e);
      } else {
        FlutterBus().postEvent(DioErrorEvent(e));
      }
      return null;
    }
  }

  Future<Response> delete(
    String path, {
    String baseUrl = ApiAddress.baseUrl,
    Map<String, dynamic> params,
    dynamic data,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailedCallback failedCallback,
  }) async {
    try {
      var response = await _dio.delete(
        baseUrl + path,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      if (successCallback != null) {
        successCallback(_process(response));
      }
      return _process(response);
    } on DioError catch (e) {
      if (failedCallback != null) {
        failedCallback(e);
      } else {
        FlutterBus().postEvent(DioErrorEvent(e));
      }
      return null;
    }
  }

  Future<Response> download(String url, String savePath, {ProgressCallback callback}) async {
    try {
      var response = await _dio.download(url, savePath, onReceiveProgress: callback);

      return _process(response);
    } on DioError catch (e) {
      FlutterBus().postEvent(DioErrorEvent(e));
      return null;
    }
  }
}
