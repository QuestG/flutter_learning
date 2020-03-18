import 'package:flutter/material.dart';

class FutureAndStreamBuilderTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FutureAndStreamBuilderTestState();
  }
}

///Flutter专门提供了FutureBuilder和StreamBuilder两个组件来快速异步UI更新的功能。
class _FutureAndStreamBuilderTestState
    extends State<FutureAndStreamBuilderTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FutureBuilder StreamBuilder"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 150,

                ///FutureBuilder会依赖一个Future，它会根据所依赖的Future的状态来动态构建自身。
                ///future：FutureBuilder依赖的Future，通常是一个异步耗时任务。
                ///initialData：初始数据，用户设置默认数据。
                ///builder：Widget构建器；该构建器会在Future执行的不同阶段被多次调用。
                child: FutureBuilder(
                    future: mockNetworkData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return Text("Contents: ${snapshot.data}");
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),

              ///Stream也用于接收异步事件数据，它可以接收多个异步操作的结果，它常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。
              ///StreamBuilder正是用于配合Stream来展示流上事件（数据）变化的UI组件。
              StreamBuilder<int>(
                  stream: counter(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Text("Stream已关闭");
                      case ConnectionState.none:
                        return Text("没有Stream");
                      case ConnectionState.waiting:
                        return Text("等待数据...");
                      case ConnectionState.active:
                        return Text("active: ${snapshot.data}");
                    }
                    return null;
                  })
            ],
          ),
        ));
  }
}

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 3), () => "我是从互联网获取的数据");
}

//计时器，间隔1秒计一次
Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}
