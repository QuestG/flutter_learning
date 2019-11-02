import 'package:flutter/material.dart';

class AlignTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Align"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.blue[200],
            child: Align(
              alignment: Alignment.topRight,
              widthFactor: 2,
              heightFactor: 2,
              child: FlutterLogo(
                size: 30,
              ),
            ),
          ),
          Container(
            color: Colors.blue[200],
            child: Align(
              //Alignment Widget会以矩形的中心点作为坐标原点，即Alignment(0.0, 0.0) 。
              // x、y的值从-1到1分别代表矩形左边到右边的距离和顶部到底边的距离
              // (Alignment.x*childWidth/2+childWidth/2, Alignment.x*childHeight+childHeight/2)
              alignment: Alignment(2, 0),
              widthFactor: 2,
              heightFactor: 2,
              child: FlutterLogo(
                size: 30,
              ),
            ),
          ),
          Container(
            color: Colors.blue[200],
            child: Align(
              //FractionalOffset 的坐标原点为矩形的左侧顶点，
              // 实际偏移 = (FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)
              alignment: FractionalOffset(1, 1),
              widthFactor: 2,
              heightFactor: 2,
              child: FlutterLogo(
                size: 30,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              child: Text("xxx"),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text("xxx"),
            ),
          )
        ].map((f) {
          return Padding(
            padding: EdgeInsets.only(top: 16),
            child: f,
          );
        }).toList(),
      ),
    );
  }
}
