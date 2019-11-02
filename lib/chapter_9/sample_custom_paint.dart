import 'dart:math';

import 'package:flutter/material.dart';

//如果CustomPaint有子节点，为了避免子节点不必要的重绘并提高性能，通常情况下都会将子节点包裹
//在RepaintBoundary组件中，这样会在绘制时就会创建一个新的绘制层（Layer），
//即子组件的绘制将独立于父组件的绘制，RepaintBoundary会隔离其子节点和CustomPaint本身的绘制边界。
class CustomPaintTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自绘组件"),
      ),
      body: Center(
        //painter: 背景画笔，会显示在子节点后面;
        //foregroundPainter: 前景画笔，会显示在子节点前面
        //size：当child为null时，代表默认绘制区域大小，如果有child则忽略此参数，画布尺寸则为child尺寸。
        //如果有child但是想指定画布为特定大小，可以使用SizeBox包裹CustomPaint实现。
        //isComplex：是否复杂的绘制，如果是，Flutter会应用一些缓存策略来减少重复渲染的开销。
        //willChange：和isComplex配合使用，当启用缓存时，该属性代表在下一帧中绘制是否会改变。
        child: CustomPaint(
          size: Size(300, 300),
          painter: ChessPainter(),
        ),
      ),
    );
  }
}

//绘制是比较昂贵的操作，所以我们在实现自绘控件时应该考虑到性能开销，下面是两条关于性能优化的建议：
//1、尽可能的利用好shouldRepaint返回值；在UI树重新build时，控件在绘制前都会先调用该方法以
//确定是否有必要重绘；假如我们绘制的UI不依赖外部状态，那么就应该始终返回false，因为外部状态
//改变导致重新build时不会影响我们的UI外观；如果绘制依赖外部状态，那么我们就应该在shouldRepaint
//中判断依赖的状态是否改变，如果已改变则应返回true来重绘，反之则应返回false不需要重绘。
//
//2、绘制尽可能多的分层；
//五子棋的示例中，我们将棋盘和棋子的绘制放在了一起，这样会有一个问题：由于棋盘始终是不变的，
//用户每次落子时变的只是棋子，但是如果按照上面的代码来实现，每次绘制棋子时都要重新绘制一次棋盘，
//这是没必要的。优化的方法就是将棋盘单独抽为一个组件，并设置其shouldRepaint回调值为false，
//然后将棋盘组件作为背景。然后将棋子的绘制放到另一个组件中，这样每次落子时只需要绘制棋子。
class ChessPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double widthEachGrid = size.width / 15;
    double heightEachGrid = size.height / 15;
    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //画线
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i < 15; i++) {
      double dy = heightEachGrid * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i < 15; i++) {
      double dx = widthEachGrid * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    //画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 2 - widthEachGrid / 2,
            size.height / 2 - heightEachGrid / 2),
        min(widthEachGrid / 2, heightEachGrid / 2) - 2,
        paint);

    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2 + widthEachGrid / 2,
          size.height / 2 - heightEachGrid / 2),
      min(widthEachGrid / 2, heightEachGrid / 2) - 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //在实际场景中正确利用此回调可以避免重绘开销，本示例简单的返回true
    return true;
  }
}
