import 'package:flutter/material.dart';

class SampleAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation的几种实现方式"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  //可用来实现自定义路由过渡动画
                  //pageBuilder 有一个animation参数，这是Flutter路由管理器提供的，
                  // 在路由切换时pageBuilder在每个动画帧都会被回调，因此可以通过animation对象来自定义过渡动画。
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleAnimationRoute(),
                        );
                      }));
            },
            child: Text("最基础动画实现"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  //自定义PageRoute
                  FadeRoute(builder: (context) => ScaleAnimationRoute2()));
            },
            child: Text("AnimatedWidget简化UI更新逻辑"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScaleAnimationRoute3()));
            },
            child: Text("AnimtatedBuilder分离渲染逻辑"),
          )
        ],
      ),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimationRouteState();
  }
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    //基本上创建一个动画的过程就包括如下步骤：
    //1. 一个控制器：AnimationController用于控制动画，它包含动画的启动forward()、
    // 停止stop() 、反向播放 reverse()等方法。
    //2. 一条曲线：Flutter中通过Curve（曲线）来描述动画过程
    //3. 一个Tween：Tween的唯一职责就是定义从输入范围到输出范围的映射。要使用Tween对象，
    // 需要调用其animate()方法，然后传入一个控制器对象。
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    //使用曲线动画
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片高度从0到300
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });
    //启动动画（正向执行）
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation基础使用"),
      ),
      body: Center(
        child: Image.asset(
          "assets/ic_avatar.png",
          width: animation.value,
          height: animation.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ScaleAnimationRoute2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimationRouteState2();
  }
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState2 extends State<ScaleAnimationRoute2>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInCirc);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation);
    //启动动画（正向执行）
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AnimatedWidget"),
        ),
        body: AnimatedImage(
          animation: animation,
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

//AnimatedWidget类封装了调用setState()的细节，并允许我们将widget分离出来
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "assets/ic_avatar.png",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaleAnimationRouteState3();
  }
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState3 extends State<ScaleAnimationRoute3>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInBack);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation);
    //启动动画（正向执行）
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedBuilder"),
      ),
      body: GrowTransition(
        animation: animation,
        child: Image.asset("assets/ic_avatar.png"),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

//AnimatedBuilder带来三个好处：
//
//不用显式的去添加帧监听器，然后再调用setState() 了，这个好处和AnimatedWidget是一样的。
//
//动画构建的范围缩小了，如果没有builder，setState()将会在父组件上下文中调用，这将会导致
// 父组件的build方法重新调用；而有了builder之后，只会导致动画widget自身的build重新调用，避免不必要的rebuild。
//
//通过AnimatedBuilder可以封装常见的过渡效果来复用动画。Flutter中正是通过这种方式封装了很多动画，
// 如：FadeTransition、ScaleTransition、SizeTransition等，很多时候都可以复用这些预置的过渡类。
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      //将外部引用child传递给AnimatedBuilder后AnimatedBuilder再将其传递给匿名构造器，
      //然后将该对象用作其子对象。最终的结果是AnimatedBuilder返回的对象插入到widget树中。
      child: new AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return new Container(
                constraints: BoxConstraints(minHeight: 0.0, minWidth: 0.0),
                height: animation.value,
                width: animation.value,
                child: child);
          },
          child: child),
    );
  }
}

class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //当前路由被激活，是打开新路由
    if (isActive) {
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    } else {
      //是返回，则不应用过渡动画
      return Padding(padding: EdgeInsets.zero);
    }
  }
}
