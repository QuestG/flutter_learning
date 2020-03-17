import 'package:flutter/material.dart';
import 'package:flutter_learning/chapter_5/sample_custom_scroll_view.dart';
import 'package:flutter_learning/chapter_5/sample_gridview.dart';
import 'package:flutter_learning/chapter_5/sample_listview.dart';
import 'package:flutter_learning/chapter_5/sample_scroll_controller.dart';
import 'package:flutter_learning/chapter_5/sample_singelchildscrollview.dart';

///可滚动Widget都直接或间接包含一个Scrollable，这里介绍一下通用的属性：
///1 axisDirection 滚动方向
///2 physics 此属性接受一个ScrollPhysics类型的对象，它决定可滚动组件如何响应用户操作，比如用户滑动完抬起手指后，继续执行动画；或者滑动到边界时，如何显示。
///默认情况下，Flutter会根据具体平台分别使用不同的ScrollPhysics对象，应用不同的显示效果，如当滑动到边界时，继续拖动的话，在iOS上会出现弹性效果，
///而在Android上会出现微光效果。如果你想在所有平台下使用同一种效果，可以显式指定一个固定的ScrollPhysics，
///Flutter SDK中包含了两个ScrollPhysics的子类，他们可以直接使用：
///ClampingScrollPhysics：Android下微光效果。
///BouncingScrollPhysics：iOS下弹性效果。
///3 controller 此属性接受一个ScrollController对象。ScrollController的主要作用是控制滚动位置和监听滚动事件。
///默认情况下，Widget树中会有一个默认的PrimaryScrollController，如果子树中的可滚动组件没有显式的指定controller，
///并且primary属性值为true时（默认就为true），可滚动组件会使用这个默认的PrimaryScrollController。
///这种机制带来的好处是父组件可以控制子树中可滚动组件的滚动行为。
///
///关于Flutter布局滚动Widget中的ViewPort概念，指一个Widget的实际显示区域。
///例如一个ListView的显示区域高度为800px，虽然其列表项总高度远高于此，但ViewPort是800px。
///
/// 通常可滚动组件的子组件可能会非常多、占用的总高度也会非常大；如果要一次性将子组件全部构建出将会非常消耗性能。
/// 为此，Flutter中提出一个Sliver概念，如果一个可滚动组件支持Sliver模型，那么该滚动可以将子组件分成好多个Sliver，
/// 只有当Sliver出现在视口中时才会去构建它，这种模型也称为“基于Sliver的延迟构建模型”。可滚动组件中有很多都支持基于Sliver的延迟构建模型，
/// 如ListView、GridView，但是也有不支持该模型的，如SingleChildScrollView。
// ignore: must_be_immutable
class NaviChapter5 extends StatelessWidget {
  var itemTitles = [
    "5.1 SingleChildScrollView",
    "5.2 ListView",
    "5.3 GridView",
    "5.4 CustomScrollView",
    "5.5 滚动监听及控制",
  ];

  var itemWidgets = [
    SingleScrollViewTest(),
    ListViewTest(),
    GridViewTest(),
    CustomScrollViewTest(),
    ScrollControllerTest()
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
