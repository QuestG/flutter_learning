import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_6/sample_async.dart';
import 'package:flutter_learning/chapter_6/sample_color_theme.dart';
import 'package:flutter_learning/chapter_6/sample_dialog.dart';
import 'package:flutter_learning/chapter_6/sample_inherited_widget.dart';
import 'package:flutter_learning/chapter_6/sample_provider.dart';
import 'package:flutter_learning/chapter_6/sample_willpopscope.dart';

///功能型Widget指的是不会影响UI布局及外观的Widget，它们通常具有一定的功能，如事件监听、数据存储等，
///功能型Widget非常多
class NaviChapter6 extends StatelessWidget {
  var itemTitles = [
    "6.1 WillPopScope",
    "6.2 InheritedWidget",
    "6.3 Provider",
    "6.4 Theme",
    "6.5 异步UI更新",
    "6.6 对话框详解",
  ];

  var itemWidgets = [
    WillPopScopeTest(),
    InheritedWidgetTest(),
    ProviderRoute(),
    ColorThemeTest(),
    FutureAndStreamBuilderTest(),
    DialogTest()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row and Column"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index < itemWidgets.length) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => itemWidgets[index]));
                } else {
                  //arguments为true是因为onGenerateRoute中的逻辑是根据bool值进行判断的
                  Navigator.pushNamed(context, itemTitles[index],
                      arguments: true);
                }
              },
              child: ListTile(
                title: Text(itemTitles[index]),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey);
          },
          itemCount: itemTitles.length),
    );
  }
}
