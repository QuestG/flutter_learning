import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 路由管理示例
///
/// 涉及的主要api：
/// 1. MaterialPageRoute
/// 2. Navigator
class NewRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewRouteState();
  }
}

class _NewRouteState extends State<NewRoute> {
  //ReceiveValueRoute的返回结果
  var routeResult;

  //RegisteredRoute的返回结果
  var registeredRouteResult;

  void _setupReceivedValue() {
    //此处用异步 等待结果返回后再进行状态更新
    setState(() async {
      routeResult = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReceiveValueRoute(
                    text: "来自父路由的问候",
                  )));
    });
  }

  void _setupRegisteredRouteValue() {
    setState(() async {
      registeredRouteResult = await Navigator.pushNamed(
          context, SAMPLE_REGISTER_ROUTE,
          arguments: "注册路由");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Management"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("This is a new route."),
            RaisedButton(
              child: Text("点击跳转新的路由，并传递参数"),
              onPressed: _setupReceivedValue,
            ),
            Text("从子路由接收的值：${routeResult == null ? "" : routeResult}"),
            RaisedButton(
              child: Text("跳转注册路由，并传递参数"),
              onPressed: _setupRegisteredRouteValue,
            ),
            Text(
                "注册路由接收子路由的值：${registeredRouteResult == null ? "" : registeredRouteResult}")
          ],
        ),
      ),
    );
  }
}

/// 接收值的路由，并关闭时携带参数给父路由
///
/// 1. 路由接收值可以直接通过构造函数来传递
/// 2. Navigator的push方法会打开新的路由，并等待返回结果。将值传递给父路由，可以通过Navigator的pop方法，将返回值作为参数返回。
class ReceiveValueRoute extends StatelessWidget {
  ReceiveValueRoute({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receive value"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("从父路由接收的值：$text"),
            RaisedButton(
              child: Text("点击返回，并传值给父路由"),
              onPressed: () {
                Navigator.pop(context, "time: ${DateTime.now()}");
              },
            )
          ],
        ),
      ),
    );
  }
}

/// 注册路由表
///
/// 路由的注册在MaterialApp的构造函数中，需要为路由设置别名，之后可以通过别名来打开对应的路由。
/// MaterialApp中涉及到路由的属性：
/// 1. routes 静态路由表
/// 2. initialRoute app初始化时的路由
class StaticRegisteredRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Static Route"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("当前路由已在MaterialApp的routes中注册"),
            Text(
                "父路由传递的值：${ModalRoute.of(context).settings.arguments.toString()}"),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, "time: ${DateTime.now()}");
              },
              child: Text("点击返回父路由"),
            )
          ],
        ),
      ),
    );
  }
}

//路由名称建议以"/"开头
const SAMPLE_REGISTER_ROUTE = "/registerRoute";

/// 路由生成钩子
///
/// 涉及到MaterialApp的onGenerateRoute属性
/// 当调用Navigator.pushNamed(...)打开命名路由时，如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；
/// 如果路由表中没有注册，才会调用onGenerateRoute来生成路由，而且它只对命名路由有效。
///
/// 若想触发onGenerateRoute,调用Navigator的pushNamed方法，指定路由名和arguments。
class NotImplementedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Not Implemented"),
      ),
      body: Center(
        child: Text("尚未实现"),
      ),
    );
  }
}
