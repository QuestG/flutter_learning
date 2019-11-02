import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learning/sample_github_client/models/cache_config.dart';
import 'package:flutter_learning/sample_github_client/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'net.dart';

//主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

///管理APP的全局变量
///
/// 需要全局共享的信息分为两类：全局变量和共享状态。全局变量就是单纯指会贯穿整个APP生命周期的变量，
/// 用于单纯的保存一些信息，或者封装一些全局工具和方法的对象。而共享状态则是指哪些需要跨组件或跨路由共享的信息，
/// 这些信息通常也是全局变量，而共享状态和全局变量的不同在于前者发生改变时需要通知所有使用该状态的组件，而后者不需要。
class Global {
  static SharedPreferences _preferences;
  static Profile profile = Profile();

  //网络缓存对象
  static NetCache netCache;

  //可选的主题列表
  static List<MaterialColor> get themes => _themes;

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，在App启动时执行。
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    var _profile = _preferences.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    //如果没有缓存策略，则设置默认的缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxCount = 100
      ..maxAge = 3600;

    //初始化网络请求相关配置
    GitHubApi.init();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _preferences.setString("profile", jsonEncode(profile.toJson()));
}
