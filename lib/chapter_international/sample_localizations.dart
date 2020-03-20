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

///一个需要国际化的 app 经常以一个封装 app 本地化值的类开始的
class DemoLocalizations {
  DemoLocalizations(this.isZh);

  //是否为中文
  bool isZh = false;

  //我们使用 Localizations widget 来加载和查询那些包含本地化值集合的对象。
  //app 通过调用 Localizations.of(context,type) 来引用这些对象。如果设备的语言环境变化了，
  // Localizations widget 会自动地加载新的语言环境的值，然后重建那些使用了语言环境的 widget。
  // 这是因为 Localizations 像 继承 widget 一样执行。当一个构建过程涉及到继承 widget，对继承 widget 的隐式依赖就创建了。
  // 当一个继承 widget 变化了（即 Localizations widget 的语言环境变化），它的依赖上下文就会被重建。
  static DemoLocalizations of(BuildContext context) {
    //查看 app 当前的语言环境
//    Localizations.localeOf(context);
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return isZh ? "Flutter 本地化" : "Flutter Localization";
  }
}

///本地化的值是通过使用 Localizations widget 的 LocalizationsDelegate 加载的。
///每一个 delegate 必须定义一个异步的 load() 方法。这个方法生成了一个封装本地化值的对象，
///通常这些对象为每个本地化的值定义了一个方法。
///
/// 在一个大型的 app 中，不同的模块或者 package 需要和它们对应的本地化资源打包在一起。
/// 这就是为什么 Localizations widget 管理着对象的一个对应表，每个 LocalizationsDelegate 对应一个对象。
/// 为了获得由 LocalizationsDelegate 的 load 方法生成的对象，你需要指定一个构建上下文 (BuildContext) 和对象的类型。
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
