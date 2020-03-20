import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SampleButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("按钮使用练习"),
      ),
      body: Container(
        width: 300,
        child: Column(
          children: <Widget>[
            //默认带有灰色背景，且带阴影
            RaisedButton(
              onPressed: () {},
              child: Text("RaisedButton"),
            ),
            //默认背景透明，且不带阴影
            FlatButton(onPressed: () {}, child: Text("FlatButton")),
            //OutlineButton默认有一个边框，不带阴影且背景透明。
            // 按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
            OutlineButton(
              onPressed: () {},
              child: Text("OutlineButton"),
            ),
            IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),
            //RaisedButton、FlatButton、OutlineButton都有一个icon 构造函数，通过它可以轻松创建带图标的按钮。
            RaisedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.send),
              label: Text("发送"),
            ),
            FlatButton.icon(
                onPressed: () {}, icon: Icon(Icons.info), label: Text("详情")),
            OutlineButton.icon(
                onPressed: () {}, icon: Icon(Icons.add), label: Text("添加")),

            //自定义外观
            // this.shape, //外形
            // this.disabledColor,//按钮禁用时的背景颜色
            //  this.highlightColor, //按钮按下时的背景颜色
            //  this.splashColor, //点击时，水波动画中水波的颜色
            //  this.colorBrightness,//按钮主题，默认是浅色主题
            FlatButton(
              onPressed: () {},
              child: Text("Submit"),
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            )
          ],
        ),
      ),
    );
  }
}
