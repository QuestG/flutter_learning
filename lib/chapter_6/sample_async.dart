import 'package:flutter/material.dart';

class FutureAndStreamBuilderTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FutureAndStreamBuilderTestState();
  }
}

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
