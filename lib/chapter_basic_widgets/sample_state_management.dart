import 'package:flutter/material.dart';

/// 管理状态的最常见的方法：
///
/// Widget管理自己的状态。
/// Widget管理子Widget状态。
/// 混合管理（父Widget和子Widget都管理状态）。
/// 如何决定使用哪种管理方法？下面是官方给出的一些原则可以帮助你做决定：
///
/// 如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父Widget管理。
/// 如果状态是有关界面外观效果的，例如颜色、动画，那么状态最好由Widget本身来管理。
/// 如果某一个状态是不同Widget共享的则最好由它们共同的父Widget管理。
///
class SampleStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("状态管理的三种方式"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text("Widget管理自己的状态"),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TapBoxSelfManagement()))),
            Text("父Widget管理子Widget状态："),
            RaisedButton(
              child: Text("父Widget管理子Widget的状态"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParentWidget())),
            ),
            RaisedButton(
              child: Text("状态混合管理"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParentMixWidget())),
            )
          ],
        ),
      ),
    );
  }
}

class TapBoxSelfManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TapBoxSelfManagementState();
  }
}

// Widget管理自己的状态
class _TapBoxSelfManagementState extends State<TapBoxSelfManagement> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Widget管理自己的状态")),
        body: GestureDetector(
          onTap: _handleTap,
          child: Container(
            width: 200,
            height: 200,
            child: Center(
                child: Text(_active ? "Active" : "Inactive",
                    style: TextStyle(fontSize: 32, color: Colors.white))),
            decoration:
                BoxDecoration(color: _active ? Colors.green : Colors.grey),
          ),
        ));
  }
}

//父Widget管理子Widget的状态
class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapBoxChildWidget(
      active: _active,
      onChanged: _handleBoxChanged,
    );
  }
}

class TapBoxChildWidget extends StatelessWidget {
  TapBoxChildWidget({Key key, this.active, this.onChanged}) : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(color: active ? Colors.green : Colors.grey),
        child: Center(
            child: Text(active ? "Active" : "Inactive",
                style: TextStyle(fontSize: 32, color: Colors.white))),
      ),
    );
  }
}

//混合管理子Widget的状态
class ParentMixWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentMixWidgetState();
  }
}

class _ParentMixWidgetState extends State<ParentMixWidget> {
  bool _active = false;

  void _handleBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBoxCWidget(
      onChanged: _handleBoxChanged,
      active: _active,
    );
  }
}

class TabBoxCWidget extends StatefulWidget {
  TabBoxCWidget({Key key, this.active = false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _TabBoxCWidgetState();
  }
}

class _TabBoxCWidgetState extends State<TabBoxCWidget> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: widget.active ? Colors.green : Colors.grey,
            border: _highlight
                ? Border.all(color: Colors.teal[700], width: 10)
                : null),
        child: Center(
            child: Text(widget.active ? "Active" : "Inactive",
                style: TextStyle(fontSize: 32, color: Colors.white))),
      ),
    );
  }
}
