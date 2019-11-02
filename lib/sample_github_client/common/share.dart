import 'package:flutter/material.dart';
import 'package:flutter_learning/sample_github_client/models/profile.dart';
import 'package:flutter_learning/sample_github_client/models/user_git_hub.dart';

import 'global.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

///用户状态在登录状态发生变化时更新、通知其依赖项
class UserModel extends ProfileChangeNotifier {
  UserGitHub get user => _profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变更，通知其widgets更新
  set user(UserGitHub user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = user.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

///主题状态在用户更换APP主题时更新、通知其依赖项
class ThemeModel extends ProfileChangeNotifier {
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.blue);

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var languages = _profile.locale.split("_");
    return Locale(languages[0], languages[1]);
  }

  // 获取当前Locale的字符串表示
  String get locale => _profile.locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
