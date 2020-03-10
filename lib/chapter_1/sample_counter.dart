import 'package:flutter/material.dart';

/// flutter的入门示例
///
/// 涉及到主要api：
/// 1. StatefulWidget StatelessWidget
/// 2. Scaffold
class CounterPageRoute extends StatefulWidget {
  CounterPageRoute({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _CounterPageRouteState();
  }
}

class _CounterPageRouteState extends State<CounterPageRoute> {
  var _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You have push this button many times."),
            Text(
              "$_counter",
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _incrementCounter,
        tooltip: "Increment",
      ),
    );
  }
}
