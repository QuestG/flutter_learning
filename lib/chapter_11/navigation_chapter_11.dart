import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_11/sample_flutter_texture.dart';
import 'package:flutter_learning/chapter_11/sample_native_webview.dart';
import 'package:flutter_learning/chapter_11/sample_plugin.dart';

// ignore: must_be_immutable
class NaviChapter11 extends StatelessWidget {
  var itemTitles = [
    "11.1 Flutter与原生插件开发",
    "11.2 Flutter与原生共享图像（Texture）",
    "11.3 Flutter中嵌套原生组件(示例：WebView)"
  ];

  var itemWidgets = [PluginTestRoute(), CameraExampleHome(), WebViewRoute()];

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
