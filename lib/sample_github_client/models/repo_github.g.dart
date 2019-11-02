// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_github.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return Repo(
    json['id'] as String,
    json['name'] as String,
    json['full_name'] as String,
    json['private'] as bool,
    json['description'] as String,
    json['fork'] as bool,
    json['language'] as String,
    json['forks_count'] as int,
    json['stargazers_count'] as int,
    json['size'] as int,
    json['default_branch'] as String,
    json['open_issues_count'] as int,
    json['pushed_at'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['subscribers_count'] as int,
    user: json['owner'] == null
        ? null
        : UserGitHub.fromJson(json['owner'] as Map<String, dynamic>),
    license: json['license'] == null
        ? null
        : License.fromJson(json['license'] as Map<String, dynamic>),
    parent: json['parent'] == null
        ? null
        : Repo.fromJson(json['parent'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'user': instance.owner,
      'parent': instance.parent,
      'private': instance.private,
      'description': instance.description,
      'fork': instance.fork,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'stargazers_count': instance.starCount,
      'size': instance.size,
      'default_branch': instance.defaultBranch,
      'open_issues_count': instance.openIssuesCount,
      'pushed_at': instance.pushedTime,
      'created_at': instance.createdTime,
      'updated_at': instance.updatedTime,
      'subscribers_count': instance.subscribeCount,
      'license': instance.license,
    };

License _$LicenseFromJson(Map<String, dynamic> json) {
  return License(
    key: json['key'] as String,
    spdxId: json['spdx_id'] as String,
    url: json['url'] as String,
    name: json['name'] as String,
    nodeId: json['node_id'] as String,
  );
}

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'spdx_id': instance.spdxId,
      'url': instance.url,
      'node_id': instance.nodeId,
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$repoDataJsonLiteral = {
  'id': 1296269,
  'name': 'Hello-World',
  'full_name': 'octocat/Hello-World',
  'owner': r'$user',
  'parent': r'$repo',
  'private': false,
  'description': 'This your first repo!',
  'fork': false,
  'language': 'JavaScript',
  'forks_count': 9,
  'stargazers_count': 80,
  'size': 108,
  'default_branch': 'master',
  'open_issues_count': 2,
  'pushed_at': '2011-01-26T19:06:43Z',
  'created_at': '2011-01-26T19:01:12Z',
  'updated_at': '2011-01-26T19:14:43Z',
  'subscribers_count': 42,
  'license': {
    'key': 'mit',
    'name': 'MIT License',
    'spdx_id': 'MIT',
    'url': 'https://api.github.com/licenses/mit',
    'node_id': 'MDc6TGljZW5zZW1pdA=='
  }
};
