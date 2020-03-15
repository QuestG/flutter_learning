import 'package:flutter/material.dart';

///Container是一个组合类容器，它本身不对应具体的RenderObject，它是DecoratedBox、
///ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器，
///所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景。
class ContainerTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container"),
      ),
      body: Center(
        child: Container(
          //BoxConstraints.tightFor可以控制宽、高
          constraints: BoxConstraints.tightFor(width: 200, height: 150),
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.red, Colors.orange[700]],
                  center: Alignment.topLeft,
                  radius: .98),
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                    color: Colors.black45, blurRadius: 3, offset: Offset(2, 2))
              ]),
          transform: Matrix4.rotationZ(.2),
          alignment: Alignment.center,
          child: Text(
            "5.20",
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        ),
      ),
    );
  }
}
