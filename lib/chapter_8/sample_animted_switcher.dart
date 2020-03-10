import 'package:flutter/material.dart';

//AnimatedSwitcher 可以同时对其新、旧子元素添加显示、隐藏动画。
class AnimatedSwitcherTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedSwitcherTestState();
  }
}

class _AnimatedSwitcherTestState extends State<AnimatedSwitcherTest> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedSwitcher"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //AnimatedSwitcher的新旧child，如果类型相同，则Key必须不相等。
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                child: child,
                scale: animation,
              );
            },
            child: Text(
              "$_count",
              //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: RaisedButton(
                    child: Text("+1"),
                    onPressed: () {
                      setState(() {
                        _count += 1;
                      });
                    }),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return SlideTransitionX(
                    position: animation,
                    child: child,
                    direction: AxisDirection.up,
                  );
                },
                child: Text(
                  "$_count",
                  //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                  key: ValueKey(_count),
                  style: Theme.of(context).textTheme.headline4,
                ),
              )
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return CustomSlideTransition(
                child: child,
                position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                    .animate(animation),
              );
            },
            child: Text(
              "$_count",
              //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey(_count),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}

//自定义SlideTransition，在正向动画从右往左滑动显示时，逆向动画改为从右往左滑动隐藏，
//而不是原先的从左往右滑动隐藏，因为同一个Animation正向（forward）和反向（reverse）是对称的。
class CustomSlideTransition extends AnimatedWidget {
  CustomSlideTransition(
      {Key key,
      @required Animation<Offset> position,
      this.transformHitTests,
      this.child})
      : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    //动画反向执行时，调整x偏移，实现从"左侧滑出隐藏"
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

//封装通用的滑出动画，可以实现不同方向的动画。
// ignore: must_be_immutable
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
