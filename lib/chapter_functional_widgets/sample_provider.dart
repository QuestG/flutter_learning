import 'dart:collection';

import 'package:flutter/material.dart';

///在Flutter开发中，状态管理是一个永恒的话题。一般的原则是：如果状态是组件私有的，则应该由组件自己管理；
///如果状态要跨组件共享，则该状态应该由各个组件共同的父元素来管理。
///对于跨组件共享的状态，管理的方式就比较多了，如使用全局事件总线EventBus，它是一个观察者模式的实现，通过它就可以实现跨组件状态同步：
///状态持有方（发布者）负责更新、发布状态，状态使用方（观察者）监听状态改变事件来执行一些操作。
///
///通过观察者模式来实现跨组件状态共享有一些明显的缺点：
///1）必须显式定义各种事件，不好管理
///2）订阅者必须需显式注册状态改变回调，也必须在组件销毁时手动去解绑回调以避免内存泄露。

//通用的InheritedWidget，保存任何需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    //简单处理，每次更新都会调用依赖其子孙节点的didChangeDependencies
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key key, this.child, this.data}) : super(key: key);

  final Widget child;
  final T data;

  //便捷方法，方便子Widget获取共享数据
  //添加一个listen参数，表示是否与InheritedWidget建立依赖关系
  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget;

    return (provider as InheritedProvider<T>).data;
  }

  @override
  State<StatefulWidget> createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

//_ChangeNotifierProviderState类的主要作用就是监听到共享状态（model）改变时重新构建Widget树。
// 注意，在_ChangeNotifierProviderState类中调用setState()方法，widget.child始终是同一个，
// 所以执行build时，InheritedProvider的child引用的始终是同一个子widget，
// 所以widget.child并不会重新build，这也就相当于对child进行了缓存！
class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider(
      data: widget.data,
      child: widget.child,
    );
  }
}

class Item {
  Item(this.price, this.count);

  double price;
  int count;
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  //禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProviderRouteState();
  }
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                Builder(builder: (context) {
                  return Consumer<CartModel>(
                      builder: (context, cart) =>
                          Text("总价：${cart.totalPrice}"));
                }),
                Builder(
                  builder: (context) {
                    return RaisedButton(
                        child: Text("添加商品"),
                        onPressed: () {
                          //不与ChangeNotifierProvider建立依赖关系，那么数据更新时，就不会再build RaiseButton了
                          //实现性能优化
                          ChangeNotifierProvider.of<CartModel>(context,
                                  listen: false)
                              .add(Item(20, 1));
                        });
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

//便捷类，获取当前context和指定数据类型的Provider
//好处：1. 防止代码冗余，2. 语义明确，为消费者。
class Consumer<T> extends StatelessWidget {
  Consumer({Key key, @required this.builder, this.child})
      : assert(builder != null),
        super(key: key);
  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, ChangeNotifierProvider.of<T>(context));
  }
}
