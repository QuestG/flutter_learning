import 'package:flutter/material.dart';

///DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。
class DecoratedBoxTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DecoratedBox"),
      ),
      body: Center(
        child: DecoratedBox(
          ///此属性决定在哪里绘制Decoration，它接收DecorationPosition的枚举类型，该枚举类有两个值：background和foreground。
          position: DecorationPosition.background,
          decoration: BoxDecoration(
              gradient:
                  //线性渐变
                  //LinearGradient(colors: [Colors.red, Colors.orange[700]]),
                  //放射渐变
                  RadialGradient(colors: [Colors.red, Colors.orange[700]]),
              //扫描渐变
              //SweepGradient(colors: [Colors.red, Colors.orange[700]]),
              borderRadius: BorderRadius.circular(3),
              //阴影
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  //模糊半径，值越大阴影颜色越浅，模糊范围越大
                  blurRadius: 3.0,
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 80),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
