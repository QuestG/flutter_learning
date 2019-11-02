import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PluginTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PluginTestRouteState();
  }
}

///通道的客户端和宿主通过通道构造函数中传递的通道名称进行连接。
///单个应用中使用的所有通道名称必须是唯一的,建议在通道名称前加一个唯一的“域名前缀”.
class _PluginTestRouteState extends State<PluginTestRoute> {
  static const platform = const MethodChannel("sample.flutter.io/battery");

  String _batteryLevel = "Unknown Battery Level";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("插件开发"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: _getBatteryLevel,
              child: Text("Get Battery Level"),
            ),
            Text(_batteryLevel)
          ],
        ),
      ),
    );
  }

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel = "Battery level at result $result%";
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
