//颜色自适应的导航
import 'package:flutter/material.dart';

class ColorAdaptiveBar extends StatelessWidget {
  ColorAdaptiveBar({Key key, this.title, this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(color: color, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 3),
          blurRadius: 3,
        ),
      ]),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //根据背景色亮度来确定Title颜色
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}

//关于ThemeData中需要注意的属性
//Brightness brightness, //深色还是浅色
//  MaterialColor primarySwatch, //主题颜色样本，见下面介绍
//  Color primaryColor, //主色，决定导航栏颜色
//  Color accentColor, //次级色，决定大多数Widget的颜色，如进度条、开关等。
//  ButtonThemeData buttonTheme, //按钮主题

// primarySwatch它是主题颜色的一个"样本色"，通过这个样本色可以在一些条件下生成一些其它的属性，
// 例如，如果没有指定primaryColor，并且当前主题不是深色主题，那么primaryColor就会默认为
// primarySwatch指定的颜色，还有一些相似的属性如accentColor 、indicatorColor等也会受primarySwatch影响。

class ColorThemeTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ColorThemeTestState();
  }
}

class _ColorThemeTestState extends State<ColorThemeTest> {
  //当前路由主题颜色
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
        data: ThemeData(
            primarySwatch: _themeColor,
            iconTheme: IconThemeData(color: _themeColor)),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Color and Theme"),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: ColorAdaptiveBar(
                  title: "标题",
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: ColorAdaptiveBar(
                  title: "标题",
                  color: Colors.white,
                ),
              ),
              //Icon使用主题中的iconTheme
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("颜色跟随主题"),
                ],
              ),
              //icon自定义颜色
              Theme(
                  data: themeData.copyWith(
                      iconTheme:
                          themeData.iconTheme.copyWith(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Icon(Icons.airport_shuttle),
                      Text("颜色固定为黑色"),
                    ],
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.palette),
            onPressed: () => setState(() => _themeColor =
                _themeColor == Colors.teal ? Colors.blue : Colors.teal),
          ),
        ));
  }
}
