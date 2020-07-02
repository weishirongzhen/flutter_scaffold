import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scaffold/extensions.dart';
class CustomLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    if (kDebugMode) {
      print(">>>>>>>>>>>>>请求数据>>>>>>>>>>>>> ${DateTime.now().millisecondsSinceEpoch.toFormattedTime()}");
      print('${options.method}\n ${options.headers} \n${options.uri} ${options.data.toString()}');
      print(">>>>>>>>>>>>>请求数据结束>>>>>>>>>>>>>");
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    if (kDebugMode) {
      print("<<<<<<<<<<<<<返回数据<<<<<<<<<<<<< ${DateTime.now().millisecondsSinceEpoch.toFormattedTime()}");
      print('${response.request.uri} $response');
      print("<<<<<<<<<<<<<返回数据结束<<<<<<<<<<<<<");
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    if (kDebugMode) print('-------------错误-------------  ${err.request.uri} $err');
    return super.onError(err);
  }
}
