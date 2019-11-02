import 'package:json_annotation/json_annotation.dart';

part 'user_git_hub.g.dart';

@JsonSerializable()
class UserGitHub {
  final String login;
  @JsonKey(name: "avatar_url")
  final String avatarUrl;
  final String type;
  final String name;
  final String company;
  final String blog;
  final String location;
  final String email;
  final String hireable;
  final String bio;
  @JsonKey(name: "public_repos")
  final String publicRepos;
  final String followers;
  final String following;
  @JsonKey(name: "created_at")
  final String createdTime;
  @JsonKey(name: "updated_at")
  final String updatedTime;
  @JsonKey(name: "total_private_repos")
  final String totalPrivateRepos;
  @JsonKey(name: "owned_private_repos")
  final String ownedPrivateRepos;

  UserGitHub(
      this.login,
      this.avatarUrl,
      this.type,
      this.name,
      this.company,
      this.blog,
      this.location,
      this.email,
      this.hireable,
      this.bio,
      this.publicRepos,
      this.followers,
      this.following,
      this.createdTime,
      this.updatedTime,
      this.totalPrivateRepos,
      this.ownedPrivateRepos);

  factory UserGitHub.fromJson(Map<String, dynamic> json) =>
      _$UserGitHubFromJson(json);
  Map<String, dynamic> toJson() => _$UserGitHubToJson(this);
}

@JsonLiteral("../jsons/user.json")
Map get userData => _$userDataJsonLiteral;
