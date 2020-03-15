import 'package:flutter/material.dart';

class ClipTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset(
      "assets/ic_avatar.png",
      width: 60,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Clip"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            avatar,

            ///child为正方形时，裁剪为内切圆形，如果为矩形，裁剪为内切椭圆。
            ClipOval(
              child: avatar,
            ),

            ///将child裁剪为圆角矩形
            ClipRRect(
              child: avatar,
              borderRadius: BorderRadius.circular(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  //宽度设为原来宽度一半，另一半会溢出
                  widthFactor: .5,
                  child: avatar,
                ),
                Text(
                  "Hello world",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ///裁剪child到实际大小，即溢出部分裁掉。
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    //宽度设为原来宽度一半，另一半会被ClipRect剪裁
                    widthFactor: .5,
                    child: avatar,
                  ),
                ),
                Text(
                  "Hello world",
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),

              ///根据clipper属性自定裁剪child的范围。
              child: ClipRect(
                  clipper: MyClipper(), //使用自定义的clipper
                  child: avatar),
            )
          ],
        ),
      ),
    );
  }
}

//getClip()是用于获取剪裁区域的接口，由于图片大小是60×60，我们返回剪裁区域为Rect.fromLTWH(10.0, 15.0, 40.0, 30.0)，及图片中部40×30像素的范围。
//shouldReclip() 接口决定是否重新剪裁。如果在应用中，剪裁区域始终不会发生变化时应该返回false，这样就不会触发重新剪裁，避免不必要的性能开销。
// 如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画），那么变化后应该返回true来重新执行剪裁。
class MyClipper extends CustomClipper<Rect> {
  @override
  getClip(Size size) {
    return Rect.fromLTWH(10, 15, 40, 30);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
