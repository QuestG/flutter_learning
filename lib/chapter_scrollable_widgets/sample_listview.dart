import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/// 关于ListView构造函数中的共同参数的一些说明：
/// itemExtent：该参数如果不为null，则会强制children的“长度”为itemExtent的值；
/// 这里的“长度”是指滚动方向上子组件的长度，也就是说如果滚动方向是垂直方向，则itemExtent代表子组件的高度；
/// 如果滚动方向为水平方向，则itemExtent就代表子组件的宽度。在ListView中，指定itemExtent比让子组件自己决定自身长度会更高效，
/// 这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，而无需每次构建子组件时都去再计算一下，
/// 尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）。
///
/// shrinkWrap：该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。
/// 默认情况下，ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true。
///
/// addAutomaticKeepAlives：该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；
/// 典型地，在一个懒加载列表中，如果将列表项包裹在AutomaticKeepAlive中，在该列表项滑出视口时它也不会被GC（垃圾回收），
/// 它会使用KeepAliveNotification来保存其状态。如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
///
/// addRepaintBoundaries：该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中。当可滚动组件滚动时，
/// 将列表项包裹在RepaintBoundary中可以避免列表项重绘，但是当列表项重绘的开销非常小（如一个颜色块，或者一个较短的文本）时，
/// 不添加RepaintBoundary反而会更高效。和addAutomaticKeepAlive一样，如果列表项自己维护其KeepAlive状态，那么此参数必须置为false。
class ListViewTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListViewTestState();
  }
}

class _ListViewTestState extends State<ListViewTest> {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("单词列表"),
          ),
          //可以自动拉伸ListView以填充屏幕剩余空间的方法吗？当然有！答案就是Flex。
          //前面已经介绍过在弹性布局中，可以使用Expanded自动拉伸组件大小，并且我们也说过Column是继承自Flex的，
          //所以我们可以直接使用Column+Expanded来实现。
          Expanded(
              //ListView的父Widget要有明确的边界，否则ListView会报高度边界无法确定的异常。
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (_words[index] == loadingTag) {
                      if (_words.length - 1 < 40) {
                        _retrieveData();
                        return Container(
                          padding: EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "没有更多了",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }
                    }
                    return ListTile(title: Text(_words[index]));
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[300],
                      ),
                  itemCount: _words.length)),
        ],
      ),
    );
  }
}
