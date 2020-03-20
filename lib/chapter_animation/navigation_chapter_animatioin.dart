import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_animation/sample_animation.dart';
import 'package:flutter_learning/chapter_animation/sample_animted_switcher.dart';
import 'package:flutter_learning/chapter_animation/sample_hero.dart';
import 'package:flutter_learning/chapter_animation/sample_stagger_animation.dart';
import 'package:flutter_learning/chapter_animation/sample_widget_encapsulation_with_animation.dart';

// ignore: must_be_immutable
class NaviChapterAnimation extends StatelessWidget {
  var itemTitles = [
    "8.1 动画结构、自定义路由过渡动画",
    "8.2 Hero动画",
    "8.3 交织动画",
    "8.4 AnimatedSwitcher",
    "8.5 动画过渡组件"
  ];

  var itemWidgets = [
    SampleAnimation(),
    HeroAnimationTest(),
    StaggerAnimationTest(),
    AnimatedSwitcherTest(),
    WidgetEncapsulationWithAnimation()
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
