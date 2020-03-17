import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'arb/messages_all.dart';

///Intl的使用
///
///1、添加依赖项 - intl，在yaml格式文件中添加intl和intl_translation的依赖
///2、创建文字资源文件，参考SampleLocalizations
///
///3、生成arb文件，命令行：flutter pub pub run intl_translation:extract_to_arb --output-dir=<arb文件存放路径> <文字资源文件路径>
///示例：flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/chapter_12/i10n/arb lib/chapter_12/i10n/sample_intl.dart
///
///4、新增和修改arb文件：对步骤3生成的intl_message.arb文件复制内容，同目录下新增intl_en.arb和intl_zh.arb。文件名规则可以自己定。
///
///5、根据arb生成dart文件，
///命令：flutter pub pub run intl_translation:generate_from_arb --output-dir=<arb文件存放路径> --no-use-deferred-loading <文字资源文件路径> <arb文件存放路径>/intl_*.arb
///
///6、创建localization代理，新建一个类继承LocalizationsDelegate，和文字资源文件联系起来
///7、MaterialApp中添加本地化代理和语言类型
///8、使用文字资源
///
///注意，如果想让国际化生效，除了实现类，还需要在MaterialApp的supportedLocales属性中注册支持，
///同时在localizationsDelegates属性中注册代理。
class SampleLocalizations {
  static Future<SampleLocalizations> load(Locale locale) {
    var name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    var localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return SampleLocalizations();
    });
  }

  static SampleLocalizations of(BuildContext context) {
    return Localizations.of<SampleLocalizations>(context, SampleLocalizations);
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }
}

//Locale代理类
class SampleLocalizationsDelegate
    extends LocalizationsDelegate<SampleLocalizations> {
  const SampleLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    var languageCode = locale.languageCode;
    print("intl_$languageCode");
    return ['en', 'zh'].contains(languageCode);
  }

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<SampleLocalizations> load(Locale locale) {
    return SampleLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(SampleLocalizationsDelegate old) => false;
}

class IntlTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SampleLocalizations.of(context).title),
      ),
      body: Center(
        child: Text(SampleLocalizations.of(context).title),
      ),
    );
  }
}
