// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CacheConfig _$CacheConfigFromJson(Map<String, dynamic> json) {
  return CacheConfig(
    enable: json['enable'] as bool,
    maxAge: json['maxAge'] as int,
    maxCount: json['maxCount'] as int,
  );
}

Map<String, dynamic> _$CacheConfigToJson(CacheConfig instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'maxAge': instance.maxAge,
      'maxCount': instance.maxCount,
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$cacheConfigJsonLiteral = {
  'enable': true,
  'maxAge': 1000,
  'maxCount': 100
};