// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_git_hub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGitHub _$UserGitHubFromJson(Map<String, dynamic> json) {
  return UserGitHub(
    json['login'] as String,
    json['avatar_url'] as String,
    json['type'] as String,
    json['name'] as String,
    json['company'] as String,
    json['blog'] as String,
    json['location'] as String,
    json['email'] as String,
    json['hireable'] as String,
    json['bio'] as String,
    json['public_repos'] as String,
    json['followers'] as String,
    json['following'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['total_private_repos'] as String,
    json['owned_private_repos'] as String,
  );
}

Map<String, dynamic> _$UserGitHubToJson(UserGitHub instance) =>
    <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'type': instance.type,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'hireable': instance.hireable,
      'bio': instance.bio,
      'public_repos': instance.publicRepos,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.createdTime,
      'updated_at': instance.updatedTime,
      'total_private_repos': instance.totalPrivateRepos,
      'owned_private_repos': instance.ownedPrivateRepos,
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$userDataJsonLiteral = {
  'login': 'octocat',
  'avatar_url': 'https://github.com/images/error/octocat_happy.gif',
  'type': 'User',
  'name': 'monalisa octocat',
  'company': 'GitHub',
  'blog': 'https://github.com/blog',
  'location': 'San Francisco',
  'email': 'octocat@github.com',
  'hireable': false,
  'bio': 'There once was...',
  'public_repos': 2,
  'followers': 20,
  'following': 0,
  'created_at': '2008-01-14T04:33:35Z',
  'updated_at': '2008-01-14T04:33:35Z',
  'total_private_repos': 100,
  'owned_private_repos': 100
};
