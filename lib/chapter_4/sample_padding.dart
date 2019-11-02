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
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text("Hello world"),
            ),
            Padding(
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
