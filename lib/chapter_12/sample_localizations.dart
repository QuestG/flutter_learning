import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///自己的UI中如何支持多语言。
///1. 封装一个Localizations类，Localizations组件用于加载和查找应用当前语言下的本地化值或资源。
///2. 继承一个LocalizationsDelegate类
///3. 在MaterialApp或WidgetsApp的localizationsDelegates列表中注册LocalizationsDelegate子类
///
///监听系统语言切换
///可以通过localeResolutionCallback或localeListResolutionCallback回调来监听locale改变的事件
///在Flutter中，应该优先使用localeListResolutionCallback
///
///

class LocalizationsTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).title),
      ),
    );
  }
}

class DemoLocalizations {
  DemoLocalizations(this.isZh);

  //是否为中文
  bool isZh = false;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of(context, DemoLocalizations);
  }

  String get title {
    return isZh ? "Flutter 本地化" : "Flutter Localization";
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ["en", "zh"].contains(locale.languageCode);
  }

  //Flutter会调用此类加载相应的Locale资源类
  @override
  Future<DemoLocalizations> load(Locale locale) {
    return SynchronousFuture<DemoLocalizations>(
        DemoLocalizations(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }
}
