import 'package:flutter/material.dart';

///Flutter Widget树中子Widget可以通过发送通知（Notification）与父(包括祖先)Widget通信。
///父级组件可以通过NotificationListener组件来监听自己关注的通知，
///
///可滚动组件在滚动时会发送ScrollNotification类型的通知，ScrollBar正是通过监听滚动通知来实现的。
///通过NotificationListener监听滚动事件和通过ScrollController有两个主要的不同：
///
///通过NotificationListener可以在从可滚动组件到widget树根之间任意位置都能监听。
///而ScrollController只能和具体的可滚动组件关联后才可以。
///收到滚动事件后获得的信息不同；NotificationListener在收到滚动事件时，
///通知中会携带当前滚动位置和ViewPort的一些信息，而ScrollController只能获取当前滚动位置。

//ScrollPosition是用来保存可滚动组件的滚动位置的。一个ScrollController对象可以同时被多个
//可滚动组件使用，ScrollController会为每一个可滚动组件创建一个ScrollPosition对象，
//这些ScrollPosition保存在ScrollController的positions属性中（List<ScrollPosition>）。
//ScrollPosition是真正保存滑动位置信息的对象，offset只是一个便捷属性
//可以通过controller.positions.length来确定controller被几个可滚动组件使用。

//当ScrollController和可滚动组件关联时，可滚动组件首先会调用ScrollController的
// createScrollPosition()方法来创建一个ScrollPosition来存储滚动位置信息，
// 接着，可滚动组件会调用attach()方法，将创建的ScrollPosition添加到ScrollController的
// positions属性中，这一步称为“注册位置”，只有注册后animateTo() 和 jumpTo()才可以被调用。
//
//当可滚动组件销毁时，会调用ScrollController的detach()方法，将其ScrollPosition对象
// 从ScrollController的positions属性中移除，这一步称为“注销位置”，注销后animateTo()
// 和 jumpTo() 将不能再被调用。
class ScrollControllerTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollControllerTestState();
  }
}

class _ScrollControllerTestState extends State<ScrollControllerTest> {
  ScrollController _controller = ScrollController();

  //是否显示"返回顶部"按钮
  bool showToTopBtn = false;

  //保存进度百分比
  String _progress = "0%";

  @override
  void initState() {
    //判断当前位置是否超过1000像素，如果超过则在屏幕右下角显示一个“返回顶部”的按钮，
    // 该按钮点击后可以使ListView恢复到初始位置；如果没有超过1000像素，则隐藏“返回顶部”按钮。
    _controller.addListener(() {
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动控制"),
      ),
      body: Scrollbar(
          //在接收到滚动事件时，参数类型为ScrollNotification，它包括一个metrics属性，它的类型是ScrollMetrics，该属性包含当前ViewPort及滚动位置等信息：
          //
          //pixels：当前滚动位置。
          //maxScrollExtent：最大可滚动长度。
          //extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
          //extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
          //extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
          //atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）。
          child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: 100,
                itemExtent: 50.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
                controller: _controller,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("$index"),
                  );
                }),
            CircleAvatar(
              radius: 30,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            )
          ],
        ),
      )),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              }),
    );
  }
}
