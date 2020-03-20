import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_container_widgets/sample_clip.dart';
import 'package:flutter_learning/chapter_container_widgets/sample_container.dart';
import 'package:flutter_learning/chapter_container_widgets/sample_decorated_box.dart';
import 'package:flutter_learning/chapter_container_widgets/sample_padding.dart';
import 'package:flutter_learning/chapter_container_widgets/sample_scaffold.dart';
import 'package:flutter_learning/chapter_container_widgets/sample_sized_widget.dart';
import 'package:flutter_learning/chapter_container_widgets/sample_transform.dart';

// ignore: must_be_immutable
class NaviChapterContainerWidgets extends StatelessWidget {
  var itemTitles = [
    "4.1 Padding",
    "4.2 尺寸限制类容器",
    "4.3 DecoratedBox",
    "4.4 Transform",
    "4.5 Container",
    "4.6 Scaffold、TabBar、底部导航",
    "4.7 Clip"
  ];

  var itemWidgets = [
    PaddingTest(),
    SizeWidgetTest(),
    DecoratedBoxTest(),
    TransformTest(),
    ContainerTest(),
    ScaffoldRoute(),
    ClipTest()
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
