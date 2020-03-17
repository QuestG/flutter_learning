import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_1/navigation_chapter_1.dart';
import 'package:flutter_learning/chapter_1/sample_route_management.dart';
import 'package:flutter_learning/chapter_10/navigation_chapter_10.dart';
import 'package:flutter_learning/chapter_11/navigation_chapter_11.dart';
import 'package:flutter_learning/chapter_12/navigation_chapter_12.dart';
import 'package:flutter_learning/chapter_12/sample_localizations.dart';
import 'package:flutter_learning/chapter_2/navigation_chapter_2.dart';
import 'package:flutter_learning/chapter_3/navigation_chapter_3.dart';
import 'package:flutter_learning/chapter_4/navigation_chapter_4.dart';
import 'package:flutter_learning/chapter_5/navigation_chapter_5.dart';
import 'package:flutter_learning/chapter_6/navigation_chapter_6.dart';
import 'package:flutter_learning/chapter_7/navigation_chapter_7.dart';
import 'package:flutter_learning/chapter_8/navigation_chapter_8.dart';
import 'package:flutter_learning/chapter_9/navigation_chapter_9.dart';
import 'package:flutter_learning/sample_github_client/routes/fake_git_hub_client.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'chapter_12/i10n/sample_intl.dart';

final bool isInDebugMode = false;

Future<Null> main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  //runZoned方法可以给执行对象指定一个Zone，类似"沙箱"，Zone中可以捕获日志、异常等。
  //zoneSpecification为Zone的自定义配置，指定一些代码行为。
  //如下示例中，则拦截所有调用print输出日志的行为。
  runZoned<Future<Null>>(() async {
    runApp(Home());
  }, onError: (Object error, StackTrace stackTrace) async {
    var details = makeDetails(error, stackTrace);
    FlutterError.reportError(details);
  }, zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
    parent.print(zone, "Intercepted: $line");
  }));
}

FlutterErrorDetails makeDetails(Object error, StackTrace stackTrace) {
  return FlutterErrorDetails(exception: error, stack: stackTrace);
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///MaterialApp 国际化需要指定 localizationsDelegates
    ///基于 WidgetsApp 构建的 app 在添加语言环境时，除了 GlobalMaterialLocalizations.delegate 不需要之外，其他的操作是类似的。
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Learning Home Page'),
      routes: {
        SAMPLE_REGISTER_ROUTE: (context) => StaticRegisteredRoute(),
      },
      onGenerateRoute: (settings) {
        if (settings.arguments as bool) {
          return MaterialPageRoute(builder: (context) => NotImplementedRoute());
        }
        return null;
      },
      //国际化
      localizationsDelegates: [
        //本地化的代理类
        // GlobalMaterialLocalizations.delegate 为Material 组件库提供的本地化的字符串和其他值，
        // 它可以使Material 组件支持多语言。
        // GlobalWidgetsLocalizations.delegate定义组件默认的文本方向，从左到右或从右到左，
        //Flutter package 包括的 MaterialLocalizations 和 WidgetsLocalizations 的接口都只提供美式英语的值，
        // 这样使得它尽可能小而简单。这些实现的类被分别称为 DefaultMaterialLocalizations 和 DefaultWidgetsLocalizations。
        // 它们会被自动地引入程序，除非你在 localizationsDelegates 参数中，相同的基本类型指定了一个不同的 delegate。
        //
        //flutter_localizations package 包括了多种语言本地化接口的实现，它们称为 GlobalMaterialLocalizations 和 GlobalWidgetsLocalizations。
        //国际化 app 必须为这些类的指定本地化 delegate，
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,

        //自定义的代理类
        DemoLocalizationsDelegate(),
        //使用Intl包的代理
        SampleLocalizationsDelegate()
      ],

      ///虽然 语言环境 (Locale) 默认的构造函数是完全没有问题的，但是还是建议大家使用 Locale.fromSubtags 的构造函数，因为它支持设置文字代码。
      ///MaterialApp 的 supportedLocales 参数限制了语言环境的变化范围。当用户在他们的设备切换语言环境的时候，
      ///只有当新语言环境是 supportedLocales 列表项中之一时， app 的 Localizations widget 才会跟着一起变。
      ///如果这个设备的语言环境不能被精确匹配， languageCode 相同的第一个支持的语言环境会被使用。
      ///如果这个也失败了，那就会使用 supportedLocales 的第一个语言环境。
      supportedLocales: [
        const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        const Locale("zh", "CN")
      ],

      ///如果一个 app 想要使用不同的语言环境解析方案，它可以提供一个 localeResolutionCallback。
      localeResolutionCallback:
          //此为举例：让ap无条件接受用户选择的任何语言环境。
          (Locale locale, Iterable<Locale> supportedLocales) {
        return locale;
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var divider = Divider(color: Colors.grey);

    //Flutter官方并没有对Widget进行官方分类，这里对其分类主要是为了方便讨论和对Widget功能区分的记忆。
    var itemTitles = [
      "Chapter-1 flutter入门",
      "Chapter-2 基础Widget",
      "Chapter-3 布局类Widget",
      "Chapter-4 容器类Widget",
      "Chapter-5 可滚动Widget",
      "Chapter-6 功能型Widget",
      "Chapter-7 事件处理与通知",
      "Chapter-8 动画",
      "Chapter-9 自定义组件",
      "Chapter-10 文件操作与网络请求",
      "Chapter-11 包与插件",
      "Chapter-12 国际化",
      "Chapter-13 一个完整的Flutter应用",
    ];

    var navigationRoutes = [
      NaviChapter1(),
      NaviChapter2(),
      NaviChapter3(),
      NaviChapter4(),
      NaviChapter5(),
      NaviChapter6(),
      NaviChapter7(),
      NaviChapter8(),
      NaviChapter9(),
      NaviChapter10(),
      NaviChapter11(),
      NaviChapter12(),
      FakeGitHub()
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: ListTile(title: Text(itemTitles[index])),
              onTap: () {
                if (index >= navigationRoutes.length) {
                  print("route name /${itemTitles[index]}");
                  //如果路由名没在路由表中注册，则触发onGenerateRoute
                  Navigator.pushNamed(context, "/${itemTitles[index]}",
                      arguments: true);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => navigationRoutes[index],
                      ));
                }
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return divider;
          },
          itemCount: itemTitles.length),
    );
  }
}
