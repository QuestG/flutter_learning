import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_flutter_start/sample_counter.dart';
import 'package:flutter_learning/chapter_flutter_start/sample_package_assets_management.dart';
import 'package:flutter_learning/chapter_flutter_start/sample_route_management.dart';

class NaviChapterFlutterStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> titleList = [
      Text("1.1 计数器示例"),
      Text("1.2 路由管理"),
      Text("1.3/4 包管理"),
      Text("1.5 调试Flutter App"),
    ];

    List<Widget> routeList = [
      CounterPageRoute(
        title: "计数器示例",
      ),
      NewRoute(),
      PackageAssetsLeaningRoute(),
      DebugAppRoute(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Navigation Chapter 1")),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ListTile(title: titleList[index]),
              onTap: () {
                if (index < routeList.length) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => routeList[index]));
                } else {
                  print("route name /${titleList[index]}");
                  Navigator.pushNamed(context, "/${titleList[index]}",
                      arguments: true);
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey);
          },
          itemCount: titleList.length),
    );
  }
}
