import 'package:flutter/material.dart';

//通常SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，
// 这是因为SingleChildScrollView不支持基于Sliver的延迟实例化模型
class SingleScrollViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String letters = "ABCDEFGHIJKLMNOPQRST";
    return Scaffold(
        appBar: AppBar(
          title: Text("SingleChildScrollView"),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: letters.split("").map((e) {
                  return Text(
                    e,
                    textScaleFactor: 2,
                    style: TextStyle(fontSize: 16),
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }
}
