import 'package:flutter/material.dart';

/// Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，
/// 所以无论对子组件应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
class TransformTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transform"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.blue,
            child: Transform(
              alignment: Alignment.topRight,
              transform: Matrix4.skewY(0.3),
              child: Container(
                color: Colors.orange,
                padding: EdgeInsets.all(16),
                child: Text("Hello world"),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.translate(
              //Offset以child左上角为原点，根据widget坐标系，这里x值为正，表示向右平移，y值为正表示向下平移
              offset: Offset(20, 5),
              child: Text(
                "Hello world",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              angle: 90,
              child: Text(
                "Hello world",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                //RotatedBox和Transform.rotate功能相似，它们都可以对子组件进行旋转变换，
                // 但是有一点不同：RotatedBox的变换是在layout阶段，会影响在子组件的位置和大小。
                child: RotatedBox(
                  quarterTurns: 1, //旋转90度(1/4圈)
                  child: Text("Hello world"),
                ),
              ),
              Text(
                "你好",
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              )
            ],
          ),
        ].map((f) {
          return Padding(
            padding: EdgeInsets.only(top: 18),
            child: f,
          );
        }).toList(),
      ),
    );
  }
}
