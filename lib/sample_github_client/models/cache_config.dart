import 'package:json_annotation/json_annotation.dart';

part 'cache_config.g.dart';

@JsonSerializable()
class CacheConfig {
  bool enable;
  int maxAge;
  int maxCount;

  CacheConfig({this.enable, this.maxAge, this.maxCount});

  factory CacheConfig.fromJson(Map<String, dynamic> json) =>
      _$CacheConfigFromJson(json);

  Map<String, dynamic> toJson() => _$CacheConfigToJson(this);
}

@JsonLiteral("../jsons/cache_config.json")
Map get cacheConfig => _$cacheConfigJsonLiteral;
