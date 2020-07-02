import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_scaffold/serializer/serializers.dart';

part 'demo_dc.g.dart';

abstract class DemoDC implements Built<DemoDC, DemoDCBuilder> {
  static Serializer<DemoDC> get serializer => _$demoDCSerializer;

  DemoDC._();

  @nullable
  int get code;

  @nullable
  String get message;

  factory DemoDC([void Function(DemoDCBuilder) updates]) = _$DemoDC;

  String toJson() {
    return jsonEncode(standardSerializers.serializeWith(serializer, this));
  }

  static DemoDC fromJson(String jsonString) {
    return standardSerializers.deserializeWith(serializer, jsonDecode(jsonString));
  }
}

