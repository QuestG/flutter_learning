import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 包管理、资源管理
///
/// 注意assets的格式，"-"与路径之间的距离使用空格敲两下，而不要使用tab键，否则路径指定会失效。
/// ```dart
///   flutter:
///     assets:
///       -  assets/ic_favorite.png
/// ```dart
///
/// 加载文本assets
/// 通过rootBundle对象加载：直接使用package:flutter/services.dart中全局静态的rootBundle对象来加载asset即可。
class PackageAssetsLeaningRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package Assets Management"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("${WordPair.random()}"),
            Image.asset("assets/ic_favorite.png")
          ],
        ),
      ),
    );
  }
}

/// 调试app的方法
///
/// widget层：debugDumpApp
/// 渲染层：debugDumpRenderTree
/// 层：debugDumpLayerTree
/// 语义：debugDumpSemanticsTree
/// 调度：要找出相对于帧的开始/结束事件发生的位置，可以谢欢debugPrintBeginFrameBanner和debugPrintEndFrameBanner布尔值以将帧的开始和结束打印到控制台
/// 可视化调试： 设置debugPaintSizeEnabled为true
/// MaterialDesign网格基线：MaterialApp构造函数中debugShowMaterialGrid参数设置为true
/// 统计应用启动时间：终端运行 flutter run --trace-startup --profile
class DebugAppRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debug Dump App"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("输出Widget层的状态"),
            onPressed: debugDumpApp,
          ),
          RaisedButton(
            child: Text("可视化调试布局"),
            onPressed: () {
              debugPaintSizeEnabled = true;
            },
          ),
        ],
      )),
    );
  }
}
