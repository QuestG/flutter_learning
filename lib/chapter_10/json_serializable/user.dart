import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User {
  User(this.name, this.email);

  String name;
  String email;
  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// 此处需要指定json的示例数据，否则执行命令并不会生成user.g.dart
///
/// 一次行生成的命令：flutter packages pub run build_runner build
/// watcher 持续生成：flutter packages pub run build_runner watch
/// 只需启动一次观察器，然后它就会在后台运行，这是安全的。
///
@JsonLiteral("user.json")
Map get userData => _$userDataJsonLiteral;
