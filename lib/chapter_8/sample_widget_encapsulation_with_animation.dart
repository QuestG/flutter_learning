import 'package:flutter/material.dart';

//约定，将在Widget属性发生变化时会执行过渡动画的组件统称为”动画过渡组件“，而动画过渡组件
//最明显的一个特征就是它会在内部自管理AnimationController。

// flutter内置了一些过渡动画组件：
//AnimatedPadding	在padding发生变化时会执行过渡动画到新状态
//AnimatedPositioned	配合Stack一起使用，当定位状态发生变化时会执行过渡动画到新的状态。
//AnimatedOpacity	在透明度opacity发生变化时执行过渡动画到新状态
//AnimatedAlign	当alignment发生变化时会执行过渡动画到新的状态。
//AnimatedContainer	当Container属性发生变化时会执行过渡动画到新的状态。
//AnimatedDefaultTextStyle	当字体样式发生变化时，子组件中继承了该样式的文本组件会动态过渡到新样式。
class WidgetEncapsulationWithAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WidgetEncapsulationWithAnimationState();
  }
}

class _WidgetEncapsulationWithAnimationState
    extends State<WidgetEncapsulationWithAnimation> {
  Color _decoratedColor = Colors.blue;

  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: 5);
    return Scaffold(
      appBar: AppBar(
        title: Text("封装Wiget中属性的过渡动画"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                AnimatedDecoratedBox1(
                  decoration: BoxDecoration(color: _decoratedColor),
                  duration: Duration(seconds: 1),
                  child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _decoratedColor = _decoratedColor == Colors.blue
                              ? Colors.red
                              : Colors.blue;
                        });
                      },
                      child: Text(
                        "AnimatedDecoratedBox1",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: AnimatedDecoratedBox(
                    decoration: BoxDecoration(color: _decoratedColor),
                    duration: Duration(seconds: 1),
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _decoratedColor = _decoratedColor == Colors.blue
                                ? Colors.red
                                : Colors.blue;
                          });
                        },
                        child: Text(
                          "AnimatedDecoratedBox",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _padding = 20;
                });
              },
              //在padding发生变化时会执行过渡动画到新状态
              child: AnimatedPadding(
                duration: Duration(seconds: 5),
                padding: EdgeInsets.all(_padding),
                child: Text("AnimatedPadding"),
              ),
            ),
            SizedBox(
              height: 50,
              child: Stack(
                children: <Widget>[
                  //配合Stack一起使用，当定位状态发生变化时会执行过渡动画到新的状态。
                  AnimatedPositioned(
                    duration: Duration(seconds: 5),
                    left: _left,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _left = 100;
                        });
                      },
                      child: Text("AnimatedPositioned"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 100,
              color: Colors.grey,
              //当alignment发生变化时会执行过渡动画到新的状态。
              child: AnimatedAlign(
                duration: duration,
                alignment: _align,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      _align = Alignment.center;
                    });
                  },
                  child: Text("AnimatedAlign"),
                ),
              ),
            ),
            //当Container属性发生变化时会执行过渡动画到新的状态。
            AnimatedContainer(
              duration: duration,
              height: _height,
              color: _color,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _height = 150;
                    _color = Colors.blue;
                  });
                },
                child: Text(
                  "AnimatedContainer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            //当字体样式发生变化时，子组件中继承了该样式的文本组件会动态过渡到新样式。
            AnimatedDefaultTextStyle(
              child: GestureDetector(
                child: Text("hello world"),
                onTap: () {
                  setState(() {
                    _style = TextStyle(
                      color: Colors.blue,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.blue,
                    );
                  });
                },
              ),
              style: _style,
              duration: duration,
            ),
          ].map((e) {
            return Padding(
              padding: EdgeInsets.only(top: 16),
              child: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}

///自定义DecoratedBox的过渡动画，在decoration属性变化时执行。
class AnimatedDecoratedBox1 extends StatefulWidget {
  AnimatedDecoratedBox1(
      {Key key,
      @required this.decoration,
      this.child,
      this.curve = Curves.linear,
      @required this.duration,
      this.reverseDuration});

  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  @override
  State<StatefulWidget> createState() {
    return _AnimatedDecoratedBox1State();
  }
}

class _AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: widget.child,
        animation: _animation,
        builder: (context, child) {
          return DecoratedBox(
            decoration: _tween.animate(_animation).value,
            child: child,
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        reverseDuration: widget.reverseDuration);
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    if (widget.curve != null) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    } else {
      _animation = _controller;
    }
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.curve != widget.curve) {
      _updateCurve();
    }
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

///为了方便开发者来实现动画过渡组件的封装，Flutter提供了一个ImplicitlyAnimatedWidget抽象类
///，它继承自StatefulWidget，同时提供了一个对应的ImplicitlyAnimatedWidgetState类，
///AnimationController的管理就在ImplicitlyAnimatedWidgetState类中。开发者如果要封装动画，
///只需要分别继承ImplicitlyAnimatedWidget和ImplicitlyAnimatedWidgetState类即可
///
class AnimatedDecoratedBox extends ImplicitlyAnimatedWidget {
  AnimatedDecoratedBox({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear, //动画曲线
    @required Duration duration, // 正向动画执行时长
  }) : super(
          key: key,
          curve: curve,
          duration: duration,
        );
  final BoxDecoration decoration;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedDecoratedBoxState();
  }
}

class _AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox> {
  DecorationTween _decoration; //定义一个Tween

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      //animation是ImplicitlyAnimatedWidgetState基类中定义的对象，
      decoration: _decoration.evaluate(animation),
      child: widget.child,
    );
  }

  //用于来更新Tween的初始值的
  @override
  void forEachTween(visitor) {
    // 在需要更新Tween时，基类会调用此方法
    _decoration = visitor(_decoration, widget.decoration,
        (value) => DecorationTween(begin: value));
  }
}
