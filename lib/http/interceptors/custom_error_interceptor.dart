import 'package:dio/dio.dart';
import 'package:flutter_scaffold/events.dart';
import 'package:flutter_scaffold/flutter_bus.dart';

class CustomErrorInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    FlutterBus().postEvent(DioErrorEvent(err));

    return super.onError(err);
  }
}
