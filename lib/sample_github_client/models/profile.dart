import 'package:flutter_learning/sample_github_client/models/cache_config.dart';
import 'package:flutter_learning/sample_github_client/models/user_git_hub.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  UserGitHub user;
  String token;
  int theme;
  CacheConfig cache;
  String lastLogin;
  String locale;

  Profile(
      {this.user,
      this.token,
      this.theme,
      this.cache,
      this.lastLogin,
      this.locale});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonLiteral('../jsons/profile.json')
Map get profileData => _$profileDataJsonLiteral;
