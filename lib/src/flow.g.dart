// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowValue<Type> _$FlowValueFromJson<Type>(
  Map<String, dynamic> json,
  Type Function(Object? json) fromJsonType,
) {
  return FlowValue<Type>(
    fromJsonType(json['value']),
  );
}

Map<String, dynamic> _$FlowValueToJson<Type>(
  FlowValue<Type> instance,
  Object? Function(Type value) toJsonType,
) =>
    <String, dynamic>{
      'value': toJsonType(instance.value),
    };

FlowInt _$FlowIntFromJson(Map<String, dynamic> json) {
  return FlowInt(
    json['value'] as int,
  );
}

Map<String, dynamic> _$FlowIntToJson(FlowInt instance) => <String, dynamic>{
      'value': instance.value,
    };

FlowDouble _$FlowDoubleFromJson(Map<String, dynamic> json) {
  return FlowDouble(
    (json['value'] as num).toDouble(),
  );
}

Map<String, dynamic> _$FlowDoubleToJson(FlowDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

FlowString _$FlowStringFromJson(Map<String, dynamic> json) {
  return FlowString(
    json['value'] as String,
  );
}

Map<String, dynamic> _$FlowStringToJson(FlowString instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

FlowBool _$FlowBoolFromJson(Map<String, dynamic> json) {
  return FlowBool(
    json['value'] as bool,
  );
}

Map<String, dynamic> _$FlowBoolToJson(FlowBool instance) => <String, dynamic>{
      'value': instance.value,
    };

FlowListString _$FlowListStringFromJson(Map<String, dynamic> json) {
  return FlowListString(
    (json['value'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$FlowListStringToJson(FlowListString instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

FlowListNum _$FlowListNumFromJson(Map<String, dynamic> json) {
  return FlowListNum(
    (json['value'] as List<dynamic>).map((e) => e as num).toList(),
  );
}

Map<String, dynamic> _$FlowListNumToJson(FlowListNum instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

FlowMap _$FlowMapFromJson(Map<String, dynamic> json) {
  return FlowMap(
    json['value'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$FlowMapToJson(FlowMap instance) => <String, dynamic>{
      'value': instance.value,
    };

FlowSetString _$FlowSetStringFromJson(Map<String, dynamic> json) {
  return FlowSetString(
    (json['value'] as List<dynamic>).map((e) => e as String).toSet(),
  );
}

Map<String, dynamic> _$FlowSetStringToJson(FlowSetString instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
    };

FlowSetInt _$FlowSetIntFromJson(Map<String, dynamic> json) {
  return FlowSetInt(
    (json['value'] as List<dynamic>).map((e) => e as int).toSet(),
  );
}

Map<String, dynamic> _$FlowSetIntToJson(FlowSetInt instance) =>
    <String, dynamic>{
      'value': instance.value.toList(),
    };

FlowVoid _$FlowVoidFromJson(Map<String, dynamic> json) {
  return FlowVoid();
}

Map<String, dynamic> _$FlowVoidToJson(FlowVoid instance) => <String, dynamic>{};
