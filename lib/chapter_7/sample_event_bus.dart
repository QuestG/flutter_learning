import 'package:flutter/material.dart';

//全局变量
var bus = EventBus();

class SampleEventBus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SampleEventBusState();
  }
}

class _SampleEventBusState extends State<SampleEventBus> {
  @override
  Widget build(BuildContext context) {
    bus.on("login", (arg) {
      print("监听到： $arg");
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("EventBus"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => _SampleEventBusTest()));
            },
            child: Text("点击模拟登录成功"),
          )
        ],
      ),
    );
  }
}

class _SampleEventBusTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bus.emit("login", "登录成功");
    return Scaffold(
      appBar: AppBar(
        title: Text("EventBusTest"),
      ),
      body: Center(
        child: Text("登录成功"),
      ),
    );
  }
}

//订阅者回调签名
typedef void EventCallback(arg);

class EventBus {
  //私有构造函数
  EventBus._internal();

  //保存单例，
  static EventBus _singleton = EventBus._internal();

  //Dart中实现单例模式的标准做法就是使用static变量+工厂构造函数的方式，
  //这样就可以保证EventBus()始终返回都是同一个实例，
  factory EventBus() => _singleton;

  //保存事件订阅者队列，key：事件名（id）,value:对应事件的订阅队列
  var _emap = Map<Object, List<EventCallback>>();

  //添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= List<EventCallback>();
    _emap[eventName].add(f);
  }

  //移除订阅者
  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向便利，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}
