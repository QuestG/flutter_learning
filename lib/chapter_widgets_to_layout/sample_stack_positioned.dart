import 'package:flutter/material.dart';

class StackTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack and Positioned"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          //此参数用于确定没有定位的子组件如何去适应Stack的大小。
          //StackFit.loose表示使用子组件的大小，StackFit.expand表示扩伸到Stack的大小。
          //fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: Text(
                "Hello world",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            //left、top 、right、 bottom分别代表离Stack左、上、右、底四边的距离。
            // width和height用于指定需要定位元素的宽度和高度。
            // 注意，Positioned的width、height 和其它地方的意义稍微有点区别，
            // 此处用于配合left、top 、right、 bottom来定位组件，
            // 举个例子，在水平方向时，你只能指定left、right、width三个属性中的两个，
            // 如指定left和width后，right会自动算出(left+width)，如果同时指定三个属性则会报错，垂直方向同理。
            Positioned(
              child: Text("I'm Quest"),
              left: 18,
            ),
            Positioned(
              child: Text("Your friend"),
              top: 18,
            )
          ],
        ),
      ),
    );
  }
}
