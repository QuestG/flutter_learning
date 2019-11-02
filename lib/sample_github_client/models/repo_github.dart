import 'package:flutter_learning/sample_github_client/models/user_git_hub.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repo_github.g.dart';

@JsonSerializable()
class Repo {
  final String id;
  final String name;
  @JsonKey(name: "full_name")
  final String fullName;
  final UserGitHub owner;
  final Repo parent;
  final bool private;
  final String description;
  final bool fork;
  final String language;
  @JsonKey(name: "forks_count")
  final int forksCount;
  @JsonKey(name: "stargazers_count")
  final int starCount;
  final int size;
  @JsonKey(name: "default_branch")
  final String defaultBranch;
  @JsonKey(name: "open_issues_count")
  final int openIssuesCount;
  @JsonKey(name: "pushed_at")
  final String pushedTime;
  @JsonKey(name: "created_at")
  final String createdTime;
  @JsonKey(name: "updated_at")
  final String updatedTime;
  @JsonKey(name: "subscribers_count")
  final int subscribeCount;
  final License license;

  Repo(
    this.id,
    this.name,
    this.fullName,
    this.private,
    this.description,
    this.fork,
    this.language,
    this.forksCount,
    this.starCount,
    this.size,
    this.defaultBranch,
    this.openIssuesCount,
    this.pushedTime,
    this.createdTime,
    this.updatedTime,
    this.subscribeCount, {
    UserGitHub user,
    License license,
    Repo parent,
  })  : owner = user,
        parent = parent,
        license = license;

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  Map<String, dynamic> toJson() => _$RepoToJson(this);
}

@JsonSerializable()
class License {
  final String key;
  final String name;
  @JsonKey(name: "spdx_id")
  final String spdxId;
  final String url;
  @JsonKey(name: "node_id")
  final String nodeId;

  License({this.key, this.spdxId, this.url, this.name, this.nodeId});

  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}

@JsonLiteral("../jsons/repo.json")
Map get repoData => _$repoDataJsonLiteral;
