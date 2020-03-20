import 'package:flutter/material.dart';

//CustomScrollView是可以使用Sliver来自定义滚动模型（效果）的组件。它可以包含多种滚动模型。
//在CustomScrollView中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，
//如果直接将ListView、GridView作为CustomScrollView是不行的，因为它们本身是可滚动组件而并不是Sliver。
//为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版本，
// 如SliverList、SliverGrid等。
// 实际上Sliver版本的可滚动组件和非Sliver版本的可滚动组件最大的区别就是
// 前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，也正因如此，
// CustomScrollView才可以将多个Sliver"粘"在一起，
// 这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。
//
//Sliver系列Widget比较多，我们不会一一介绍，读者只需记住它的特点，需要时再去查看文档即可。
// 上面之所以说“大多数”Sliver都和可滚动组件对应，是由于还有一些如SliverPadding、
// SliverAppBar等是和可滚动组件无关的，它们主要是为了结合CustomScrollView一起使用，
// 这是因为CustomScrollView的子组件必须都是Sliver。
class CustomScrollViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //包含一个可滚动的AppBar，SliverAppBar可以结合FlexibleSpaceBar实现Material Design中头部伸缩的模型。
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Demo"),
              background: Image.asset(
                "assets/ic_avatar.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            //它用SliverPadding包裹以给SliverGrid添加补白。
            //这里的SliverGrid实例被设置为一个两列，宽高比为4的网格，它有20个子组件。
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text("grid item $index"),
                  );
                }, childCount: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4)),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  child: Text("list item $index"),
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                );
              }, childCount: 50),
              itemExtent: 50)
        ],
      ),
    );
  }
}
