import 'package:flutter/material.dart';

class SampleTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文本及样式"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //此处需要Container，才能让textAlign生效，
            // 否则text的对齐水平会受crossAxisAlignment影响
            Container(
              child: Text(
                "Hello world",
                textAlign: TextAlign.end,
              ),
              width: 200,
              color: Colors.grey,
            ),
            Text(
              "Hello world I'm Quest" * 4,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Hello wrold",
              textScaleFactor: 1.5,
            ),
            Text(
              "Hello World",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  wordSpacing: 10,
                  height: 1.2,
                  background: Paint()..color = Colors.yellow,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            //富文本
            Text.rich(
              TextSpan(children: [
                TextSpan(text: "Home:"),
                TextSpan(
                  text: "http://www.flutter.dev",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ]),
            ),
            //优先使用默认文本样式
            DefaultTextStyle(
              style: TextStyle(color: Colors.red, fontSize: 20),
              textAlign: TextAlign.left,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("I'm Quest"),
                  Text("Hello world"),
                  Text(
                    "million years ago",
                    style: TextStyle(color: Colors.lightGreen, fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
