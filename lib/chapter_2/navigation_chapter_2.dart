import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_2/sample_button.dart';
import 'package:flutter_learning/chapter_2/sample_image_icon.dart';
import 'package:flutter_learning/chapter_2/sample_progress_indicator.dart';
import 'package:flutter_learning/chapter_2/sample_state_management.dart';
import 'package:flutter_learning/chapter_2/sample_switch_check_box.dart';
import 'package:flutter_learning/chapter_2/sample_text.dart';
import 'package:flutter_learning/chapter_2/sample_textfield_form.dart';
import 'package:flutter_learning/chapter_2/sample_widget_intro.dart';

class NaviChapter2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> titleList = [
      Text("2.1 Widget简介"),
      Text("2.2 状态管理"),
      Text("2.3 文本字体样式"),
      Text("2.4 按钮"),
      Text("2.5 图片与Icon"),
      Text("2.6 单选框与复选框"),
      Text("2.7 输入框与表单"),
      Text("2.8 进度指示器"),
    ];

    List<Widget> routeList = [
      StateLifecycleWidget(),
      SampleStateWidget(),
      SampleTextWidget(),
      SampleButtonWidget(),
      SampleImageIconWidget(),
      SwitchCheckBoxRoute(),
      TextFieldAndFormRoute(),
      ProgressIndicatorRoute()
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Navigation Chapter 2")),
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
