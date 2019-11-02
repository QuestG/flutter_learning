import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_7/sample_event_bus.dart';
import 'package:flutter_learning/chapter_7/sample_gesture_detector.dart';
import 'package:flutter_learning/chapter_7/sample_notification.dart';
import 'package:flutter_learning/chapter_7/sample_pointer_event.dart';

class NaviChapter7 extends StatelessWidget {
  var itemTitles = [
    "7.1 原始指针事件处理",
    "7.2 手势识别",
    "7.3 全局事件总线",
    "7.4 Notification",
  ];

  var itemWidgets = [
    PointerEventTest(),
    SampleGestureTest(),
    SampleEventBus(),
    NotificationTest()
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
