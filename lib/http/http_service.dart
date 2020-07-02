import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:flutter_scaffold/data_class/demo_dc.dart';
import 'package:flutter_scaffold/http/api_address.dart';
import 'package:flutter_scaffold/http/http_base.dart';
import 'package:flutter_scaffold/serializer/serializers.dart';

class HttpService {
  static T serialize<T>(Serializer<T> serializer, Response response) {
    if (response != null) {
      return standardSerializers.deserializeWith(serializer, response.data);
    } else {
      return null;
    }
  }

  ///检查更新
  static Future<DemoDC> checkVersion() async {
    Response response = await HttpBase().post(
      ApiAddress.baseUrl,
      data: {},
    );
    return serialize(DemoDC.serializer, response);
  }
}
