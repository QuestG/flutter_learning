import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context Test"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          //在Widget树中向上查找最近的'Scaffold' Widget
          Scaffold scaffold = context.findAncestorStateOfType();
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}

// 打印State的生命周期
class StateLifecycleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLifecycleWidgetState();
  }
}

class _StateLifecycleWidgetState extends State<StateLifecycleWidget> {
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  var _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// 构建Widget子树
  /// 调用场景：
  /// 1 在调用initState()之后。
  /// 2 在调用didUpdateWidget()之后。
  /// 3 在调用setState()之后。
  /// 4 在调用didChangeDependencies()之后。
  /// 5 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
  ///
  /// 在Widget树中获取ScaffoldState对象
  /// 1. 通过context的ancestorStateOfType方法来获取
  /// 2. 通过GlobalKey获取，不过使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复。
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("State Lifecycle"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("counter: $_counter"),
            RaisedButton(
              child: Text("向上查找最近的Scaffold Widget"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContextRoute())),
            ),
            Builder(
              builder: (context) {
                return RaisedButton(
                  child: Text("通过context获取State对象"),
                  onPressed: () {
                    ScaffoldState _state = context.findAncestorStateOfType();
                    print("_state is null ${_state == null}");
                    _state.showSnackBar(SnackBar(
                      content: Text("我是snackbar"),
                    ));
                  },
                );
              },
            ),
            RaisedButton(
              onPressed: () {
                _globalKey.currentState
                    .showSnackBar(SnackBar(content: Text("我是snackbar")));
              },
              child: Text("通过GlobalKey获取State对象"),
            ),
            RaisedButton(
                child: Text("打开IOS风格页面"),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CupertinoTestRoute())))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }

  ///当Widget第一次插入到Widget树时会被调用，对于每一个State对象，
  ///Flutter framework只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。
  @override
  void initState() {
    super.initState();
    print("initState");
  }

  ///在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中同一位置的新旧节点，
  ///然后决定是否需要更新，如果Widget.canUpdate返回true则会调用此回调
  @override
  void didUpdateWidget(StateLifecycleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  ///当State对象从树中被移除时，会调用此回调。
  ///在一些场景下，Flutter framework会将State对象重新插到树中，
  ///如包含此State对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。
  ///如果移除后没有重新插入到树中则紧接着会调用dispose()方法。
  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  ///当State对象从树中被永久移除时调用；通常在此回调中释放资源。
  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  ///此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。
  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  ///当State对象的依赖发生变化时会被调用；
  ///例如：在之前build() 中包含了一个InheritedWidget，然后在之后的build() 中InheritedWidget发生了变化，
  ///那么此时InheritedWidget的子widget的didChangeDependencies()回调都会被调用。
  ///典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeBlue,
          child: Text("Press"),
          onPressed: () {
            print("CupertinoHello");
          },
        ),
      ),
    );
  }
}
