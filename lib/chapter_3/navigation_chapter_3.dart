import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_3/sample_align.dart';
import 'package:flutter_learning/chapter_3/sample_flex_expanded.dart';
import 'package:flutter_learning/chapter_3/sample_row_column.dart';
import 'package:flutter_learning/chapter_3/sample_stack_positioned.dart';
import 'package:flutter_learning/chapter_3/sample_wrap_flow.dart';

// ignore: must_be_immutable
class NaviChapter3 extends StatelessWidget {
  var itemTitles = [
    "3.1 线性布局（Row、Column）",
    "3.2 弹性布局（Flex）",
    "3.3 流式布局（Wrap、Flow）",
    "3.4 层叠布局（Stack、Positioned）",
    "3.5 对齐与相对定位（Align）",
  ];

  var itemWidgets = [
    RowColumnRoute(),
    FlexRoute(),
    WrapFlowRoute(),
    StackTest(),
    AlignTest()
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
