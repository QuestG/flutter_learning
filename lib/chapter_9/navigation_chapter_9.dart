import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_9/sample_compose_widgets.dart';
import 'package:flutter_learning/chapter_9/sample_custom_paint.dart';
import 'package:flutter_learning/chapter_9/sample_gradient_circular_progress_indicator.dart';
import 'package:flutter_learning/chapter_9/sample_turn_box.dart';

//自定义组件有三种方式：通过组合其它组件、自绘和实现RenderObject
//自绘可以通过Flutter中提供的CustomPaint和Canvas来实现UI自绘。
//自绘和通过实现RenderObject的方法本质上是一样的，都需要开发者调用Canvas API手动去绘制UI，
//优点是强大灵活，理论上可以实现任何外观的UI，而缺点是必须了解Canvas API细节，并且得自己去实现绘制逻辑。
// ignore: must_be_immutable
class NaviChapter9 extends StatelessWidget {
  var itemTitles = [
    "9.1 组合现有组件",
    "9.2 组合实例：TurnBox",
    "9.3 自绘组件",
    "9.4 自绘实例：圆形渐变进度条",
  ];

  var itemWidgets = [
    ComposeWidgetsTest(),
    TurnBoxTest(),
    CustomPaintTest(),
    GradientCircularProgressRoute()
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
