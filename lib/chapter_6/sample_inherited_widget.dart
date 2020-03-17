import 'package:flutter/material.dart';

//InheritedWidget是Flutter中非常重要的一个功能型组件，它提供了一种数据在widget树中从上到下传递、共享的方式，
//比如我们在应用的根widget中通过InheritedWidget共享了一个数据，那么我们便可以在任意子widget中来获取该共享的数据。
//这个特性在一些需要在widget树中共享数据的场景中非常方便：
//如Flutter SDK中正是通过InheritedWidget来共享应用主题（Theme）和Locale (当前语言环境)信息的。
class InheritedWidgetTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InheritedWidgetTestState();
  }
}

// State对象有一个didChangeDependencies回调，它会在“依赖”发生变化时被Flutter Framework调用。
// 而这个“依赖”指的就是子widget是否使用了父widget中InheritedWidget的数据。
// 如果使用了，则代表子widget依赖有依赖InheritedWidget；如果没有使用则代表没有依赖。
// 这种机制可以使子组件在所依赖的InheritedWidget变化时来更新自身。
class _InheritedWidgetTestState extends State<InheritedWidgetTest> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidget"),
      ),
      body: Center(
        child: ShareDataWidget(
          data: _count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _CounterTest(),
              RaisedButton(
                  child: Text("Increment"),
                  onPressed: () {
                    setState(() {
                      _count++;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class _CounterTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CounterTestState();
  }
}

class _CounterTestState extends State<_CounterTest> {
  //如果build方法中没有使用ShareDataWidget中共享的数据，
  //那么该Widget的didChangeDependencies()将不会被调用，因为它并没有依赖ShareDataWidget。
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context).data.toString());
  }

  //一般来说，子widget很少会重写此方法，因为在依赖改变后framework也都会调用build()方法。
  // 但是，如果你需要在依赖改变后执行一些昂贵的操作，比如网络请求，这时最好的方式就是
  // 在此方法中执行，这样可以避免每次build()都执行这些昂贵操作。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

//InheritedWidget提供了一种数据在widget树中从上到下传递、共享的方式，
//比如我们在应用的根widget中通过InheritedWidget共享了一个数据，那么我们便可以在任意子widget中来获取该共享的数据。
class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  //在子树中共享的数据，保存点击次数
  final int data;

  //定义的便捷方法，方便子树中的Widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    //调用inheritFromWidgetOfExactType() 和 ancestorInheritedElementForWidgetOfExactType()
    // 的区别就是前者会注册依赖关系，而后者不会，所以在调用inheritFromWidgetOfExactType()时，
    // InheritedWidget和依赖它的子孙组件关系便完成了注册，之后当InheritedWidget发生变化时，
    // 就会更新依赖它的子孙组件，也就是会调这些子孙组件的didChangeDependencies()方法和build()方法。
    // 而当调用的是 ancestorInheritedElementForWidgetOfExactType()时，由于没有注册依赖关系，
    // 所以之后当InheritedWidget发生变化时，就不会更新相应的子孙Widget。
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>(
        aspect: ShareDataWidget);
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    //如果返回true，则子树中依赖此Widget的子Widget的didChangeDependencies会被调用
    return oldWidget.data != data;
  }
}
