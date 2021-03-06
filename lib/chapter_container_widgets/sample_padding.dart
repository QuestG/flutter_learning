import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaddingTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Padding"),
      ),
      body: Padding(
        ///所有方向上都使用相同的内边距值
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              ///分别设置特定方向上的内边距值
              padding: EdgeInsets.only(left: 16),
              child: Text("Hello world"),
            ),
            Padding(
              ///用于设置对称方向上的内边距值
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Hello world"),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Text("Hello world"),
            ),
          ],
        ),
      ),
    );
  }
}
