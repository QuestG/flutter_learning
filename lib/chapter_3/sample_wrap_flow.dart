import 'package:flutter/material.dart';

/// 超出屏幕显示范围会自动折行的布局称为流式布局
///
/// Wrap的专有属性：
/// spacing：主轴方向子widget的间距
/// runSpacing：纵轴方向的间距
/// runAlignment：纵轴方向的对齐方式
class WrapFlowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wrap and FLow"),
      ),
      body: Wrap(
        spacing: 8,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: <Widget>[
          Chip(
            label: Text("Inside Out"),
            avatar: CircleAvatar(
              child: Text("I"),
              backgroundColor: Colors.blue,
            ),
          ),
          Chip(
            label: Text("Up"),
            avatar: CircleAvatar(
              child: Text("U"),
              backgroundColor: Colors.blue,
            ),
          ),
          Chip(
            label: Text("Eva"),
            avatar: CircleAvatar(
              child: Text("E"),
              backgroundColor: Colors.blue,
            ),
          ),
          Chip(
            label: Text("Coco"),
            avatar: CircleAvatar(
              child: Text("C"),
              backgroundColor: Colors.blue,
            ),
          ),
          Chip(
            label: Text("Brave"),
            avatar: CircleAvatar(
              child: Text("B"),
              backgroundColor: Colors.blue,
            ),
          ),
          Chip(
            label: Text("Monsters,Inc"),
            avatar: CircleAvatar(
              child: Text("M"),
              backgroundColor: Colors.blue,
            ),
          ),
          FlowTest()
        ],
      ),
    );
  }
}

//Flow主要用于一些需要自定义布局策略或性能要求较高(如动画中)的场景
class FlowTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowTestDelegate(margin: EdgeInsets.all(16)),
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          color: Colors.blue[100],
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue[200],
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue[300],
        ),
        Container(width: 80, height: 80, color: Colors.blue[400]),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue[500],
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue[600],
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue[700],
        ),
      ],
    );
  }
}

class FlowTestDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  FlowTestDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x = w + margin.left;
      } else {
        //换行
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    //不能自适应子组件大小，必须通过指定父容器大小或实现TestFlowDelegate的getSize返回固定大小
    return Size(double.infinity, 200);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
