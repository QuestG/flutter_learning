import 'package:flutter/material.dart';

class StaggerAnimationTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggerAnimationTestState();
  }
}

//交织动画需要注意以下几点：
//
//要创建交织动画，需要使用多个动画对象（Animation）。
//一个AnimationController控制所有的动画对象。
//给每一个动画对象指定时间间隔（Interval）
//所有动画都由同一个AnimationController驱动，无论动画需要持续多长时间，控制器的值必须在
// 0.0到1.0之间，而每个动画的间隔（Interval）也必须介于0.0和1.0之间。
class _StaggerAnimationTestState extends State<StaggerAnimationTest>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StaggerAnimation"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(color: Colors.black.withOpacity(0.5))),
            //交织动画
            child: _StaggerAnimationWidget(
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}

//例子，实现一个柱状图增长的动画：
//
//开始时高度从0增长到300像素，同时颜色由绿色渐变为红色；这个过程占据整个动画时间的60%。
//高度增长到300后，开始沿X轴向右平移100像素；这个过程占用整个动画时间的40%。
// ignore: must_be_immutable
class _StaggerAnimationWidget extends StatelessWidget {
  _StaggerAnimationWidget({Key key, this.controller}) : super(key: key) {
    height = Tween<double>(begin: 0.0, end: 300).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));

    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));

    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.center,
      padding: padding.value,
      child: Container(
        height: height.value,
        color: color.value,
        width: 50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}
