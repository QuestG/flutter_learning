import 'package:flutter/material.dart';

class ComposeWidgetsTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("组合组件"),
      ),
      body: Column(
        children: <Widget>[
          GradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            child: Text("Submit"),
            onPressed: onTap,
          ),
          GradientButton(
            height: 50.0,
            colors: [Colors.lightGreen, Colors.green[700]],
            child: Text("Submit"),
            onPressed: onTap,
          ),
          GradientButton(
            height: 50.0,
            colors: [Colors.lightBlue[300], Colors.blueAccent],
            child: Text("Submit"),
            onPressed: onTap,
          ),
        ].map((e) {
          return Padding(
            padding: EdgeInsets.only(top: 16),
            child: e,
          );
        }).toList(),
      ),
    );
  }

  onTap() {
    print("button click");
  }
}

//GradientButton组件支持以下功能：
//1、背景支持渐变色（由DecoratedBox实现）
//2、手指按下时有涟漪效果(由InkWell来实现，它得是Material的子Widget才可以)
//3、可以支持圆角
class GradientButton extends StatelessWidget {
  GradientButton(
      {@required this.child,
      this.colors,
      this.borderRadius,
      this.width,
      this.height,
      this.onPressed});

  final List<Color> colors;
  final double width;
  final double height;
  final Widget child;
  final BorderRadius borderRadius;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保colors数组不为空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: width, height: height),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: DefaultTextStyle(
                  child: child,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
