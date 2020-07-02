// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_dc.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DemoDC> _$demoDCSerializer = new _$DemoDCSerializer();

class _$DemoDCSerializer implements StructuredSerializer<DemoDC> {
  @override
  final Iterable<Type> types = const [DemoDC, _$DemoDC];
  @override
  final String wireName = 'DemoDC';

  @override
  Iterable<Object> serialize(Serializers serializers, DemoDC object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.code != null) {
      result
        ..add('code')
        ..add(serializers.serialize(object.code,
            specifiedType: const FullType(int)));
    }
    if (object.message != null) {
      result
        ..add('message')
        ..add(serializers.serialize(object.message,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  DemoDC deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DemoDCBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DemoDC extends DemoDC {
  @override
  final int code;
  @override
  final String message;

  factory _$DemoDC([void Function(DemoDCBuilder) updates]) =>
      (new DemoDCBuilder()..update(updates)).build();

  _$DemoDC._({this.code, this.message}) : super._();

  @override
  DemoDC rebuild(void Function(DemoDCBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DemoDCBuilder toBuilder() => new DemoDCBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DemoDC && code == other.code && message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, code.hashCode), message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DemoDC')
          ..add('code', code)
          ..add('message', message))
        .toString();
  }
}

class DemoDCBuilder implements Builder<DemoDC, DemoDCBuilder> {
  _$DemoDC _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  DemoDCBuilder();

  DemoDCBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DemoDC other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DemoDC;
  }

  @override
  void update(void Function(DemoDCBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DemoDC build() {
    final _$result = _$v ?? new _$DemoDC._(code: code, message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
