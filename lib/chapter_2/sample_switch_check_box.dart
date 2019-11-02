import 'package:flutter/material.dart';

class SwitchCheckBoxRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SwitchCheckBoxRouteState();
  }
}

class SwitchCheckBoxRouteState extends State<SwitchCheckBoxRoute> {
  bool _switchChecked = false;
  bool _checkBoxChecked = false;

  void _handleSwitchChanged(bool value) {
    setState(() {
      _switchChecked = value;
    });
  }

  void _checkBoxChanged(bool value) {
    setState(() {
      _checkBoxChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单选框与复选框"),
      ),
      body: Column(
        children: <Widget>[
          Switch(value: _switchChecked, onChanged: _handleSwitchChanged),
          Checkbox(
            value: _checkBoxChecked,
            onChanged: _checkBoxChanged,
            activeColor: Colors.red,
          )
        ],
      ),
    );
  }
}
